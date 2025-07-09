# SQL Assignments

## Assignment Questions

1. Create Database as **ecommerce** and create 4 tables (`gold_member_users`, `users`, `sales`, `product`) under the above database. Insert the values provided with respective datatypes.

2. Write a query to find for each date the number of different products sold and their names from the `product_details` table.

3. Find the total salary of each department from the `department_salary` table.

4. Write a query to find Gmail accounts with latest and first signup date and difference between both the dates from the `email_signup` table. Also, replace null signup dates with `1970-01-01`.

5. Using the `sales_data` table:
   - Assign rank by partition based on `product_id` and find the latest `product_id` sold.
   - Retrieve the `quantity_sold` value from a previous row and compare it.
   - Return the first and last values in the ordered set for each `product_id`.
