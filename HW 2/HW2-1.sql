--=========================================================================
--QUESTION 1a. 
--Create tables and insert data into tables

--Creating table CUSTOMER:
CREATE TABLE CUSTOMER (
cID INTEGER,
cName VARCHAR(25),
cCreditPoint INTEGER,
PRIMARY KEY (cID));

--OUTPUT: 
--Table CUSTOMER created

--Creating Table cusOrder:
CREATE TABLE cusOrder (
oID INTEGER,
c_ID INTEGER,
oTotal FLOAT,
FOREIGN KEY(c_ID) REFERENCES CUSTOMER(cID)
);

--OUTPUT: 
--Table CUSORDER created


--Inserting Values into Table CUSTOMER:

INSERT INTO CUSTOMER VALUES(110,'Phil',10);
INSERT INTO CUSTOMER VALUES(111,'Louis',21);
INSERT INTO CUSTOMER VALUES(112,'John',90);
INSERT INTO CUSTOMER VALUES(113,'Tom',6);
INSERT INTO CUSTOMER VALUES(114,'Yay',80);
INSERT INTO CUSTOMER VALUES(115,'Maria',110);
INSERT INTO CUSTOMER VALUES(116,'Ana',30);
INSERT INTO CUSTOMER VALUES(117,'Antonio',90);
INSERT INTO CUSTOMER VALUES(118,'Andrew',15);
INSERT INTO CUSTOMER VALUES(119,'Shawn',10);

INSERT INTO cusOrder VALUES(1000,115,126.55);
INSERT INTO cusOrder VALUES(1001,114,26.50);
INSERT INTO cusOrder VALUES(1002,117,106.45);
INSERT INTO cusOrder VALUES(1003,118,90.74);
INSERT INTO cusOrder VALUES(1004,112,6.35);
INSERT INTO cusOrder VALUES(1005,114,305.92);
INSERT INTO cusOrder VALUES(1006,111,3.15);
INSERT INTO cusOrder VALUES(1007,110,80.60);
INSERT INTO cusOrder VALUES(1008,115,66.29);
INSERT INTO cusOrder VALUES(1009,117,226.45);

--=========================================================================

--QUESTION 1b. 
--Finding cCreditPoint*2 on Customer:

SELECT cID,cName,cCreditPoint*2 FROM CUSTOMER;

--OUTPUT:
--		cID		cName		cCreditPoint
--1   	110		Phil		20
--2   	111		Louis		42
--3   	112		John		180
--4   	113		Tom	    	12
--5   	114		Yay	    	160
--6   	115		Maria		220
--7   	116		Ana	    	60
--8   	117		Antonio		180
--9   	118		Andrew		30
--10  	119		Shawn		20

--=========================================================================

--QUESTION 1c. 
--Sorting Customer on cCreditPoint, cID (in ascending):
SELECT cID,cName,cCreditPoint 
FROM CUSTOMER 
ORDER BY cCreditPoint,cID;

--OUTPUT:
--		cID		cName		cCreditPoint
--  1   113		Tom	   		6
--  2   110		Phil		10
--  3   119		Shawn		10
--  4   118		Andrew		15
--  5   111		Louis		21
--  6   116		Ana	    	30
--  7   114		Yay	    	80
--  8   112		John		90
--  9   117		Antonio		90
--  10  115		Maria		110

--=========================================================================
--QUESTION 1d. 
--Computing the sum of ototal for each c_ID value in cusOrder:
SELECT c_ID,sum(oTotal) 
FROM cusOrder 
GROUP BY c_ID;

--OUTPUT:
--		C_ID	SUM(OTOTAL)
--1		110		80.6
--2		118		90.74
--3   	115		192.84
--4   	112		6.35
--5   	114		332.42
--6   	111		3.15
--7   	117		332.9

--=========================================================================
--QUESTION 1e. 
--Join Customer and cusOrder and compute the max value of oTotal for each cID:

SELECT C.cID,C.cName,C.cCreditPoint,max(co.oTotal)
FROM CUSTOMER C INNER JOIN cusOrder co ON (c.cID=co.c_ID)
GROUP BY C.cID,C.cName,C.cCreditPoint;

--OUTPUT:

--		CID		CNAME		ccred		MAX(CO.TOTAL)
--  1   118		Andrew		15			90.74
--  2   115		Maria		110			66.29
--  3   110		Phil		10			80.6
--  4   112		John		90			6.35
--  5   117		Antonio		90			226.45
--  6   115		Maria		110			126.55
--  7   114		Yay	    	80			26.5
--  8   117		Antonio		90			106.45
--  9   114		Yay	    	80			305.92
--  10  111		Louis		21			3.15

--=========================================================================
--QUESTION 1f. 
--Find tuples of Customer which match and unmatch with cusOrder:

SELECT *
FROM CUSTOMER LEFT OUTER JOIN cusOrder ON(CUSTOMER.cID=cusOrder.c_ID);

--OUTPUT:
--		CID		CNAME		CCRED		OID		CID_1		ototal
--1		115		Maria		110	    	1000	115			126.55
--2   	114		Yay	    	80	    	1001	114			26.5
--3   	117		Antonio		90	    	1002	117			106.45
--4   	118		Andrew		15	    	1003	118			90.74
--5   	112		John		90	    	1004	112			6.35
--6   	114		Yay	    	80	    	1005    114			305.92
--7   	111		Louis		21	    	1006	111			3.15
--8   	110		Phil		10	    	1007	110			80.6
--9   	115		Maria		110	    	1008	115			66.29
--10  	117		Antonio		90	    	1009	117			226.45
--11  	113		Tom	    	6	    	null	null    	null  	
--12  	116		Ana	    	30	    	null    null    	null
--13  	119		Shawn		10      	null    null    	null

--=========================================================================
--QUESTION 1g. 
--Find tuples of cusOrder which match and unmatch with Customer:
SELECT *
FROM cusOrder RIGHT OUTER JOIN CUSTOMER ON(CUSTOMER.cID=cusOrder.c_ID);

--OUTPUT:

--		OID		CID		OTOTAL		CID_1		CNAME		CCREDITPOINT
--1   	1000	115		126.55		115			Maria		110
--2   	1001	114		26.5		114			Yay			80
--3   	1002	117		106.45		117			Antonio		90
--4   	1003	118		90.74		118			Andrew		15
--5   	1004	112		6.35		112			John		90
--6   	1005	114		305.92		114			Yay	    	80
--7   	1006	111		3.15		111			Louis		21
--8   	1007	110		80.6		110			Phil		10
--9   	1008	115		66.29		115			Maria		110
--10  	1009	117		226.45		117			Antonio		90
--11  	null    null 	null   		113			Tom	    	6
--12  	null    null 	null		116			Ana	    	30
--13  	null    null 	null		119			Shawn		10

--=========================================================================
--QUESTION 1h. 
--Find tuples of customer which match and unmatch with cusOrder in which cCreditpoint is larger than oTotal:

SELECT *
FROM CUSTOMER LEFT OUTER JOIN cusOrder ON(CUSTOMER.cID=cusOrder.c_ID)
WHERE cCreditpoint > oTotal;

--OUTPUT:
--		CID		CNAME		Ccred		OID		CID_1		OTOTAL
--1   	114		Yay	    	80			1001	114	    	26.5
--2   	112		John		90			1004	112	    	6.35
--3   	111		Louis		21			1006	111	    	3.15
--4   	115		Maria		110			1008	115	    	66.29

--=========================================================================