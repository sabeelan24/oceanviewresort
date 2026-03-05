package com.oceanview.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.oceanview.dao.ReportDAO;

/**
 * TASK 5: Admin Panel - Guest Audit Portal
 * Provides detailed guest relationship analytics and lifetime value analysis
 * Shows customer behavior patterns and identifies VIP clients
 */
@WebServlet("/admin/guestAudit")
public class GuestAuditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch guest audit data from ReportDAO
        ReportDAO reportDAO = new ReportDAO();
        request.setAttribute("guestReport", reportDAO.getGuestAuditReport());

        request.getRequestDispatcher("/admin/guest_audit.jsp").forward(request, response);
    }
}