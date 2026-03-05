package com.oceanview.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.RoomType;
import com.oceanview.util.MessageUtil;

/**
 * TASK 5: Admin Panel - Room Management Servlet
 * Handles dual responsibilities:
 * 1. GET: Display room categories (room_types) and physical inventory (rooms)
 * 2. POST: Create new room types OR add physical rooms to inventory
 */
@WebServlet("/admin/roomManagement")
public class RoomManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RoomDAO roomDAO = new RoomDAO();

    /**
     * GET: Load both room categories and physical rooms for display
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Load BOTH lists: Categories (room_types) and Physical Inventory (rooms)
        request.setAttribute("roomTypes", roomDAO.getAllRoomTypes());
        request.setAttribute("physicalRooms", roomDAO.getAllPhysicalRooms());
        
        request.getRequestDispatcher("/admin/room_management.jsp").forward(request, response);
    }

    /**
     * POST: Handle form submissions for creating types or adding physical rooms
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            // ACTION 1: Create a new Room Category (e.g., "Penthouse", "Suite")
            if ("createType".equals(action)) {
                String typeName = request.getParameter("typeName");
                BigDecimal basePrice = new BigDecimal(request.getParameter("basePrice"));
                String description = request.getParameter("description");
                
                if (roomDAO.createRoomType(typeName, basePrice, description)) {
                    MessageUtil.setFlashMessage(request, "success", 
                        "✓ Category '" + typeName + "' created successfully.");
                } else {
                    MessageUtil.setFlashMessage(request, "danger", 
                        "✗ Category creation failed. It may already exist.");
                }

            }
            // ACTION 2: Add a Physical Room to Inventory (e.g., Room "305")
            else if ("addPhysical".equals(action)) {
                String roomNumber = request.getParameter("roomNumber");
                int typeId = Integer.parseInt(request.getParameter("typeId"));
                
                if (roomDAO.addPhysicalRoom(roomNumber, typeId)) {
                    MessageUtil.setFlashMessage(request, "success", 
                        "✓ Physical Room #" + roomNumber + " added to inventory.");
                } else {
                    MessageUtil.setFlashMessage(request, "danger", 
                        "✗ Room #" + roomNumber + " already exists or error occurred.");
                }
            }
        } catch (NumberFormatException e) {
            MessageUtil.setFlashMessage(request, "danger", 
                "✗ Input Error: Invalid number format. Please check your inputs.");
        } catch (Exception e) {
            MessageUtil.setFlashMessage(request, "danger", 
                "✗ Error: " + e.getMessage());
        }
        
        // Redirect to GET (PRG pattern - Post-Redirect-Get)
        response.sendRedirect("roomManagement");
    }
}