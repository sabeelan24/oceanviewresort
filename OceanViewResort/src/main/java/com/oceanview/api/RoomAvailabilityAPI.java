package com.oceanview.api;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;

@WebServlet("/api/available-rooms")
public class RoomAvailabilityAPI extends HttpServlet {
    private RoomDAO roomDAO = new RoomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            int typeId = Integer.parseInt(request.getParameter("typeId"));
            LocalDate start = LocalDate.parse(request.getParameter("checkIn"));
            LocalDate end = LocalDate.parse(request.getParameter("checkOut"));

            List<Room> available = roomDAO.getAvailableRooms(typeId, start, end);
            
            // Build JSON: [{"id": 1, "number": "101"}, ...]
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < available.size(); i++) {
                Room r = available.get(i);
                json.append(String.format("{\"id\":%d, \"number\":\"%s\"}", r.getRoomId(), r.getRoomNumber()));
                if (i < available.size() - 1) json.append(",");
            }
            json.append("]");
            out.print(json.toString());
            
        } catch (Exception e) {
            out.print("[]");
        }
    }
}