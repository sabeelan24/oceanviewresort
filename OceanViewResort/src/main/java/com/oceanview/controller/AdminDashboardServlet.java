package com.oceanview.controller;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.ReportDAO;

/**
 * TASK 5: Admin Panel - Admin Dashboard Servlet
 * Fetches and aggregates data from ReportDAO for administrative overview
 * Provides: Total Revenue, Bookings, Occupancy Rate, Revenue by Category
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Fetch Key Metrics from ReportDAO (lazy instantiation)
        ReportDAO reportDAO = new ReportDAO();
        double totalRevenue = reportDAO.getTotalRevenue();
        int totalBookings = reportDAO.getTotalBookings();
        int activeBookings = reportDAO.getActiveBookingsCount();
        int totalRooms = reportDAO.getTotalPhysicalRooms();
        
        // 2. Calculate Occupancy Rate (as percentage or ratio)
        String occupancyDisplay = (totalRooms > 0) ? 
            (activeBookings + " / " + totalRooms) : 
            "0 / 0";
        
        // 3. Fetch Chart Data (Revenue by Room Category)
        Map<String, Double> revenueByCat = reportDAO.getRevenueByType();
        
        // 4. Fetch Audit Data (New Intelligence Features)
        request.setAttribute("roomReport", reportDAO.getRoomPerformanceReport());
        request.setAttribute("monthlyTrend", reportDAO.getMonthlyRevenueTrend());
        
        // 5. Set Attributes for JSP
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("occupancy", occupancyDisplay);
        request.setAttribute("activeBookings", activeBookings);
        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("revenueChartData", revenueByCat);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}