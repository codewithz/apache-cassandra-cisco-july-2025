# 📝 Cassandra Practice Tasks – Social Media Application


---

## 🔹 Task 1: Create Keyspace

**Q1.** Create a keyspace named `social_app` with the following specs:

- Replication strategy: `SimpleStrategy`
- Replication factor: 1

```sql
CREATE KEYSPACE social_app WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
};
```

Switch to this keyspace:

```sql
USE social_app;
```

---

## 🔹 Task 2: Create Tables

**Q2.** Create a table `users` to store user profile information:

- user_id (UUID, primary key)
- username (text)
- email (text)
- join_date (timestamp)

**Q3.** Create a table `posts` where users can write posts:

- post_id (UUID)
- user_id (UUID)
- content (text)
- posted_on (timestamp)
- PRIMARY KEY ((user_id), posted_on)

> *Note:* This schema allows fetching posts for a given user, sorted by time.

**Q4.** Create a table `comments` to store comments on posts:

- comment_id (UUID)
- post_id (UUID)
- user_id (UUID)
- comment (text)
- commented_on (timestamp)
- PRIMARY KEY ((post_id), commented_on)

---

## 🔹 Task 3: Insert Sample Data

**Q5.** Insert at least 3 users into the `users` table.

**Q6.** For each user, insert 2–3 posts into the `posts` table, spaced out with different timestamps.

**Q7.** For at least 2 posts, insert 2–3 comments using the `comments` table.

---

## 🔹 Task 4: Partition & Clustering Key Practice

**Q8.** Try querying `posts` with only `posted_on`:

```sql
SELECT * FROM posts WHERE posted_on = '2025-07-01';
```

- Observe the error. What part of the key is missing?

**Q9.** Correct the above query by adding the full partition key:

```sql
SELECT * FROM posts WHERE user_id = <user_uuid> AND posted_on = '2025-07-01';
```

**Q10.** Perform a time-range query:

```sql
SELECT * FROM posts WHERE user_id = <user_uuid> AND posted_on > '2025-07-01' AND posted_on < '2025-07-15';
```

**Q11.** Try `ALLOW FILTERING` with a non-key field in `users`:

```sql
SELECT * FROM users WHERE email = 'someone@example.com';
```

- Then repeat using `ALLOW FILTERING`. Discuss performance impact.

---

## 🔹 Task 5: Update & Delete

**Q12.** Update the username of a user:

```sql
UPDATE users SET username = 'new_name' WHERE user_id = <user_uuid>;
```

**Q13.** Delete a comment from a specific post:

```sql
DELETE FROM comments WHERE post_id = <post_uuid> AND commented_on = <timestamp>;
```

---

## 🧠 Bonus Tasks

**Q14.** Create a `followers` table:

- follower_id (UUID)
- followee_id (UUID)
- PRIMARY KEY ((followee_id), follower_id)

Insert data and write a query to fetch all followers of a user.

**Q15.** Modify the `posts` table to include a TTL of 7 days when inserting content.

---

