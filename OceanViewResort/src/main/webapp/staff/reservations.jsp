<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservations & Transactions | Ocean View Staff</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard">📊 Dashboard</a>
                <a href="reservations" class="active">📋 Reservations</a>
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
                    <h2>Reservations & Transactions</h2>
                    <p style="color: var(--text-muted);">View all bookings and print bills</p>
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
                <c:remove var="flashType" scope="session" />
            </c:if>

            <!-- Summary Stats -->
            <div class="stats-grid" style="margin-bottom: 2rem;">
                <div class="card stat-card">
                    <h3>Total Bookings</h3>
                    <div class="value">${reservationList.size()}</div>
                </div>
                <div class="card stat-card">
                    <h3>Confirmed</h3>
                    <div class="value" style="color: var(--success);">
                        ${reservationList.stream().filter(r -> r.status == 'CONFIRMED').count()}
                    </div>
                </div>
            </div>

            <!-- Reservations Table -->
            <div class="card">
                <div style="display:flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                    <h3>All Reservations</h3>
                    <a href="add_reservation.jsp" class="btn btn-primary">+ Create New</a>
                </div>
                
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Guest Name</th>
                                <th>Contact</th>
                                <th>Room</th>
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
                                    <td><strong>${res.guestName}</strong></td>
                                    <td><small>${res.guestContact}</small></td>
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
                                               🖨️ Bill
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reservationList}">
                                <tr>
                                    <td colspan="9" style="text-align:center; padding: 2rem; color: var(--text-muted);">
                                        No reservations found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Information Note -->
            <div class="info-box" style="margin-top: 2rem;">
                <h4>📌 Quick Guide</h4>
                <p>
                    View all guest reservations here. For confirmed bookings, you can print bills directly. 
                    Use the "Create New" button to add a new reservation.
                </p>
            </div>
        </main>
    </div>
</body>
</html>
