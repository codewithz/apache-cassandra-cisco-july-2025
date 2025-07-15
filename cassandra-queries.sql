
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

 Create table accountotp(id int PRIMARY KEY,name text, otp int);

cqlsh:cisco_ks>
cqlsh:cisco_ks> Insert into accountotp(id ,name,otp) values (1,'Tom',2025);
cqlsh:cisco_ks>
cqlsh:cisco_ks>
cqlsh:cisco_ks> Update accountotp using ttl 60 set otp=9867 where id=1;
cqlsh:cisco_ks> select * from accountotp;

 id | name | otp
----+------+------
  1 |  Tom | 9867

(1 rows)
cqlsh:cisco_ks> select * from accountotp;

 id | name | otp
----+------+------
  1 |  Tom | 9867

(1 rows)
cqlsh:cisco_ks> select * from accountotp;

 id | name | otp
----+------+------
  1 |  Tom | 9867




INSERT INTO sessions (session_id, user_id, login_time)
VALUES (123, 456, toTimestamp(now()))
USING TTL 3600;

-- After 3600 seconds (1 hour), the entire row will be deleted.

------------------ Netowork Topology Strategy -----------------------------

PS J:\Zartab\Trainings\2025\25-B-15-Cisco-Cassandra-Indai-July-2025\git_repo\multi-dc\5.0> docker exec -it n1 cqlsh
Connected to SocialCluster at 127.0.0.1:9042
[cqlsh 6.2.0 | Cassandra 5.0.4 | CQL spec 3.4.7 | Native protocol v5]
Use HELP for help.
cqlsh> CREATE KEYSPACE social_app
   ... WITH REPLICATION={}
   ... 'class':'NetworkTopologyStrategy',
   ... 'DC1':2,
   ... 'DC2':1
   ... } and durable_writes=true;
