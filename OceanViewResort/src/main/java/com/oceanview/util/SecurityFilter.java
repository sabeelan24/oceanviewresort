package com.oceanview.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Map to ALL URLs
@WebFilter("/*")
public class SecurityFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        // 1. THE BACK BUTTON FIX (Cache Control)
        // Forces browser to not store the page.
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        // 2. Define Public Resources (Login page, CSS, JS, API)
        String loginURI = request.getContextPath() + "/staff/stafflogin.jsp";
        String loginServlet = request.getContextPath() + "/login";
        // NEW: Add Admin Login to public resources
        String adminLoginURI = request.getContextPath() + "/admin/adminlogin.jsp";
        String publicAssets = request.getContextPath() + "/assets/";
        String pricingApi = request.getContextPath() + "/api/pricing"; 

        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        boolean loginRequest = request.getRequestURI().equals(loginURI);
        boolean isTestPage = request.getRequestURI().endsWith("system_test.jsp");
        boolean loginAction = request.getRequestURI().equals(loginServlet);
        boolean isAsset = request.getRequestURI().startsWith(publicAssets);
        boolean isApi = request.getRequestURI().equals(pricingApi);
        // Add index.jsp to public resources
        boolean isIndex = request.getRequestURI().endsWith("/") || request.getRequestURI().endsWith("index.jsp");
        boolean adminLoginRequest = request.getRequestURI().equals(adminLoginURI);

        // 3. Authorization Logic
        // Update the IF condition
        if (loggedIn || loginRequest || loginAction || isAsset || isApi || isIndex || adminLoginRequest || isTestPage) {
            
            // *** CRITICAL RBAC (Role-Based Access Control) CHECK ***
            String requestURI = request.getRequestURI();
            if (requestURI.startsWith(request.getContextPath() + "/admin/")) {
                // Accessing admin area - must be logged in AND have ADMIN role
                if (!loggedIn) {
                    // Not logged in -> Show 401 Access Denied page
                    response.sendRedirect(request.getContextPath() + "/error/401.jsp");
                    return; // Stop the request
                }
                
                String userRole = (String) session.getAttribute("role");
                if (!"ADMIN".equals(userRole)) {
                    // STAFF or other role trying to access ADMIN area -> Show 401 Access Denied
                    response.sendRedirect(request.getContextPath() + "/error/401.jsp");
                    return; // Stop the request
                }
            }
            
            chain.doFilter(request, response); // Allow request to proceed
        } else {
            // Not logged in -> Kick to login page
            response.sendRedirect(loginURI);
        }
    }

    public void init(FilterConfig fConfig) throws ServletException {}
    public void destroy() {}
}