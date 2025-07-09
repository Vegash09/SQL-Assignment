-- create a table named sales_data with columns: product_id, sale_date, and  quantity_sold. 
CREATE TABLE sales_data (
    product_id INT,
    sale_date DATE,
    quantity_sold INT
);

-- insert some sample data into the table: 
INSERT INTO sales_data VALUES
(1, '2022-01-01', 20),
(2, '2022-01-01', 15),
(1, '2022-01-02', 10),
(2, '2022-01-02', 25),
(1, '2022-01-03', 30),
(2, '2022-01-03', 18),
(1, '2022-01-04', 12),
(2, '2022-01-04', 22);


--Assign rank by partition based on product_id and find the latest product_id sold 
SELECT * FROM (
SELECT
product_id,
sale_date,
quantity_sold,
DENSE_RANK() OVER(PARTITION BY product_id ORDER BY sale_date DESC ) as rn
FROM sales_data
)as Ranked
WHERE rn = 1

--Retrieve the quantity_sold value from a previous row and compare the quantity_sold. 
SELECT
  product_id,
  sale_date,
  quantity_sold,
  LAG(quantity_sold) OVER(PARTITION BY product_id ORDER BY sale_date) AS prev_quantity
FROM sales_data;


--Partition based on product_id and return the first and last values in ordered set. 
SELECT product_id,
       FIRST_VALUE(quantity_sold) OVER(PARTITION BY product_id ORDER BY sale_date) AS first_quantity,
       LAST_VALUE(quantity_sold) OVER(PARTITION BY product_id ORDER BY sale_date) as last_quantity
FROM sales_data;

