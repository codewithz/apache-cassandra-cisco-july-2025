/*
 * This code utilizes Cassandra's timeuuid type and related functions.
 *
 * timeuuid:
 *   - A special UUID type in Cassandra that encodes a timestamp.
 *   - Useful for representing unique events in time and for ordering data chronologically.
 *   - Commonly used as a clustering key for time-series data.
 *
 * Functions:
 *   - now(): Generates a new timeuuid based on the current timestamp.
 *   - minTimeuuid(timestamp): Returns the smallest possible timeuuid for the given timestamp.
 *   - maxTimeuuid(timestamp): Returns the largest possible timeuuid for the given timestamp.
 *   - dateOf(timeuuid): Extracts the timestamp from a timeuuid value.
 *   - unixTimestampOf(timeuuid): Returns the timestamp of a timeuuid as a Unix epoch value (milliseconds since 1970-01-01).
 *
 * Usage Notes:
 *   - timeuuid values are sortable by time, making them ideal for queries that require chronological ordering.
 *   - Functions like minTimeuuid and maxTimeuuid are useful for range queries over timeuuid columns.
 *   - When inserting data, using now() ensures each row has a unique and time-ordered identifier.
 */

 Create table course_page_views (
    course_id text,
    view_id timeuuid,
    PRIMARY KEY (course_id, view_id)
 ) WITH CLUSTERING ORDER BY (view_id DESC);


insert into course_page_views (course_id, view_id) values ('react-big-picture', now()) using ttl 31536000; -- 1 year TTL

insert into course_page_views (course_id, view_id) values ('react-big-picture', now()) using ttl 31536000; -- 1 year TTL
insert into course_page_views (course_id, view_id) values ('react-big-picture', now()) using ttl 31536000; -- 1 year TTL

INSERT INTO course_page_views (course_id, view_id) VALUES ('react-big-picture', minTimeuuid('2025-07-15T10:00:00Z')) USING TTL 31536000;


Select toTimestamp(view_id) from course_page_views where course_id='react-big-picture';

Select toTimestamp(view_id) from course_page_views where course_id='react-big-picture'
 and view_id >= minTimeuuid('2025-07-15T10:00:00Z') and view_id <= maxTimeuuid('2025-07-15T11:00:00Z');

truncate course_page_views;

alter table course_page_views add first_view_id timeuuid static;

insert into course_page_views (course_id, view_id, first_view_id) values ('react-big-picture', now(), now()) using ttl 31536000; --

cqlsh:pluralsight> truncate course_page_views;
cqlsh:pluralsight> alter table course_page_views add first_view_id timeuuid static;
cqlsh:pluralsight> insert into course_page_views (course_id, view_id, first_view_id)
               ... values ('react-big-picture', now(), now()) using ttl 31536000;
cqlsh:pluralsight> select * from course_page_views;

 course_id         | view_id                              | first_view_id
-------------------+--------------------------------------+--------------------------------------
 react-big-picture | 33beeca0-620e-11f0-8c27-9f5b4c3f63d7 | 33beecaa-620e-11f0-8c27-9f5b4c3f63d7

(1 rows)
cqlsh:pluralsight> insert into course_page_views (course_id, view_id, first_view_id) values ('react-big-picture', now(), now()) using ttl 31536000; --
cqlsh:pluralsight> insert into course_page_views (course_id, view_id, first_view_id) values ('react-big-picture', now(), now()) using ttl 31536000; --
cqlsh:pluralsight> insert into course_page_views (course_id, view_id, first_view_id) values ('react-big-picture', now(), now()) using ttl 31536000; --
cqlsh:pluralsight> select * from course_page_views;

 course_id         | view_id                              | first_view_id
-------------------+--------------------------------------+--------------------------------------
 react-big-picture | 4b2c8b40-620e-11f0-8c27-9f5b4c3f63d7 | 4b2c8b4a-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 4839b110-620e-11f0-8c27-9f5b4c3f63d7 | 4b2c8b4a-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 42a047f0-620e-11f0-8c27-9f5b4c3f63d7 | 4b2c8b4a-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 33beeca0-620e-11f0-8c27-9f5b4c3f63d7 | 4b2c8b4a-620e-11f0-8c27-9f5b4c3f63d7

