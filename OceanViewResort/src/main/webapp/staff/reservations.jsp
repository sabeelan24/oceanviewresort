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
    
    <script>
        function openEditModal(id, amount, status, checkIn, checkOut) {
            document.getElementById('editResId').value = id;
            document.getElementById('editAmount').value = amount;
            document.getElementById('editStatus').value = status;
            document.getElementById('editCheckIn').value = checkIn;
            document.getElementById('editCheckOut').value = checkOut;
            document.getElementById('editModalOverlay').style.display = 'flex';
        }

        function closeEditModal() {
            document.getElementById('editModalOverlay').style.display = 'none';
        }
    </script>
</head>
<body>
    <div id="editModalOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.6); z-index:9999; justify-content:center; align-items:center;">
        <div class="card" style="width:450px; padding:25px; box-shadow: var(--shadow-lg); background: white; border-radius: 8px;">
            <h3 style="margin-bottom:15px; border-bottom:1px solid #eee; padding-bottom:10px; color: var(--primary-color);">Update Reservation Details</h3>
            
            <form action="${pageContext.request.contextPath}/editReservation" method="POST">
                <input type="hidden" id="editResId" name="resId">
                
                <div class="form-group" style="margin-bottom:15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Total Payment (LKR)</label>
                    <input type="number" step="0.01" id="editAmount" name="amount" required style="width:100%; padding:10px; border:1px solid #ddd; border-radius:4px;">
                </div>

                <div class="form-group" style="margin-bottom:15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Status</label>
                    <select id="editStatus" name="status" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:4px;">
                        <option value="PENDING">Pending</option>
                        <option value="CONFIRMED">Confirmed</option>
                        <option value="CHECKED_OUT">Checked Out</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>

                <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px; margin-bottom:20px;">
                    <div class="form-group">
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">Check-In</label>
                        <input type="date" id="editCheckIn" name="checkIn" required style="width:100%; padding:10px; border:1px solid #ddd; border-radius:4px;">
                    </div>
                    <div class="form-group">
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">Check-Out</label>
                        <input type="date" id="editCheckOut" name="checkOut" required style="width:100%; padding:10px; border:1px solid #ddd; border-radius:4px;">
                    </div>
                </div>

                <div style="display:flex; justify-content:flex-end; gap:10px; border-top: 1px solid #eee; padding-top: 15px;">
                    <button type="button" onclick="closeEditModal()" class="btn" style="background:#6c757d; color:white;">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Reservation</button>
                </div>
            </form>
        </div>
    </div>

    <div class="dashboard-wrapper">
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

            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}">
                    ${sessionScope.flashMessage}
                </div>
                <c:remove var="flashMessage" scope="session" />
                <c:remove var="flashType" scope="session" />
            </c:if>

            <div class="card">
                <div style="display:flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <h3>All Guest Reservations</h3>
                    <a href="add_reservation.jsp" class="btn btn-primary" style="text-decoration:none;">+ Create New</a>
                </div>
                
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Guest Details</th>
                                <th>Room</th>
                                <th>Stay Dates</th>
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
                                        <small style="color: #666;">📞 ${res.guestContact}</small>
                                    </td>
                                    <td>
                                        ${res.roomTypeName}<br>
                                        <small class="badge badge-info" style="font-size: 0.7rem;">Room ${res.roomNumber}</small>
                                    </td>
                                    <td>
                                        <small><strong>In:</strong> ${res.checkIn}</small><br>
                                        <small><strong>Out:</strong> ${res.checkOut}</small>
                                    </td>
                                    <td><strong>LKR <fmt:formatNumber value="${res.totalAmount}" pattern="#,###.00"/></strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.status == 'CONFIRMED'}"><span class="badge badge-success">Confirmed</span></c:when>
                                            <c:when test="${res.status == 'CANCELLED'}"><span class="badge badge-danger">Cancelled</span></c:when>
                                            <c:when test="${res.status == 'PENDING'}"><span class="badge badge-warning">Pending</span></c:when>
                                            <c:otherwise><span class="badge badge-info">${res.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div style="display:flex; gap:8px;">
                                            <button onclick="openEditModal('${res.resId}', '${res.totalAmount}', '${res.status}', '${res.checkIn}', '${res.checkOut}')" 
                                                    class="btn btn-primary" 
                                                    style="font-size: 0.75rem; padding: 6px 12px; border:none; cursor:pointer; border-radius:4px;">
                                                ✏️ Edit
                                            </button>

                                            <c:if test="${res.status == 'CONFIRMED'}">
                                                <a href="printBill?id=${res.resId}" 
                                                   class="btn" 
                                                   style="background: var(--accent-color); color: white; font-size: 0.75rem; padding: 6px 12px; text-decoration: none; border-radius: 4px;"
                                                   target="_blank">
                                                   🖨️ Bill
                                                </a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reservationList}">
                                <tr>
                                    <td colspan="7" style="text-align:center; padding: 2rem; color: #999;">No reservations available.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>