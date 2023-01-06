--Creating Models table

CREATE TABLE Models (

model_id number(5) primary key,

modelBrand varchar(15),

modelName varchar(15) );

--Output:
--Table MODELS created.
--=======================================

--Creating Cars table

CREATE TABLE Cars (

CarID number(5) primary key,

VIN number(10) UNIQUE,
Color char(15),

YearofMake number(4),

Model_id number(5),

foreign key (model_id) references Models(model_id)

);

--Output:
--Table CARS created.
--=======================================

-- Inserting values into Models table
INSERT INTO Models VALUES(1,'Toyota','Camry');
INSERT INTO Models VALUES(2,'Toyota','Corolla');

--=======================================
-- Inserting values into Cars table
INSERT INTO cars VALUES(123,3456783412,'Red',2010,1);
INSERT INTO cars VALUES(234,2876309034,'Blue',2003,2);


INSERT INTO Cars VALUES (235,3456783412,'Silver',2010,1);

-- i)
--INSERT INTO Cars VALUES (235,3456783412,'Silver',2010,1)
--Error report -
--ORA-00001: unique constraint (ASHANKA4.SYS_C00231408) violated

----Explanation ----
--The VIN has a UNIQUE constraint but a duplicate values can not be inserted because of constraint violation hence error was received. 

--=======================================
-- ii)
DELETE FROM Models;


--DELETE FROM Models
--Error report -
--ORA-02292: integrity constraint (ASHANKA4.SYS_C00231409) violated - child record found


--Here constraint violation error occured because ModelId attribute already been used in a child table cars which needs to be taken care of first.

--=============================================
--iii)

ALTER TABLE Cars DROP CONSTRAINT SYS_C00231408;

--Table CARS altered.


ALTER TABLE Cars DROP CONSTRAINT SYS_C00231409;

--Table CARS altered.


DELETE FROM Models;

--2 rows deleted.
--SYS_C00231409


INSERT INTO Cars VALUES (235,3456783412,'Silver',2010,1);

--1 row inserted.

--==============================================