--1.Create Database as ecommerce 
--2.Create 4 tables (gold_member_users, users, sales, product) under the above database(ecommerce) 
--3.Insert the values provided above with respective datatypes 

USE ecommerce
-- Create GoldMembers table
CREATE TABLE GoldMembers (
    userid VARCHAR(50),
    signup_date DATE
);

-- Insert data into GoldMembers
INSERT INTO GoldMembers VALUES
('John', '2017-09-22'),
('Mary', '2017-04-21');


-- Create Users table
CREATE TABLE Users (
    userid VARCHAR(50),
    signup_date DATE
);

-- Insert data into Users
INSERT INTO Users VALUES
('John', '2014-09-02'),
('Michel', '2015-01-15'),
('Mary', '2014-04-11');


-- Create Sales table
CREATE TABLE Sales (
    userid VARCHAR(50),
    created_date DATE,
    product_id INT
);

-- Insert data into Sales
INSERT INTO Sales VALUES
('John', '2017-04-19', 2),
('Mary', '2019-12-18', 1),
('Michel', '2020-07-20', 3),
('John', '2019-10-23', 2),
('John', '2018-03-19', 3),
('Mary', '2016-12-20', 2),
('John', '2016-11-09', 1),
('John', '2016-05-20', 3),
('Michel', '2017-09-24', 1),
('John', '2017-03-11', 2),
('John', '2016-03-11', 1),
('Mary', '2016-11-10', 1),
('Mary', '2017-12-07', 2);


-- Create Product table
CREATE TABLE Product (
    product_id INT,
    product_name VARCHAR(50),
    price INT
);

-- Insert data into Product
INSERT INTO Product VALUES
(1, 'Mobile', 980),
(2, 'Ipad', 870),
(3, 'Laptop', 330);

--4.Show all the tables in the same database(ecommerce) 
SELECT * FROM gold_membership_users
SELECT * FROM Users
SELECT * FROM Sales
SELECT * FROM Product

--5.Count all the records of all four tables using single query 
SELECT COUNT(*)as Goldmembers FROM GoldMembers
SELECT COUNT(*) as users FROM Users
SELECT COUNT(*) as sales FROM Sales
SELECT COUNT(*) as product FROM Product

--6.What is the total amount each customer spent on ecommerce company 
select 
s.userid as name,
SUM(p.price) as total
from Sales as s
join Product as p on p.product_id = s.product_id
GROUP BY (s.userid)

--7.Find the distinct dates of each customer visited the website:     output should have 2 columns date and customer name 
SELECT DISTINCT
userid as name,
created_date as date
from Sales
order by created_date


--8.Find the first product purchased by each customer using 3 tables(users, sales, product) 
Select name,item
from (
SELECT
DENSE_RANK() OVER(partition by s.userid ORDER BY s.created_date) as rn,
S.userid as name,
p.product_name as item
FROM Sales AS S
JOIN Users AS U ON S.userid = U.userid
JOIN Product AS P ON P.product_id = S.product_id
) as rs
where rn = 1


--9.What is the most purchased item of each customer and how many times the customer has purchased it: output should have 2 columns count of the items as item_count and customer name 
--10.Find out the customer who is not the gold_member_

SELECT 
    U.userid
FROM Users AS U
LEFT JOIN GoldMembers AS G ON U.userid = G.userid
WHERE G.userid IS NULL;


--11.What is the amount spent by each customer when he was the gold_memberorder by  user 

SELECT
s.userid,
sum(P.price)
FROM Sales as S
join GoldMembers As G on S.userid = G.userid
join Product as P on P.product_id = S.product_id
WHERE s.created_date >= g.signup_date
group by s.userid

--12.Find the Customers names whose name starts with M 
SELECT userid from Users 
where userid like 'm%';

--13.Find the Distinct customer Id of each customer 
select distinct userid from Sales

--14.Change the Column name from product table as price_value from price 
    --ALTER TABLE Product
    --RENAME COLUMN price TO price_value;
    EXEC sp_rename 'product.price','price_value';


--15.Change the Column value product_name   Ipad to Iphone from product table
UPDATE product
set product_name = 'Iphone'
where product_name = 'Ipad'

--16.Change the table name of gold_member to gold_membership_users 
exec sp_rename 'GoldMembers','gold_membership_users';

--17.Create a new column  as Status in the table crate above gold_membership_users  the Status values should be 2 Yes and No if the user is gold member, then status should be Yes else No. 
SELECT * FROM Users as U 

ALTER TABLE Users
ADD Status VARCHAR(5);

UPDATE Users
set Status = 'Yes'
Where userid In (Select userid from gold_membership_users)


UPDATE Users
set Status = 'No'
Where Status IS NULL

--18.Delete the users_ids 1,2 from users table and roll the back changes once both the rows are deleted one by one mention the result when performed roll back 
Begin Transaction
DELETE FROM Users
WHERE userid IN ('John', 'Michel');
SELECT * FROM Users
rollback;

--19.Insert one more record as same (3,'Laptop',330) as product table 
INSERT Product VALUES (3,'laptop',330)

--20.Write a query to find the duplicates in product table 
SELECT * FROM Product
SELECT
product_name
from Product
group by product_name
having COUNT(*) > 1