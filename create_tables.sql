CREATE DATABASE IF NOT EXISTS the_office;

USE the_office;

-- Start with the 'employee' table but hold on
-- to define the foreign keys as no tables exist
-- yet
CREATE TABLE IF NOT EXISTS employee (
    emp_id INT,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    sex VARCHAR(1),
    birthday DATE,
    salary INT,
    branch_id INT,
    super_id INT,
    PRIMARY KEY(emp_id)
);

-- Create 'branch' table now. Define the foreign key and
-- its relationship with the employee.emp_id. If emp_id
-- is deleted from the employee table, set the mgr_id
-- to NULL
CREATE TABLE IF NOT EXISTS branch(
    branch_id INT,
    br_name VARCHAR(40),
    mgr_id INT,
    start_date DATE,
    PRIMARY KEY(branch_id),
    FOREIGN KEY(mgr_id)
    REFERENCES employee(emp_id)
    ON DELETE SET NULL
);

-- Now, let's define the foreign keys in the 'employee'
-- table by altering the employee table properties
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

-- Create 'supplier' table. If branch.branch_id is deleted
-- remove the entire row
CREATE TABLE IF NOT EXISTS supplier(
    supp_name VARCHAR(40),
    branch_id INT,
    product VARCHAR(40),
    PRIMARY KEY(branch_id,supp_name),
    FOREIGN KEY(branch_id) 
    REFERENCES branch(branch_id)
    ON DELETE CASCADE
);

-- Create 'client' table. If branch.branch_id is deleted,
-- remove the entire row
CREATE TABLE IF NOT EXISTS client(
    client_id INT,
    branch_id INT,
    cl_name VARCHAR(40),
    PRIMARY KEY(client_id),
    FOREIGN KEY(branch_id)
    REFERENCES branch(branch_id)
    ON DELETE CASCADE
);

-- Create 'works_with' table. If employee.emp_id or
-- client.client_id are removed, remove the entire row
CREATE TABLE IF NOT EXISTS works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id,client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

-- INSERT INFORMATION
-- Branch table has not entry. So, David Wallace's branch_id
-- is initially set to 'NULL'
INSERT INTO employee 
VALUES(
    100,'David','Wallace','M','1967-11-17',250000,NULL,NULL
    );
-- Now, add the corporate branch to the branch table
INSERT INTO branch
VALUES(
    1,'Corporate',100,'2006-02-09'
);
-- Update David Wallece's branch_id
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;
-- Now, I can insert Jan Levinson because her supervisor
-- and branch exist.
INSERT INTO employee
VALUES(
    101,'Jan','Levinson','F','1961-05-11',110000,1,100
    );
-- Next, insert the next branch supervisor, Michael Scott
INSERT INTO employee
VALUES(
    102,'Michael','Scott','M','1964-03-15',75000,NULL,100
    );
-- Insert Scranton branch into branch TABLE
INSERT INTO branch
VALUES(
    2,'Scranton',102,'1992-04-06'
);
-- Update Michael Scott's branch_id
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;
-- Insert other employees working at the Scranton branch
INSERT INTO employee
VALUES
(103,'Angela','White','F','1971-06-25',63000,2,102),
(104,'Kelly','Kapoor','F','1980-02-05',55000,2,102),
(105,'Stanley','Hudson','M','1958-02-19',69000,2,102);
-- Insert Stamford branch's supervisor
INSERT INTO employee
VALUES(106,'Josh','Porter','M','1969-09-05',78000,NULL,100);
-- Insert Stamford branch into the branch table
INSERT INTO branch
VALUES(3,'Stamford',106,'1998-02-13');
-- UPDATE Josh Porter's branch id in the employee TABLE
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;
-- Insert Stamford branch employees
INSERT INTO employee
VALUES
(107,'Andy','Bernard','M','1973-07-22',65000,3,106),
(108,'Jim','Halpert','M','1978-10-01',71000,3,106);

-- Insert one more branch without a manager
INSERT INTO branch
VALUES(
    4,'Buffalo',NULL,NULL
);
-- Insert clients into the client TABLE
-- I'll insert all clients at once.
INSERT INTO client
VALUES
(400,2,'Dunmore Highschool'),
(401,2,'Lackawana Country'),
(402,3,'FedEx'),
(403,3,'John Daly Law, LLC'),
(404,2,'Scranton Whitepages'),
(405,3,'Times Newspaper'),
(406,2,'FedEx');
-- Insert info into the works_with table now
INSERT INTO works_with
VALUES
(105,400,55000),
(102,401,267000),
(108,402,22500),
(107,403,5000),
(108,403,12000),
(105,404,33000),
(107,405,26000),
(102,406,15000),
(105,406,130000);
-- Finally, insert info into the supplier table
INSERT INTO supplier
VALUES
('Hammer Mill',2,'Paper'),
('Uni-ball',2,'Writing utensils'),
('Patriot Paper',3,'Paper'),
('J.T. Forms & Labels',2,'Custom forms'),
('Uni-ball',3,'Writing utensils'),
('Hammer Mill',3,'Paper'),
('Stamford Labels',3,'Custom forms');
