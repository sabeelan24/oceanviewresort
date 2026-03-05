<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard | Ocean View</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>

    <div class="dashboard-wrapper">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard" class="active">📊 Dashboard</a>
                <a href="reservations">📋 Reservations</a>
                <a href="add_reservation.jsp">➕ New Booking</a>
                <a href="help.jsp">❓ Help System</a>
            </nav>
            <div class="sidebar-footer">
                <a href="../logout" style="color: #ff7675;">🚪 Logout</a>
            </div>
        </div>

        <!-- Main Content -->
        <main class="main-content">
            <header class="top-bar">
                <div class="page-title">
                    <h2>Operational Overview</h2>
                    <p style="color: var(--text-muted);">Welcome back, ${sessionScope.user.fullName}</p>
                </div>
                <div class="user-info">
                    Role: <span class="badge badge-info">${sessionScope.role}</span>
                </div>
            </header>

            <!-- Flash Messages -->
            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}">
                    ${sessionScope.flashMessage}
                </div>
                <c:remove var="flashMessage" scope="session" />
            </c:if>

            <!-- Stats Overview -->
            <div class="stats-grid">
                <div class="card stat-card">
                    <h3>Total Bookings</h3>
                    <div class="value">${reservationList.size()}</div>
                </div>
                <div class="card stat-card">
                    <h3>Available Rooms</h3>
                    <div class="value" style="color: var(--success);">Active</div>
                </div>
            </div>

            <!-- Recent Reservations Table -->
            <div class="card">
                <div style="display:flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                    <h3>Recent Reservations</h3>
                    <a href="add_reservation.jsp" class="btn btn-primary">+ Create New</a>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Guest Name</th>
                                <th>Room</th>
                                <th>Check-In</th>
                                <th>Check-Out</th>
                                <th>Total Bill</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="res" items="${reservationList}">
                                <tr>
                                    <td><strong>${res.guestName}</strong><br><small>${res.guestContact}</small></td>
                                    <td>${res.roomTypeName} - ${res.roomNumber}</td>
                                    <td>${res.checkIn}</td>
                                    <td>${res.checkOut}</td>
                                    <td><strong>LKR <fmt:formatNumber value="${res.totalAmount}" pattern="#,###.00"/></strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.status == 'CONFIRMED'}">
                                                <span class="badge badge-success">Confirmed</span>
                                                <!-- ACADEMIC NOTE: Task 4 - Print Bill Button -->
                                                <a href="printBill?id=${res.resId}" class="btn" 
                                                   style="background: var(--accent-color); color: white; font-size: 0.75rem; padding: 4px 8px; margin-left: 5px; text-decoration: none; border-radius: 4px; display: inline-block;">
                                                   🖨️ Bill
                                                </a>
                                            </c:when>
                                            <c:when test="${res.status == 'CANCELLED'}"><span class="badge badge-danger">Cancelled</span></c:when>
                                            <c:otherwise><span class="badge badge-info">${res.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reservationList}">
                                <tr><td colspan="6" style="text-align:center;">No reservations found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>