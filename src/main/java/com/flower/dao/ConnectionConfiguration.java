package com.flower.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class ConnectionConfiguration {
    private static final String jdbcURL = "jdbc:oracle:thin:@localhost:1521/XE";
    private static final String driver = "oracle.jdbc.driver.OracleDriver";
    private static Connection conn;


    public static void main(String[] args) throws SQLException {
        try {
            createDbUserTable();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        try {
            addUserTable();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }

    private static Connection getDBConnection() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e1) {
            System.out.println("Driver not found: " + driver);
        }
        try {
            System.out.println("Connecting DB");
            conn = DriverManager.getConnection(jdbcURL, "FLOWER", "123");

        } catch (SQLException e) {
            System.out.println("Unable to establish connection");
        }
        return conn;
    }


    private static void createDbUserTable() throws SQLException {
        Connection dbConnection = null;
        Statement statement = null;

        String createTableSQL = "CREATE TABLE DBUSER("
                + "USER_ID NUMBER(5) NOT NULL, "
                + "USERNAME VARCHAR(20) NOT NULL, "
                + "CREATED_BY VARCHAR(20) NOT NULL, "
                + "CREATED_DATE DATE NOT NULL, " + "PRIMARY KEY (USER_ID) "
                + ")";

        try {
            dbConnection = getDBConnection();
            statement = dbConnection.createStatement();

            // выполнить SQL запрос
            statement.execute(createTableSQL);
            System.out.println("Table \"dbuser\" is created!");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }

    private static String getCurrentTimeStamp() {
        Date today = new Date();
        String dateFormat = null;
        System.out.println(dateFormat.format(String.valueOf(today.getTime())));
        return dateFormat.format(String.valueOf(today.getTime()));
    }

    private static void addUserTable() throws SQLException {
        Connection dbConnection = null;
        Statement statement = null;

        String insertTableSQL = "INSERT INTO DBUSER"
                + "(USER_ID, USERNAME, CREATED_BY, CREATED_DATE) " + "VALUES"
                + "(1,'mkyong','system', " + "to_date('"
                + getCurrentTimeStamp() + "', 'yyyy/mm/dd hh24:mi:ss'))";

        try {
            dbConnection = getDBConnection();
            statement = dbConnection.createStatement();

            // выполнить SQL запрос
            statement.execute(insertTableSQL);
            System.out.println("add user!");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }

    //end class

}