package com.oceanview.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.RoomType;

@WebServlet("/staff/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Fetch Data
        List<Reservation> resList = reservationDAO.getAllReservations();
        List<RoomType> roomList = roomDAO.getAllRoomTypes();

        // 2. Pass to View
        request.setAttribute("reservationList", resList);
        request.setAttribute("roomTypes", roomList);

        // 3. Forward
        request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
    }
}