package com.oceanview.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import com.oceanview.util.MessageUtil;
import com.oceanview.util.PasswordUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String u = request.getParameter("username");
        String p = request.getParameter("password");
        // NEW: Detect which portal is being used for correct redirects
        String portal = request.getParameter("portal"); 
        
        // ACADEMIC NOTE: Never store or compare plain text passwords.
        // We hash the input immediately to compare with the DB hash.
        String hashedPass = PasswordUtil.hashPassword(p);
        
        User user = userDAO.authenticate(u, hashedPass);

        if (user != null) {
            // Login Success
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());
            
            // Welcome Flash Message
            MessageUtil.setFlashMessage(request, "success", "Welcome back, " + user.getFullName());
            
            // ACADEMIC NOTE: Role-Based Redirection
            // Admins go to the admin dashboard, Staff go to the staff dashboard.
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard");
            } else {
                response.sendRedirect("staff/dashboard");
            }
        } else {
            // Login Failed - redirect back to the correct login page
            MessageUtil.setFlashMessage(request, "danger", "Invalid credentials or account inactive.");
            if ("admin".equals(portal)) {
                response.sendRedirect("admin/adminlogin.jsp");
            } else {
                response.sendRedirect("staff/stafflogin.jsp"); // Default to staff login
            }
        }
    }
}