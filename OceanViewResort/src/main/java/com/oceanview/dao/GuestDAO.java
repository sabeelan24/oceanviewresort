package com.oceanview.dao;

import java.sql.*;
import com.oceanview.model.Guest;
import com.oceanview.util.DBConnection;

public class GuestDAO {

    // Logic: If guest exists, return ID. If not, create and return new ID.
    public int getOrCreateGuest(String name, String contact, String email) {
        String checkSql = "SELECT guest_id FROM guests WHERE contact_number = ?";
        String insertSql = "INSERT INTO guests (full_name, contact_number, email) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getInstance().getConnection()) {
            // 1. Check if exists
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setString(1, contact);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) return rs.getInt(1);
            }

            // 2. Create new guest
            try (PreparedStatement ps = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, name);
                ps.setString(2, contact);
                ps.setString(3, email);
                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    // Method to find a guest by contact number
    public Guest findByContact(String contact) {
        String sql = "SELECT * FROM guests WHERE contact_number = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, contact);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Guest guest = new Guest();
                    guest.setGuestId(rs.getInt("guest_id"));
                    guest.setFullName(rs.getString("full_name"));
                    guest.setContactNumber(rs.getString("contact_number"));
                    guest.setEmail(rs.getString("email"));
                    return guest;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to create a new guest and return their new ID
    public int createGuest(Guest guest) {
        String sql = "INSERT INTO guests (full_name, contact_number, email) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, guest.getFullName());
            pstmt.setString(2, guest.getContactNumber());
            pstmt.setString(3, guest.getEmail());
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Indicate failure
    }
}