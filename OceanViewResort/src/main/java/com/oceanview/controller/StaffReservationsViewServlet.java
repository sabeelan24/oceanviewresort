package com.oceanview.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

/**
 * Staff Reservations View Servlet
 * Displays all reservations with transaction details and print capabilities
 */
@WebServlet("/staff/reservations")
public class StaffReservationsViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Fetch all reservations
        List<Reservation> reservationList = reservationDAO.getAllReservations();
        
        // Pass to view
        request.setAttribute("reservationList", reservationList);
        
        // Forward to reservations view page
        request.getRequestDispatcher("/staff/reservations.jsp").forward(request, response);
    }
}
