create table ratings (
    course_id varchar PRIMARY KEY,
    ratings_count counter,
    ratings_total counter
) WITH comment='Table to store course ratings';

update ratings  set ratings_count = ratings_count + 1, ratings_total = ratings_total + 5 where course_id = 'react-big-picture';

update ratings  set ratings_count = ratings_count + 1, ratings_total = ratings_total + 4 where course_id = 'nodejs-big-picture';

cqlsh:pluralsight> create table ratings (
               ...     course_id varchar PRIMARY KEY,
               ...     ratings_count counter,
               ...     ratings_total counter
               ... ) WITH comment='Table to store course ratings';
cqlsh:pluralsight> update ratings  set ratings_count = ratings_count + 1, ratings_total = ratings_total + 5 where course_id = 'react-big-picture';
cqlsh:pluralsight> update ratings  set ratings_count = ratings_count + 1, ratings_total = ratings_total + 4 where course_id = 'nodejs-big-picture';
cqlsh:pluralsight>
cqlsh:pluralsight> select * from ratings;

 course_id          | ratings_count | ratings_total
--------------------+---------------+---------------
 nodejs-big-picture |             1 |             4
  react-big-picture |             1 |             5

(2 rows)
cqlsh:pluralsight> update ratings  set ratings_count = ratings_count + 1, ratings_total = ratings_total + 5 where course_id = 'react-big-picture';
cqlsh:pluralsight> select * from ratings;

 course_id          | ratings_count | ratings_total
--------------------+---------------+---------------
 nodejs-big-picture |             1 |             4
  react-big-picture |             2 |            10

(2 rows)
cqlsh:pluralsight> drop table ratings;

-- new ratings table 

create table ratings(
    course_id varchar,
    user_id varchar,
    rating float,
    PRIMARY KEY (course_id, user_id)
) WITH comment='Table to store course ratings by users';

insert into ratings (course_id, user_id, rating) values ('react-big-picture', '1', 5.0);
insert into ratings (course_id, user_id, rating) values ('nodejs-big-picture', '2', 4.0);
insert into ratings (course_id, user_id, rating) values ('advanced-javascript', '1', 4.5);
insert into ratings (course_id, user_id, rating) values ('advanced-python', '2', 4.0);
insert into ratings (course_id, user_id, rating) values ('raspberry-pi-for-developers', '1', 3.5);
insert into ratings (course_id, user_id, rating) values ('react-big-picture', '2', 4.0);
insert into ratings (course_id, user_id, rating) values ('nodejs-big-picture', '1', 5.0);
insert into ratings (course_id, user_id, rating) values ('react-big-picture', '3', 4.5);
insert into ratings (course_id, user_id, rating) values ('nodejs-big-picture', '4', 3.0);
insert into ratings (course_id, user_id, rating) values ('advanced-javascript', '2', 5.0);
insert into ratings (course_id, user_id, rating) values ('advanced-python', '3', 4.2);
insert into ratings (course_id, user_id, rating) values ('raspberry-pi-for-developers', '2', 4.8);
insert into ratings (course_id, user_id, rating) values ('react-big-picture', '4', 3.7);
insert into ratings (course_id, user_id, rating) values ('nodejs-big-picture', '3', 4.6);
insert into ratings (course_id, user_id, rating) values ('advanced-javascript', '3', 3.9);
insert into ratings (course_id, user_id, rating) values ('advanced-python', '4', 5.0);
insert into ratings (course_id, user_id, rating) values ('raspberry-pi-for-developers', '3', 4.1);

cqlsh:pluralsight> select * from ratings;

 course_id                   | user_id | rating
-----------------------------+---------+--------
             advanced-python |       2 |      4
             advanced-python |       3 |    4.2
             advanced-python |       4 |      5
         advanced-javascript |       1 |    4.5
         advanced-javascript |       2 |      5
         advanced-javascript |       3 |    3.9
          nodejs-big-picture |       1 |      5
          nodejs-big-picture |       2 |      4
          nodejs-big-picture |       3 |    4.6
          nodejs-big-picture |       4 |      3
 raspberry-pi-for-developers |       1 |    3.5
 raspberry-pi-for-developers |       2 |    4.8
 raspberry-pi-for-developers |       3 |    4.1
           react-big-picture |       1 |      5
           react-big-picture |       2 |      4
           react-big-picture |       3 |    4.5
           react-big-picture |       4 |    3.7

(17 rows)
cqlsh:pluralsight> select course_id, avg(rating) from ratings;

 course_id       | system.avg(rating)
-----------------+--------------------
 advanced-python |            4.28235

(1 rows)

Warnings :
Aggregation query used without partition key

cqlsh:pluralsight> select course_id, avg(rating) from ratings where course_id='advanced-javascript';

 course_id           | system.avg(rating)
---------------------+--------------------
 advanced-javascript |            4.46667

(1 rows)
cqlsh:pluralsight> select course_id, avg(rating) from ratings where course_id='react-big-picture';

 course_id         | system.avg(rating)
-------------------+--------------------
 react-big-picture |                4.3
