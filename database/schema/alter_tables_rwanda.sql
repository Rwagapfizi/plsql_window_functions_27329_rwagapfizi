-- ALTER queries for Rwandan context adaptation

-- Update REGION table: change country to province
ALTER TABLE REGION 
CHANGE COLUMN country province VARCHAR(50) NOT NULL;

-- Add district column to CUSTOMER
ALTER TABLE CUSTOMER 
ADD COLUMN district VARCHAR(50) AFTER region_id;

-- Add currency column to ORDERS
ALTER TABLE ORDERS 
ADD COLUMN currency VARCHAR(3) DEFAULT 'USD' AFTER shipping_district;

-- Change shipping_region to shipping_district in ORDERS
ALTER TABLE ORDERS 
CHANGE COLUMN shipping_region shipping_district VARCHAR(50);