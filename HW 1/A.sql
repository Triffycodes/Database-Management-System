-- For Question 1 and 2
-- creating table customers

CREATE TABLE CUSTOMERS (
CUSTOMERID NUMBER(3),
NAME VARCHAR(25),
ADDRESS VARCHAR(50),
PRIMARY KEY (CUSTOMERID)
);

-- Output:
--Table CUSTOMERS created.

--==============================================

-- creating table orders

CREATE TABLE ORDERS (
ORDERID NUMBER(5),
ORDERDATE VARCHAR(25),
CUSTOMERID NUMBER(3),
PRIMARY KEY (ORDERID),
FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(CUSTOMERID)
);

-- Output:
--Table ORDERS created.

--==============================================

-- creating table products

CREATE TABLE PRODUCTS (
PRODUCTID NUMBER(2),
DESCRIPTION VARCHAR(28),
FINISH VARCHAR(10),
PRICE FLOAT(10),
CONSTRAINT CHECK_PRICE
CHECK (PRICE BETWEEN 0 and 899.9),
PRIMARY KEY (PRODUCTID)
);

-- Output:
--Table PRODUCTS created.

--==============================================

-- creating table requests

CREATE TABLE REQUESTS (
ORDERID NUMBER(5),
PRODUCTID NUMBER(2),
QUANTITY INTEGER,
PRIMARY KEY (ORDERID,PRODUCTID),
FOREIGN KEY (ORDERID) REFERENCES ORDERS(ORDERID),
CONSTRAINT CHECK_QUANTITY
CHECK (QUANTITY BETWEEN 0 and 51),
FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTS(PRODUCTID)
);

-- Output:
--Table REQUESTS created.

--==============================================
--==============================================

--For Question 3

-- Inserting values to Customers table 

INSERT INTO CUSTOMERS VALUES(2,'CASUAL FURNITURE','PLANO, TX');
INSERT INTO CUSTOMERS VALUES(6,'MOUNTAIN GALLERY','BOULDER, CO');

-- Output:
--1 row inserted.

--1 row inserted.

--==============================================

-- Inserting values to Orders table 

INSERT INTO ORDERS VALUES(1006,'24-MAR-10',2);
INSERT INTO ORDERS VALUES(1007,'25-MAR-10',6);
INSERT INTO ORDERS VALUES(1008,'25-MAR-10',6);
INSERT INTO ORDERS VALUES(1009,'26-MAR-10',2);

-- Output:
--1 row inserted.

--1 row inserted.

--1 row inserted.

--1 row inserted.

--==============================================

-- Inserting values to Products table 

INSERT INTO PRODUCTS VALUES(10,'WRITING DESK','OAK',425);
INSERT INTO PRODUCTS VALUES(30,'DINING TABLE','ASH',NULL);
INSERT INTO PRODUCTS VALUES(40,'ENTERTAINMENT CENTER','MAPLE',650);
INSERT INTO PRODUCTS VALUES(70,'CHILDRENS DRESSER','PINE',300);

-- Output:
--1 row inserted.

--1 row inserted.

--1 row inserted.

--1 row inserted.

--==============================================

-- Inserting values to Requests table 

INSERT INTO REQUESTS VALUES(1006,10,4);
INSERT INTO REQUESTS VALUES(1006,30,2);
INSERT INTO REQUESTS VALUES(1006,40,1);
INSERT INTO REQUESTS VALUES(1007,40,3);
INSERT INTO REQUESTS VALUES(1007,70,2);
INSERT INTO REQUESTS VALUES(1008,70,1);
INSERT INTO REQUESTS VALUES(1009,10,2);
INSERT INTO REQUESTS VALUES(1009,40,1);

--Output:
--1 row inserted.

--1 row inserted.

--1 row inserted.

--1 row inserted.

--1 row inserted.

--1 row inserted.

--1 row inserted.

--1 row inserted.

--==============================================

-- Printing all the values Customers

SELECT * FROM CUSTOMERS;

--Output:
--1  2	CASUAL FURNITURE	PLANO, TX
--2  6	MOUNTAIN GALLERY	BOULDER, CO

--==============================================

-- Printing all the values Orders

SELECT * FROM ORDERS;

--Output:
--1    1006	24-MAR-10	2
--2    1007	25-MAR-10	6
--3    1008	25-MAR-10	6
--4    1009	26-MAR-10	2

--==============================================

-- Printing all the values Products

SELECT * FROM PRODUCTS;

--Output:
--1     10	WRITING DESK	OAK	425
--2     30	DINING TABLE	ASH	
--3     40	ENTERTAINMENT CENTER	MAPLE	650
--4     70	CHILDRENS DRESSER	PINE	300

--==============================================

-- Printing all the values Products

SELECT * FROM REQUESTS;

--Output:
--1 1006	10	4
--2 1006	30	2
--3 1006	40	1
--4 1007	40	3
--5 1007	70	2
--6 1008	70	1
--7 1009	10	2
--8 1009	40	1


--Dropping the table:
--drop table customers
--drop table orders
--drop table products
--drop table requests
