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