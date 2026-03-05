package com.oceanview.controller;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

/**
 * Task 4: Calculate & Print Bill
 * 
 * This servlet handles invoice calculation and forwards to a print-friendly JSP view.
 * 
 * Features:
 * - Dynamically calculates bill based on nights stayed and room base price
 * - Handles both Admin and Staff access
 * - Supports browser-based printing with professional CSS layout
 */
@WebServlet({"/staff/printBill", "/admin/printBill"})
public class PrintBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ReservationDAO resDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            
            // Validate parameter
            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reservation ID is required");
                return;
            }
            
            int resId = Integer.parseInt(idParam);
            
            // Fetch reservation from database
            Reservation res = resDAO.getReservationById(resId);
            
            if (res != null) {
                // Task 4: Calculate amount based on nights
                long nights = java.time.temporal.ChronoUnit.DAYS.between(res.getCheckIn(), res.getCheckOut());
                if (nights <= 0) nights = 1; // Minimum 1 night
                
                BigDecimal basePrice = res.getBasePrice();
                if (basePrice == null) basePrice = BigDecimal.ZERO;
                
                BigDecimal calculatedTotal = basePrice.multiply(BigDecimal.valueOf(nights));
                
                // Add taxes (e.g. 10%)
                BigDecimal tax = calculatedTotal.multiply(new BigDecimal("0.10")).setScale(2, java.math.RoundingMode.HALF_UP);
                BigDecimal grandTotal = calculatedTotal.add(tax);
                
                request.setAttribute("reservation", res);
                request.setAttribute("nights", nights);
                request.setAttribute("subtotal", calculatedTotal);
                request.setAttribute("tax", tax);
                request.setAttribute("grandTotal", grandTotal);
                
                // Forward to a beautiful JSP print page
                request.getRequestDispatcher("/common/print_bill.jsp").forward(request, response);
                
            } else {
                // Reservation not found
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation #" + resId + " not found");
            }
            
        } catch (NumberFormatException e) {
            // Invalid reservation ID format
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid reservation ID format");
            
        } catch (Exception e) {
            // Log error and return 500
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating invoice");
        }
    }
}