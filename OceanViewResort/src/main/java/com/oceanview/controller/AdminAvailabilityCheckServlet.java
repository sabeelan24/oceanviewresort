package com.oceanview.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oceanview.model.Room;
import com.oceanview.service.RoomAvailabilityService;
import com.oceanview.util.MessageUtil;
import com.oceanview.util.InputValidator;
import com.oceanview.util.ValidationException;

@WebServlet("/admin/checkAvailability")
public class AdminAvailabilityCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RoomAvailabilityService availabilityService = new RoomAvailabilityService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Extract guest information from the first form
            String guestName = request.getParameter("guestName");
            String guestContact = request.getParameter("guestContact");
            String guestEmail = request.getParameter("guestEmail");
            int roomTypeId = Integer.parseInt(request.getParameter("roomTypeId"));
            LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"));

            // BACKEND VALIDATION (Dual-Layer Validation)
            // ACADEMIC NOTE: Never trust client-side validation alone!
            // Users can bypass JavaScript validation by:
            // - Disabling JavaScript
            // - Using browser developer tools
            // - Making direct HTTP requests
            
            // Validate required fields
            InputValidator.validateRequired(guestName, "Guest name");
            InputValidator.validateRequired(guestContact, "Contact number");
            
            // CRITICAL: Phone number validation (10 digits, numeric only)
            InputValidator.validatePhoneNumber(guestContact);
            
            // Validate email format (if provided)
            if (guestEmail != null && !guestEmail.trim().isEmpty()) {
                InputValidator.validateEmail(guestEmail);
            }

            // 2. Validate date range using service layer
            if (!availabilityService.isValidDateRange(checkIn, checkOut)) {
                MessageUtil.setFlashMessage(request, "danger", "Invalid date range. Please check your check-in and check-out dates.");
                response.sendRedirect("add_reservation.jsp");
                return;
            }

            // 3. Get ALL rooms with availability status (FULL INVENTORY VIEW)
            // ACADEMIC NOTE: This is the key change - we now show ALL rooms, not just available ones
            List<Room> allRooms = availabilityService.getAllRoomsWithAvailability(roomTypeId, checkIn, checkOut);
            
            // Count how many are actually available
            long availableCount = allRooms.stream().filter(Room::isAvailable).count();

            // 4. Route based on availability
            if (allRooms.isEmpty()) {
                // No rooms of this type exist in the system at all
                MessageUtil.setFlashMessage(request, "danger", 
                    "No rooms of that type exist in the system. Please contact the administrator.");
                response.sendRedirect("add_reservation.jsp");
            } else {
                // SUCCESS: We have rooms to show (available or not)
                // ACADEMIC NOTE: Using request attributes to pass data to the next page (not session)
                // This maintains data integrity and avoids session pollution.
                request.setAttribute("guestName", guestName);
                request.setAttribute("guestContact", guestContact);
                request.setAttribute("guestEmail", guestEmail);
                request.setAttribute("roomTypeId", roomTypeId);
                request.setAttribute("checkIn", checkIn.toString());
                request.setAttribute("checkOut", checkOut.toString());
                request.setAttribute("allRooms", allRooms);
                request.setAttribute("availableCount", availableCount);
                
                // Forward to room selection page (Wizard Step 2)
                request.getRequestDispatcher("select_room.jsp").forward(request, response);
            }
        } catch (ValidationException e) {
            // Handle validation errors with user-friendly messages
            MessageUtil.setFlashMessage(request, "danger", "Validation Error: " + e.getMessage());
            response.sendRedirect("add_reservation.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            MessageUtil.setFlashMessage(request, "danger", "Invalid room type selected.");
            response.sendRedirect("add_reservation.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            MessageUtil.setFlashMessage(request, "danger", "A system error occurred: " + e.getMessage());
            response.sendRedirect("add_reservation.jsp");
        }
    }
}