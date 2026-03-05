package com.oceanview.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import com.oceanview.util.MessageUtil;
import com.oceanview.util.PasswordUtil;

@WebServlet("/admin/userManagement")
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.getUserById(id);
            request.setAttribute("userToEdit", user);
        }
        List<User> userList = userDAO.getAllUsers();
        request.setAttribute("users", userList);
        request.getRequestDispatcher("/admin/user_management.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            String fullName = request.getParameter("fullName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            String hashedPassword = PasswordUtil.hashPassword(password);
            
            boolean success = userDAO.createUser(username, hashedPassword, role, fullName);
            
            if (success) {
                MessageUtil.setFlashMessage(request, "success", "User '" + username + "' created successfully.");
            } else {
                MessageUtil.setFlashMessage(request, "danger", "Error: Could not create user. Username might already exist.");
            }
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            String hashedPassword = null;
            if (password != null && !password.trim().isEmpty()) {
                hashedPassword = PasswordUtil.hashPassword(password);
            }
            
            boolean success = userDAO.updateUser(id, username, hashedPassword, role, fullName);
            
            if (success) {
                MessageUtil.setFlashMessage(request, "success", "User '" + username + "' updated successfully.");
            } else {
                MessageUtil.setFlashMessage(request, "danger", "Error: Could not update user.");
            }
        }
        response.sendRedirect("userManagement");
    }
}