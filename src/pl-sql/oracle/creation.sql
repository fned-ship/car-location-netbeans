create TABLE cartb(
	carReg 	INT auto_increment primary key ,
    brand varchar(255) not null ,
    model varchar(255) not null ,
    status varchar(255) not null ,
    price int not null 
);
CREATE TABLE customertb (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone INT NOT NULL
);
INSERT INTO customertb (name, address, phone) VALUES ('adam', 'iin klm 6', '9999999');
INSERT INTO customertb (name, address, phone) VALUES ('fned', 'gremda klm 9', '9899999');


create table usersaccount(
     id varchar(255) primary key,
     password varchar(255) );
create TABLE location(
	rent_id 	INT auto_increment primary key ,
    carReg INT not null ,
     customer_id INT not null,
    rent_day DATE not null ,
    return_day DATE not null,
    fees INT not null,
	FOREIGN KEY (carReg) REFERENCES cartb(carReg),
    FOREIGN KEY (customer_id) REFERENCES customertb(customer_id)
);

create TABLE retour(
	rent_id 	INT not null  ,
    carReg INT not null ,
     customer_id INT not null,
    return_day DATE not null ,
	delay INT not null default 0 ,
    fees INT not null default 0,
	FOREIGN KEY (carReg) REFERENCES cartb(carReg),
    FOREIGN KEY (customer_id) REFERENCES customertb(customer_id),
	FOREIGN KEY (rent_id) REFERENCES location(rent_id)
);

ALTER TABLE customertb ADD COLUMN rental_count INT DEFAULT 0;

INSERT INTO cartb (brand, model, status, price) VALUES ('Audi', 'A4', 'BOOKED', 5000);
INSERT INTO cartb (brand, model, status, price) VALUES ('Mercedes', 'C-Class', 'BOOKED', 5500);


-- Inserting values into the location table
INSERT INTO location (carReg, customer_id, rent_day, return_day , fees)
VALUES 
    ((SELECT carReg FROM cartb WHERE status = 'BOOKED' AND brand = 'Audi' AND model = 'A4'), 1, '2024-04-25', '2024-04-28' , 100),
    ((SELECT carReg FROM cartb WHERE status = 'BOOKED' AND brand = 'Mercedes' AND model = 'C-Class'), 2, '2024-04-26', '2024-05-02' , 150);




UPDATE customertb
SET rental_count = rental_count + 1
WHERE customer_id = 1;


UPDATE customertb
SET rental_count = rental_count + 1
WHERE customer_id = 2;

select * from location;
FLUSH PRIVILEGES;

SELECT c.*
FROM customertb c
JOIN (
    SELECT customer_id
    FROM location
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    LIMIT 3
) AS top_customers ON c.customer_id = top_customers.customer_id;
