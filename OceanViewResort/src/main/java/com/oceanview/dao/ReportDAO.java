package com.oceanview.dao;

import java.sql.*;
import java.util.*;
import com.oceanview.util.DBConnection;

/**
 * TASK 5: Admin Panel - Business Intelligence Layer
 * ReportDAO handles complex aggregations (SUM, COUNT, GROUP BY) for Admin Dashboard.
 * Generates strategic reports based on 5-table schema data.
 */
public class ReportDAO {

    /**
     * 1. Total Revenue (Confirmed bookings only)
     * Sums all total_amount from non-cancelled reservations
     */
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) FROM reservations WHERE status != 'CANCELLED'";
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                double revenue = rs.getDouble(1);
                return revenue > 0 ? revenue : 0.0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    /**
     * 2. Total Bookings Count
     * Returns the count of all reservations (any status)
     */
    public int getTotalBookings() {
        String sql = "SELECT COUNT(*) FROM reservations";
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 3. Active Bookings Count
     * Returns count of bookings where today's date is between check_in and check_out
     * AND status is CONFIRMED (not cancelled)
     */
    public int getActiveBookingsCount() {
        String sql = "SELECT COUNT(*) FROM reservations WHERE status = 'CONFIRMED' AND CURDATE() BETWEEN check_in AND check_out";
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 4. Total Physical Rooms (Inventory Count)
     * Counts the total number of physical room records in the rooms table
     */
    public int getTotalPhysicalRooms() {
        String sql = "SELECT COUNT(*) FROM rooms";
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Avoid division by zero
    }

    /**
     * 5. Revenue by Room Type (For Revenue Distribution Chart)
     * Returns Map<RoomTypeName, TotalRevenue>
     * Performs 4-table JOIN to group revenue by room category
     */
    public Map<String, Double> getRevenueByType() {
        Map<String, Double> data = new HashMap<>();
        String sql = "SELECT rt.type_name, SUM(r.total_amount) as revenue " +
                     "FROM reservations r " +
                     "JOIN rooms rm ON r.room_id = rm.room_id " +
                     "JOIN room_types rt ON rm.room_type_id = rt.type_id " +
                     "WHERE r.status != 'CANCELLED' " +
                     "GROUP BY rt.type_name";
                     
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                data.put(rs.getString("type_name"), rs.getDouble("revenue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    /**
     * AUDIT FEATURE: Guest Relationship Audit
     * Returns master list of all guests with visit frequency and total revenue
     * Used for customer lifetime value analysis and VIP identification
     */
    public List<Map<String, Object>> getGuestAuditReport() {
        List<Map<String, Object>> report = new ArrayList<>();
        String sql = "SELECT g.full_name, g.contact_number, g.email, " +
                     "COUNT(r.res_id) as visit_count, " +
                     "SUM(r.total_amount) as total_spent " +
                     "FROM guests g " +
                     "LEFT JOIN reservations r ON g.guest_id = r.guest_id " +
                     "GROUP BY g.guest_id " +
                     "ORDER BY total_spent DESC";
        
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("name", rs.getString("full_name"));
                row.put("contact", rs.getString("contact_number"));
                row.put("email", rs.getString("email"));
                row.put("visits", rs.getInt("visit_count"));
                row.put("spent", rs.getDouble("total_spent"));
                report.add(row);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return report;
    }

    /**
     * AUDIT FEATURE: Room Performance Analysis
     * Returns which physical rooms are most popular/profitable
     * Shows room utilization and revenue generation per physical room
     */
    public List<Map<String, Object>> getRoomPerformanceReport() {
        List<Map<String, Object>> report = new ArrayList<>();
        String sql = "SELECT rm.room_number, rt.type_name, " +
                     "COUNT(res.res_id) as times_booked, SUM(res.total_amount) as room_revenue " +
                     "FROM rooms rm " +
                     "JOIN room_types rt ON rm.room_type_id = rt.type_id " +
                     "LEFT JOIN reservations res ON rm.room_id = res.room_id " +
                     "WHERE res.status != 'CANCELLED' OR res.res_id IS NULL " +
                     "GROUP BY rm.room_id " +
                     "ORDER BY room_revenue DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("roomNumber", rs.getString("room_number"));
                row.put("typeName", rs.getString("type_name"));
                row.put("count", rs.getInt("times_booked"));
                row.put("revenue", rs.getDouble("room_revenue"));
                report.add(row);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return report;
    }

    /**
     * AUDIT FEATURE: Monthly Revenue Trend Analysis
     * Returns last 6 months of revenue data for trend visualization
     * Used for financial performance tracking and forecasting
     */
    public Map<String, Double> getMonthlyRevenueTrend() {
        Map<String, Double> trend = new LinkedHashMap<>();
        String sql = "SELECT DATE_FORMAT(check_in, '%b %Y') as month, SUM(total_amount) as revenue " +
                     "FROM reservations WHERE status != 'CANCELLED' " +
                     "GROUP BY month ORDER BY check_in ASC LIMIT 6";
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                trend.put(rs.getString("month"), rs.getDouble("revenue"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return trend;
    }
}
