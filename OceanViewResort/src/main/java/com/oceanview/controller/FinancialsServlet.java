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
 * Financials Servlet for Admin
 * Provides detailed financial reports and analytics
 */
@WebServlet("/admin/financials")
public class FinancialsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Fetch financial data from ReportDAO
        ReportDAO reportDAO = new ReportDAO();
        double totalRevenue = reportDAO.getTotalRevenue();
        Map<String, Double> revenueByCat = reportDAO.getRevenueByType();
        
        // Set attributes for financial data
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("monthlyTrend", reportDAO.getMonthlyRevenueTrend());
        request.setAttribute("roomReport", reportDAO.getRoomPerformanceReport());
        request.setAttribute("revenueChartData", revenueByCat);

        request.getRequestDispatcher("/admin/financials.jsp").forward(request, response);
    }
}