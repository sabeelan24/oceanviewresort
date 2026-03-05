package com.oceanview.api;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.RoomType;
import com.oceanview.service.BillingService;

// ACADEMIC NOTE: This Servlet acts as a RESTful Web Service.
// It allows the frontend to request data asynchronously (AJAX) without reloading the page.
@WebServlet("/api/pricing")
public class PricingAPI extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private BillingService billingService = new BillingService();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Set Response Type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();

        try {
            // 2. Capture Parameters
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String roomIdStr = request.getParameter("roomTypeId");

            // 3. Basic Validation
            if (checkInStr == null || checkOutStr == null || roomIdStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"Missing parameters\"}");
                return;
            }

            // 4. Parse Data
            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);
            int roomTypeId = Integer.parseInt(roomIdStr);

            // 5. Get Room Rate from DB
            RoomType room = roomDAO.getRoomTypeById(roomTypeId);
            if (room == null) {
                out.print("{\"error\": \"Invalid Room Type\"}");
                return;
            }

            // 6. Calculate Logic
            long nights = billingService.calculateNights(checkIn, checkOut);
            BigDecimal total = billingService.calculateTotalCost(checkIn, checkOut, room.getBasePrice());

            // 7. Construct JSON Response Manually
            // Format: { "nights": 3, "rate": 5000.00, "total": 15000.00 }
            String jsonResponse = String.format(
                "{\"nights\": %d, \"rate\": %.2f, \"total\": %.2f}",
                nights,
                room.getBasePrice(),
                total
            );

            out.print(jsonResponse);

        } catch (Exception e) {
            // Handle parsing errors gracefully
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Calculation error: " + e.getMessage() + "\"}");
        }
        
        out.flush();
    }
}