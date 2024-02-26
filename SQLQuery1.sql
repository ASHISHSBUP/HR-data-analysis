Create Database HR ;
USE HR ;

Select * from HR_data;

----DATA FORMATTING/CLEANING

--1)CONVERT DATES TO yyyy-MM-dd.
select termdate
from HR_data
order by termdate DESC;

update HR_data
set termdate = FORMAT(CONVERT(datetime,LEFT(termdate,19),120),'yyyy-MM-dd');

--change the data type of termdate

ALTER TAble HR_data
ALTER COLUMN termdate DATE;

--GET AGE IN YEARS.
ALTER TABLE HR_data
ADD AGE nvarchar(50);

update HR_data
SET AGE= DATEDIFF(YEAR,BIRTHDATE,GETDATE());


----DATA ANALYSIS
---QUESTION TO ANSWER FROM THE DATA

--1)what is the age distribution in the company?

--age distribution
select 
 min (AGE ) AS YOUNGEST,
 MAX (AGE) AS OLDEST
FROM HR_data;

SELECT AGE FROM HR_data
--age group distribution

select AGE
from HR_data
order by age;

alter table HR_data
drop column age_group ;

select * from HR_data;
--

SELECT	age_group, count(*) AS count
FROM

(SELECT 
CASE 
WHEN AGE >=21 AND AGE <=30 THEN '21 to 30'
WHEN AGE >=31 AND AGE <=40 THEN '31 to 40'
WHEN AGE >=41 AND AGE <=50 THEN '41 to 50'
ELSE '50+'
END AS Age_group
FROM HR_data) AS Subquery
GROUP BY age_group
ORDER BY age_group

--AGE GROUP BY GENDER
SELECT age_group,
gender ,
 count (*) as count
FROM
(SELECT 
CASE 
WHEN AGE >=21 AND AGE <=30 THEN '21 to 30'
WHEN AGE >=31 AND AGE <=40 THEN '31 to 40'
WHEN AGE >=41 AND AGE <=50 THEN '41 to 50'
ELSE '50+'
END AS age_group ,gender
FROM HR_data) AS Subquery
GROUP BY age_group ,gender
ORDER BY age_group ,gender

--2)what is the gender breakdown in company?
select 
gender,
count (gender) as count 
from HR_data
group by gender
order by gender;

--3) how does gender vary across departments and Job titles?
select 
gender,department,
count(gender) as count
from HR_data
group by gender,department
order by gender,department;
 
 --job titles
 select 
gender,department,jobtitle,
count(gender) as count
from HR_data
group by gender,department,jobtitle
order by gender,department,jobtitle;

---4)what is the race distribution in the company?
 select 
race,
count(*) as count
from HR_data
group by  race

--5) what is the average length of employment in the company?
select 
avg(datediff(year,hire_date,termdate))as tenure
from HR_data

--6)what is the tenure distribution for each  department?

select 
department,
avg(datediff(year,hire_date,termdate))as tenure
from HR_data
group by department
order by tenure

--7)how many employees work remotely for each department?
select location,
count (*) 
from HR_data
group by location

--8)what is the distribution of employees across different states?

select location_state,
count(*)
from HR_data
group by location_state

--9)How are job titles distributed in the company?
select jobtitle,
count(*)
from HR_data
group by jobtitle;













 
