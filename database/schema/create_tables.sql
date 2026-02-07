-- Database Schema for GreenCycle Electronics Rwanda

-- Create REGION table
CREATE TABLE REGION (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    manager_name VARCHAR(100),
    manager_email VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATE NOT NULL,
    region_id INT,
    district VARCHAR(50),
    customer_segment VARCHAR(20) DEFAULT 'Standard',
    total_purchases DECIMAL(10,2) DEFAULT 0.00,
    last_purchase_date DATE,
    FOREIGN KEY (region_id) REFERENCES REGION(region_id)
);

-- Create PRODUCT table
CREATE TABLE PRODUCT (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    sustainability_rating CHAR(1) CHECK (sustainability_rating IN ('A', 'B', 'C', 'D', 'E')),
    launch_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create ORDERS table
CREATE TABLE ORDERS (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Completed' 
        CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Completed')),
    payment_method VARCHAR(30),
    shipping_district VARCHAR(50),
    order_month VARCHAR(7),
    currency VARCHAR(3) DEFAULT 'USD',
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    INDEX idx_order_date (order_date),
    INDEX idx_customer_order (customer_id, order_date)
);

-- Create ORDER_DETAIL table
CREATE TABLE ORDER_DETAIL (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    line_total DECIMAL(10,2),
    discount_percentage DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
    INDEX idx_order_product (order_id, product_id)
);

-- Add RWF price virtual column to PRODUCT
ALTER TABLE PRODUCT 
ADD COLUMN rwf_price INT GENERATED ALWAYS AS (price * 1300) VIRTUAL;