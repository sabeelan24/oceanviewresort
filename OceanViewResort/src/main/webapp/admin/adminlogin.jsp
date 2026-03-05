<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Ocean View Resort</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>🌊 Admin Control</h1>
                <p>Ocean View Resort Management System</p>
            </div>

            <!-- Flash Messages -->
            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}">
                    ${sessionScope.flashMessage}
                </div>
                <c:remove var="flashMessage" scope="session" />
                <c:remove var="flashType" scope="session" />
            </c:if>

            <form action="../login" method="POST">
                <input type="hidden" name="portal" value="admin">
                
                <div class="form-group">
                    <label>👤 Admin Username</label>
                    <input type="text" name="username" placeholder="Enter your admin username" required autofocus>
                </div>

                <div class="form-group">
                    <label>🔒 Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block">
                    🔐 Authenticate & Access
                </button>
            </form>

            <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid #e5e7eb; text-align: center;">
                <p style="font-size: 0.85rem; color: var(--text-muted);">
                    🔒 Secure Administrator Access Only
                </p>
            </div>
        </div>
    </div>
</body>
</html>