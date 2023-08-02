DROP DATABASE IF EXISTS ummc;
CREATE DATABASE ummc;
USE ummc;

DROP TABLE IF EXISTS sql_city;
CREATE TABLE sql_city (
	area FLOAT,
	city_id BIGINT PRIMARY KEY,
	city_name VARCHAR(50),
	population BIGINT,
	state VARCHAR(50),
	INDEX city_name_idx(city_name)
);

DROP TABLE IF EXISTS sql_customer;
CREATE TABLE sql_customer (
	cust_id BIGINT PRIMARY KEY,
	cust_name VARCHAR(50),
	annual_revenue BIGINT,
	cust_type VARCHAR(50),
	address VARCHAR(50),
	zip BIGINT,
	phone VARCHAR(50),
	city_id BIGINT, 
	INDEX cust_name_idx(cust_name),
	
FOREIGN KEY (city_id) REFERENCES sql_city(city_id) ON UPDATE CASCADE ON DELETE CASCADE	
);

DROP TABLE IF EXISTS sql_driver;
CREATE TABLE sql_driver (
	driver_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	address VARCHAR(50),
	zip_code BIGINT,
	phone VARCHAR(50),
	city_id BIGINT,
	
	FOREIGN KEY (city_id) REFERENCES sql_city(city_id) ON UPDATE CASCADE ON DELETE CASCADE	
);

DROP TABLE IF EXISTS sql_truck;
CREATE TABLE sql_truck (
	truck_id INT PRIMARY KEY,
	make VARCHAR(50),
	model_year YEAR
);

DROP TABLE IF EXISTS sql_shipment;
CREATE TABLE sql_shipment (
	ship_id INT PRIMARY KEY,
	cust_id BIGINT,
	weight FLOAT,
	driver_id INT,
	city_id BIGINT,
	ship_date DATE,
	truck_id INT,
	
	FOREIGN KEY (cust_id) REFERENCES sql_customer(cust_id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (driver_id) REFERENCES sql_driver(driver_id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (city_id) REFERENCES sql_city(city_id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (truck_id) REFERENCES sql_truck(truck_id) ON UPDATE CASCADE ON DELETE SET NULL
);