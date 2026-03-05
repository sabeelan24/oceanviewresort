package com.oceanview.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.GuestDAO;
import com.oceanview.model.User;
import com.oceanview.service.BillingService;
import com.oceanview.service.RoomAvailabilityService;
import com.oceanview.util.MessageUtil;
import com.oceanview.util.InputValidator;
import com.oceanview.util.ValidationException;

@WebServlet("/staff/createReservation")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private GuestDAO guestDAO = new GuestDAO();
    private ReservationDAO resDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private BillingService billingService = new BillingService();
    private RoomAvailabilityService availabilityService = new RoomAvailabilityService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get IDs and Dates
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            int roomTypeId = Integer.parseInt(request.getParameter("roomTypeId"));
            LocalDate cin = LocalDate.parse(request.getParameter("checkIn"));
            LocalDate cout = LocalDate.parse(request.getParameter("checkOut"));
            
            // 2. Get Guest Info
            String gName = request.getParameter("guestName");
            String gContact = request.getParameter("guestContact");
            String gEmail = request.getParameter("guestEmail");

            // BACKEND VALIDATION (Dual-Layer Protection)
            // ACADEMIC NOTE: This is the second layer of validation
            // Even though we validated in AvailabilityCheckServlet, we validate again here
            // because users could potentially skip that step via direct URL manipulation
            
            InputValidator.validateRequired(gName, "Guest name");
            InputValidator.validatePhoneNumber(gContact); // Critical: 10-digit validation
            
            if (gEmail != null && !gEmail.trim().isEmpty()) {
                InputValidator.validateEmail(gEmail);
            }

            // 3. Handle Guest Profile (Get existing ID or create new)
            // ACADEMIC NOTE: This is atomic - if guest exists, we get ID. If not, create new.
            int guestId = guestDAO.getOrCreateGuest(gName, gContact, gEmail);
            
            if (guestId == -1) {
                MessageUtil.setFlashMessage(request, "danger", "Failed to process guest information.");
                response.sendRedirect("add_reservation.jsp");
                return;
            }

            // 4. Final Security Check: Is the room STILL available?
            // ACADEMIC NOTE: Crucial for concurrency control in distributed systems.
            // Using service layer to encapsulate business logic and maintain separation of concerns.
            if (!availabilityService.isRoomAvailable(roomId, cin, cout)) {
                MessageUtil.setFlashMessage(request, "danger", "Room was just booked by someone else! Please try again.");
                response.sendRedirect("add_reservation.jsp");
                return;
            }

            // 5. Calculate Final Price
            BigDecimal rate = roomDAO.getRoomPrice(roomTypeId);
            BigDecimal total = billingService.calculateTotalCost(cin, cout, rate);

            // 6. Get Current User ID (who is making the booking)
            HttpSession session = request.getSession(false);
            User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
            int userId = (currentUser != null) ? currentUser.getId() : 1;

            // 7. Save to Database (Table 5) - ATOMIC TRANSACTION
            boolean success = resDAO.finalSave(guestId, roomId, cin, cout, total, userId);

            if (success) {
                MessageUtil.setFlashMessage(request, "success", "Booking confirmed! Room #" + roomId + " is reserved for " + gName);
                response.sendRedirect("dashboard");
            } else {
                MessageUtil.setFlashMessage(request, "danger", "Database error occurred. Booking failed.");
                response.sendRedirect("add_reservation.jsp");
            }

        } catch (ValidationException e) {
            // Handle validation errors with user-friendly messages
            MessageUtil.setFlashMessage(request, "danger", "Validation Error: " + e.getMessage());
            response.sendRedirect("add_reservation.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            MessageUtil.setFlashMessage(request, "danger", "System Error: " + e.getMessage());
            response.sendRedirect("add_reservation.jsp");
        }
    }
}
