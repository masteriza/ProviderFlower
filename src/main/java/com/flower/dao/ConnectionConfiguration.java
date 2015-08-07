package com.flower.dao;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ConnectionConfiguration {
    private static final String jdbcURL = "jdbc:oracle:thin:@localhost:1521/XE";
    private static final String driver = "oracle.jdbc.driver.OracleDriver";
    private static Connection conn;


    //public static void main(String[] args) throws SQLException {
    public static void qwe() throws SQLException {


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
        try {
            readUserTable();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        try {
            updateUserTable();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        /*try {
            deleteUserTable();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        try {
            dropUserTable();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }*/



    }


    private static Connection getDBConnection() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e1) {
            System.out.println("Driver not found: " + driver);
        }
        try {

            //System.out.println("Connecting DB");
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
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
        return dateFormat.format(date);
    }

    private static void addUserTable() throws SQLException {
        Connection dbConnection = null;
        Statement statement = null;
        System.out.println(getCurrentTimeStamp());

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


    private static void readUserTable() throws SQLException {
        Connection dbConnection = null;
        Statement statement = null;
        System.out.println(getCurrentTimeStamp());

        String selectTableSQL = "SELECT * FROM DEMO_CUSTOMERS dc";

        try {
            dbConnection = getDBConnection();
            statement = dbConnection.createStatement();

            // выбираем данные с Ѕƒ
            ResultSet rs = statement.executeQuery(selectTableSQL);

            // » если что то было получено то цикл while сработает
            while (rs.next()) {
                String userid = rs.getString("CUST_FIRST_NAME");
                String username = rs.getString("CUST_LAST_NAME");

                System.out.println("CUST_FIRST_NAME : " + userid);
                System.out.println("CUST_LAST_NAME : " + username);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private static void updateUserTable() throws SQLException {
        Connection dbConnection = null;
        Statement statement = null;
        System.out.println(getCurrentTimeStamp());

        String updateTableSQL = "UPDATE DBUSER SET USERNAME = 'mkyong_new' WHERE USER_ID = 1";

        try {
            dbConnection = getDBConnection();
            statement = dbConnection.createStatement();

            // выполн€ем запрос update SQL
            statement.execute(updateTableSQL);

            System.out.println("Record is updated to DBUSER table!");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private static void deleteUserTable() throws SQLException {
        Connection dbConnection = null;
        Statement statement = null;
        String deleteTableSQL = "DELETE DBUSER WHERE USER_ID = 1";
        try {
            dbConnection = getDBConnection();
            statement = dbConnection.createStatement();

            // выполн€ем запрос delete SQL
            statement.execute(deleteTableSQL);
            System.out.println("Record is deleted from DBUSER table!");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private static void dropUserTable() throws SQLException {
        Connection dbConnection = null;
        Statement statement = null;
        String dropTableSQL = "DROP TABLE DBUSER";
        try {
            dbConnection = getDBConnection();
            statement = dbConnection.createStatement();

            // выполн€ем запрос delete SQL
            statement.execute(dropTableSQL);
            System.out.println("Drop DBUSER table!");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }


    }

    //end class

}