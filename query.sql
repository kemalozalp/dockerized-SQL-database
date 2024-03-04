-- FOR ORIGINAL QUERIES THAT I CAME UP WITH,
-- SCROLL DOWN TO THE BOTTOM OF THE FILE.ADD

-- ----------------------------
-- Queries from the tutorial --
-- ----------------------------

-- 1.View the employee TABLE
SELECT * FROM employee;

-- 2.Find all employees ordered by salary
-- in ascending order
SELECT * FROM employee
ORDER BY salary;

-- 3.Find all employees ordered by salary
-- in descending order
SELECT * FROM employee
ORDER BY salary DESC;

-- 4.Find all employees ordered by sex and name
SELECT * FROM employee
ORDER BY sex,first_name;

-- 5.Find the first 5 employees
SELECT * FROM employee
LIMIT 5;

-- 6.Find the first and last name of all employees
SELECT first_name,last_name
FROM employee;

-- 7.Find the first and last name of all employees
-- but change column names to forename and surname, respectively
SELECT first_name AS forename,last_name AS surname
FROM employee;

-- 8.Find out all the different branches
SELECT DISTINCT branch_id,br_name FROM branch;

-- 9.Find the number of employees
SELECT COUNT(emp_id) FROM employee;

-- 10.Find the number of female employees
SELECT COUNT(emp_id) FROM employee
WHERE sex = 'F';

-- 11.Find female employees born after 1970
SELECT first_name,last_name
FROM employee
WHERE birthday > '1970-12-31' and sex = 'F';

-- 12.Find the average salary
SELECT AVG(salary)
FROM employee;

-- 13.Find the average salary for male employees
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- 14.Find the average salary for female employees
SELECT AVG(salary)
FROM employee
WHERE sex = 'F';

-- 15.Find the average salary for male and female employees
-- and show all in one table
SELECT AVG(salary), sex
FROM employee
GROUP BY sex;

-- 16.Find the total salary budget of the corporate
SELECT SUM(salary)
FROM employee;

-- 17.Find the total sales of each salesman
SELECT emp_id, SUM(total_sales)
FROM works_with
GROUP BY emp_id;

-- 18.Find the volume of sales to each client
SELECT client_id, SUM(total_sales)
FROM works_with
GROUP BY client_id;

-- 19.Find clients who are LLC
SELECT cl_name
FROM client
WHERE cl_name LIKE "%LLC%";

-- 20.Find any branch supplier who are in the label business
SELECT supp_name
FROM supplier
WHERE supp_name LIKE "%label%";

-- 21.Find employees born in October
SELECT first_name,last_name,birthday
FROM employee
WHERE birthday LIKE "____-10%";

-- 22.Find clients who are schools
SELECT cl_name,client_id
FROM client
WHERE cl_name LIKE "%school%";

-- 23.Find a list of employee and branch names
-- Change the column name to 'names'
SELECT first_name as names
FROM employee
UNION
SELECT br_name
FROM branch;

-- 24.Find employees born in October
SELECT first_name,last_name,birthday
FROM employee
WHERE birthday LIKE "____-10%";

-- 25.List all branches and their managers
SELECT branch.branch_id, branch.br_name, employee.first_name, employee.last_name
FROM branch
LEFT JOIN employee
ON branch.mgr_id = employee.emp_id;

-- 26.List all branches with managers and their managers
SELECT branch.branch_id, branch.br_name, employee.first_name, employee.last_name
FROM branch
JOIN employee
ON branch.mgr_id = employee.emp_id;

-- 27.Find all employees who have sold over 30,000 to a single client
SELECT emp_id, first_name, last_name
FROM employee
WHERE emp_id IN
(SELECT emp_id
FROM works_with
WHERE total_sales > 30000);

-- 28.Find all employees who have sold over 30,000 to a single client
-- List their first_name, last_name and the amount of sale they made
SELECT employee.emp_id, employee.first_name, employee.last_name,works_with.total_sales
FROM employee
JOIN works_with
ON employee.emp_id = works_with.emp_id
WHERE works_with.total_sales > 30000;
-- -------------------------------------
-- EXTRAS: QUERIES THAT I CAME UP WITH--
-- -------------------------------------

-- Find the employee who made the biggest sale to a single client
SELECT first_name,last_name
FROM employee
WHERE emp_id = 
(SELECT emp_id
FROM works_with
ORDER BY total_sales DESC
LIMIT 1);

-- Find the employee who made the biggest sale to a single client
-- List first_name,last_name and sales made
SELECT e.first_name, e.last_name,ww.total_sales
FROM employee as e
JOIN works_with as ww
ON e.emp_id = ww.emp_id
ORDER BY ww.total_sales DESC
LIMIT 1;

-- Find the employee who made the biggest sale to a single client
-- List first_name,last_name and sales made
SELECT e.first_name, e.last_name,ww.total_sales
FROM employee as e
JOIN works_with as ww
ON e.emp_id = ww.emp_id
ORDER BY ww.total_sales DESC
LIMIT 1;

-- Find the total sales made by each employee
-- List first_name,last_name and total_sales made
-- List in descending order.
SELECT e.first_name, e.last_name, SUM(ww.total_sales)
FROM employee as e
JOIN works_with as ww
ON e.emp_id = ww.emp_id
GROUP BY e.first_name,e.last_name
ORDER BY SUM(ww.total_sales) DESC;

-- Find the total sales to each client.
-- List client_id, client _name and total_sales made
-- List in descending order.
SELECT c.client_id, c.cl_name, SUM(ww.total_sales)
FROM client as c
JOIN works_with as ww
ON c.client_id = ww.client_id
GROUP BY c.client_id,c.cl_name
ORDER BY SUM(ww.total_sales) DESC;

-- Find the ratio of salesman's salaries to total_sales they made
-- List first_name, last_name and the salary-to-sales ratio
-- Rename the ratio column as 'salary_to_total_sales'
SELECT e.first_name, e.last_name, (e.salary/SUM(ww.total_sales)) as salary_to_total_sales
FROM employee as e
JOIN works_with as ww
ON e.emp_id = ww.emp_id
GROUP BY e.first_name,e.last_name,e.salary
ORDER BY SUM(ww.total_sales) DESC;

-- Find the total sales volume of each branch
-- List branch_id, br_name and total sales
-- ORDER BY total sales in descending order
SELECT e.branch_id,b.br_name, SUM(ww.total_sales)
FROM employee as e
JOIN works_with as ww
ON e.emp_id = ww.emp_id
JOIN branch as b
ON e.branch_id = b.branch_id
GROUP BY e.branch_id
ORDER BY SUM(total_sales) DESC;