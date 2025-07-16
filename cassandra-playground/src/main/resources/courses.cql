CREATE KEYSPACE IF NOT EXISTS course_keyspace
    WITH replication = {'class': 'NetworkTopologyStrategy', 'DC1': 2, 'DC2': 1};

USE course_keyspace;

CREATE TABLE IF NOT EXISTS courses (
                                       course_id UUID PRIMARY KEY,
                                       title TEXT,
                                       instructor TEXT,
                                       level TEXT
);

INSERT INTO courses (course_id, title, instructor, level)
VALUES (uuid(), 'Apache Cassandra Basics', 'Zartab', 'Beginner');
