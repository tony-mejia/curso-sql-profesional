-- ============================================================
-- PRACTICA: Queries Complejos (Capitulo 6)
-- Dominio: tienda de electronica (esquema espejo de Northwind)
-- Ejecuta este archivo completo en MySQL Workbench / terminal.
-- ============================================================

DROP SCHEMA IF EXISTS `practica_queries`;
CREATE SCHEMA IF NOT EXISTS `practica_queries` DEFAULT CHARACTER SET utf8mb4;
USE `practica_queries`;

-- ------------------------------------------------------------
-- Tabla suppliers
-- ------------------------------------------------------------
CREATE TABLE `suppliers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(50) DEFAULT NULL,
  `city` VARCHAR(50) DEFAULT NULL,
  `state_province` VARCHAR(50) DEFAULT NULL,
  `country_region` VARCHAR(50) DEFAULT NULL,
  `email_address` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO suppliers (id, company, city, state_province, country_region, email_address) VALUES (1, 'VoltWorks', 'San Jose', 'CA', 'USA', 'sales@voltworks.com');
INSERT INTO suppliers (id, company, city, state_province, country_region, email_address) VALUES (2, 'PixelForge', 'San Francisco', 'CA', 'USA', 'sales@pixelforge.com');
INSERT INTO suppliers (id, company, city, state_province, country_region, email_address) VALUES (3, 'SoundCore', 'Austin', 'TX', 'USA', 'sales@soundcore.com');
INSERT INTO suppliers (id, company, city, state_province, country_region, email_address) VALUES (4, 'AeroByte', 'Albany', 'NY', 'USA', 'sales@aerobyte.com');
INSERT INTO suppliers (id, company, city, state_province, country_region, email_address) VALUES (5, 'CircuitPeak', 'Buffalo', 'NY', 'USA', 'sales@circuitpeak.com');
INSERT INTO suppliers (id, company, city, state_province, country_region, email_address) VALUES (6, 'KeyMaster', 'Dallas', 'TX', 'USA', 'sales@keymaster.com');

-- ------------------------------------------------------------
-- Tabla products
-- ------------------------------------------------------------
CREATE TABLE `products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_code` VARCHAR(25) DEFAULT NULL,
  `product_name` VARCHAR(50) DEFAULT NULL,
  `standard_cost` DECIMAL(19,4) DEFAULT '0.0000',
  `list_price` DECIMAL(19,4) NOT NULL DEFAULT '0.0000',
  `category` VARCHAR(50) DEFAULT NULL,
  `supplier_ids` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (1, 'LAP-01', 'Aurora 14 Laptop', 900.00, 1299.99, 'Laptops', '1');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (2, 'LAP-02', 'Falcon 15 Pro', 750.00, 1099.00, 'Laptops', '2');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (3, 'LAP-03', 'Nova Ultrabook', 1100.00, 1599.99, 'Laptops', '1');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (4, 'LAP-04', 'Comet 13 Basic', 480.00, 749.00, 'Laptops', '2');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (5, 'PHN-01', 'Pulse X Smartphone', 520.00, 899.00, 'Smartphones', '4');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (6, 'PHN-02', 'Pulse X Max', 620.00, 1099.99, 'Smartphones', '4');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (7, 'PHN-03', 'Orbit S10', 350.00, 649.00, 'Smartphones', '5');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (8, 'PHN-04', 'Orbit S10 Mini', 280.00, 499.00, 'Smartphones', '5');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (9, 'AUD-01', 'EchoBuds Pro', 90.00, 199.00, 'Audio', '3');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (10, 'AUD-02', 'EchoHead Wireless', 140.00, 299.00, 'Audio', '3');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (11, 'AUD-03', 'BassBoost Speaker', 60.00, 129.00, 'Audio', '6');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (12, 'AUD-04', 'Studio Mic USB', 45.00, 99.00, 'Audio', '3');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (13, 'MON-01', 'Vivid 27 4K', 380.00, 599.00, 'Monitors', '4');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (14, 'MON-02', 'Vivid 32 UltraWide', 520.00, 799.00, 'Monitors', '4');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (15, 'MON-03', 'Pixel 24 FHD', 150.00, 249.00, 'Monitors', '5');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (16, 'MON-04', 'Pixel 27 Gaming 165Hz', 300.00, 459.00, 'Monitors', '5');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (17, 'ACC-01', 'TypePro Keyboard', 35.00, 89.00, 'Accessories', '6');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (18, 'ACC-02', 'TypePro Keyboard RGB', 45.00, 119.00, 'Accessories', '6');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (19, 'ACC-03', 'Swift Mouse', 15.00, 39.00, 'Accessories', '6');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (20, 'ACC-04', 'Swift Mouse Wireless', 25.00, 59.00, 'Accessories', '6');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (21, 'ACC-05', 'Hub USB-C 7-in-1', 20.00, 49.00, 'Accessories', '5');
INSERT INTO products (id, product_code, product_name, standard_cost, list_price, category, supplier_ids) VALUES (22, 'ACC-06', 'Laptop Sleeve 14', 10.00, 24.99, 'Accessories', '2');

-- ------------------------------------------------------------
-- Tabla customers
-- ------------------------------------------------------------
CREATE TABLE `customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(50) DEFAULT NULL,
  `last_name` VARCHAR(50) DEFAULT NULL,
  `first_name` VARCHAR(50) DEFAULT NULL,
  `email_address` VARCHAR(50) DEFAULT NULL,
  `city` VARCHAR(50) DEFAULT NULL,
  `state_province` VARCHAR(50) DEFAULT NULL,
  `country_region` VARCHAR(50) DEFAULT NULL,
  `job_title` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (1, 'TechNova Solutions', 'Mendoza', 'Laura', 'lmendoza@technova.com', 'Austin', 'TX', 'USA', 'Purchasing Manager');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (2, 'BlueWave Media', 'Chen', 'Mark', 'mchen@bluewave.com', 'San Francisco', 'CA', 'USA', 'Owner');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (3, 'GreenLeaf Retail', 'Torres', 'Ana', 'atorres@greenleaf.com', 'New York', 'NY', 'USA', 'Buyer');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (4, 'SkyHigh Airlines', 'Kim', 'David', 'dkim@skyhigh.com', 'Dallas', 'TX', 'USA', 'IT Director');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (5, 'UrbanDesk Co', 'Ruiz', 'Sofia', 'sruiz@urbandesk.com', 'Chicago', 'IL', 'USA', 'Office Manager');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (6, 'PixelMart', 'Smith', 'John', 'jsmith@pixelmart.com', 'Los Angeles', 'CA', 'USA', 'CEO');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (7, 'CafeDigital', 'Lopez', 'Maria', 'mlopez@cafedigital.com', 'Miami', 'FL', 'USA', 'Founder');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (8, 'BrightLabs', 'Johnson', 'Peter', 'pjohnson@brightlabs.com', 'Seattle', 'WA', 'USA', 'CTO');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (9, 'NovaCorp', 'Petrova', 'Elena', 'epetrova@novacorp.com', 'Boston', 'MA', 'USA', 'VP Operations');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (10, 'SunsetElectronics', 'Diaz', 'Carlos', 'cdiaz@sunset.com', 'San Diego', 'CA', 'USA', 'Owner');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (11, 'AuroraBooks', 'Lee', 'Grace', 'glee@aurorabooks.com', 'Portland', 'OR', 'USA', 'Manager');
