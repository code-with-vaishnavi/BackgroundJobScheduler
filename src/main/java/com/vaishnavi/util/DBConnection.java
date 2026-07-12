package com.vaishnavi.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/background_scheduler";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Jayesh@1213";

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            System.out.println("✅ Database Connected Successfully!");

            return connection;

        } catch (Exception e) {

            System.out.println("❌ Database Connection Failed!");

            e.printStackTrace();

            return null;
        }
    }
}