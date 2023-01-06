--Creating a table called Location

CREATE TABLE LOCATION(
LATITUDE FLOAT,
LONGITUDE FLOAT,
NAME VARCHAR(50),
PRIMARY KEY(LATITUDE,LONGITUDE)
)

--Output
--Table LOCATION created.
--==============================================

--For Question 1

--i) Latitude or Longitude alone can not be made as primary key since it can be repeated 
--   but we can combine both latitude and longitude and make it as primary key.

--==============================================

-- For Question 2
-- ii)

INSERT INTO LOCATION VALUES(41.881832,-87.623177,'Chicago');
INSERT INTO LOCATION VALUES(42.881832,-87.623177,'Chicago');
INSERT INTO LOCATION VALUES(41.881832,-86.623177,'Chicago');

--Output:
--1 row inserted.

--1 row inserted.

--1 row inserted.

--==============================================

-- For Question 3
-- iii)

-- We combined both Latitude and Longitude and made them as primary key because in the real world the combination of both latitude and longitude will not repeat.
-- no violation of statement will occur.

--==============================================