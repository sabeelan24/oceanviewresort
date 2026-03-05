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
    <style>
        /* Modern Modal Animation and Styling */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 2000; 
            left: 0; top: 0; width: 100%; height: 100%; 
            background-color: rgba(0,0,0,0.65);
            backdrop-filter: blur(4px);
            align-items: center;
            justify-content: center;
        }
        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 2rem;
            border-radius: 12px;
            width: 480px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            animation: slideIn 0.3s ease-out;
        }
        @keyframes slideIn {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .modal-header { border-bottom: 2px solid #f1f2f6; margin-bottom: 1.5rem; padding-bottom: 1rem; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #2d3436; font-size: 0.9rem; }
        .form-control { 
            width: 100%; padding: 12px; border: 1px solid #dfe6e9; 
            border-radius: 6px; margin-bottom: 15px; font-size: 1rem;
            box-sizing: border-box;
        }
        .form-control:focus { border-color: #0984e3; outline: none; box-shadow: 0 0 0 3px rgba(9,132,227,0.1); }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
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
                <a href="../logout" style="color: #ff7675;">🚪 Logout</a>
            </div>
        </div>

        <main class="main-content">
            <header class="top-bar">
                <div class="page-title">
                    <h2>Reservations & Transactions</h2>
                    <p style="color: var(--text-muted);">Administrative control and payment management</p>
                </div>
                <div class="user-info">
                    Admin: <span class="badge badge-info">${sessionScope.user.fullName}</span>
                </div>
            </header>

            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}" style="margin-bottom: 25px; border-left: 5px solid;">
                    <strong>Notice:</strong> ${sessionScope.flashMessage}
                </div>
                <c:remove var="flashMessage" scope="session" />
                <c:remove var="flashType" scope="session" />
            </c:if>

            <div class="card">
                <div style="display:flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <h3>System-wide Bookings</h3>
                    <a href="add_reservation.jsp" class="btn btn-primary" style="text-decoration:none;">+ Create New Booking</a>
                </div>
                
                

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Guest Detail</th>
                                <th>Room Assignment</th>
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
                                        <span style="font-weight: 700; color: var(--primary-color);">${res.guestName}</span><br>
                                        <small style="color: #636e72;">📞 ${res.guestContact}</small>
                                    </td>
                                    <td>
                                        ${res.roomTypeName}<br>
                                        <small class="badge" style="background: #f1f2f6; color: #2d3436;">Room ${res.roomNumber}</small>
                                    </td>
                                    <td>
                                        <small><strong>In:</strong> ${res.checkIn}</small><br>
                                        <small><strong>Out:</strong> ${res.checkOut}</small>
                                    </td>
                                    <td>
                                        <strong style="color: #2d3436;">
                                            LKR <fmt:formatNumber value="${res.totalAmount}" pattern="#,###.00"/>
                                        </strong>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.status == 'CONFIRMED'}"><span class="badge badge-success">Confirmed</span></c:when>
                                            <c:when test="${res.status == 'CANCELLED'}"><span class="badge badge-danger">Cancelled</span></c:when>
                                            <c:when test="${res.status == 'CHECKED_OUT'}"><span class="badge badge-info">Checked Out</span></c:when>
                                            <c:otherwise><span class="badge badge-warning">${res.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 8px;">
                                            <button type="button" class="btn" 
                                                    style="background: #0984e3; color: white; font-size: 0.75rem; padding: 6px 12px; border:none; cursor:pointer;"
                                                    onclick="openEditModal('${res.resId}', '${res.totalAmount}', '${res.status}', '${res.checkIn}', '${res.checkOut}')">
                                                ✏️ Edit
                                            </button>

                                            <c:if test="${res.status == 'CONFIRMED' || res.status == 'CHECKED_OUT'}">
                                                <a href="printBill?id=${res.resId}" 
                                                   class="btn" 
                                                   style="background: #e67e22; color: white; font-size: 0.75rem; padding: 6px 12px; text-decoration: none; border-radius: 4px;"
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
                                    <td colspan="7" style="text-align:center; padding: 3rem; color: #636e72;">
                                        No reservations recorded in the database.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle" style="margin:0; color: var(--primary-color);">Edit Reservation</h3>
            </div>
            
            <form action="${pageContext.request.contextPath}/editReservation" method="POST">
                <input type="hidden" id="editResId" name="resId">
                
                <div class="form-group">
                    <label>Updated Payment Amount (LKR)</label>
                    <input type="number" step="0.01" id="editAmount" name="amount" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label>Reservation Status</label>
                    <select id="editStatus" name="status" class="form-control">
                        <option value="PENDING">PENDING</option>
                        <option value="CONFIRMED">CONFIRMED</option>
                        <option value="CHECKED_OUT">CHECKED_OUT</option>
                        <option value="CANCELLED">CANCELLED</option>
                    </select>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div class="form-group">
                        <label>Adjust Check-In</label>
                        <input type="date" id="editCheckIn" name="checkIn" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Adjust Check-Out</label>
                        <input type="date" id="editCheckOut" name="checkOut" class="form-control" required>
                    </div>
                </div>

                <div style="display:flex; justify-content: flex-end; gap: 12px; margin-top: 25px; border-top: 1px solid #eee; padding-top: 15px;">
                    <button type="button" class="btn" style="background: #b2bec3; color: white;" onclick="closeModal()">Close</button>
                    <button type="submit" class="btn btn-primary" style="padding: 10px 20px;">Save System Changes</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openEditModal(id, amount, status, checkIn, checkOut) {
            document.getElementById('modalTitle').innerText = "Update Reservation #" + id;
            document.getElementById('editResId').value = id;
            document.getElementById('editAmount').value = amount;
            document.getElementById('editStatus').value = status;
            document.getElementById('editCheckIn').value = checkIn;
            document.getElementById('editCheckOut').value = checkOut;
            document.getElementById('editModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // Close when clicking outside the white box
        window.onclick = function(event) {
            let modal = document.getElementById('editModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>