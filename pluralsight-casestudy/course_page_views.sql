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