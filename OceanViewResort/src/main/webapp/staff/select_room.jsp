<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>New Reservation: Step 2 | Ocean View</title>
    <link rel="stylesheet" href="../assets/style.css">
    <!-- Page-specific styling moved into assets/style.css (scoped under .select-room-page) -->
    <script>
        function selectRoom(roomId, roomNumber, isAvailable) {
            if (!isAvailable) {
                alert('Room ' + roomNumber + ' is currently occupied for the selected dates.\nPlease choose an available room (shown in green).');
                return;
            }
            
            if (confirm('Confirm booking for Room ' + roomNumber + '?')) {
                document.getElementById('selectedRoomId').value = roomId;
                document.getElementById('reservationForm').submit();
            }
        }
    </script>
</head>
<body>
    <div class="dashboard-wrapper">
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard">📊 Dashboard</a>
                <a href="reservations">📋 Reservations</a>
                <a href="add_reservation.jsp" class="active">➕ New Booking</a>
                <a href="help.jsp">❓ Help System</a>
            </nav>
            <div class="sidebar-footer">
                <a href="../logout" style="color: #ff7675;">🚪 Logout</a>
            </div>
        </div>

        <main class="main-content select-room-page">
            <div class="page-title">
                <h2>New Booking: Step 2 of 2 - Select Room</h2>
                <p>View complete inventory and select an available room.</p>
            </div>
            
            <!-- Booking Summary -->
            <div class="inventory-summary">
                <h4>📋 Booking Summary</h4>
                <p><strong>Guest:</strong> <c:out value="${guestName}"/> | <strong>Contact:</strong> <c:out value="${guestContact}"/></p>
                <p><strong>Dates:</strong> <c:out value="${checkIn}"/> to <c:out value="${checkOut}"/></p>
                <p><strong>Available Rooms:</strong> ${availableCount} out of ${allRooms.size()} total rooms</p>
                
                <!-- Legend -->
                <div class="legend">
                    <div class="legend-item">
                        <div class="legend-box available"></div>
                        <span>Available - Click to Book</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-box occupied"></div>
                        <span>Occupied - Cannot Book</span>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <h3>Complete Room Inventory</h3>
                <p style="color: #666; margin-bottom: 20px;">
                    FULL INVENTORY VIEW: Showing all rooms in this category. 
                    Green = Available for your dates. Red = Already booked.
                </p>
                
                <!-- Full Inventory Grid -->
                <div class="room-grid">
                    <c:forEach var="room" items="${allRooms}">
                        <div class="room-card ${room.available ? 'available' : 'occupied'}" 
                             onclick="selectRoom(${room.roomId}, '${room.roomNumber}', ${room.available})">
                            <div class="room-number">🚪 ${room.roomNumber}</div>
                            <div style="font-size: 0.85em; color: #666;">Room ID: ${room.roomId}</div>
                            <div class="room-status ${room.available ? 'status-available' : 'status-occupied'}">
                                ${room.available ? '✓ AVAILABLE' : '✗ OCCUPIED'}
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Hidden Form for Submission -->
                <form id="reservationForm" action="createReservation" method="POST" style="margin-top: 30px;">
                    <input type="hidden" id="selectedRoomId" name="roomId" value="">
                    <input type="hidden" name="guestName" value="<c:out value="${guestName}"/>">
                    <input type="hidden" name="guestContact" value="<c:out value="${guestContact}"/>">
                    <input type="hidden" name="guestEmail" value="<c:out value="${guestEmail}"/>">
                    <input type="hidden" name="roomTypeId" value="<c:out value="${roomTypeId}"/>">
                    <input type="hidden" name="checkIn" value="<c:out value="${checkIn}"/>">
                    <input type="hidden" name="checkOut" value="<c:out value="${checkOut}"/>">
                </form>
                
                <a href="add_reservation.jsp" class="btn-secondary" style="margin-top:20px; display:inline-block;">
                    ← Go Back & Change Dates
                </a>
            </div>
        </main>
    </div>
</body>
</html>