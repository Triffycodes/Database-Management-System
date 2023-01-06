-----------------------------------------------------
--ADARSH SHANKAR
-----------------------------------------------------

-- QUESTION 1 Retrieve the names of all employees who work on at least one of the projects. 
--(In other words, look at the list of projects given in the PROJECT table, and retrieve the names of all employees 
--who work on at least one of them.)

SELECT DISTINCT  E.FNAME,E.MINIT, E.LNAME,E.SSN, W.ESSN 
FROM EMPLOYEE E, WORKS_ON W 
WHERE E.SSN=W.ESSN;

--QUESTION 2 For each department, retrieve the department number, department name, and the average salary of all employees 
--working in that department. Order the output by department number in ascending order.

SELECT D.DNUMBER,D.DNAME,AVG(E.SALARY) 
FROM EMPLOYEE E,DEPARTMENT D 
WHERE D.DNUMBER=E.DNO 
GROUP BY D.DNUMBER, D.DNAME;


--QUESTION 3 List the last names of all department managers who have no dependents.

SELECT LNAME 
FROM EMPLOYEE 
WHERE  SSN IN (SELECT MGR_SSN FROM DEPARTMENT) 
AND SSN NOT IN (SELECT ESSN  FROM DEPENDENT);
         
--QUESTION 4  Determine the department that has the employee with the lowest salary among all employees.
--For this department retrieve the names of all employees. Write one query for this question using subquery.  

SELECT FNAME FROM EMPLOYEE 
WHERE DNO IN (SELECT DNO FROM EMPLOYEE 
WHERE SALARY IN( SELECT MIN(SALARY) FROM EMPLOYEE )
GROUP BY DNO );

--QUESTION 5 Find the total number of employees and the total number of dependents for every department 
--(the number of dependents for a department is the sum of the number of dependents for each employee working for that department). 
--Return the result as department name, total number of employees, and total number of dependents.


SELECT D.DNAME,D.DNUMBER,COUNT(E.SSN),COUNT(DE.ESSN) 
FROM DEPARTMENT D,EMPLOYEE E,DEPENDENT DE 
WHERE  DE.ESSN = E.SSN AND E.DNO =  D.DNUMBER 
GROUP BY D.DNAME,D.DNUMBER;
                           
--QUESTION 6 : Determine if, in the company, male employees earn more than female employees.
 SELECT SEX, AVG(SALARY) 
 FROM  EMPLOYEE 
 GROUP BY SEX;  
 
 -- Answer: It is proved that the male employees earn more than female employees
 
--QUESTION 7 Retrieve the names of employees whose salary is within $20,000 of the salary of the employee who is paid the most in the company 
--(e.g., if the highest salary in the company is $80,000, retrieve the names of all employees that make at least $60,000).

SELECT FNAME 
FROM EMPLOYEE 
WHERE SALARY>=(SELECT MAX(salary) 
FROM EMPLOYEE)-20000;

--QUESTION 8
--Find the names and addresses of all employees whose departments have no location in Houston 
--(that is, whose departments do not have a Dlocation of Houston) but who work on at least one project that is 
--located in Houston (that is, who work on at least one project that has a Plocation of Houston). Note that the
--first condition is not equivalent to the employee's department having some Dlocation that
--is not in Houston the department must not have any Dlocation that is in Houston in order to be included in the result.

SELECT FNAME,MINIT,LNAME,ADDRESS FROM EMPLOYEE
WHERE SSN IN (SELECT ESSN
              FROM WORKS_ON,PROJECT
              WHERE PNO = PNUMBER AND PLOCATION = 'Houston') 
              AND DNO NOT IN (SELECT DNUMBER
              FROM   DEPT_LOCATIONS
              WHERE  DLOCATION = 'Houston');

-----------------------------------------------
-----------------------------------------------





