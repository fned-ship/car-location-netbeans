-- Create tables for 'cartb' and 'customertb'
CREATE TABLE cartb (
    carReg SERIAL PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    price INT NOT NULL
);

CREATE TABLE customertb (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone INT NOT NULL,
    rental_count INT DEFAULT 0
);

-- Insert sample data into customertb
INSERT INTO customertb (name, address, phone) 
VALUES 
    ('adam', 'iin klm 6', 9999999),
    ('fned', 'gremda klm 9', 9899999);

-- Create 'user' table
CREATE TABLE usersaccount (
    id VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255)
);

-- Create 'location' table
CREATE TABLE location (
    rent_id SERIAL PRIMARY KEY,
    carReg INT NOT NULL,
    customer_id INT NOT NULL,
    rent_day DATE NOT NULL,
    return_day DATE NOT NULL,
    fees INT NOT NULL,
    FOREIGN KEY (carReg) REFERENCES cartb(carReg),
    FOREIGN KEY (customer_id) REFERENCES customertb(customer_id)
);

-- Create 'retour' table
CREATE TABLE retour (
    rent_id INT NOT NULL,
    carReg INT NOT NULL,
    customer_id INT NOT NULL,
    return_day DATE NOT NULL,
    delay INT NOT NULL DEFAULT 0,
    fees INT NOT NULL DEFAULT 0,
    FOREIGN KEY (carReg) REFERENCES cartb(carReg),
    FOREIGN KEY (customer_id) REFERENCES customertb(customer_id),
    FOREIGN KEY (rent_id) REFERENCES location(rent_id)
);

-- Insert sample data into cartb
INSERT INTO cartb (brand, model, status, price) 
VALUES 
    ('Audi', 'A4', 'BOOKED', 5000),
    ('Mercedes', 'C-Class', 'BOOKED', 5500);

-- Inserting values into the location table
INSERT INTO location (carReg, customer_id, rent_day, return_day, fees)
VALUES 
    ((SELECT carReg FROM cartb WHERE status = 'BOOKED' AND brand = 'Audi' AND model = 'A4'), 1, '2025-04-25', '2025-04-28', 100),
    ((SELECT carReg FROM cartb WHERE status = 'BOOKED' AND brand = 'Mercedes' AND model = 'C-Class'), 2, '2025-04-26', '2025-05-02', 150);

-- Update rental count in customertb
UPDATE customertb
SET rental_count = rental_count + 1
WHERE customer_id = 1;

UPDATE customertb
SET rental_count = rental_count + 1
WHERE customer_id = 2;

-- Select data from location table
SELECT * FROM location;

-- Select top 3 customers based on rental count
SELECT c.*
FROM customertb c
JOIN (
    SELECT customer_id
    FROM location
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    LIMIT 3
) AS top_customers ON c.customer_id = top_customers.customer_id;
