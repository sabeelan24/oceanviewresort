<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard" class="active">📊 Strategic Dashboard</a>
                <a href="reservations">📋 Reservations</a>
                <a href="guestAudit">👥 Guest Audit</a>
                <a href="userManagement">🔐 User Management</a>
                <a href="roomManagement">🏨 Room Management</a>
                <a href="financials">💰 Financials</a>
                <a href="help.jsp">💡 Help & Docs</a>
            </nav>
            <div class="sidebar-footer">
                <a href="../logout">🚪 Logout</a>
            </div>
        </div>

        <!-- Main Content -->
        <main class="main-content">
            <header class="top-bar">
                <div class="page-title">
                    <h2>Strategic Executive Dashboard</h2>
                    <p>Real-time analytics and performance intelligence</p>
                </div>
            </header>
            
            <!-- KEY METRICS GRID -->
            <div class="stats-grid">
                <div class="card stat-card">
                    <h3>💰 Gross Revenue</h3>
                    <div class="value">LKR <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/></div>
                    <p>From confirmed bookings</p>
                </div>
                <div class="card stat-card">
                    <h3>📅 Total Bookings</h3>
                    <div class="value">${totalBookings}</div>
                    <p>All reservations</p>
                </div>
                <div class="card stat-card">
                    <h3>🏨 Occupancy Rate</h3>
                    <div class="value" style="color: var(--success);">${occupancy}</div>
                    <p>Active / Total Rooms</p>
                </div>
            </div>

            <!-- DATA SOURCE FOOTER -->
            <div class="info-box" style="margin-top: 2.5rem;">
                <h4>📌 Dashboard Intelligence</h4>
                <p>
                    <strong>Powered By:</strong> ReportDAO aggregations | 
                    <strong>Schema:</strong> Multi-table analytics for operational insights |
                    <strong>Real-time Updates:</strong> On page refresh
                </p>
            </div>
        </main>
    </div>
</body>
</html>