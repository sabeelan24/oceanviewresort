<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Login | Ocean View Resort</title>
    <!-- Linking the Master CSS -->
    <link rel="stylesheet" href="../assets/style.css">
    <style>
        /* Specific adjustments for the login background if needed */
        body {
            background: url('https://images.unsplash.com/photo-1551882547-ff43c63faf76?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
        }
        .overlay {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 51, 102, 0.7); /* Deep blue overlay for luxury feel */
            z-index: 1;
        }
        .login-container {
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body>

    <div class="overlay"></div>

    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <div style="font-size: 3rem; color: var(--accent-color); margin-bottom: 10px;">🏨</div>
                <h1>OCEAN VIEW</h1>
                <p>RESORT & SPA | GALLE</p>
                <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
                <p style="color: var(--text-main); font-weight: 600;">Staff Management Portal</p>
            </div>

            <!-- FLASH MESSAGE LOGIC: Prevents alerts from persisting on refresh -->
            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}">
                    ${sessionScope.flashMessage}
                </div>
                <!-- Remove message from session immediately after displaying -->
                <c:remove var="flashMessage" scope="session" />
                <c:remove var="flashType" scope="session" />
            </c:if>

            <form action="../login" method="POST">
                <div class="form-group">
                    <label for="username">Staff Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block">Authorize Access</button>
            </form>

            <div style="margin-top: 2rem; font-size: 0.8rem; color: var(--text-muted);">
             <a href="../admin/adminlogin.jsp" style="color: blue; text-decoration: underline; font-weight: 500;">Admin Login</a><br>
                &copy; 2025 Ocean View Resort Galle. <br>
                System Security: SHA-256 Protected.
            </div>
        </div>
    </div>

</body>
</html>
