package com.oceanview.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

/**
 * Admin Reservations View Servlet
 * Displays all reservations with transaction details and print capabilities
 */
@WebServlet("/admin/reservations")
public class AdminReservationsViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Fetch all reservations
        List<Reservation> reservationList = reservationDAO.getAllReservations();
        
        // Calculate total revenue for CONFIRMED reservations
        double totalRevenue = reservationList.stream()
            .filter(r -> "CONFIRMED".equals(r.getStatus()))
            .mapToDouble(r -> r.getTotalAmount() != null ? r.getTotalAmount().doubleValue() : 0.0)
            .sum();
        
        // Pass to view
        request.setAttribute("reservationList", reservationList);
        request.setAttribute("totalRevenue", totalRevenue);
        
        // Forward to reservations view page
        request.getRequestDispatcher("/admin/reservations.jsp").forward(request, response);
    }
}
