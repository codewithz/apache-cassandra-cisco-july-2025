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


-- Indexes 

alter table users add company text;

update users set company = 'Tech Solutions' where id='1';

cqlsh:pluralsight> alter table users add company text;
cqlsh:pluralsight> update users set company = 'Tech Solutions' where id='1';
cqlsh:pluralsight> select * from users;

 id | company        | email                | first_name | last_login_with_ip                                                        | last_name | password | reset_token
----+----------------+----------------------+------------+---------------------------------------------------------------------------+-----------+----------+-------------
  2 |           null | jane.doe@example.com |       Jane |                                                                      null |       Doe |     null |        null
  1 | Tech Solutions | john.doe@example.com |       John | {'Apple MAC [12345]': ('2023-01-01 10:00:00.000000+0000', '192.168.1.1')} |       Doe |     null |        null

(2 rows)
cqlsh:pluralsight> select * from users where company='Tech Solutions;'
               ... ;
InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot execute this query as it might involve data filtering and thus may have unpredictable performance. If you want to execute this query despite the performance unpredictability, use ALLOW FILTERING"
cqlsh:pluralsight> select * from users where company='Tech Solutions';
InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot execute this query as it might involve data filtering and thus may have unpredictable performance. If you want to execute this query despite the performance unpredictability, use ALLOW FILTERING"


Create materialized view to allow filtering by company

CREATE MATERIALIZED VIEW users_by_company AS
SELECT * FROM users
WHERE company IS NOT NULL
PRIMARY KEY (company, id);