(4 rows)
cqlsh:pluralsight> insert into course_page_views (course_id, view_id, first_view_id) values ('react-big-picture', now(), now()) using ttl 31536000; --
cqlsh:pluralsight> insert into course_page_views (course_id, view_id, first_view_id) values ('react-big-picture', now(), now()) using ttl 31536000; --
cqlsh:pluralsight> insert into course_page_views (course_id, view_id, first_view_id) values ('react-big-picture', now(), now()) using ttl 31536000; --
cqlsh:pluralsight> select * from course_page_views;

 course_id         | view_id                              | first_view_id
-------------------+--------------------------------------+--------------------------------------
 react-big-picture | 6c398ae0-620e-11f0-8c27-9f5b4c3f63d7 | 6c398aea-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 6b72b870-620e-11f0-8c27-9f5b4c3f63d7 | 6c398aea-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 68831290-620e-11f0-8c27-9f5b4c3f63d7 | 6c398aea-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 4b2c8b40-620e-11f0-8c27-9f5b4c3f63d7 | 6c398aea-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 4839b110-620e-11f0-8c27-9f5b4c3f63d7 | 6c398aea-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 42a047f0-620e-11f0-8c27-9f5b4c3f63d7 | 6c398aea-620e-11f0-8c27-9f5b4c3f63d7
 react-big-picture | 33beeca0-620e-11f0-8c27-9f5b4c3f63d7 | 6c398aea-620e-11f0-8c27-9f5b4c3f63d7

(7 rows)
cqlsh:pluralsight>

-- Bucketing Data to manage partition size

drop table if exists course_page_views;

CREATE TABLE course_page_views (
    bucket_id varchar,
    course_id text,
    view_id timeuuid,
    last_view_id timeuuid static,
    PRIMARY KEY ((bucket_id, course_id), view_id)
) WITH CLUSTERING ORDER BY (view_id DESC);

-- Insert 5 records for May, June, and July with last_view_id for each bucket

