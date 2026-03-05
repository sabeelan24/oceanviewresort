package com.oceanview.controller;

import com.oceanview.util.MessageUtil;
import com.oceanview.dao.ReservationDAO;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// The URL pattern must match the form action in your JSP
@WebServlet("/editReservation") // Absolute mapping at the root
public class EditReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        
        try {
            int resId = Integer.parseInt(request.getParameter("resId"));
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            String status = request.getParameter("status");
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");

            ReservationDAO dao = new ReservationDAO();
            boolean success = dao.updateReservation(resId, amount, status, checkIn, checkOut);

            if (success) {
                MessageUtil.setFlashMessage(request, "success", "Reservation #" + resId + " updated successfully!");
            } else {
                MessageUtil.setFlashMessage(request, "danger", "Database update failed.");
            }
        } catch (Exception e) {
            MessageUtil.setFlashMessage(request, "danger", "Error: " + e.getMessage());
        }

        // FIX 404: Redirect based on folder context
        String redirectPath = "ADMIN".equals(role) ? "admin/reservations" : "staff/reservations";
        response.sendRedirect(request.getContextPath() + "/" + redirectPath);
    }
}