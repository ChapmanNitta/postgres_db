-- Drop all tables to allow scripts below to be re-run

DROP TABLE IF EXISTS account CASCADE;
DROP TABLE IF EXISTS brick_and_mortar CASCADE;
DROP TABLE IF EXISTS distributor CASCADE;
DROP TABLE IF EXISTS flavor CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS online CASCADE;
DROP TABLE IF EXISTS order_details CASCADE;
DROP TABLE IF EXISTS purchase_order CASCADE;
DROP TABLE IF EXISTS sale CASCADE;
DROP TABLE IF EXISTS sale_details CASCADE;

-- Create Account Table
CREATE TABLE account(
  account_id SERIAL PRIMARY KEY,
  email_address VARCHAR(255) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  account_created_date DATE NOT NULL
);

-- Create Distributor Table
CREATE TABLE distributor(
  distributor_id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Create Flavor Table
CREATE TABLE flavor(
  flavor_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(1000) NOT NULL,
  price DECIMAL(12,2)
);

-- Create brick and mortar table
CREATE TABLE brick_and_mortar(
  distributor_id INT PRIMARY KEY REFERENCES distributor(distributor_id),
  address VARCHAR(255) NOT NULL,
  address_secondary VARCHAR(255) NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  zipcode INT NOT NULL
);

-- Create online table
CREATE TABLE online(
  distributor_id INT PRIMARY KEY REFERENCES distributor(distributor_id),
  website VARCHAR(255)
);

-- Create purchase order table
CREATE TABLE purchase_order(
  purchase_order_id SERIAL PRIMARY KEY,
  account_id INT NOT NULL,
  distributor_id INT NOT NULL,
  purchase_order_date DATE NOT NULL,
  order_total DECIMAL(12,2) NOT NULL,
  pick_up_date DATE NOT NULL,
  picked_up_status BOOLEAN
);

-- Create order details table
CREATE TABLE order_details(
  order_info_id SERIAL PRIMARY KEY,
  purchase_order_id INT NOT NULL,
  flavor_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(12,2) NOT NULL
);

-- Create sale table
CREATE TABLE sale(
  sale_id SERIAL PRIMARY KEY,
  distributor_id INT NOT NULL,
  sale_total DECIMAL(12,2) NOT NULL,
  sale_date DATE NOT NULL
);

-- Create sale details table
CREATE TABLE sale_details(
  sale_detail_id SERIAL PRIMARY KEY,
  sale_id INT NOT NULL,
  flavor_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(12,2)
);

-- Create inventory table
CREATE TABLE inventory(
  inventory_id SERIAL PRIMARY KEY,
  distributor_id INT NOT NULL,
  flavor_id INT NOT NULL,
  quantity INT,
  UNIQUE(distributor_id, flavor_id)
);
