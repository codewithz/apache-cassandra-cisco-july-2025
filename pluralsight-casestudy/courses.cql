use pluralsight;

create table courses(
    id varchar PRIMARY KEY,
    name varchar,
    author varchar,
    audience int,
    duration int,
    cc boolean,
    released timestamp) with comment='Table to store course information';

    -- Sample data insertion
insert into courses(id, name, author, audience, duration, cc, released)
 values('react-big-picture', 'React: Big Picture', 'Cory House', 1, 4260, true, '2023-01-01');

INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('nodejs-big-picture','Node.js: The Big Picture', 'Paul O''Fallon', 1, 3240, true, '2019-06-03');

INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('advanced-javascript','Advanced Javascript', 'Kyle Simpson', 2, 24900, true, '2015-04-09');

INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('advanced-python','Advanced Python', 'Robert Smallshire', 3, 13980, true, '2017-06-24');

INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('raspberry-pi-for-developers','Raspberry Pi for Developers', 'Jon Flanders', 2, 8640, true, '2013-05-30');


-- Adding modules to courses

-- drop table courses;

-- A static column in Cassandra is a special type of column defined in a table with a clustering key. 
--Static columns store values that are shared by all rows within the same partition.

--Key Points
--Scope: Static columns are stored once per partition, not per row.
--Usage: Useful for data that is common to all rows in a partition (e.g., metadata, summary info).
--Definition: Declared with the STATIC keyword in the table schema.
--Example
--Suppose you have a table for courses and modules:

--CREATE TABLE course_modules (
--    course_id text,
--    module_id text,
 --   course_title text STATIC,
 --   module_title text,
 --   PRIMARY KEY (course_id, module_id)
--);

--course_title is static: only one value per course_id partition.
--module_title is regular: different for each module.
--Gotchas
--Static columns only work in tables with a clustering key.
--If you update a static column, it updates for all rows in the partition.
--Static columns can't be used in tables without clustering columns.
--When to Use
--When you need to store partition-level data (e.g., course description for all modules of a course).


create table courses(
    id varchar ,
    name varchar static,
    author varchar static,
    audience int static,
    duration int static,
    cc boolean static,
    released timestamp static,
    module_id int,
    module_name varchar,
    module_duration int,
    PRIMARY KEY (id, module_id)
) with comment='Table to store course information with modules';

-- Sample data for courses table
INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('react-big-picture','React: The Big Picture', 'Cory House', 1, 4260, true, '2017-11-21');

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('react-big-picture', 1, 'Course Overview', 86);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('react-big-picture', 2, 'Why React?', 1555);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('react-big-picture', 3, 'Tradeoffs', 1412);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('react-big-picture', 4, 'Why Not React?', 1236);

  expand on 

  INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('nodejs-big-picture','Node.js: The Big Picture', 'Paul O''Fallon', 1, 3240, true, '2019-06-03');

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('nodejs-big-picture', 1, 'Course Overview', 70);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('nodejs-big-picture', 2, 'Considering Node.js', 900);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('nodejs-big-picture', 3, 'Thinking Asynchronously', 1304);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('nodejs-big-picture', 4, 'Defining an Application and Managing Dependencies', 525);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('nodejs-big-picture', 5, 'Assembling a Development Toolset', 489);

INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('advanced-javascript','Advanced Javascript', 'Kyle Simpson', 2, 24900, false, '2015-04-09');

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-javascript', 1, 'Introduction', 2408);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-javascript', 2, 'Scope', 9914);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-javascript', 3, 'Closure', 2801);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-javascript', 4, 'Object Orienting', 6376);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-javascript', 5, 'Async Patterns', 3437);

INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('advanced-python','Advanced Python', 'Robert Smallshire', 3, 13980, true, '2017-06-24');

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 1, 'Course Overview', 130);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 2, 'Advanced Flow Control', 2579);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 3, 'Byte-oriented Programming', 2526);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 4, 'Object Internals and Custom Attributes', 1851);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 5, 'Descriptors', 1329);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 6, 'Instance Creation', 647);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 7, 'Metaclasses', 2182);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 8, 'Class Decorators', 717);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('advanced-python', 9, 'Abstract Base Classes', 2036);

INSERT INTO courses (id, name, author, audience, duration, cc, released)
VALUES ('raspberry-pi-for-developers','Raspberry Pi for Developers', 'Jon Flanders', 2, 8640, true, '2013-05-30');

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('raspberry-pi-for-developers', 1, 'Introduction to Raspberry Pi', 1765);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('raspberry-pi-for-developers', 2, 'Programming the Raspberry Pi', 2250);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('raspberry-pi-for-developers', 3, 'Raspberry Pi and Hardware', 1877);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('raspberry-pi-for-developers', 4, 'Raspberry Pi as a Web Server', 1592);

  INSERT INTO courses (id, module_id, module_name, module_duration)
  VALUES ('raspberry-pi-for-developers', 5, 'Raspberry Pi as a DVR', 1197);


  -- Implement collections and user defined types (UDTs) in Cassandra


alter table courses drop cc;

alter table courses add features set<text> static;

update courses set features = {'video', 'audio', 'pdf','cc'} where id = 'react-big-picture';
select distinct id,name,features from courses;
update courses set features = features- {'pdf'} where id = 'react-big-picture';

-- list  

alter table courses add clips list<text>;

update courses set clips= ['Introduction', 'Installation', 'Components'] where id = 'react-big-picture' amd module_id = 1;