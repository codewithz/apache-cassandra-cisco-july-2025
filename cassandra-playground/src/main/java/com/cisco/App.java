package com.cisco;

import com.datastax.oss.driver.api.core.CqlSession;

/**
 * Hello world!
 *
 */
public class App {
    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder().build()) {
            System.out.println("✅ Connected to Cassandra!");

            session.execute("CREATE KEYSPACE IF NOT EXISTS demo WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};");
            session.execute("USE demo;");
            session.execute("CREATE TABLE IF NOT EXISTS articles (id UUID PRIMARY KEY, title TEXT, author TEXT);");
            session.execute("INSERT INTO articles (id, title, author) VALUES (uuid(), 'Cassandra with Java', 'Z');");

            session.execute("SELECT * FROM articles").forEach(row ->
                    System.out.println("📘 " + row.getString("title") + " by " + row.getString("author"))
            );

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