INSERT INTO customers (id, company, last_name, first_name, email_address, city, state_province, country_region, job_title) VALUES (12, 'FrostyTech', 'Muller', 'Hans', 'hmuller@frostytech.com', 'Denver', 'CO', 'USA', 'COO');

-- ------------------------------------------------------------
-- Tabla orders
-- ------------------------------------------------------------
CREATE TABLE `orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT DEFAULT NULL,
  `order_date` DATETIME DEFAULT NULL,
  `shipped_date` DATETIME DEFAULT NULL,
  `ship_city` VARCHAR(50) DEFAULT NULL,
  `ship_state_province` VARCHAR(50) DEFAULT NULL,
  `ship_country_region` VARCHAR(50) DEFAULT NULL,
  `shipping_fee` DECIMAL(19,4) DEFAULT NULL,
  `payment_type` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (1, 1, '2025-01-01 09:30:00', '2025-01-03 15:00:00', 'Austin', 'TX', 'USA', 45.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (2, 1, '2025-01-02 09:30:00', '2025-01-04 15:00:00', 'Austin', 'TX', 'USA', 120.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (3, 1, '2025-01-03 09:30:00', '2025-01-05 15:00:00', 'Austin', 'TX', 'USA', 25.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (4, 1, '2025-01-04 09:30:00', NULL, 'Austin', 'TX', 'USA', NULL, NULL);
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (5, 2, '2025-01-05 09:30:00', '2025-01-07 15:00:00', 'San Francisco', 'CA', 'USA', 30.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (6, 2, '2025-01-06 09:30:00', '2025-01-08 15:00:00', 'New York', 'NY', 'USA', 90.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (7, 2, '2025-01-07 09:30:00', '2025-01-09 15:00:00', 'San Francisco', 'CA', 'USA', 15.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (8, 2, '2025-01-08 09:30:00', '2025-01-10 15:00:00', 'San Francisco', 'CA', 'USA', 50.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (9, 3, '2025-01-09 09:30:00', '2025-01-11 15:00:00', 'New York', 'NY', 'USA', 60.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (10, 3, '2025-01-10 09:30:00', '2025-01-12 15:00:00', 'New York', 'NY', 'USA', 80.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (11, 3, '2025-01-11 09:30:00', NULL, 'New York', 'NY', 'USA', NULL, NULL);
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (12, 4, '2025-01-12 09:30:00', '2025-01-14 15:00:00', 'Dallas', 'TX', 'USA', 100.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (13, 4, '2025-01-13 09:30:00', '2025-01-15 15:00:00', 'Dallas', 'TX', 'USA', 40.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (14, 4, '2025-01-14 09:30:00', '2025-01-16 15:00:00', 'New York', 'NY', 'USA', 75.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (15, 4, '2025-01-15 09:30:00', '2025-01-17 15:00:00', 'Dallas', 'TX', 'USA', 20.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (16, 4, '2025-01-16 09:30:00', '2025-01-18 15:00:00', 'Dallas', 'TX', 'USA', 55.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (17, 5, '2025-01-17 09:30:00', '2025-01-19 15:00:00', 'Chicago', 'IL', 'USA', 35.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (18, 5, '2025-01-18 09:30:00', '2025-01-20 15:00:00', 'Chicago', 'IL', 'USA', 28.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (19, 6, '2025-01-19 09:30:00', '2025-01-21 15:00:00', 'Los Angeles', 'CA', 'USA', 22.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (20, 6, '2025-01-20 09:30:00', '2025-01-22 15:00:00', 'Los Angeles', 'CA', 'USA', 18.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (21, 6, '2025-01-21 09:30:00', '2025-01-23 15:00:00', 'New York', 'NY', 'USA', 65.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (22, 6, '2025-01-22 09:30:00', '2025-01-24 15:00:00', 'Los Angeles', 'CA', 'USA', 30.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (23, 7, '2025-01-23 09:30:00', '2025-01-25 15:00:00', 'Miami', 'FL', 'USA', 48.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (24, 7, '2025-01-24 09:30:00', '2025-01-26 15:00:00', 'New York', 'NY', 'USA', 95.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (25, 7, '2025-01-25 09:30:00', '2025-01-27 15:00:00', 'Miami', 'FL', 'USA', 42.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (26, 8, '2025-01-26 09:30:00', '2025-01-28 15:00:00', 'Seattle', 'WA', 'USA', 33.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (27, 8, '2025-01-27 09:30:00', '2025-02-01 15:00:00', 'Seattle', 'WA', 'USA', 27.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (28, 8, '2025-01-28 09:30:00', '2025-02-02 15:00:00', 'Seattle', 'WA', 'USA', 58.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (29, 8, '2025-02-01 09:30:00', '2025-02-03 15:00:00', 'Seattle', 'WA', 'USA', 12.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (30, 8, '2025-02-02 09:30:00', NULL, 'Seattle', 'WA', 'USA', NULL, NULL);
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (31, 9, '2025-02-03 09:30:00', '2025-02-05 15:00:00', 'Boston', 'MA', 'USA', 70.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (32, 9, '2025-02-04 09:30:00', '2025-02-06 15:00:00', 'Boston', 'MA', 'USA', 88.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (33, 9, '2025-02-05 09:30:00', '2025-02-07 15:00:00', 'Boston', 'MA', 'USA', 44.00, 'Credit Card');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (34, 10, '2025-02-06 09:30:00', '2025-02-08 15:00:00', 'San Diego', 'CA', 'USA', 52.00, 'Bank Transfer');
INSERT INTO orders (id, customer_id, order_date, shipped_date, ship_city, ship_state_province, ship_country_region, shipping_fee, payment_type) VALUES (35, 10, '2025-02-07 09:30:00', '2025-02-09 15:00:00', 'San Diego', 'CA', 'USA', 66.00, 'Credit Card');

-- ------------------------------------------------------------
-- Tabla order_details
-- ------------------------------------------------------------
CREATE TABLE `order_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT DEFAULT NULL,
  `quantity` DECIMAL(18,4) NOT NULL DEFAULT '0.0000',
  `unit_price` DECIMAL(19,4) DEFAULT '0.0000',
  `discount` DOUBLE NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (1, 1, 5, 5, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (2, 1, 1, 4, 1299.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (3, 1, 16, 4, 459.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (4, 2, 5, 11, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (5, 3, 3, 1, 1599.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (6, 3, 13, 1, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (7, 3, 9, 2, 199.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (8, 4, 10, 9, 299.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (9, 5, 1, 12, 1299.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (10, 5, 11, 11, 129.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (11, 5, 5, 12, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (12, 6, 18, 10, 119.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (13, 6, 5, 5, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (14, 6, 10, 1, 299.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (15, 7, 18, 6, 119.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (16, 8, 6, 6, 1099.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (17, 8, 5, 2, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (18, 9, 17, 2, 89.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (19, 10, 16, 5, 459.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (20, 10, 13, 1, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (21, 11, 19, 7, 39.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (22, 11, 11, 2, 129.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (23, 11, 2, 9, 1099.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (24, 12, 16, 4, 459.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (25, 12, 13, 12, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (26, 13, 2, 11, 1099.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (27, 14, 13, 2, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (28, 15, 5, 7, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (29, 16, 19, 6, 39.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (30, 16, 14, 3, 799.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (31, 17, 16, 11, 459.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (32, 17, 5, 5, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (33, 18, 3, 3, 1599.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (34, 18, 13, 9, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (35, 18, 14, 12, 799.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (36, 19, 7, 8, 649.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (37, 20, 11, 11, 129.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (38, 20, 19, 12, 39.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (39, 21, 10, 1, 299.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (40, 21, 14, 4, 799.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (41, 21, 7, 1, 649.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (42, 22, 17, 2, 89.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (43, 22, 6, 4, 1099.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (44, 23, 14, 8, 799.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (45, 23, 5, 7, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (46, 23, 20, 11, 59.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (47, 24, 6, 3, 1099.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (48, 24, 20, 4, 59.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (49, 25, 11, 7, 129.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (50, 25, 16, 10, 459.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (51, 25, 13, 7, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (52, 26, 10, 9, 299.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (53, 26, 3, 8, 1599.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (54, 27, 2, 2, 1099.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (55, 28, 7, 11, 649.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (56, 29, 3, 7, 1599.99, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (57, 29, 9, 10, 199.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (58, 30, 11, 1, 129.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (59, 30, 20, 11, 59.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (60, 31, 5, 5, 899.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (61, 31, 14, 11, 799.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (62, 31, 11, 6, 129.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (63, 32, 13, 7, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (64, 33, 19, 1, 39.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (65, 34, 11, 3, 129.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (66, 34, 20, 9, 59.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (67, 34, 17, 2, 89.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (68, 35, 13, 9, 599.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (69, 35, 18, 10, 119.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (70, 35, 14, 4, 799.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (71, 1, 19, 60, 39.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (72, 9, 7, 55, 649.00, 0);
INSERT INTO order_details (id, order_id, product_id, quantity, unit_price, discount) VALUES (73, 19, 17, 50, 89.00, 0);
