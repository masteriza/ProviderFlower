package com.flower.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionConfiguration {
    private static final String jdbcURL = "jdbc:oracle:thin:@localhost:1521/xe";
    private static final String driver = "oracle.jdbc.driver.OracleDriver";
    private static Connection conn;

    public static void main(String[] args) {
        try {
            Class.forName (driver);
        } catch (ClassNotFoundException e1) {
            System.out.println("Driver not found: " + driver);
        }
        try {
            conn = DriverManager.getConnection(jdbcURL, "ALEX", "alex");
        } catch (SQLException e) {
            System.out.println("Unable to establish connection");
        }
        System.out.println("Hello World!");
    }





}