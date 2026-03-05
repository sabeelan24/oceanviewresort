package com.oceanview.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oceanview.util.MessageUtil;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (request.getSession() != null) {
            // Securely wipe session data
            request.getSession().invalidate();
        }

        // Create a separate temporary session just for the logout message
        // This ensures the next request (stafflogin.jsp) can show the success alert
        MessageUtil.setFlashMessage(request, "success", "You have been logged out securely. Have a nice day!");
        
        response.sendRedirect("staff/stafflogin.jsp");
    }
}