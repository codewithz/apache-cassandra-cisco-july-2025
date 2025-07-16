
# Cassandra CQL Commands Guide

This guide covers a wide range of Cassandra Query Language (CQL) commands for schema creation, data manipulation, and cluster-level operations.

---

## 🔸 Keyspace Commands

### Create Keyspace
```sql
CREATE KEYSPACE IF NOT EXISTS my_keyspace
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};
```

### List Keyspaces
```sql
DESCRIBE keyspaces;
```

### Use Keyspace
```sql
USE my_keyspace;
```

### Drop Keyspace
```sql
DROP KEYSPACE my_keyspace;
```

---

## 🔸 Table Commands

### Create Table
```sql
CREATE TABLE users (
  user_id UUID PRIMARY KEY,
  name TEXT,
  email TEXT
);
```

### List Tables
```sql
DESCRIBE TABLES;
```

### Describe Table Schema
```sql
DESCRIBE TABLE users;
```

### Alter Table
```sql
ALTER TABLE users ADD age INT;
```

### Drop Table
```sql
DROP TABLE users;
```

---

## 🔸 Data Manipulation (CRUD)

### Insert Data
```sql
INSERT INTO users (user_id, name, email)
VALUES (uuid(), 'Alice', 'alice@example.com');
```

### Select Data
```sql
SELECT * FROM users;
```

### Update Data
```sql
UPDATE users SET name = 'Alice Cooper' WHERE user_id = some_uuid;
```

### Delete Data
```sql
DELETE FROM users WHERE user_id = some_uuid;
```

---

## 🔸 TTL (Time To Live)

### Insert with TTL
```sql
INSERT INTO sessions (session_id, data) VALUES (uuid(), 'mydata') USING TTL 86400;
```

### Select TTL
```sql
SELECT TTL(data) FROM sessions WHERE session_id = some_uuid;
```

---

## 🔸 Indexes

### Create Index
```sql
CREATE INDEX ON users (email);
```

### Drop Index
```sql
DROP INDEX users_email_idx;
```

---

## 🔸 User-Defined Types (UDT)

### Create Type
```sql
CREATE TYPE address (
  street TEXT,
  city TEXT,
  zip INT
);
```

### Use Type in Table
```sql
CREATE TABLE contacts (
  contact_id UUID PRIMARY KEY,
  address FROZEN<address>
);
```

---

## 🔸 Batch Statements

### Execute a Batch
```sql
BEGIN BATCH
  INSERT INTO users (user_id, name) VALUES (uuid(), 'User A');
  INSERT INTO users (user_id, name) VALUES (uuid(), 'User B');
APPLY BATCH;
```

---

## 🔸 Role and Access Control

### Create Role
```sql
CREATE ROLE readonly WITH PASSWORD = 'pass' AND LOGIN = true;
```

### Grant Permissions
```sql
GRANT SELECT ON keyspace_name.users TO readonly;
```

### List Roles
```sql
LIST ROLES;
```

---

## 🔸 Other Useful CQL Commands

### Truncate Table
```sql
TRUNCATE users;
```

### Paging
```sql
SELECT * FROM users PER PARTITION LIMIT 10;
```

### Allow Filtering (use with caution)
```sql
SELECT * FROM users WHERE name = 'Alice' ALLOW FILTERING;
```

---

## 🧠 Notes

- Use `CONSISTENCY` command to check or set consistency levels for your session.
- `COPY` command is useful for CSV import/export.
- Use `DESCRIBE` for any object (keyspace, table, type, etc.)

---

## 📚 References

- Official CQL Documentation: https://cassandra.apache.org/doc/latest/cql/
- CQLSH Commands: https://cassandra.apache.org/doc/latest/tools/cqlsh.html

