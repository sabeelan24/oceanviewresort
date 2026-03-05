package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Singleton Database Connection Manager
public class DBConnection {

    private static DBConnection instance;
    private Connection connection;
    
    private final String URL = "jdbc:mysql://localhost:3306/Ocean_view_hotel_db";
    private final String USER = "root"; 
    private final String PASSWORD = ""; // CHANGE THIS TO YOUR DB PASSWORD

    private DBConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static DBConnection getInstance() throws SQLException {
        if (instance == null) {
            instance = new DBConnection();
        } else if (instance.getConnection().isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}