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
