package com.youthtravel.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class DatabaseMigrationRunner implements CommandLineRunner {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) throws Exception {
        // Fix 1: saved_packages legacy column
        try {
            jdbcTemplate.execute("ALTER TABLE saved_packages DROP FOREIGN KEY FKe3x8nxh83kvm3art22g4id85g");
            jdbcTemplate.execute("ALTER TABLE saved_packages DROP COLUMN package_id");
            System.out.println("Successfully migrated saved_packages table and dropped legacy package_id column.");
        } catch (Exception e) {
            try {
                jdbcTemplate.execute("ALTER TABLE saved_packages DROP COLUMN package_id");
            } catch (Exception ex) {}
        }
        
        // Fix 2: messages legacy columns
        try {
            jdbcTemplate.execute("ALTER TABLE messages MODIFY COLUMN receiver_id BIGINT NULL");
            jdbcTemplate.execute("ALTER TABLE messages MODIFY COLUMN sender_id BIGINT NULL");
            System.out.println("Successfully made legacy receiver_id and sender_id columns NULLABLE in messages table.");
        } catch (Exception e) {
            System.out.println("Legacy columns modification skipped (already modified or not found).");
        }

        // Fix 3: Handle legacy package_id in reviews table
        try {
            jdbcTemplate.execute("ALTER TABLE reviews MODIFY COLUMN package_id BIGINT NULL");
            System.out.println("Successfully made legacy package_id NULLABLE in reviews table.");
        } catch (Exception e) {
            System.out.println("Legacy package_id migration skipped (already modified or not found).");
        }
    }
}
