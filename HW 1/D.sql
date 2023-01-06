--Creating Emps table and All managers are employees

CREATE TABLE Emps(
empID number(10), 
ssNo number(10),
name varchar(25), 
mgrID number(10),
Primary key(empID), 
FOREIGN KEY(mgrID) references Emps(empID));

--Output
--Table EMPS created.
