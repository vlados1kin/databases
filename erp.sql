-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.11.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for erp
CREATE DATABASE IF NOT EXISTS `erp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `erp`;

-- Dumping structure for table erp.addresses
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `address_line1` varchar(255) NOT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.addresses: ~2 rows (approximately)
INSERT INTO `addresses` (`id`, `entity_type`, `entity_id`, `address_line1`, `address_line2`, `city`, `state`, `postal_code`, `country`) VALUES
	(1, 'users', 1, '123 Maple St', NULL, 'CityA', 'StateA', '12345', 'USA'),
	(2, 'customers', 1, '456 Oak St', 'Suite 100', 'CityB', 'StateB', '23456', 'USA');

-- Dumping structure for table erp.assets
CREATE TABLE IF NOT EXISTS `assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `value` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.assets: ~2 rows (approximately)
INSERT INTO `assets` (`id`, `name`, `purchase_date`, `value`) VALUES
	(1, 'Laptop', '2024-01-01', 1500.00),
	(2, 'Printer', '2023-05-15', 300.00);

-- Dumping structure for table erp.asset_movements
CREATE TABLE IF NOT EXISTS `asset_movements` (
  `asset_id` int(11) NOT NULL,
  `from_location` varchar(100) DEFAULT NULL,
  `to_location` varchar(100) DEFAULT NULL,
  `moved_on` datetime NOT NULL,
  PRIMARY KEY (`asset_id`,`moved_on`),
  CONSTRAINT `asset_movements_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.asset_movements: ~2 rows (approximately)
INSERT INTO `asset_movements` (`asset_id`, `from_location`, `to_location`, `moved_on`) VALUES
	(1, 'Office', 'Home', '2025-01-10 09:00:00'),
	(2, 'Warehouse', 'Office', '2025-01-11 10:00:00');

-- Dumping structure for table erp.audit_trail
CREATE TABLE IF NOT EXISTS `audit_trail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `record_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `changed_by` (`changed_by`),
  CONSTRAINT `audit_trail_ibfk_1` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.audit_trail: ~11 rows (approximately)
INSERT INTO `audit_trail` (`id`, `table_name`, `record_id`, `action`, `changed_by`, `changed_at`) VALUES
	(1, 'users', 1, 'INSERT', 1, '2025-05-14 05:57:58'),
	(2, 'users', 2, 'INSERT', 2, '2025-05-14 05:57:58'),
	(3, 'users', 3, 'INSERT', 3, '2025-05-14 05:57:58'),
	(4, 'users', 4, 'INSERT', 4, '2025-05-14 05:57:58'),
	(5, 'inventory', 1, 'UPDATE', NULL, '2025-05-14 05:57:58'),
	(6, 'inventory', 2, 'UPDATE', NULL, '2025-05-14 05:57:58'),
	(7, 'inventory', 1, 'UPDATE', NULL, '2025-05-14 05:57:58'),
	(8, 'inventory', 2, 'UPDATE', NULL, '2025-05-14 05:57:58'),
	(9, 'users', 1, 'UPDATE', 1, '2025-05-14 05:58:19'),
	(10, 'orders', 1, 'CREATE', 2, '2025-05-14 05:58:19'),
	(11, 'inventory', 4, 'UPDATE', NULL, '2025-05-14 07:14:10'),
	(12, 'users', 5, 'INSERT', 5, '2025-05-14 07:20:02'),
	(13, 'users', 7, 'INSERT', 7, '2025-05-15 11:49:56'),
	(14, 'users', 9, 'INSERT', 9, '2025-05-15 11:50:45');

-- Dumping structure for table erp.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.categories: ~4 rows (approximately)
INSERT INTO `categories` (`id`, `name`, `description`) VALUES
	(1, 'Category A', 'Description A'),
	(2, 'Category B', 'Description B'),
	(3, 'Category C', 'Description C'),
	(4, 'Category D', 'Description D');

-- Dumping structure for table erp.configurations
CREATE TABLE IF NOT EXISTS `configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) NOT NULL,
  `config_value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.configurations: ~2 rows (approximately)
INSERT INTO `configurations` (`id`, `config_key`, `config_value`) VALUES
	(1, 'site_name', 'MySite'),
	(2, 'support_email', 'support@example.com');

-- Dumping structure for table erp.contacts
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `contact_type` varchar(50) DEFAULT NULL,
  `contact_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.contacts: ~3 rows (approximately)
INSERT INTO `contacts` (`id`, `entity_type`, `entity_id`, `contact_type`, `contact_value`) VALUES
	(1, 'users', 1, 'phone', '555-0100'),
	(2, 'customers', 1, 'email', 'alice.cust@example.com'),
	(3, 'suppliers', 1, 'email', 'sam.sup@example.com');

