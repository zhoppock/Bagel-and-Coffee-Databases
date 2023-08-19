CREATE DATABASE jaunty_coffee_co;
USE jaunty_coffee_co;
CREATE TABLE coffee_shop (
	shop_id		INT,
    shop_name	VARCHAR(50),
    city		VARCHAR(50),
    state		CHAR(2),
    PRIMARY KEY (shop_id)
);
CREATE TABLE supplier (
	supplier_id			INT,
    company_name		VARCHAR(50),
    country				VARCHAR(30),
    sales_contact_name	VARCHAR(60),
    email				VARCHAR(50) NOT NULL,
    PRIMARY KEY (supplier_id)
);
CREATE TABLE employee (
	employee_id	INT,
    first_name	VARCHAR(30),
    last_name	VARCHAR(30),
    hire_date	DATE,
    job_title	VARCHAR(30),
    shop_id		INT,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (shop_id) REFERENCES coffee_shop(shop_id)
);
CREATE TABLE coffee (
	coffee_id		INT,
    shop_id			INT,
    supplier_id		INT,
    coffee_name		VARCHAR(30),
    price_per_pound	NUMERIC(5, 2),
    PRIMARY KEY (coffee_id),
    FOREIGN KEY (shop_id) REFERENCES coffee_shop(shop_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

INSERT INTO coffee_shop
VALUES	(1, 'Coffee Bean Needs', 'Miami', 'FL'),
		(2, 'Java Needs', 'Tampa Bay', 'FL'),
        (3, 'Mocha Lot, Eh?', 'Atlanta', 'GA');
INSERT INTO employee
VALUES	(11, 'James', 'Brendon', '2015-04-12', 'Manager', 1),
		(12, 'Madison', 'Sauls', '2015-04-14', 'Barista', 1),
        (13, 'Jeremy', 'Elbertson', '2015-05-02', 'Barista', 1),
        (21, 'Monique', 'Mendez', '2016-11-23', 'Manager', 2),
        (22, 'Thomas', 'Sholts', '2016-11-23', 'Barista', 2),
        (23, 'Timothy', 'Morris', '2016-11-28', 'Barista', 2),
        (31, 'Velma', 'Dinklidge', '2016-12-01', 'Manager', 3),
        (32, 'Fred', 'Jonesy', '2016-12-10', 'Barista', 3),
        (33, 'Madison', 'Lillith', '2017-01-09', 'Barista', 3);
INSERT INTO supplier
VALUES	(100, 'Miami Blend Specialty', 'United States', 'Dillon Michaels', 'dmichaels@mblends.com'),
		(200, 'Scottsdale Java', 'Ireland', 'Sam Smith', 'samsmith@scottsdalej.com'),
        (300, 'Southern Hospitality', 'United States', 'Terry Grimes', 'terrygrimes@sohos.com');
INSERT INTO coffee
VALUES	(101, 1, 100, 'Ocean Breeze Latte', 1.75),
		(102, 1, 100, 'Mocha Sea, Mocha Do', 1.95),
        (201, 2, 100, 'Latte On The Rocks', 1.55),
        (202, 2, 300, 'Fresh Blend Coffee', 2.75),
        (301, 3, 200, 'Top Of the Morning', 1.35),
        (302, 3, 300, 'Dark Blend Coffee', 2.65);
        
CREATE VIEW employee_info AS
SELECT
	employee_id,
	CONCAT(first_name, ' ', last_name) AS employee_full_name,
    hire_date,
    job_title,
    shop_id
FROM
	employee;

CREATE INDEX coffee_name_idx
ON coffee (coffee_name);

SELECT
	supplier_id,
    coffee_name,
    price_per_pound
FROM
	coffee
WHERE
	price_per_pound < 2;
    
SELECT
	shop_name, city, state, 									-- from coffee_shop table
    coffee_name, price_per_pound, 								-- from coffee table
    company_name AS supplier_name, country AS supplier_country	-- from supplier table
FROM coffee_shop
INNER JOIN coffee ON coffee_shop.shop_id = coffee.shop_id
INNER JOIN supplier ON coffee.supplier_id = supplier.supplier_id
ORDER BY shop_name;
    