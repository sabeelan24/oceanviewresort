<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservations & Transactions | Ocean View Admin</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard">📊 Strategic Dashboard</a>
                <a href="reservations" class="active">📋 Reservations</a>
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
                    <h2>Reservations & Transactions</h2>
                    <p>Complete view of all bookings and their transaction status</p>
                </div>
            </header>

            <!-- Flash Messages -->
            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}">
                    ${sessionScope.flashMessage}
                </div>
                <c:remove var="flashMessage" scope="session" />
                <c:remove var="flashType" scope="session" />
            </c:if>

            <!-- Summary Stats -->
            <div class="stats-grid" style="margin-bottom: 2rem;">
                <div class="card stat-card">
                    <h3>Total Reservations</h3>
                    <div class="value">${reservationList.size()}</div>
                </div>
                <div class="card stat-card">
                    <h3>Confirmed Bookings</h3>
                    <div class="value" style="color: var(--success);">
                        ${reservationList.stream().filter(r -> r.status == 'CONFIRMED').count()}
                    </div>
                </div>
                <div class="card stat-card">
                    <h3>Total Revenue</h3>
                    <div class="value">
                        LKR <fmt:formatNumber value="${totalRevenue}" pattern="#,###.00"/>
                    </div>
                </div>
            </div>

            <!-- Reservations Table -->
            <div class="card">
                <div style="display:flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                    <h3>All Reservations</h3>
                    <a href="addReservation" class="btn btn-primary">+ New Reservation</a>
                </div>
                
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Reservation ID</th>
                                <th>Guest Information</th>
                                <th>Room Details</th>
                                <th>Check-In</th>
                                <th>Check-Out</th>
                                <th>Total Bill</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="res" items="${reservationList}">
                                <tr>
                                    <td><strong>#${res.resId}</strong></td>
                                    <td>
                                        <strong>${res.guestName}</strong><br>
                                        <small style="color: var(--text-muted);">${res.guestContact}</small>
                                    </td>
                                    <td>
                                        ${res.roomTypeName}<br>
                                        <small style="color: var(--text-muted);">Room ${res.roomNumber}</small>
                                    </td>
                                    <td>${res.checkIn}</td>
                                    <td>${res.checkOut}</td>
                                    <td><strong>LKR <fmt:formatNumber value="${res.totalAmount}" pattern="#,###.00"/></strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.status == 'CONFIRMED'}">
                                                <span class="badge badge-success">Confirmed</span>
                                            </c:when>
                                            <c:when test="${res.status == 'CANCELLED'}">
                                                <span class="badge badge-danger">Cancelled</span>
                                            </c:when>
                                            <c:when test="${res.status == 'PENDING'}">
                                                <span class="badge badge-warning">Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-info">${res.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${res.status == 'CONFIRMED'}">
                                            <a href="printBill?id=${res.resId}" 
                                               class="btn" 
                                               style="background: var(--accent-color); color: white; font-size: 0.75rem; padding: 6px 12px; text-decoration: none; border-radius: 4px; display: inline-block;"
                                               target="_blank">
                                               🖨️ Print Bill
                                            </a>
                                        </c:if>
                                        <c:if test="${res.status != 'CONFIRMED' && res.status != 'CANCELLED'}">
                                            <span style="color: var(--text-muted); font-size: 0.85rem;">No actions</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reservationList}">
                                <tr>
                                    <td colspan="8" style="text-align:center; padding: 2rem; color: var(--text-muted);">
                                        No reservations found in the system.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Information Note -->
            <div class="info-box" style="margin-top: 2rem;">
                <h4>📌 About Reservations View</h4>
                <p>
                    This comprehensive view shows all reservations across the system. 
                    You can print bills for confirmed bookings and monitor transaction status. 
                    Use this page to track all guest bookings and their payment details.
                </p>
            </div>
        </main>
    </div>
</body>
</html>