-- Dumping structure for table erp.currencies
CREATE TABLE IF NOT EXISTS `currencies` (
  `code` char(3) NOT NULL,
  `name` varchar(50) NOT NULL,
  `symbol` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.currencies: ~3 rows (approximately)
INSERT INTO `currencies` (`code`, `name`, `symbol`) VALUES
	('EUR', 'Euro', '€'),
	('GBP', 'British Pound', '£'),
	('USD', 'US Dollar', '$');

-- Dumping structure for table erp.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.customers: ~4 rows (approximately)
INSERT INTO `customers` (`id`, `company_name`, `contact_name`, `contact_email`, `created_at`) VALUES
	(1, 'Customer A', 'Alice Contact', 'alice.cust@example.com', '2025-01-05 06:00:00'),
	(2, 'Customer B', 'Bob Contact', 'bob.cust@example.com', '2025-01-06 06:00:00'),
	(3, 'Customer C', 'Carol Contact', 'carol.cust@example.com', '2025-01-07 06:00:00'),
	(4, 'Customer D', 'Dave Contact', 'dave.cust@example.com', '2025-01-08 06:00:00');

-- Dumping structure for table erp.departments
CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `organization_id` (`organization_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.departments: ~4 rows (approximately)
INSERT INTO `departments` (`id`, `organization_id`, `name`, `created_at`) VALUES
	(1, 1, 'HR', '2025-01-01 07:00:00'),
	(2, 1, 'IT', '2025-01-01 07:30:00'),
	(3, 2, 'Sales', '2025-01-02 07:00:00'),
	(4, 3, 'Support', '2025-01-03 07:00:00');

-- Dumping structure for table erp.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.employees: ~4 rows (approximately)
INSERT INTO `employees` (`id`, `first_name`, `last_name`, `email`, `phone`, `hire_date`, `created_at`) VALUES
	(1, 'John', 'Smith', 'john.smith@example.com', '555-0100', '2024-06-01', '2025-01-01 08:00:00'),
	(2, 'Jane', 'Doe', 'jane.doe@example.com', '555-0101', '2024-07-15', '2025-01-02 08:00:00'),
	(3, 'Jim', 'Beam', 'jim.beam@example.com', '555-0102', '2024-08-20', '2025-01-03 08:00:00'),
	(4, 'Jill', 'Stark', 'jill.stark@example.com', '555-0103', '2024-09-10', '2025-01-04 08:00:00');

-- Dumping structure for table erp.employee_departments
CREATE TABLE IF NOT EXISTS `employee_departments` (
  `employee_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employee_departments_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `employee_departments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.employee_departments: ~5 rows (approximately)
INSERT INTO `employee_departments` (`employee_id`, `department_id`) VALUES
	(1, 1),
	(1, 2),
	(2, 2),
	(3, 3),
	(4, 4);

-- Dumping structure for table erp.exchange_rates
CREATE TABLE IF NOT EXISTS `exchange_rates` (
  `from_currency` char(3) NOT NULL,
  `to_currency` char(3) NOT NULL,
  `rate` decimal(18,8) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`from_currency`,`to_currency`,`date`),
  KEY `to_currency` (`to_currency`),
  CONSTRAINT `exchange_rates_ibfk_1` FOREIGN KEY (`from_currency`) REFERENCES `currencies` (`code`) ON DELETE CASCADE,
  CONSTRAINT `exchange_rates_ibfk_2` FOREIGN KEY (`to_currency`) REFERENCES `currencies` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.exchange_rates: ~4 rows (approximately)
INSERT INTO `exchange_rates` (`from_currency`, `to_currency`, `rate`, `date`) VALUES
	('EUR', 'USD', 1.18000000, '2025-04-01'),
	('GBP', 'USD', 1.33000000, '2025-04-01'),
	('USD', 'EUR', 0.85000000, '2025-04-01'),
	('USD', 'GBP', 0.75000000, '2025-04-01');

-- Dumping structure for table erp.expenses
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `incurred_on` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  KEY `expense_category_id` (`expense_category_id`),
  CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.expenses: ~3 rows (approximately)
INSERT INTO `expenses` (`id`, `employee_id`, `expense_category_id`, `amount`, `incurred_on`) VALUES
	(1, 1, 1, 100.00, '2025-02-10'),
	(2, 2, 2, 50.00, '2025-02-11'),
	(3, 3, 3, 25.00, '2025-02-12');

-- Dumping structure for table erp.expense_categories
CREATE TABLE IF NOT EXISTS `expense_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.expense_categories: ~3 rows (approximately)
INSERT INTO `expense_categories` (`id`, `name`) VALUES
	(2, 'Meals'),
	(3, 'Supplies'),
	(1, 'Travel');

-- Dumping structure for function erp.fn_calculate_order_total
DELIMITER //
CREATE FUNCTION `fn_calculate_order_total`(p_order_id INT) RETURNS decimal(12,2)
    DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(12,2);
  SELECT SUM(quantity * unit_price) INTO total FROM `order_items` WHERE order_id = p_order_id;
  RETURN IFNULL(total, 0);
END//
DELIMITER ;

-- Dumping structure for function erp.fn_calculate_tax
DELIMITER //
CREATE FUNCTION `fn_calculate_tax`(p_amount DECIMAL(12,2), p_tax_rate DECIMAL(5,4)) RETURNS decimal(12,2)
    DETERMINISTIC
RETURN ROUND(p_amount * p_tax_rate, 2)//
DELIMITER ;

-- Dumping structure for function erp.fn_days_between
DELIMITER //
CREATE FUNCTION `fn_days_between`(p_start DATE, p_end DATE) RETURNS int(11)
    DETERMINISTIC
RETURN DATEDIFF(p_end, p_start)//
DELIMITER ;

-- Dumping structure for function erp.fn_format_currency
DELIMITER //
CREATE FUNCTION `fn_format_currency`(p_amount DECIMAL(12,2), p_symbol VARCHAR(10)) RETURNS varchar(50) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    DETERMINISTIC
RETURN CONCAT(p_symbol, FORMAT(p_amount, 2))//
DELIMITER ;

-- Dumping structure for function erp.fn_get_customer_balance
DELIMITER //
CREATE FUNCTION `fn_get_customer_balance`(p_customer_id INT) RETURNS decimal(12,2)
    DETERMINISTIC
BEGIN
  DECLARE bal DECIMAL(12,2);
  SELECT IFNULL(SUM(i.total_amount) - SUM(IFNULL(p.amount, 0)), 0)
  INTO bal
  FROM `invoices` i
  LEFT JOIN `payments` p ON i.id = p.invoice_id
  WHERE i.order_id IN (SELECT id FROM `orders` WHERE customer_id = p_customer_id);
  RETURN bal;
END//
DELIMITER ;

-- Dumping structure for function erp.fn_get_employee_fullname
DELIMITER //
CREATE FUNCTION `fn_get_employee_fullname`(p_emp_id INT) RETURNS varchar(101) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    DETERMINISTIC
BEGIN
  DECLARE fname VARCHAR(50);
  DECLARE lname VARCHAR(50);
  SELECT first_name, last_name INTO fname, lname FROM `employees` WHERE id = p_emp_id;
  RETURN CONCAT(fname, ' ', lname);
END//
DELIMITER ;

-- Dumping structure for function erp.fn_get_stock_level
DELIMITER //
CREATE FUNCTION `fn_get_stock_level`(p_product_id INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
  DECLARE qty INT;
  SELECT SUM(quantity_on_hand) INTO qty FROM `inventory` WHERE product_id = p_product_id;
  RETURN IFNULL(qty, 0);
END//
DELIMITER ;

-- Dumping structure for table erp.inventory
CREATE TABLE IF NOT EXISTS `inventory` (
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_id`,`warehouse_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.inventory: ~8 rows (approximately)
INSERT INTO `inventory` (`product_id`, `warehouse_id`, `quantity_on_hand`) VALUES
	(1, 1, 180),
	(1, 2, 200),
	(2, 1, 250),
	(3, 1, 70),
	(3, 3, 300),
	(4, 1, 40),
	(4, 2, 40),
	(4, 4, 400);

-- Dumping structure for table erp.invoices
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.invoices: ~4 rows (approximately)
INSERT INTO `invoices` (`id`, `order_id`, `invoice_date`, `due_date`, `total_amount`, `created_at`) VALUES
	(1, 1, '2025-02-05', '2025-02-15', 40.00, '2025-02-05 09:00:00'),
	(2, 2, '2025-02-06', '2025-02-16', 90.00, '2025-02-06 09:00:00'),
	(3, 3, '2025-02-07', '2025-02-17', 100.00, '2025-02-07 09:00:00'),
	(5, 5, '2025-05-14', '2025-06-13', 200.00, '2025-05-14 07:14:50');

-- Dumping structure for table erp.invoice_items
CREATE TABLE IF NOT EXISTS `invoice_items` (
  `invoice_id` int(11) NOT NULL,
  `order_item_order_id` int(11) NOT NULL,
  `order_item_product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`invoice_id`,`order_item_order_id`,`order_item_product_id`),
  KEY `order_item_order_id` (`order_item_order_id`,`order_item_product_id`),
  CONSTRAINT `invoice_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_items_ibfk_2` FOREIGN KEY (`order_item_order_id`, `order_item_product_id`) REFERENCES `order_items` (`order_id`, `product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.invoice_items: ~6 rows (approximately)
INSERT INTO `invoice_items` (`invoice_id`, `order_item_order_id`, `order_item_product_id`, `quantity`, `unit_price`) VALUES
	(1, 1, 1, 2, 10.00),
	(1, 1, 2, 1, 20.00),
	(2, 2, 2, 3, 20.00),
	(2, 2, 3, 1, 30.00),
	(3, 3, 3, 2, 30.00),
	(3, 3, 4, 1, 40.00);

-- Dumping structure for table erp.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `entity` varchar(100) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.logs: ~6 rows (approximately)
INSERT INTO `logs` (`id`, `user_id`, `action`, `entity`, `entity_id`, `created_at`) VALUES
	(1, NULL, 'Payment of 40.00 recorded for invoice 1', 'payments', 1, '2025-05-14 05:57:58'),
	(2, NULL, 'Payment of 90.00 recorded for invoice 2', 'payments', 2, '2025-05-14 05:57:58'),
	(3, NULL, 'Payment of 100.00 recorded for invoice 3', 'payments', 3, '2025-05-14 05:57:58'),
	(4, NULL, 'Payment of 90.00 recorded for invoice 4', 'payments', 4, '2025-05-14 05:57:58'),
	(5, 1, 'LOGIN', 'sessions', 1, '2025-01-01 06:05:00'),
	(6, 2, 'CREATE', 'orders', 2, '2025-02-02 09:05:00'),
	(7, NULL, 'Order status changed from New to Completed', 'orders', 5, '2025-05-14 07:21:47');

-- Dumping structure for table erp.maintenance_logs
CREATE TABLE IF NOT EXISTS `maintenance_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `logged_on` datetime NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `request_id` (`request_id`),
  CONSTRAINT `maintenance_logs_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `maintenance_requests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.maintenance_logs: ~2 rows (approximately)
INSERT INTO `maintenance_logs` (`id`, `request_id`, `logged_on`, `notes`) VALUES
	(1, 1, '2025-02-03 10:00:00', 'Fixed issue'),
	(2, 2, '2025-02-04 11:00:00', 'Replaced part');

-- Dumping structure for table erp.maintenance_requests
CREATE TABLE IF NOT EXISTS `maintenance_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `requested_by` int(11) DEFAULT NULL,
  `requested_on` datetime NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_id` (`asset_id`),
  KEY `requested_by` (`requested_by`),
  CONSTRAINT `maintenance_requests_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `maintenance_requests_ibfk_2` FOREIGN KEY (`requested_by`) REFERENCES `employees` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.maintenance_requests: ~2 rows (approximately)
INSERT INTO `maintenance_requests` (`id`, `asset_id`, `requested_by`, `requested_on`, `status`) VALUES
	(1, 1, 1, '2025-02-01 08:00:00', 'Open'),
	(2, 2, 2, '2025-02-02 09:00:00', 'Closed');

-- Dumping structure for table erp.message_templates
CREATE TABLE IF NOT EXISTS `message_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.message_templates: ~0 rows (approximately)

-- Dumping structure for table erp.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.notifications: ~2 rows (approximately)
INSERT INTO `notifications` (`id`, `title`, `body`, `created_at`) VALUES
	(1, 'Welcome', 'Welcome to the system', '2025-01-01 06:00:00'),
	(2, 'Reminder', 'Your invoice is due', '2025-02-10 06:00:00');

-- Dumping structure for table erp.notification_recipients
CREATE TABLE IF NOT EXISTS `notification_recipients` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `read` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`notification_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notification_recipients_ibfk_1` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notification_recipients_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.notification_recipients: ~4 rows (approximately)
INSERT INTO `notification_recipients` (`notification_id`, `user_id`, `read`) VALUES
	(1, 1, 0),
	(1, 2, 1),
	(2, 1, 0),
	(2, 3, 0);

-- Dumping structure for table erp.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.orders: ~4 rows (approximately)
INSERT INTO `orders` (`id`, `customer_id`, `order_date`, `status`, `created_at`) VALUES
	(1, 1, '2025-02-01', 'Pending', '2025-02-01 09:00:00'),
	(2, 2, '2025-02-02', 'Shipped', '2025-02-02 09:00:00'),
	(3, 3, '2025-02-03', 'Completed', '2025-02-03 09:00:00'),
	(5, 1, '2025-05-10', 'Completed', '2025-05-14 06:56:17');

-- Dumping structure for table erp.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.order_items: ~6 rows (approximately)
INSERT INTO `order_items` (`order_id`, `product_id`, `quantity`, `unit_price`) VALUES
	(1, 1, 2, 10.00),
	(1, 2, 1, 20.00),
	(2, 2, 3, 20.00),
	(2, 3, 1, 30.00),
	(3, 3, 2, 30.00),
	(3, 4, 1, 40.00),
	(5, 2, 10, 20.00);

-- Dumping structure for table erp.organizations
CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.organizations: ~4 rows (approximately)
INSERT INTO `organizations` (`id`, `name`, `address`, `created_at`) VALUES
	(1, 'Org A', '123 Main St', '2025-01-01 06:00:00'),
	(2, 'Org B', '456 Elm St', '2025-01-02 06:00:00'),
	(3, 'Org C', '789 Oak St', '2025-01-03 06:00:00'),
	(4, 'Org D', '321 Pine St', '2025-01-04 06:00:00');

-- Dumping structure for table erp.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `payment_method_id` (`payment_method_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.payments: ~4 rows (approximately)
INSERT INTO `payments` (`id`, `invoice_id`, `payment_date`, `amount`, `payment_method_id`, `created_at`) VALUES
	(1, 1, '2025-02-10', 40.00, 1, '2025-02-10 10:00:00'),
	(2, 2, '2025-02-11', 90.00, 2, '2025-02-11 10:00:00'),
	(3, 3, '2025-02-12', 100.00, 3, '2025-02-12 10:00:00');

-- Dumping structure for table erp.payment_methods
CREATE TABLE IF NOT EXISTS `payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `method_name` varchar(50) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `method_name` (`method_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.payment_methods: ~3 rows (approximately)
INSERT INTO `payment_methods` (`id`, `method_name`, `details`) VALUES
	(1, 'Credit Card', 'Visa'),
	(2, 'PayPal', 'PayPal account'),
	(3, 'Bank Transfer', 'IBAN details');

-- Dumping structure for table erp.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.permissions: ~4 rows (approximately)
INSERT INTO `permissions` (`id`, `name`, `description`) VALUES
	(1, 'read', 'Read permission'),
	(2, 'write', 'Write permission'),
	(3, 'delete', 'Delete permission'),
	(4, 'update', 'Update permission');

-- Dumping structure for table erp.price_lists
CREATE TABLE IF NOT EXISTS `price_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `effective_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.price_lists: ~3 rows (approximately)
INSERT INTO `price_lists` (`id`, `name`, `effective_date`) VALUES
	(1, 'PriceList A', '2025-01-01'),
	(2, 'PriceList B', '2025-02-01'),
	(3, 'PriceList C', '2025-03-01');

-- Dumping structure for table erp.price_list_items
CREATE TABLE IF NOT EXISTS `price_list_items` (
  `price_list_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`price_list_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `price_list_items_ibfk_1` FOREIGN KEY (`price_list_id`) REFERENCES `price_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `price_list_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.price_list_items: ~6 rows (approximately)
INSERT INTO `price_list_items` (`price_list_id`, `product_id`, `price`) VALUES
	(1, 1, 9.50),
	(1, 2, 19.00),
	(2, 3, 29.00),
	(2, 4, 39.00),
	(3, 1, 9.00),
	(3, 4, 38.00);

-- Dumping structure for table erp.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `sku` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `supplier_id` (`supplier_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.products: ~4 rows (approximately)
INSERT INTO `products` (`id`, `supplier_id`, `category_id`, `sku`, `name`, `description`, `unit_price`, `created_at`) VALUES
	(1, 1, 1, 'SKU001', 'Product A', 'Desc A', 10.00, '2025-01-05 08:00:00'),
	(2, 2, 2, 'SKU002', 'Product B', 'Desc B', 20.00, '2025-01-06 08:00:00'),
	(3, 3, 3, 'SKU003', 'Product C', 'Desc C', 30.00, '2025-01-07 08:00:00'),
	(4, 4, 4, 'SKU004', 'Product D', 'Desc D', 40.00, '2025-01-08 08:00:00');

-- Dumping structure for table erp.product_categories
CREATE TABLE IF NOT EXISTS `product_categories` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.product_categories: ~6 rows (approximately)
INSERT INTO `product_categories` (`product_id`, `category_id`) VALUES
	(1, 2),
	(1, 3),
	(2, 1),
	(3, 4),
	(4, 1),
	(4, 2);

-- Dumping structure for table erp.projects
CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.projects: ~2 rows (approximately)
INSERT INTO `projects` (`id`, `name`, `start_date`, `end_date`, `status`) VALUES
	(1, 'Project Alpha', '2025-01-01', '2025-06-01', 'Active'),
	(2, 'Project Beta', '2025-02-01', '2025-07-01', 'Planned');

-- Dumping structure for table erp.project_tasks
CREATE TABLE IF NOT EXISTS `project_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `assignee_id` int(11) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `assignee_id` (`assignee_id`),
  CONSTRAINT `project_tasks_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_tasks_ibfk_2` FOREIGN KEY (`assignee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.project_tasks: ~3 rows (approximately)
INSERT INTO `project_tasks` (`id`, `project_id`, `name`, `assignee_id`, `due_date`, `status`) VALUES
	(1, 1, 'Task 1', 1, '2025-03-01', 'Open'),
	(2, 1, 'Task 2', 2, '2025-04-01', 'InProgress'),
	(3, 2, 'Task 3', 3, '2025-05-01', 'Open');

-- Dumping structure for table erp.purchase_orders
CREATE TABLE IF NOT EXISTS `purchase_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.purchase_orders: ~4 rows (approximately)
INSERT INTO `purchase_orders` (`id`, `supplier_id`, `order_date`, `status`, `created_at`) VALUES
	(1, 1, '2025-03-01', 'Ordered', '2025-03-01 07:00:00'),
	(2, 2, '2025-03-02', 'Received', '2025-03-02 07:00:00'),
	(3, 3, '2025-03-03', 'Cancelled', '2025-03-03 07:00:00'),
	(4, 4, '2025-03-04', 'Pending', '2025-03-04 07:00:00');

-- Dumping structure for table erp.purchase_order_items
CREATE TABLE IF NOT EXISTS `purchase_order_items` (
  `purchase_order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`purchase_order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `purchase_order_items_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.purchase_order_items: ~6 rows (approximately)
INSERT INTO `purchase_order_items` (`purchase_order_id`, `product_id`, `quantity`, `unit_cost`) VALUES
	(1, 1, 50, 8.00),
	(1, 2, 60, 15.00),
	(2, 3, 70, 25.00),
	(2, 4, 80, 35.00),
	(3, 1, 30, 8.00),
	(4, 2, 40, 15.00);

-- Dumping structure for table erp.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.roles: ~4 rows (approximately)
INSERT INTO `roles` (`id`, `name`, `description`, `created_at`) VALUES
	(1, 'Admin', 'Administrator role', '2025-01-01 06:00:00'),
	(2, 'Manager', 'Manager role', '2025-01-02 06:00:00'),
	(3, 'User', 'Regular user role', '2025-01-03 06:00:00'),
	(4, 'Guest', 'Guest role', '2025-01-04 06:00:00');

-- Dumping structure for table erp.role_permissions
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.role_permissions: ~9 rows (approximately)
INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(2, 1),
	(2, 2),
	(2, 4),
	(3, 1),
	(4, 1);

-- Dumping structure for table erp.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` char(128) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.sessions: ~2 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `created_at`, `expires_at`) VALUES
	('sess1', 1, '2025-05-01 05:00:00', '2025-05-02 05:00:00'),
	('sess2', 2, '2025-05-02 06:00:00', '2025-05-03 06:00:00');

-- Dumping structure for table erp.shipments
CREATE TABLE IF NOT EXISTS `shipments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `shipment_date` date NOT NULL,
  `carrier` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.shipments: ~4 rows (approximately)
INSERT INTO `shipments` (`id`, `order_id`, `shipment_date`, `carrier`, `tracking_number`, `created_at`) VALUES
	(1, 1, '2025-02-03', 'UPS', '1Z999AA101', '2025-05-14 05:57:58'),
	(2, 2, '2025-02-04', 'FedEx', '999999999', '2025-05-14 05:57:58'),
	(3, 3, '2025-02-05', 'DHL', 'JVGL999', '2025-05-14 05:57:58');

-- Dumping structure for table erp.shipment_items
CREATE TABLE IF NOT EXISTS `shipment_items` (
  `shipment_id` int(11) NOT NULL,
  `order_item_order_id` int(11) NOT NULL,
  `order_item_product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`shipment_id`,`order_item_order_id`,`order_item_product_id`),
  KEY `order_item_order_id` (`order_item_order_id`,`order_item_product_id`),
  CONSTRAINT `shipment_items_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shipment_items_ibfk_2` FOREIGN KEY (`order_item_order_id`, `order_item_product_id`) REFERENCES `order_items` (`order_id`, `product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.shipment_items: ~6 rows (approximately)
INSERT INTO `shipment_items` (`shipment_id`, `order_item_order_id`, `order_item_product_id`, `quantity`) VALUES
	(1, 1, 1, 2),
	(1, 1, 2, 1),
	(2, 2, 2, 3),
	(2, 2, 3, 1),
	(3, 3, 3, 2),
	(3, 3, 4, 1);

-- Dumping structure for procedure erp.sp_add_product_to_order
DELIMITER //
CREATE PROCEDURE `sp_add_product_to_order`(
  IN p_order_id INT,
  IN p_product_id INT,
  IN p_quantity INT
)
BEGIN
  DECLARE price DECIMAL(10,2);

  SELECT unit_price INTO price
  FROM products
  WHERE id = p_product_id
  LIMIT 1;

  IF price IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Product not found or unit_price is NULL';
  END IF;

  INSERT INTO order_items (order_id, product_id, quantity, unit_price)
  VALUES (p_order_id, p_product_id, p_quantity, price);
END//
DELIMITER ;

-- Dumping structure for procedure erp.sp_assign_employee_to_department
DELIMITER //
CREATE PROCEDURE `sp_assign_employee_to_department`(
  IN p_employee_id INT,
  IN p_department_id INT
)
BEGIN
  INSERT IGNORE INTO `employee_departments`(`employee_id`,`department_id`)
  VALUES(p_employee_id, p_department_id);
END//
DELIMITER ;

-- Dumping structure for procedure erp.sp_create_invoice
DELIMITER //
CREATE PROCEDURE `sp_create_invoice`(
  IN p_order_id INT,
  OUT p_invoice_id INT
)
BEGIN
  DECLARE total DECIMAL(12,2) DEFAULT 0;
  SELECT SUM(quantity * unit_price) INTO total FROM `order_items` WHERE order_id = p_order_id;
  INSERT INTO `invoices`(`order_id`,`invoice_date`,`due_date`,`total_amount`)
  VALUES(p_order_id, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), total);
  SET p_invoice_id = LAST_INSERT_ID();
END//
DELIMITER ;

-- Dumping structure for procedure erp.sp_create_order
DELIMITER //
CREATE PROCEDURE `sp_create_order`(
  IN p_customer_id INT,
  IN p_order_date DATE,
  OUT p_order_id INT
)
BEGIN
  INSERT INTO `orders`(`customer_id`,`order_date`,`status`)
  VALUES(p_customer_id, p_order_date, 'New');
  SET p_order_id = LAST_INSERT_ID();
END//
DELIMITER ;

-- Dumping structure for procedure erp.sp_record_payment
DELIMITER //
CREATE PROCEDURE `sp_record_payment`(
  IN p_invoice_id INT,
  IN p_amount DECIMAL(12,2),
  IN p_method_id INT
)
BEGIN
  INSERT INTO `payments`(`invoice_id`,`payment_date`,`amount`,`payment_method_id`)
  VALUES(p_invoice_id, CURDATE(), p_amount, p_method_id);
END//
DELIMITER ;

-- Dumping structure for procedure erp.sp_transfer_stock
DELIMITER //
CREATE PROCEDURE `sp_transfer_stock`(
  IN p_product_id INT,
  IN p_from_wh INT,
  IN p_to_wh INT,
  IN p_quantity INT
)
BEGIN
  UPDATE `inventory` SET quantity_on_hand = quantity_on_hand - p_quantity
    WHERE product_id = p_product_id AND warehouse_id = p_from_wh;
  INSERT INTO `inventory`(`product_id`,`warehouse_id`,`quantity_on_hand`)
    VALUES(p_product_id, p_to_wh, p_quantity)
    ON DUPLICATE KEY UPDATE quantity_on_hand = quantity_on_hand + p_quantity;
END//
DELIMITER ;

-- Dumping structure for table erp.suppliers
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.suppliers: ~4 rows (approximately)
INSERT INTO `suppliers` (`id`, `company_name`, `contact_name`, `contact_email`, `created_at`) VALUES
	(1, 'Supplier A', 'Sam Supplier', 'sam.sup@example.com', '2025-01-05 07:00:00'),
	(2, 'Supplier B', 'Sue Supplier', 'sue.sup@example.com', '2025-01-06 07:00:00'),
	(3, 'Supplier C', 'Sid Supplier', 'sid.sup@example.com', '2025-01-07 07:00:00'),
	(4, 'Supplier D', 'Sky Supplier', 'sky.sup@example.com', '2025-01-08 07:00:00');

-- Dumping structure for table erp.system_settings
CREATE TABLE IF NOT EXISTS `system_settings` (
  `key` varchar(100) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.system_settings: ~0 rows (approximately)

-- Dumping structure for table erp.taxation_rules
CREATE TABLE IF NOT EXISTS `taxation_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `rate` decimal(5,4) NOT NULL,
  `applicable_from` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.taxation_rules: ~2 rows (approximately)
INSERT INTO `taxation_rules` (`id`, `name`, `rate`, `applicable_from`) VALUES
	(1, 'VAT', 0.2000, '2025-01-01'),
	(2, 'GST', 0.1000, '2025-01-15');

-- Dumping structure for table erp.timesheets
CREATE TABLE IF NOT EXISTS `timesheets` (
  `employee_id` int(11) NOT NULL,
  `project_task_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `hours` decimal(4,2) NOT NULL,
  PRIMARY KEY (`employee_id`,`project_task_id`,`date`),
  KEY `project_task_id` (`project_task_id`),
  CONSTRAINT `timesheets_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `timesheets_ibfk_2` FOREIGN KEY (`project_task_id`) REFERENCES `project_tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.timesheets: ~4 rows (approximately)
INSERT INTO `timesheets` (`employee_id`, `project_task_id`, `date`, `hours`) VALUES
	(1, 1, '2025-02-01', 8.00),
	(2, 1, '2025-02-01', 6.00),
	(2, 2, '2025-02-02', 7.50),
	(3, 3, '2025-02-03', 8.00);

-- Dumping structure for table erp.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.users: ~7 rows (approximately)
INSERT INTO `users` (`id`, `username`, `password_hash`, `email`, `created_at`, `updated_at`) VALUES
	(1, 'alice', 'hash1', 'alice@example.com', '2025-01-01 06:00:00', '2025-01-01 06:00:00'),
	(2, 'bob', 'hash2', 'bob@example.com', '2025-01-02 07:00:00', '2025-01-02 07:00:00'),
	(3, 'carol', 'hash3', 'carol@example.com', '2025-01-03 08:00:00', '2025-01-03 08:00:00'),
	(4, 'dave', 'hash4', 'dave@example.com', '2025-01-04 09:00:00', '2025-01-04 09:00:00'),
	(5, 'test', 'test', 'test@test.com', '2025-05-13 21:00:00', '2025-05-13 21:00:00'),
	(7, 'tptptpt', 'test', 'www@aaa.com', '2025-05-14 21:00:00', '2025-05-14 21:00:00'),
	(9, '111111', 'test', 'www@ahhhaa.com', '2025-05-14 21:00:00', '2025-05-14 21:00:00');

-- Dumping structure for table erp.user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.user_roles: ~4 rows (approximately)
INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4);

-- Dumping structure for view erp.v_customer_balances
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_customer_balances` (
	`customer_id` INT(11) NOT NULL,
	`company_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`balance` DECIMAL(12,2) NULL
) ENGINE=MyISAM;

-- Dumping structure for view erp.v_employee_directory
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_employee_directory` (
	`employee_id` INT(11) NOT NULL,
	`fullname` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`phone` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- Dumping structure for view erp.v_inventory_levels
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_inventory_levels` (
	`product_id` INT(11) NOT NULL,
	`name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`quantity_on_hand` INT(11) NULL
) ENGINE=MyISAM;

-- Dumping structure for view erp.v_order_overview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_order_overview` (
	`order_id` INT(11) NOT NULL,
	`company_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`order_date` DATE NOT NULL,
	`status` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`total_amount` DECIMAL(12,2) NULL
) ENGINE=MyISAM;

-- Dumping structure for view erp.v_purchase_order_status
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_purchase_order_status` (
	`id` INT(11) NOT NULL,
	`supplier` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`order_date` DATE NOT NULL,
	`status` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`total_cost` DECIMAL(42,2) NULL
) ENGINE=MyISAM;

-- Dumping structure for view erp.v_sales_summary
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_sales_summary` (
	`sale_date` DATE NULL,
	`daily_sales` DECIMAL(42,2) NULL
) ENGINE=MyISAM;

-- Dumping structure for table erp.warehouses
CREATE TABLE IF NOT EXISTS `warehouses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table erp.warehouses: ~4 rows (approximately)
INSERT INTO `warehouses` (`id`, `name`, `location`) VALUES
	(1, 'Warehouse A', 'Location A'),
	(2, 'Warehouse B', 'Location B'),
	(3, 'Warehouse C', 'Location C'),
	(4, 'Warehouse D', 'Location D');

-- Dumping structure for trigger erp.trg_inventory_after_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_inventory_after_update`
AFTER UPDATE ON `inventory`
FOR EACH ROW
BEGIN
  INSERT INTO `audit_trail`(`table_name`,`record_id`,`action`,`changed_by`)
  VALUES('inventory', OLD.product_id, 'UPDATE', NULL);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger erp.trg_orders_status_change
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_orders_status_change`
BEFORE UPDATE ON `orders`
FOR EACH ROW
BEGIN
  IF OLD.status <> NEW.status THEN
    INSERT INTO `logs`(`user_id`,`action`,`entity`,`entity_id`)
    VALUES(NULL, CONCAT('Order status changed from ', OLD.status, ' to ', NEW.status), 'orders', NEW.id);
  END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger erp.trg_payments_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_payments_after_insert`
AFTER INSERT ON `payments`
FOR EACH ROW
BEGIN
  INSERT INTO `logs`(`user_id`,`action`,`entity`,`entity_id`)
  VALUES(NULL, CONCAT('Payment of ', NEW.amount, ' recorded for invoice ', NEW.invoice_id), 'payments', NEW.id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger erp.trg_products_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_products_before_update`
BEFORE UPDATE ON `products`
FOR EACH ROW
BEGIN
  SET NEW.created_at = OLD.created_at;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger erp.trg_purchase_order_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_purchase_order_after_insert`
AFTER INSERT ON `purchase_order_items`
FOR EACH ROW
BEGIN
  INSERT INTO `inventory`(`product_id`,`warehouse_id`,`quantity_on_hand`)
  VALUES(NEW.product_id, 1, NEW.quantity)
  ON DUPLICATE KEY UPDATE quantity_on_hand = quantity_on_hand + NEW.quantity;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger erp.trg_shipments_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_shipments_before_insert`
BEFORE INSERT ON `shipments`
FOR EACH ROW
BEGIN
  SET NEW.created_at = NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger erp.trg_users_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_users_after_insert`
AFTER INSERT ON `users`
FOR EACH ROW
BEGIN
  INSERT INTO `audit_trail`(`table_name`,`record_id`,`action`,`changed_by`)
  VALUES('users', NEW.id, 'INSERT', NEW.id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_customer_balances`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_customer_balances` AS SELECT c.id AS customer_id, c.company_name,
       fn_get_customer_balance(c.id) AS balance
FROM customers c 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_employee_directory`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_employee_directory` AS SELECT id AS employee_id, fn_get_employee_fullname(id) AS fullname, email, phone
FROM employees 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_inventory_levels`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_inventory_levels` AS SELECT p.id AS product_id, p.name, fn_get_stock_level(p.id) AS quantity_on_hand
FROM products p 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_order_overview`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_order_overview` AS SELECT o.id AS order_id, c.company_name, o.order_date, o.status,
       fn_calculate_order_total(o.id) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_purchase_order_status`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_purchase_order_status` AS SELECT po.id, s.company_name AS supplier, po.order_date, po.status,
       SUM(poi.quantity * poi.unit_cost) AS total_cost
FROM purchase_orders po
JOIN suppliers s ON po.supplier_id = s.id
JOIN purchase_order_items poi ON po.id = poi.purchase_order_id
GROUP BY po.id 
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_sales_summary`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_sales_summary` AS SELECT DATE(o.order_date) AS sale_date,
       SUM(oi.quantity * oi.unit_price) AS daily_sales
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY DATE(o.order_date) 
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
