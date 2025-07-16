CREATE KEYSPACE IF NOT EXISTS pluralsight
WITH replication={'class':'SimpleStrategy','replication_factor':1};

USE pluralsight;


CREATE TABLE users(
    id varchar PRIMARY KEY,
    first_name varchar,
    last_name varchar,
    email varchar,
    password varchar,
    reset_token varchar
) WITH comment='Table to store user information';   


insert into users(id,first_name,last_name,email) values('1','John','Doe','john.doe@example.com');

insert into users(id,first_name,last_name,email) values('2','Jane','Doe','jane.doe@example.com');


-- using ttl 

update users using ttl 120 set reset_token='abc123' where id='1';

select ttl(reset_token) from users where id='1';

 ttl(reset_token)
------------------
              101