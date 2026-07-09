package com.airline.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Utility class responsible for creating JDBC connections to the MySQL
 * database. Connection settings are read from db.properties which is
 * bundled on the classpath (src/main/resources).
 *
 * A new connection is created for every request and closed by the caller
 * using try-with-resources. This is the simplest and most predictable
 * approach when no external connection-pooling library is permitted.
 */
public class DBConnection {

    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    // Static initializer block - loads properties and JDBC driver once
    // when this class is first referenced by the application.
    static {
        try (InputStream input = DBConnection.class.getClassLoader()
                .getResourceAsStream("db.properties")) {

            Properties props = new Properties();
            if (input == null) {
                throw new RuntimeException("Unable to find db.properties on classpath");
            }
            props.load(input);

            driver = props.getProperty("db.driver");
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");

            Class.forName(driver);

        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize database configuration", e);
        }
    }

    private DBConnection() {
        // Prevent instantiation - this is a static utility class
    }

    /**
     * Opens and returns a brand new JDBC connection.
     * Callers are responsible for closing the connection (use try-with-resources).
     *
     * @return a live java.sql.Connection
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
