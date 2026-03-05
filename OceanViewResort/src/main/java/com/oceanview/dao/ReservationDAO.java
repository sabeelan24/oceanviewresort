package com.oceanview.dao;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;

public class ReservationDAO {

    /**
     * 1. Create a new reservation
     * Used by the step-by-step booking process.
     */
    public boolean createReservation(Reservation res) {
        String sql = "INSERT INTO reservations (guest_id, room_id, check_in, check_out, total_amount, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, res.getGuestId());
            pstmt.setInt(2, res.getRoomId());
            pstmt.setDate(3, Date.valueOf(res.getCheckIn()));
            pstmt.setDate(4, Date.valueOf(res.getCheckOut()));
            pstmt.setBigDecimal(5, res.getTotalAmount());
            pstmt.setString(6, "CONFIRMED");
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 2. Overlap Protection Logic
     * Prevents double-booking by checking if any existing reservation 
     * conflicts with the requested date range for a specific room.
     */
    public boolean isRoomAvailable(int roomId, LocalDate checkIn, LocalDate checkOut) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE room_id = ? AND status != 'CANCELLED' AND check_in < ? AND check_out > ?";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roomId);
            pstmt.setDate(2, java.sql.Date.valueOf(checkOut));
            pstmt.setDate(3, java.sql.Date.valueOf(checkIn));
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0; // If count is 0, room is available
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 3. Get All Reservations (Master View)
     * Performs a 4-table JOIN to display Guest Names and Room Types instead of just IDs.
     */
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.res_id, g.full_name, g.contact_number, rm.room_number, rt.type_name, " +
                     "r.check_in, r.check_out, r.total_amount, r.status " +
                     "FROM reservations r " +
                     "JOIN guests g ON r.guest_id = g.guest_id " +
                     "JOIN rooms rm ON r.room_id = rm.room_id " +
                     "JOIN room_types rt ON rm.room_type_id = rt.type_id " +
                     "ORDER BY r.res_id DESC";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Reservation res = new Reservation();
                res.setResId(rs.getInt("res_id"));
                res.setGuestName(rs.getString("full_name"));
                res.setGuestContact(rs.getString("contact_number"));
                res.setRoomNumber(rs.getString("room_number"));
                res.setRoomTypeName(rs.getString("type_name"));
                res.setCheckIn(rs.getDate("check_in").toLocalDate());
                res.setCheckOut(rs.getDate("check_out").toLocalDate());
                res.setTotalAmount(rs.getBigDecimal("total_amount"));
                res.setStatus(rs.getString("status"));
                list.add(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 4. Update Reservation (The requested Edit Logic)
     * This method handles the dynamic updates for billing and dates.
     */
    public boolean updateReservation(int resId, BigDecimal amount, String status, String checkIn, String checkOut) {
        String sql = "UPDATE reservations SET total_amount = ?, status = ?, check_in = ?, check_out = ? WHERE res_id = ?";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBigDecimal(1, amount);
            pstmt.setString(2, status);
            pstmt.setDate(3, java.sql.Date.valueOf(checkIn));
            pstmt.setDate(4, java.sql.Date.valueOf(checkOut));
            pstmt.setInt(5, resId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 5. Get Single Reservation by ID
     * Critical for Invoice PDF generation and populating the Edit Modal.
     */
    public Reservation getReservationById(int resId) {
        String sql = "SELECT r.res_id, g.full_name, g.contact_number, rm.room_number, rt.type_name, rt.base_price, " +
                     "r.check_in, r.check_out, r.total_amount, r.status " +
                     "FROM reservations r " +
                     "JOIN guests g ON r.guest_id = g.guest_id " +
                     "JOIN rooms rm ON r.room_id = rm.room_id " +
                     "JOIN room_types rt ON rm.room_type_id = rt.type_id " +
                     "WHERE r.res_id = ?";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, resId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Reservation res = new Reservation();
                    res.setResId(rs.getInt("res_id"));
                    res.setGuestName(rs.getString("full_name"));
                    res.setGuestContact(rs.getString("contact_number"));
                    res.setRoomNumber(rs.getString("room_number"));
                    res.setRoomTypeName(rs.getString("type_name"));
                    res.setBasePrice(rs.getBigDecimal("base_price"));
                    res.setCheckIn(rs.getDate("check_in").toLocalDate());
                    res.setCheckOut(rs.getDate("check_out").toLocalDate());
                    res.setTotalAmount(rs.getBigDecimal("total_amount"));
                    res.setStatus(rs.getString("status"));
                    return res;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 6. Save Method (Transactional Style)
     * Records which staff member created the reservation.
     */
    public boolean finalSave(int guestId, int roomId, LocalDate cin, LocalDate cout, BigDecimal total, int userId) {
        String sql = "INSERT INTO reservations (guest_id, room_id, check_in, check_out, total_amount, status, booked_by_user_id) " +
                     "VALUES (?, ?, ?, ?, ?, 'CONFIRMED', ?)";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, guestId);
            pstmt.setInt(2, roomId);
            pstmt.setDate(3, java.sql.Date.valueOf(cin));
            pstmt.setDate(4, java.sql.Date.valueOf(cout));
            pstmt.setBigDecimal(5, total);
            pstmt.setInt(6, userId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}