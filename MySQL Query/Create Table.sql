# Create tables

CREATE TABLE calendar (
    date DATE,
    year INT,
    month INT,
    day INT,
    week INT,
    day_of_week INT,
    month_name VARCHAR(50),
    day_name VARCHAR(50),
    week_of_year INT
);

CREATE TABLE stores (
    store_id VARCHAR(50),
    store_name VARCHAR(50),
    city VARCHAR(50),
    store_type VARCHAR(50),
    country_name VARCHAR(50)
);

CREATE TABLE sales (
    order_id VARCHAR(50),
    order_date DATE,
    product_id VARCHAR(50),
    store_id VARCHAR(50),
    customer_id VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    revenue DECIMAL(10,2),
    cost DECIMAL(10,2),
    profit DECIMAL(10,2)
);

CREATE TABLE products (
    product_id VARCHAR(50),
    product_name VARCHAR(100),
    brand VARCHAR(50),
    category VARCHAR(50),
    cocoa_percent INT,
    weight_g INT,
    full_product_name VARCHAR(150)
);

CREATE TABLE customers (
    customer_id VARCHAR(50),
    age INT,
    gender VARCHAR(50),
    join_date DATE,
    loyalty_member VARCHAR(50),
    age_category VARCHAR(100)
);

# Create Flag Table
CREATE TABLE country_metadata (
    country_name VARCHAR(100) PRIMARY KEY,
    flag_url VARCHAR(255)
);

INSERT INTO 
	country_metadata (country_name, flag_url)
VALUES 
	('Australia', 'https://flagcdn.com/w160/au.png'),
	('Canada', 'https://flagcdn.com/w160/ca.png'),
	('France', 'https://flagcdn.com/w160/fr.png'),
	('Germany', 'https://flagcdn.com/w160/de.png'),
	('UK', 'https://flagcdn.com/w160/gb.png'),
	('USA', 'https://flagcdn.com/w160/us.png');
