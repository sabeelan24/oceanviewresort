package com.oceanview.dao;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import com.oceanview.model.RoomType;
import com.oceanview.model.Room;
import com.oceanview.util.DBConnection;

public class RoomDAO {

    public List<RoomType> getAllRoomTypes() {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT * FROM room_types";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(new RoomType(
                    rs.getInt("type_id"),
                    rs.getString("type_name"),
                    rs.getBigDecimal("base_price"),
                    rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public RoomType getRoomTypeById(int id) {
        String sql = "SELECT * FROM room_types WHERE type_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if(rs.next()) {
                    return new RoomType(
                        rs.getInt("type_id"),
                        rs.getString("type_name"),
                        rs.getBigDecimal("base_price"),
                        rs.getString("description")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createRoomType(String name, BigDecimal price, String description) {
        String sql = "INSERT INTO room_types (type_name, base_price, description) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setBigDecimal(2, price);
            pstmt.setString(3, description);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Finds available room numbers (e.g., '101', '102') for the booking form.
    public List<Room> findAvailableRooms(int roomTypeId, LocalDate checkIn, LocalDate checkOut) {
        List<Room> availableRooms = new ArrayList<>();
        // This is an advanced SQL query. It finds all rooms of a certain type
        // that are NOT present in the list of rooms booked during the overlap period.
        String sql = "SELECT r.*, rt.type_name FROM rooms r " +
                     "JOIN room_types rt ON r.room_type_id = rt.type_id " +
                     "WHERE r.room_type_id = ? AND r.room_id NOT IN " +
                     "(SELECT room_id FROM reservations WHERE status != 'CANCELLED' AND check_in < ? AND check_out > ?)";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roomTypeId);
            pstmt.setDate(2, java.sql.Date.valueOf(checkOut));
            pstmt.setDate(3, java.sql.Date.valueOf(checkIn));

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Room room = new Room();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setRoomNumber(rs.getString("room_number"));
                    room.setRoomTypeId(rs.getInt("room_type_id"));
                    room.setStatus(rs.getString("status"));
                    room.setRoomTypeName(rs.getString("type_name"));
                    availableRooms.add(room);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableRooms;
    }

    // ACADEMIC NOTE: Advanced Subquery to find rooms NOT booked during the requested dates
    public List<Room> getAvailableRooms(int typeId, LocalDate start, LocalDate end) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE room_type_id = ? AND room_id NOT IN (" +
                     "SELECT room_id FROM reservations WHERE status != 'CANCELLED' " +
                     "AND (check_in < ? AND check_out > ?))";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, typeId);
            pstmt.setDate(2, java.sql.Date.valueOf(end));   // Overlap Check End
            pstmt.setDate(3, java.sql.Date.valueOf(start)); // Overlap Check Start
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                list.add(r);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    
    // Helper to get room price
    public java.math.BigDecimal getRoomPrice(int typeId) {
        String sql = "SELECT base_price FROM room_types WHERE type_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, typeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return java.math.BigDecimal.ZERO;
    }

    // Helper to get room type ID by room ID
    public int getRoomTypeIdByRoomId(int roomId) {
        String sql = "SELECT room_type_id FROM rooms WHERE room_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    /**
     * TASK 5: Admin Panel - Add Physical Room
     * Creates a new physical room entry (e.g., "305") under a specific category
     * @param roomNumber The physical room identifier (e.g., "305", "A101")
     * @param typeId The room type (category) this room belongs to
     * @return true if insertion succeeds, false otherwise
     */
    public boolean addPhysicalRoom(String roomNumber, int typeId) {
        String sql = "INSERT INTO rooms (room_number, room_type_id, status) VALUES (?, ?, 'AVAILABLE')";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, roomNumber);
            pstmt.setInt(2, typeId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * TASK 5: Admin Panel - Get All Physical Rooms
     * Retrieves complete inventory with room numbers and their categories
     * @return List of all Room objects with room_type_name populated for display
     */
    public List<Room> getAllPhysicalRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.room_id, r.room_number, r.status, t.type_name, t.type_id " +
                     "FROM rooms r JOIN room_types t ON r.room_type_id = t.type_id " +
                     "ORDER BY r.room_number";
                 
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setStatus(rs.getString("status"));
                r.setRoomTypeName(rs.getString("type_name"));
                r.setRoomTypeId(rs.getInt("type_id"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * FULL INVENTORY VIEW: Get ALL rooms with availability status for given dates
     * This method returns EVERY room in the system and marks them as available or occupied
     * 
     * ACADEMIC NOTE: This prevents the "empty list" problem by showing complete inventory
     * 
     * @param roomTypeId The room type to filter by
     * @param checkIn Check-in date
     * @param checkOut Check-out date
     * @return List of ALL rooms with availability flag set
     */
    public List<Room> getAllRoomsWithAvailability(int roomTypeId, LocalDate checkIn, LocalDate checkOut) {
        List<Room> allRooms = new ArrayList<>();
        
        // Query: Get ALL rooms of the specified type with a LEFT JOIN to check reservations
        // This ensures we get every room, even if it has no reservations
        String sql = "SELECT r.room_id, r.room_number, r.room_type_id, r.status, rt.type_name, " +
                     "CASE WHEN res.room_id IS NULL THEN 1 ELSE 0 END AS is_available " +
                     "FROM rooms r " +
                     "JOIN room_types rt ON r.room_type_id = rt.type_id " +
                     "LEFT JOIN reservations res ON r.room_id = res.room_id " +
                     "  AND res.status != 'CANCELLED' " +
                     "  AND res.check_in < ? " +
                     "  AND res.check_out > ? " +
                     "WHERE r.room_type_id = ? " +
                     "GROUP BY r.room_id, r.room_number, r.room_type_id, r.status, rt.type_name " +
                     "ORDER BY r.room_number";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setDate(1, java.sql.Date.valueOf(checkOut));   // Overlap check end
            pstmt.setDate(2, java.sql.Date.valueOf(checkIn));    // Overlap check start
            pstmt.setInt(3, roomTypeId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Room room = new Room();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setRoomNumber(rs.getString("room_number"));
                    room.setRoomTypeId(rs.getInt("room_type_id"));
                    room.setStatus(rs.getString("status"));
                    room.setRoomTypeName(rs.getString("type_name"));
                    room.setAvailable(rs.getInt("is_available") == 1);
                    allRooms.add(room);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return allRooms;
    }
}
