--Question 1 For each restaurant that has at least one rating, find the highest number of stars that a restaurant received. 
--Return the restaurant name and number of stars. Sort by restaurant name.


SELECT NAME, MAX(stars)
FROM RATING
INNER JOIN RESTAURANT USING(RID)
GROUP BY NAME
ORDER BY NAME;

--Question 2 For each restaurant, return the name and the 'rating spread', that is, the difference between 
--highest and lowest ratings given to that restaurant. 
--Sort by rating spread from highest to lowest, then by restaurant name.


SELECT NAME, (MAX(STARS) - MIN(STARS)) AS RATING_SPREAD
FROM RATING
INNER JOIN RESTAURANT USING(RID)
GROUP BY NAME
ORDER BY RATING_SPREAD DESC, NAME;


--QUESTION 3 Find the difference between the average rating of Indian restaurants and the average rating of 
--Chinese restaurants. (Make sure to calculate the average rating for each restaurant, 
--then the average of those averages for Indian and Chinese restaurants. Don't just calculate the 
--overall average rating for Indian and Chinese restaurants.) Note: The difference can be negative.


SELECT ROUND(MAX(A)-MIN(A),2) AS DIFFERENCE FROM
(SELECT AVG(A1) A FROM (SELECT AVG(STARS) AS A1 FROM RATING R1 JOIN RESTAURANT R2 ON R1.RID=R2.RID WHERE R2.CUISINE='Indian')
UNION 
SELECT AVG(A2) A FROM (SELECT AVG(STARS) AS A2 FROM RATING R1 INNER JOIN RESTAURANT R2 ON R1.RID=R2.RID WHERE CUISINE='Chinese'));


--QUESTION 4: Are there reviewers who reviewed both Indian and Chinese restaurants? Write a query and answer Yes/No.

SELECT R2.NAME FROM RATING R1 INNER JOIN REVIEWER R2 ON R2.VID=R1.VID INNER JOIN RESTAURANT R3 ON R3.RID=R1.RID WHERE R3.CUISINE='Indian'
INTERSECT
SELECT R2.NAME FROM RATING R1 INNER JOIN REVIEWER R2 ON R2.VID=R1.VID INNER JOIN RESTAURANT R3 ON R3.RID=R1.RID WHERE R3.CUISINE='Chinese'
