-- Drop all the tables to clean up
DROP TABLE Handles;
DROP TABLE Animal;
DROP TABLE ZooKeeper;
--=============================================
CREATE TABLE ZooKeeper
(
  ZID        NUMBER(3,0),
  ZName       VARCHAR2(25) NOT NULL,
  HourlyRate NUMBER(6, 2) NOT NULL,
  
  CONSTRAINT ZooKeeper_PK
     PRIMARY KEY(ZID)
);

--=============================================
-- ACategory: Animal category 'common', 'rare', 'exotic'.  May be NULL
-- TimeToFeed: Time it takes to feed the animal (hours)
CREATE TABLE Animal
(
  AID       NUMBER(3, 0),
  AName      VARCHAR(30) NOT NULL,
  ACategory VARCHAR(18),
  
  TimeToFeed NUMBER(4,2),  
  
  CONSTRAINT Animal_PK
    PRIMARY KEY(AID)
);

--=============================================
CREATE TABLE Handles
(
  ZooKeepID      NUMBER(3,0),
  AnimalID     NUMBER(3,0),
  
  Assigned     DATE,
  
  CONSTRAINT Handles_PK
    PRIMARY KEY(ZooKeepID, AnimalID),
    
  CONSTRAINT Handles_FK1
    FOREIGN KEY(ZooKeepID)
      REFERENCES ZooKeeper(ZID),
      
  CONSTRAINT Handles_FK2
    FOREIGN KEY(AnimalID)
      REFERENCES Animal(AID)
);

--=============================================
INSERT INTO ZooKeeper VALUES (1, 'Jim Carrey', 500);
INSERT INTO ZooKeeper VALUES (2, 'Tina Fey', 350);  
INSERT INTO ZooKeeper VALUES (3, 'Rob Schneider', 250);
  
INSERT INTO Animal VALUES(1, 'Galapagos Penguin', 'exotic', 0.5);
INSERT INTO Animal VALUES(2, 'Emperor Penguin', 'rare', 0.75);

INSERT INTO Animal VALUES(3, 'Sri Lankan sloth bear', 'exotic', 2.5);
INSERT INTO Animal VALUES(4, 'Grizzly bear', 'common', 3.0);
INSERT INTO Animal VALUES(5, 'Giant Panda bear', 'exotic', 1.5);
INSERT INTO Animal VALUES(6, 'Florida black bear', 'rare', 1.75);

INSERT INTO Animal VALUES(7, 'Siberian tiger', 'rare', 3.5);
INSERT INTO Animal VALUES(8, 'Bengal tiger', 'common', 2.75);
INSERT INTO Animal VALUES(9, 'South China tiger', 'exotic', 2.25);

INSERT INTO Animal VALUES(10, 'Alpaca', 'common', 0.25);
INSERT INTO Animal VALUES(11, 'Llama', NULL, 3.5);

--=============================================

INSERT INTO Handles VALUES(1, 1, '01-Jan-2000');
INSERT INTO Handles VALUES(1, 2, '02-Jan-2000');
INSERT INTO Handles VALUES(1, 10, '01-Jan-2000');

INSERT INTO Handles VALUES(2, 3, '02-Jan-2000');
INSERT INTO Handles VALUES(2, 4, '04-Jan-2000');
INSERT INTO Handles VALUES(2, 5, '03-Jan-2000');

INSERT INTO Handles VALUES(3, 7, '01-Jan-2000');
INSERT INTO Handles VALUES(3, 8, '03-Jan-2000');
INSERT INTO Handles VALUES(3, 9, '05-Jan-2000');
INSERT INTO Handles Values(3, 10,'04-Jan-2000');

--=============================================
--Q1 i) Find the total feeding time for all of the rare animals.

SELECT SUM(TIMETOFEED), ANAME
FROM ANIMAL 
WHERE ACATEGORY = 'rare'
GROUP BY ANAME;
--
--OUTPUT--
--      SUM(TIMETOFEED)     ANAME
--1     1.75	Florida black bear
--2     0.75	Emperor Penguin
--3     3.5     Siberian tiger
--=============================================

--Q1 ii) Which animal(s) have a `time to feed' larger than every rare animal? Give the id and name of the animal.

SELECT ANAME, AID
FROM ANIMAL
WHERE TIMETOFEED > (
                    SELECT AVG(TIMETOFEED) 
                    FROM ANIMAL 
                    WHERE ACATEGORY='rare');

--
--OUTPUT--
--      ANAME                   AID
--1     Sri Lankan sloth bear	3
--2     Grizzly bear	        4
--3     Siberian tiger	        7
--4     Bengal tiger	        8
--5     South China tiger	    9
--6     Llama	                11

--=============================================
--Q1 iii) Name zookeepers handling at least 4 animals.

SELECT Z.ZNAME, H.ZOOKEEPID,COUNT(H.ZOOKEEPID) 
FROM HANDLES H, ZOOKEEPER Z
WHERE Z.ZID = H.ZOOKEEPID
GROUP BY Z.ZNAME,ZOOKEEPID
HAVING COUNT(H.ZOOKEEPID) >=4;

--
--OUTPUT--
--     ZNAME                ZOOKEEPID       COUNT(H.ZOOKEEPID)
--1    Rob Schneider	    3               4

--=============================================
--Q1 iv) Find the names of the animals that are not related to the bear.

SELECT ANAME 
FROM ANIMAL 
WHERE ANAME NOT LIKE '%bear';

--OUTPUT--
--      ANAME
--1     Galapagos Penguin
--2     Emperor Penguin
--3     Siberian tiger
--4     Bengal tiger
--5     South China tiger
--6     Alpaca
--7     Llama

--=============================================
--Q1 v) List zookeepers earning the most while feeding animals.

SELECT * FROM (SELECT ZNAME, (HOURLYRATE*SUM(TIMETOFEED)) AS MOST_EARN 
FROM  ZooKeeper, Handles, Animal 
WHERE ZooKeeper.ZID = Handles.ZOOKEEPID  AND Animal.AID = Handles.ANIMALID 
GROUP BY ZNAME ,HOURLYRATE 
ORDER BY MOST_EARN DESC) 
WHERE ROWNUM<=1;
--OUTPUT--
--      ZNAME       MOST_EARN
--1     Tina Fey	    2450

--=============================================