SyntaxException: line 3:0 mismatched input 'class' expecting EOF (... social_appWITH REPLICATION={}['clas]...)
cqlsh> CREATE KEYSPACE social_app WITH REPLICATION={'class':'NetworkTopologyStrategy', 'DC1':2, 'DC2':1 } and durable_writes=true;
cqlsh> USE social_app;
cqlsh:social_app> CREATE TABLE posts (
              ...     post_id UUID,
              ...     user_id UUID,
              ...     content TEXT,
              ...     posted_on TIMESTAMP,
              ...     PRIMARY KEY ((user_id), posted_on)
              ... );

cqlsh:social_app>
cqlsh:social_app> INSERT INTO posts (post_id, user_id, content, posted_on) VALUES (
              ...   uuid(), uuid(), 'Hello from DC1!', toTimestamp(now())
              ... );
cqlsh:social_app> Select * from posts;

 user_id                              | posted_on                       | content         | post_id
--------------------------------------+---------------------------------+-----------------+--------------------------------------
 63ca4753-d29b-41a3-af79-e506649fc57d | 2025-07-15 06:35:54.069000+0000 | Hello from DC1! | fd211d3a-c471-4a6a-b5ef-bf0406514b96

 -- Tracing Cassandra with Network Topology Strategy

 cqlsh:social_app> TRACING ON;
TRACING set to ON
cqlsh:social_app> INSERT INTO posts (post_id, user_id, content, posted_on) VALUES (
              ...               ...   uuid(), uuid(), 'Hello from DC1!', toTimestamp(now())
              ...               ... );
SyntaxException: line 2:14 no viable alternative at input '..' (...content, posted_on) VALUES (              [..]...)
cqlsh:social_app> INSERT INTO posts (post_id, user_id, content, posted_on) VALUES (   uuid(), uuid(), 'Hello from DC1!', toTimestamp(now()) );

Tracing session: cf224520-6146-11f0-8c27-9f5b4c3f63d7

 activity                                                                                                                                                           | timestamp                  | source     | source_elapsed | client
--------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------+------------+----------------+-----------
                                                                                                                                                 Execute CQL3 query | 2025-07-15 06:41:59.922000 | 172.22.0.2 |              0 | 127.0.0.1
 Parsing INSERT INTO posts (post_id, user_id, content, posted_on) VALUES (   uuid(), uuid(), 'Hello from DC1!', toTimestamp(now()) ); [Native-Transport-Requests-1] | 2025-07-15 06:41:59.923000 | 172.22.0.2 |            498 | 127.0.0.1
                                                                                                                  Preparing statement [Native-Transport-Requests-1] | 2025-07-15 06:41:59.924000 | 172.22.0.2 |           1143 | 127.0.0.1
                                                                                                    Determining replicas for mutation [Native-Transport-Requests-1] | 2025-07-15 06:41:59.925000 | 172.22.0.2 |           2299 | 127.0.0.1
                                  Sending mutation to remote replica Full(/172.22.0.4:7000,(1180247101545117923,1779035269665644201]) [Native-Transport-Requests-1] | 2025-07-15 06:41:59.926000 | 172.22.0.2 |           3136 | 127.0.0.1
                                                                                                                           Appending to commitlog [MutationStage-2] | 2025-07-15 06:41:59.926001 | 172.22.0.2 |           3291 | 127.0.0.1
                                                                  Sending MUTATION_REQ message to /172.22.0.3:7000 message size 141 bytes [Messaging-EventLoop-3-4] | 2025-07-15 06:41:59.926002 | 172.22.0.2 |           3436 | 127.0.0.1
                                                                                                                         Adding to posts memtable [MutationStage-2] | 2025-07-15 06:41:59.926003 | 172.22.0.2 |           3646 | 127.0.0.1
                                                                 Sending MUTATION_REQ message to /172.22.0.4:7000 message size 141 bytes [Messaging-EventLoop-3-10] | 2025-07-15 06:41:59.926004 | 172.22.0.2 |           3681 | 127.0.0.1
                                                                                     MUTATION_REQ message received from /172.22.0.2:7000 [Messaging-EventLoop-3-13] | 2025-07-15 06:41:59.930000 | 172.22.0.3 |            544 | 127.0.0.1
                                                                                     MUTATION_REQ message received from /172.22.0.2:7000 [Messaging-EventLoop-3-13] | 2025-07-15 06:41:59.930000 | 172.22.0.4 |            578 | 127.0.0.1
                                                                                                                           Appending to commitlog [MutationStage-1] | 2025-07-15 06:41:59.935000 | 172.22.0.3 |           6346 | 127.0.0.1
                                                                                                                         Adding to posts memtable [MutationStage-1] | 2025-07-15 06:41:59.936000 | 172.22.0.3 |           6745 | 127.0.0.1
                                                                                                           Enqueuing response to /172.22.0.2:7000 [MutationStage-1] | 2025-07-15 06:41:59.936001 | 172.22.0.3 |           6997 | 127.0.0.1
                                                                                                                           Appending to commitlog [MutationStage-1] | 2025-07-15 06:41:59.937000 | 172.22.0.4 |           7719 | 127.0.0.1
                                                                 Sending MUTATION_RSP message to n1/172.22.0.2:7000 message size 33 bytes [Messaging-EventLoop-3-1] | 2025-07-15 06:41:59.938000 | 172.22.0.3 |           9108 | 127.0.0.1
                                                                                                                         Adding to posts memtable [MutationStage-1] | 2025-07-15 06:41:59.938000 | 172.22.0.4 |           8555 | 127.0.0.1
                                                                                                           Enqueuing response to /172.22.0.2:7000 [MutationStage-1] | 2025-07-15 06:41:59.939000 | 172.22.0.4 |           9069 | 127.0.0.1
                                                                                     MUTATION_RSP message received from /172.22.0.3:7000 [Messaging-EventLoop-3-14] | 2025-07-15 06:41:59.940000 | 172.22.0.2 |             76 | 127.0.0.1
                                                                 Sending MUTATION_RSP message to n1/172.22.0.2:7000 message size 33 bytes [Messaging-EventLoop-3-1] | 2025-07-15 06:41:59.940000 | 172.22.0.4 |          10574 | 127.0.0.1
                                                                                                 Processing response from /172.22.0.3:7000 [RequestResponseStage-3] | 2025-07-15 06:41:59.940001 | 172.22.0.2 |            664 | 127.0.0.1
                                                                                     MUTATION_RSP message received from /172.22.0.4:7000 [Messaging-EventLoop-3-13] | 2025-07-15 06:41:59.941000 | 172.22.0.2 |             13 | 127.0.0.1
                                                                                                 Processing response from /172.22.0.4:7000 [RequestResponseStage-1] | 2025-07-15 06:41:59.941001 | 172.22.0.2 |            136 | 127.0.0.1
                                                                                                                                                   Request complete | 2025-07-15 06:41:59.926129 | 172.22.0.2 |           4129 | 127.0.0.1


cqlsh:social_app> select * from posts;

 user_id                              | posted_on                       | content         | post_id
--------------------------------------+---------------------------------+-----------------+--------------------------------------
 63ca4753-d29b-41a3-af79-e506649fc57d | 2025-07-15 06:35:54.069000+0000 | Hello from DC1! | fd211d3a-c471-4a6a-b5ef-bf0406514b96
 21785f34-92c5-490f-ad5a-bc338d089197 | 2025-07-15 06:41:59.924000+0000 | Hello from DC1! | f3cb7d03-c52c-4484-aa1e-425e6b538282

(2 rows)

Tracing session: e42dfef0-6146-11f0-8c27-9f5b4c3f63d7

 activity                                                                                                                   | timestamp                  | source     | source_elapsed | client
----------------------------------------------------------------------------------------------------------------------------+----------------------------+------------+----------------+-----------
                                                                                                         Execute CQL3 query | 2025-07-15 06:42:35.231000 | 172.22.0.2 |              0 | 127.0.0.1
                                                                 Parsing select * from posts; [Native-Transport-Requests-1] | 2025-07-15 06:42:35.231001 | 172.22.0.2 |            383 | 127.0.0.1
                                                                          Preparing statement [Native-Transport-Requests-1] | 2025-07-15 06:42:35.231002 | 172.22.0.2 |            629 | 127.0.0.1
                                                                    Computing ranges to query [Native-Transport-Requests-1] | 2025-07-15 06:42:35.232000 | 172.22.0.2 |           1136 | 127.0.0.1
 Submitting range requests on 65 ranges with a concurrency of 1 (0.0 rows per range expected) [Native-Transport-Requests-1] | 2025-07-15 06:42:35.232001 | 172.22.0.2 |           1458 | 127.0.0.1
                                                        Submitted 1 concurrent range requests [Native-Transport-Requests-1] | 2025-07-15 06:42:35.235000 | 172.22.0.2 |           4087 | 127.0.0.1
              Executing seq scan across 0 sstables for (min(-9223372036854775808), min(-9223372036854775808)] [ReadStage-3] | 2025-07-15 06:42:35.235001 | 172.22.0.2 |           4217 | 127.0.0.1
                                                                       Read 2 live rows and 0 tombstone cells [ReadStage-3] | 2025-07-15 06:42:35.235002 | 172.22.0.2 |           4500 | 127.0.0.1
                                                                                           
| **Trace Message**                                                                                                                  | **What It Means**                                                                                                                                                                                 |
| ---------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Execute CQL3 query**                                                                                                             | The coordinator node (`172.22.0.2`) has accepted the client request (from `127.0.0.1`) and created a tracing session. `source_elapsed = 0 µs` is the starting point.                              |
| **Parsing select \* from posts;**                                                                                                  | The coordinator parses the CQL string into an internal statement representation on the **Native‑Transport‑Requests‑1** thread. Elapsed ≈ 383 µs.                                                  |
| **Preparing statement**                                                                                                            | The statement is prepared (or fetched from the prepared‑statement cache). This includes validation, metadata lookup, and digest calculation.                                                      |
| **Computing ranges to query**                                                                                                      | Because the query has **no partition key restriction**, Cassandra must compute *which token ranges* could satisfy the query. That’s why it’s expensive.                                           |
| **Submitting range requests on 65 ranges with a concurrency of 1**                                                                 | The coordinator plans to fetch data from **65 token ranges** (there are 65 vnodes in this cluster). Concurrency 1 means ranges are queried sequentially.                                          |
| **Submitted 1 concurrent range requests**                                                                                          | The first range request has been dispatched to replicas.                                                                                                                                          |
| **Executing seq scan across 0 SSTables for (min(‑∞), min(‑∞)]**                                                                    | On a replica’s **ReadStage** thread, Cassandra does a sequential scan of in‑memory structures and SSTables for that range. In this example it found everything in memtables (0 SSTables scanned). |
| **Read 2 live rows and 0 tombstone cells**                                                                                         | The replica actually read two live rows (and no tombstones) for that range.                                                                                                                       |
| *(The coordinator will repeat the last two steps for every remaining range, then merge results and send them back to the client.)* |                                                                                                                                                                                                   |


-- Collection Types 

List -- Notation Used -- [, , , ,]

Create table batsmen (id int primary key, name text, country text, last5scores list<int>);

Insert into batsmen(id,name,country,last5scores) values (1,'Virat Kohli','India',[23,100,123,34,76]);

-- Set 
-- Notation Used -- {, , , ,}

Create table passportholder(id int primary key, name text, passport set<text>);

Insert into passportholder(id,name,passport) values (1,'John Doe',{'A1234567','B2345678','A1234567'});

-- Map 
-- Notation Used -- {, : , , : , , : }

Create table todos(id int primary key, name text, todo map<int,text>);

Insert into todo(id,name,todo) values (1,'Zartab',{1:'Collect Medicine for Mother',2:'Do Laundry',3:
'Pay Electicity Bill',4:'Fill up petrol in car'});
                  ... ;


