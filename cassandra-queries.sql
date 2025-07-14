
CREATE KEYSPACE comapanies with replication={'class':'SimpleStrategy','replication_factor':'1'} and durable_writes=true;


Create Table employee(
    id int, name text, salary float, dept text, designation text,
    primary key(dept,id)
)


INSERT INTO employee(id, name, dept, designation, salary) VALUES (1, 'Tom', 'IT', 'Dev', 25000);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (2, 'Alex', 'IT', 'Admin', 35000);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (3, 'Mike', 'Finance', 'Manager', 24000);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (4, 'John', 'Finance', 'Admin', 23400);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (5, 'Ross', 'Sales', 'Exec', 12000);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (6, 'Chandler', 'Sales', 'Manager', 32400);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (7, 'Joey', 'HR', 'Exec', 23000);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (8, 'Phoebe', 'HR', 'Exec', 21000);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (9, 'Monica', 'IT', 'Tester', 23400);
INSERT INTO employee(id, name, dept, designation, salary) VALUES (10, 'Rachel', 'HR', 'Manager', 25000);
-- Cabinet --> Drawer --> File
-- Keyspace --> Table --> Partition Key --> Clustering Key


CREATE TABLE [IF NOT EXISTS] keyspace_name.table_name (
    column_name data_type,
    ...
    PRIMARY KEY (partition_key [, clustering_column1, clustering_column2, ...])
);



Create Table employee(
    id int, name text, salary float, dept text, designation text,
    primary key(dept,id)  
)
-- Partition Key: dept
-- Clustering Key: id

CREATE TABLE attendance (
    school_id INT,
    student_id INT,
    date DATE,
    status TEXT,
    PRIMARY KEY ((school_id, student_id), date)
);
-- Partition Key: school_id, student_id
-- Clustering Key: date


CREATE TABLE attendance (
    school_id INT,
    student_id INT,
    date DATE,
    status TEXT,
    PRIMARY KEY (school_id, student_id, date)
);
-- Partition Key: school_id
-- Clustering Key: student_id, date

-- ------------------------------------------------------------------------------------------------

 Create table employee_multi_cluster
             (id int, name text, salary float, dept text, designation text,
            primary key(dept, id, designation));


Insert into employee_multi_cluster(id,name,dept,designation,salary) values (8,'Phoebe','HR','Exec',21000);
Insert into employee_multi_cluster(id,name,dept,designation,salary) values (9,'Monica','IT','Tester',23400);
Insert into employee_multi_cluster(id,name,dept,designation,salary) values (10,'Rachel','HR','Manager',25000);

-- ----------------------------------------------------------------------------------

-- Multi Partition Table 

Create table employee_multipartition
(
    id int, name text, salary float, dept text, designation text,
    primary key((dept,designation),id)
)

Insert into employee_multipartition(id,name,dept,designation,salary) values (8,'Phoebe','HR','Exec',21000);
Insert into employee_multipartition(id,name,dept,designation,salary) values (9,'Monica','IT','Tester',23400);
Insert into employee_multipartition(id,name,dept,designation,salary) values (10,'Rachel','HR','Manager',25000);

-- Cassandra requires that clustering columns be queried in order, 
-- and you cannot skip clustering keys unless you specify all preceding ones.

-- -------------------------------write time-----------------------------------------------------------------

 Select dept,id,name,writetime(name) from employee;

 -- The writetime function returns the time at which a column was last written to in microseconds since the epoch (January 1, 1970).

 -- -----------------------------Update -------------------------------------------------------------------------------

update employee set name='Tommy' where dept='IT' and id=1;


1. Update will insert if the value we are trying to update doesnt exist already 


name=Penny
dept=Admin
designation=Manager
salary=30000
id=89
 
 Update employee set name='Penny',designation='Manager',salary=30000 where dept='Admin' and id=89;

 2. If trying to insert an already existing record, it will update it 

 Insert into employee(id,name,dept,designation,salary) values (6,'Chandler Bing','Sales','Team Lead',450000)

