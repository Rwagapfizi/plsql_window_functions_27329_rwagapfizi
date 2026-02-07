-- Sample Data for GreenCycle Electronics Rwanda
-- File: 02_insert_data.sql

-- Insert REGION data
INSERT INTO REGION (region_name, province, manager_name, manager_email) VALUES
('Gasabo', 'Kigali', 'Alice Uwase', 'alice.uwase@greencycle.rw'),
('Kicukiro', 'Kigali', 'David Habimana', 'david.h@greencycle.rw'),
('Musanze', 'Northern', 'Eric Tuyishime', 'eric.t@greencycle.rw'),
('Rubavu', 'Western', 'Chantal Uwimana', 'chantal.u@greencycle.rw');

-- Insert CUSTOMER data
INSERT INTO CUSTOMER (first_name, last_name, email, registration_date, region_id, district) VALUES
('Eric', 'Ndahiro', 'eric@email.rw', '2024-01-01', 1, 'Remera'),
('Marie', 'Uwamahoro', 'marie@email.rw', '2024-01-15', 2, 'Gikondo'),
('Jean', 'Baptiste', 'jean@email.rw', '2024-02-01', 3, 'Musanze Town'),
('Chantal', 'Mukamana', 'chantal@email.rw', '2024-02-15', 1, 'Kimironko'),
('Samuel', 'Twahirwa', 'samuel@email.rw', '2024-03-01', 4, 'Rubavu Town'),
('Annette', 'Uwimana', 'annette@email.rw', '2024-03-15', 2, 'Kicukiro');

-- Insert PRODUCT data
INSERT INTO PRODUCT (product_name, category, brand, price, cost, sustainability_rating) VALUES
('Solar Home System', 'Energy', 'GreenTech', 299.99, 180.00, 'A'),
('Solar Phone Charger', 'Accessories', 'Mara Solar', 39.99, 20.00, 'B'),
('Energy Saving Bulbs', 'Lighting', 'EcoLight', 9.99, 4.00, 'A'),
('Solar Radio', 'Electronics', 'Kigali Tech', 49.99, 25.00, 'B'),
('Biogas Cooker', 'Kitchen', 'GreenHome', 199.99, 120.00, 'A');

-- Insert ORDERS data
INSERT INTO ORDERS (customer_id, order_date, total_amount, payment_method, shipping_district) VALUES
(1, '2024-01-20', 299.99, 'Mobile Money', 'Remera'),
(2, '2024-01-25', 89.98, 'Bank Transfer', 'Gikondo'),
(3, '2024-02-10', 199.99, 'Mobile Money', 'Musanze Town'),
(4, '2024-02-15', 39.99, 'Credit Card', 'Kimironko'),
(5, '2024-03-05', 349.97, 'Mobile Money', 'Rubavu Town'),
(1, '2024-03-10', 49.99, 'Bank Transfer', 'Remera'),
(2, '2024-03-15', 199.99, 'Mobile Money', 'Gikondo'),
(6, '2024-03-20', 129.98, 'Credit Card', 'Kicukiro');

-- Insert ORDER_DETAIL data
INSERT INTO ORDER_DETAIL (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 299.99),
(2, 2, 1, 39.99),
(2, 3, 5, 9.99),
(3, 5, 1, 199.99),
(4, 2, 1, 39.99),
(5, 1, 1, 299.99),
(5, 4, 1, 49.99),
(6, 3, 5, 9.99),
(7, 5, 1, 199.99),
(8, 2, 2, 39.99),
(8, 3, 5, 9.99);

-- Update calculated columns
UPDATE ORDERS 
SET order_month = DATE_FORMAT(order_date, '%Y-%m');

UPDATE ORDER_DETAIL 
SET line_total = quantity * unit_price;

-- Update customer statistics
UPDATE CUSTOMER c
SET 
    total_purchases = (
        SELECT COALESCE(SUM(total_amount), 0)
        FROM ORDERS o
        WHERE o.customer_id = c.customer_id
    ),
    last_purchase_date = (
        SELECT MAX(order_date)
        FROM ORDERS o
        WHERE o.customer_id = c.customer_id
    );