-- May 2025
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'react-big-picture', minTimeuuid('2025-05-01T10:00:00Z'), maxTimeuuid('2025-05-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'react-big-picture', minTimeuuid('2025-05-10T12:00:00Z'), maxTimeuuid('2025-05-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'react-big-picture', minTimeuuid('2025-05-15T14:00:00Z'), maxTimeuuid('2025-05-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'react-big-picture', minTimeuuid('2025-05-20T16:00:00Z'), maxTimeuuid('2025-05-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'react-big-picture', minTimeuuid('2025-05-25T18:00:00Z'), maxTimeuuid('2025-05-31T23:59:59Z'));

-- June 2025
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'react-big-picture', minTimeuuid('2025-06-01T10:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'react-big-picture', minTimeuuid('2025-06-08T12:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'react-big-picture', minTimeuuid('2025-06-15T14:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'react-big-picture', minTimeuuid('2025-06-22T16:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'react-big-picture', minTimeuuid('2025-06-29T18:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));

-- July 2025
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'react-big-picture', minTimeuuid('2025-07-01T10:00:00Z'), maxTimeuuid('2025-07-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'react-big-picture', minTimeuuid('2025-07-10T12:00:00Z'), maxTimeuuid('2025-07-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'react-big-picture', minTimeuuid('2025-07-15T14:00:00Z'), maxTimeuuid('2025-07-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'react-big-picture', minTimeuuid('2025-07-20T16:00:00Z'), maxTimeuuid('2025-07-31T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'react-big-picture', minTimeuuid('2025-07-25T18:00:00Z'), maxTimeuuid('2025-07-31T23:59:59Z'));


-- May 2025 - other course
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'nodejs-big-picture', minTimeuuid('2025-05-01T10:00:00Z'), maxTimeuuid('2025-05-25T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'nodejs-big-picture', minTimeuuid('2025-05-10T12:00:00Z'), maxTimeuuid('2025-05-25T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'nodejs-big-picture', minTimeuuid('2025-05-15T14:00:00Z'), maxTimeuuid('2025-05-25T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'nodejs-big-picture', minTimeuuid('2025-05-20T16:00:00Z'), maxTimeuuid('2025-05-25T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-05', 'nodejs-big-picture', minTimeuuid('2025-05-25T18:00:00Z'), maxTimeuuid('2025-05-25T23:59:59Z'));

-- June 2025 - other course
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'nodejs-big-picture', minTimeuuid('2025-06-01T10:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'nodejs-big-picture', minTimeuuid('2025-06-08T12:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'nodejs-big-picture', minTimeuuid('2025-06-15T14:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'nodejs-big-picture', minTimeuuid('2025-06-22T16:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-06', 'nodejs-big-picture', minTimeuuid('2025-06-29T18:00:00Z'), maxTimeuuid('2025-06-30T23:59:59Z'));

-- July 2025 - other course (today's date)
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'nodejs-big-picture', minTimeuuid('2025-07-01T10:00:00Z'), maxTimeuuid(toTimestamp(now())));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'nodejs-big-picture', minTimeuuid('2025-07-10T12:00:00Z'), maxTimeuuid(toTimestamp(now())));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'nodejs-big-picture', minTimeuuid('2025-07-15T14:00:00Z'), maxTimeuuid(toTimestamp(now())));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'nodejs-big-picture', minTimeuuid('2025-07-20T16:00:00Z'), maxTimeuuid(toTimestamp(now())));
INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
VALUES ('2025-07', 'nodejs-big-picture', minTimeuuid('2025-07-25T18:00:00Z'), maxTimeuuid(toTimestamp(now())));


select distinct course_id, toTimestamp(last_view_id) from course_page_views where course_id in ('nodejs-big-picture','react-big-picture') and bucket_id='2025-05' ;


cqlsh:pluralsight> INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id)
               ... VALUES ('2025-07', 'nodejs-big-picture', now(),now());
cqlsh:pluralsight> INSERT INTO course_page_views (bucket_id, course_id, view_id, last_view_id) VALUES ('2025-07', 'react-big-picture', now(),now());
cqlsh:pluralsight> select * from course_page_views;

 bucket_id | course_id          | view_id                              | last_view_id
-----------+--------------------+--------------------------------------+--------------------------------------
   2025-05 |  react-big-picture | 13485000-3992-11f0-8080-808080808080 | 5bc4d08f-3e7b-11f0-7f7f-7f7f7f7f7f7f
   2025-05 |  react-big-picture | 7baec000-3593-11f0-8080-808080808080 | 5bc4d08f-3e7b-11f0-7f7f-7f7f7f7f7f7f
   2025-05 |  react-big-picture | e4153000-3194-11f0-8080-808080808080 | 5bc4d08f-3e7b-11f0-7f7f-7f7f7f7f7f7f
   2025-05 |  react-big-picture | 4c7ba000-2d96-11f0-8080-808080808080 | 5bc4d08f-3e7b-11f0-7f7f-7f7f7f7f7f7f
   2025-05 |  react-big-picture | 0b3b1000-2673-11f0-8080-808080808080 | 5bc4d08f-3e7b-11f0-7f7f-7f7f7f7f7f7f
   2025-05 | nodejs-big-picture | 13485000-3992-11f0-8080-808080808080 | 5d4a508f-39c4-11f0-7f7f-7f7f7f7f7f7f
   2025-05 | nodejs-big-picture | 7baec000-3593-11f0-8080-808080808080 | 5d4a508f-39c4-11f0-7f7f-7f7f7f7f7f7f
   2025-05 | nodejs-big-picture | e4153000-3194-11f0-8080-808080808080 | 5d4a508f-39c4-11f0-7f7f-7f7f7f7f7f7f
   2025-05 | nodejs-big-picture | 4c7ba000-2d96-11f0-8080-808080808080 | 5d4a508f-39c4-11f0-7f7f-7f7f7f7f7f7f
   2025-05 | nodejs-big-picture | 0b3b1000-2673-11f0-8080-808080808080 | 5d4a508f-39c4-11f0-7f7f-7f7f7f7f7f7f
   2025-06 |  react-big-picture | dfbd9000-5512-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 |  react-big-picture | f3508000-4f81-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 |  react-big-picture | 06e37000-49f1-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 |  react-big-picture | 1a766000-4460-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 |  react-big-picture | 2e095000-3ecf-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-07 |  react-big-picture | 2e7b1000-6981-11f0-8080-808080808080 | 06b780da-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 |  react-big-picture | 96e18000-6582-11f0-8080-808080808080 | 06b780da-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 |  react-big-picture | 06b780d0-6215-11f0-8c27-9f5b4c3f63d7 | 06b780da-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 |  react-big-picture | ff47f000-6183-11f0-8080-808080808080 | 06b780da-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 |  react-big-picture | 67ae6000-5d85-11f0-8080-808080808080 | 06b780da-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 |  react-big-picture | 266dd000-5662-11f0-8080-808080808080 | 06b780da-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 2e7b1000-6981-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 96e18000-6582-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 0155c980-6215-11f0-8c27-9f5b4c3f63d7 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | ff47f000-6183-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 67ae6000-5d85-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 266dd000-5662-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-06 | nodejs-big-picture | dfbd9000-5512-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 | nodejs-big-picture | f3508000-4f81-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 | nodejs-big-picture | 06e37000-49f1-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 | nodejs-big-picture | 1a766000-4460-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f
   2025-06 | nodejs-big-picture | 2e095000-3ecf-11f0-8080-808080808080 | 5429508f-560e-11f0-7f7f-7f7f7f7f7f7f

(32 rows)
cqlsh:pluralsight> select * from course_page_views where course_id='nodejs-big-picture';
InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot execute this query as it might involve data filtering and thus may have unpredictable performance. If you want to execute this query despite the performance unpredictability, use ALLOW FILTERING"
cqlsh:pluralsight> select * from course_page_views where course_id='nodejs-big-picture' and bucket_id='2025-07';

 bucket_id | course_id          | view_id                              | last_view_id
-----------+--------------------+--------------------------------------+--------------------------------------
   2025-07 | nodejs-big-picture | 2e7b1000-6981-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 96e18000-6582-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 0155c980-6215-11f0-8c27-9f5b4c3f63d7 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | ff47f000-6183-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 67ae6000-5d85-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7
   2025-07 | nodejs-big-picture | 266dd000-5662-11f0-8080-808080808080 | 0155c98a-6215-11f0-8c27-9f5b4c3f63d7

(6 rows)
cqlsh:pluralsight> select bucket_id,course_id,toTimestamp(view_id),toTimestamp(last_view_id) from course_page_views where course_id='nodejs-big-picture' and bucket
_id='2025-07';

 bucket_id | course_id          | system.totimestamp(view_id)     | system.totimestamp(last_view_id)
-----------+--------------------+---------------------------------+----------------------------------
   2025-07 | nodejs-big-picture | 2025-07-25 18:00:00.000000+0000 |  2025-07-16 07:18:00.472000+0000
   2025-07 | nodejs-big-picture | 2025-07-20 16:00:00.000000+0000 |  2025-07-16 07:18:00.472000+0000
   2025-07 | nodejs-big-picture | 2025-07-16 07:18:00.472000+0000 |  2025-07-16 07:18:00.472000+0000
   2025-07 | nodejs-big-picture | 2025-07-15 14:00:00.000000+0000 |  2025-07-16 07:18:00.472000+0000
   2025-07 | nodejs-big-picture | 2025-07-10 12:00:00.000000+0000 |  2025-07-16 07:18:00.472000+0000
   2025-07 | nodejs-big-picture | 2025-07-01 10:00:00.000000+0000 |  2025-07-16 07:18:00.472000+0000

(6 rows)
cqlsh:pluralsight>