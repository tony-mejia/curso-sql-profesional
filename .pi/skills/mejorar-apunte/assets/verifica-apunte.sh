#!/usr/bin/env bash
# Verifica que la mejora de un apunte sea PURAMENTE ADITIVA.
#
# Uso:  bash verifica-apunte.sh "ruta/al/apunte.sql" [ruta/al/respaldo]
#
# Si no pasas respaldo, lo busca en /tmp/apunte-backup/<nombre-del-archivo>.
# Hay que respaldar ANTES de escribir: los apuntes pendientes están sin
# commitear, así que git no los puede recuperar.
#
# Qué comprueba:
#   1. Que no queden placeholders.
#   2. Que los finales de línea sigan igual que en el original.
#   3. Que TODAS las líneas propias estén presentes byte a byte.
#   4. Que no se haya borrado ninguna línea de contenido (cambio aditivo).
#   5. Que las separadoras midan 79 caracteres.
#
# TRAMPA CONOCIDA: detectar CRLF mirando los últimos 2 bytes FALLA si el
# archivo no termina en salto de línea. Por eso aquí se usa `file -b`.
set -u

F="$1"
B="${2:-/tmp/apunte-backup/$(basename "$F")}"
EQ=$(printf '=%.0s' $(seq 1 76))
MN=$(printf -- '-%.0s' $(seq 1 76))

[ -f "$F" ] || { echo "ERROR: no existe $F"; exit 1; }
[ -f "$B" ] || { echo "ERROR: no hay respaldo en $B (respalda antes de escribir)"; exit 1; }

# 1) sustituir placeholders de las separadoras
if grep -q '@@EQ@@\|@@MN@@' "$F"; then
  sed -i "s/@@EQ@@/$EQ/g; s/@@MN@@/$MN/g" "$F"
fi

# 2) igualar finales de línea al original (idempotente)
if file -b "$B" | grep -q CRLF; then
  sed -i 's/\r*$/\r/' "$F"
  ORIG_END="CRLF"
else
  ORIG_END="LF"
fi

# 3) normalizar para comparar: sin \r y con salto final garantizado
sed 's/\r$//' "$B" > /tmp/vb.txt
[ -n "$(tail -c 1 /tmp/vb.txt)" ] && printf '\n' >> /tmp/vb.txt
sed 's/\r$//' "$F" > /tmp/vn.txt

printf '  placeholders restantes: %s\n' "$(grep -c '@@' "$F" || true)"
printf '  finales de linea: original=%s  ahora=%s\n' "$ORIG_END" "$(file -b "$F" | grep -q CRLF && echo CRLF || echo LF)"

# 4) líneas propias, byte a byte
fail=0; total=0
while IFS= read -r line; do
  [ -z "$line" ] && continue
  total=$((total+1))
  grep -Fxq -- "$line" /tmp/vn.txt || { printf '  FALTA: %s\n' "$line"; fail=1; }
done < /tmp/vb.txt
if [ $fail -eq 0 ]; then
  echo "  lineas propias: $total/$total intactas"
else
  echo "  lineas propias: HAY PERDIDAS -> NO reportar como terminado"
fi

# 5) aditividad y separadoras
printf '  lineas de contenido borradas: %s\n' "$(diff --unchanged-line-format= --old-line-format='-|%L' --new-line-format= /tmp/vb.txt /tmp/vn.txt | grep -c '^-|.' || true)"
sed 's/\r$//' "$F" | awk '$0 ~ /={76}/ || $0 ~ /-{76}/ {t++; if (length($0)==79) ok++} END {printf "  separadoras: %d / correctas: %d\n", t, ok}'
printf '  lineas: original %s -> ahora %s\n' "$(wc -l < /tmp/vb.txt)" "$(wc -l < /tmp/vn.txt)"

# Recordatorio: si el original NO terminaba en salto de línea, la última línea
# propia ganó un terminador. Es la única diferencia inevitable; hay que reportarla.
if [ -n "$(tail -c 1 "$B")" ]; then
  echo "  OJO: el original no terminaba en salto de linea. La ultima linea propia ahora si termina: es la unica diferencia inevitable, reportala."
fi
