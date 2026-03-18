package com.ecommerce.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {

    public static Connection getConnection() {
        Connection conn = null;
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            Properties prop = new Properties();
            if (input == null) {
                System.out.println("Sorry, unable to find db.properties");
                return null;
            }
            prop.load(input);

            Class.forName(prop.getProperty("db.driver"));
            conn = DriverManager.getConnection(
                prop.getProperty("db.url"),
                prop.getProperty("db.username"),
                prop.getProperty("db.password")
            );
        } catch (Exception e) {
            System.out.println("Database Connection Setup Error:");
            e.printStackTrace();
        }
        return conn;
    }
}
