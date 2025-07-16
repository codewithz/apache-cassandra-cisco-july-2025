package com.cisco;

import com.datastax.oss.driver.api.core.CqlSession;

public class App {
    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder().build()) {
            System.out.println("✅ Connected to Cassandra!");

            // Create keyspace using NetworkTopologyStrategy
            session.execute("CREATE KEYSPACE IF NOT EXISTS blog_space_java " +
                    "WITH replication = {'class':'NetworkTopologyStrategy', 'DC1': 2, 'DC2': 1};");

            // Set keyspace context (note: USE is not supported in DataStax Java driver, so set in each query)
            session.execute("CREATE TABLE IF NOT EXISTS blog_space_java.posts (" +
                    "id UUID PRIMARY KEY, " +
                    "title TEXT, " +
                    "author TEXT);");

            // Insert a row
            session.execute("INSERT INTO blog_space_java.posts (id, title, author) " +
                    "VALUES (uuid(), 'Cassandra with Java', 'Z');");

            // Select all rows
            session.execute("SELECT * FROM blog_space_java.posts").forEach(row ->
                    System.out.println("📘 " + row.getString("title") + " by " + row.getString("author"))
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
