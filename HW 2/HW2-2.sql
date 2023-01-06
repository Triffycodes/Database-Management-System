--QUESTION 1: Find name of all customers in Illinois:
--

SELECT first_name,last_name FROM CUSTOMERS WHERE state='IL';

--OUTPUT:
--		first_name		last_name
--1		Elka			Twiddell

--===================================================================================
--QUESTION 2: Find all customers whose last names start with letter 'B':
--

SELECT * FROM CUSTOMERS WHERE last_name LIKE 'B%';

--OUTPUT:
--		customer_id		first_name	last_name	birth_date	phone			address					city			state	points
--1		2				Ines		Brushfield	13-04-86	804-427-9456	14187 Commercial Trail	Hampton 	    VA		947
--2		3				Freddi		Boagey	    07-02-85	719-724-7869	251 Springs Junction	ColoradoSprings	CO		2967
--3		5				Clemmie		Betchley	07-11-73	null	        5 Spohn Circle	        Arlington	    TX		3675

--===================================================================================
--QUESTION 3: Find name of all customers that have order in 2018, sort them in increasing order of order_date:
--

SELECT C.FIRST_NAME,C.LAST_NAME, ORDERS.ORDER_DATE 
FROM CUSTOMERS C  INNER JOIN ORDERS ON (C.CUSTOMER_ID=ORDERS.CUSTOMER_ID)
WHERE ltrim(TO_CHAR(ORDER_DATE,'yy'),'0') = 18 
ORDER BY ORDER_DATE;

--OUTPUT:
--		first_name	last_name	birth_date
--1		Elka		Twiddell	22-04-18
--2		Clemmie		Betchley	08-06-18
--3		Ilene		Dowson	    02-08-18
--4		Ines		Brushfield	22-09-18
--5		Levy		Mynett	    18-11-18

--===================================================================================
--QUESTION 4: Find all customers that have no order:
--

SELECT C.CUSTOMER_ID,C.FIRST_NAME,C.LAST_NAME
FROM  CUSTOMERS C
LEFT OUTER JOIN  Orders ON C.CUSTOMER_ID = Orders.CUSTOMER_ID
WHERE Orders.CUSTOMER_ID IS NULL;

--OUTPUT:
--		customer_id		first_name	last_name
--1   	1				Babara		MacCaffrey
--2   	4				Ambur		Roseburgh
--3   	3				Freddi		Boagey
--4   	9				Romola		Rumgay

--===================================================================================
--QUESTION 5: Find name of all customers that have orders with no shipped_date (i.e., shipped_data is NULL):
--

SELECT DISTINCT C.CUSTOMER_ID,C.FIRST_NAME,C.LAST_NAME,ORDERS.SHIPPED_DATE
FROM	CUSTOMERS C, ORDERS
WHERE ORDERS.SHIPPED_DATE IS NULL ;

--OUTPUT:
--		customer_id		first_name		last_name			SHIPPED_DATE
--1   	1				Babara			MacCaffrey			NULL
--2   	2				Ines			Brushfield			NULL
--3   	3				Freddi			Boagey				NULL
--4   	4				Ambur			Roseburgh			NULL
--5   	5				Clemmie			Betchley			NULL
--6   	6				Elka			Twiddell			NULL
--7   	7				Ilene			Dowson				NULL
--8   	8				Thacher			Naseby				NULL
--9   	9				Romola			Rumgay				NULL
--10  	10				Levy			Mynett				NULL

--===================================================================================
--QUESTION 6: Find all customers that order more than once, sort in increasing order of the total number of orders.
--

SELECT  CUSTOMERS.CUSTOMER_ID,CUSTOMERS.FIRST_NAME,CUSTOMERS.LAST_NAME, 
		COUNT(ORDERS.CUSTOMER_ID) AS TOTAL_COUNT
FROM  CUSTOMERS JOIN ORDERS ON (CUSTOMERS.CUSTOMER_ID=ORDERS.CUSTOMER_ID)
GROUP BY CUSTOMERS.CUSTOMER_ID,CUSTOMERS.FIRST_NAME,CUSTOMERS.LAST_NAME
HAVING COUNT(ORDERS.CUSTOMER_ID) > 1;

--OUTPUT:
--		customer_id		first_name		last_name		TOTAL_COUNT
--1   	6				Elka			Twiddell		2
--2   	5				Clemmie			Betchley		2
--3   	2				Ines			Brushfield		2
--4   	10				Levy			Mynett	    	2
--===================================================================================