package com.cisco;

import com.datastax.oss.driver.api.core.CqlSession;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class ReadFromCQL {
    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder().build()) {
            System.out.println("✅ Connected to Cassandra!");

            // --- Execute all CQL statements in courses.cql -----------------------------
            String script = Files.readString(Paths.get("src/main/resources/courses.cql"));

            for (String stmt : script.split(";")) {                 // split on semicolons
                String cql = stmt.trim();
                if (!cql.isEmpty() && !cql.startsWith("--")) {      // skip blanks / comments
                    System.out.println("▶ Executing: " + cql);
                    session.execute(cql);                           // run the full statement
                }
            }
// ---------------------------------------------------------------------------

            System.out.println("✅ Done executing schema file.");
        } catch (IOException e) {
            System.err.println("❌ Error reading CQL file: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
