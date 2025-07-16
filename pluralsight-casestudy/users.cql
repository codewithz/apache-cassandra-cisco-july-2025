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



alter table users add last_login map<text,timestamp>;

update users set last_login = last_login + {'Apple MAC [12345]': '2023-01-01 10:00:00'} where id='1';

-- nesting of types 

 alter table users drop last_login;
select * from users;

alter table users add last_login_with_ip map<text,frozen<tuple<timestamp,inet>>>;

update users set last_login_with_ip = last_login_with_ip + {'Apple MAC [12345]': ('2023-01-01 10:00:00', '192.168.1.1')} where id='1';
