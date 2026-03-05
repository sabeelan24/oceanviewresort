<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>New Reservation: Step 1 | Ocean View Admin</title>
    <link rel="stylesheet" href="../assets/style.css">
    <script>
        // FRONTEND VALIDATION (First Layer of Dual-Layer Validation)
        // ACADEMIC NOTE: This provides immediate feedback to users without server round-trip
        // However, we NEVER trust this alone - always validate on backend too!

        function validateForm() {
            // Get form values
            const guestName = document.getElementsByName('guestName')[0].value.trim();
            const guestContact = document.getElementsByName('guestContact')[0].value.trim();
            const guestEmail = document.getElementsByName('guestEmail')[0].value.trim();
            const checkIn = document.getElementsByName('checkIn')[0].value;
            const checkOut = document.getElementsByName('checkOut')[0].value;

            // Validate guest name
            if (guestName === '') {
                alert('Guest name is required.');
                return false;
            }

            // CRITICAL: Phone number validation using Regular Expression
            // Pattern: ^[0-9]{10}$ means exactly 10 numeric digits
            const phonePattern = /^[0-9]{10}$/;

            if (guestContact === '') {
                alert('Contact number is required.');
                return false;
            }

            if (guestContact.length !== 10) {
                alert('Phone number must be exactly 10 digits.\nCurrent length: ' + guestContact.length);
                return false;
            }

            if (!phonePattern.test(guestContact)) {
                alert('Phone number must contain only numeric digits (0-9).\nNo spaces, dashes, or special characters allowed.');
                return false;
            }

            // Validate email format (if provided)
            if (guestEmail !== '') {
                const emailPattern = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
                if (!emailPattern.test(guestEmail)) {
                    alert('Please enter a valid email address.');
                    return false;

                }
            }

            // Validate dates
            if (checkIn === '' || checkOut === '') {
                alert('Please select both check-in and check-out dates.');
                return false;
            }

            const checkInDate = new Date(checkIn);
            const checkOutDate = new Date(checkOut);
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            if (checkInDate < today) {
                alert('Check-in date cannot be in the past.');
                return false;
            }

            if (checkOutDate <= checkInDate) {
                alert('Check-out date must be after check-in date.');
                return false;
            }

            return true;
        }

        // Set minimum date to today
        window.onload = function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementsByName('checkIn')[0].setAttribute('min', today);
            document.getElementsByName('checkOut')[0].setAttribute('min', today);
        };
    </script>
</head>
<body>
    <div class="dashboard-wrapper">
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard">📊 Strategic Dashboard</a>
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

        <main class="main-content">
            <div class="page-title">
                <h2>New Booking: Step 1 of 2</h2>
                <p>Enter guest details and check for available room types.</p>
            </div>

            <!-- Flash Messages for errors like "No rooms available" -->
            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}"><c:out value="${sessionScope.flashMessage}"/></div>
                <c:remove var="flashMessage" scope="session"/>
            </c:if>

            <div class="card">
                <!-- ACADEMIC NOTE: This form submits to a new 'checkAvailability' servlet -->
                <form action="checkAvailability" method="POST" onsubmit="return validateForm();">
                    <h3>Guest Information</h3>
                    <hr style="margin: 10px 0 20px 0;">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div class="form-group">
                            <label>Guest Full Name</label>
                            <input type="text" name="guestName" required>
                        </div>
                        <div class="form-group">
                            <label>Contact Number (10 Digits - Unique Identifier)</label>
                            <input type="text" name="guestContact"
                                   pattern="[0-9]{10}"
                                   maxlength="10"
                                   placeholder="1234567890"
                                   title="Enter exactly 10 numeric digits"
                                   required>
                            <small style="color: #666; font-size: 0.85em;">Enter 10 digits only (no spaces or dashes)</small>
                        </div>
                        <div class="form-group" style="grid-column: span 2;">
                            <label>Email Address (Optional)</label>
                            <input type="email" name="guestEmail" placeholder="guest@example.com">
                        </div>
                    </div>

                    <h3 style="margin-top: 20px;">Booking Details</h3>
                    <hr style="margin: 10px 0 20px 0;">
                    <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px;">
                        <div class="form-group">
                            <label>Room Category</label>
                            <select name="roomTypeId" required>
                                <!-- This could be populated from a DAO call in a servlet -->
                                <option value="1">Standard Room</option>
                                <option value="2">Deluxe Ocean View</option>
                                <option value="3">Presidential Suite</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Check-In Date</label>
                            <input type="date" name="checkIn" required>
                        </div>
                        <div class="form-group">
                            <label>Check-Out Date</label>
                            <input type="date" name="checkOut" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-accent btn-block" style="margin-top: 20px;">Check for Specific Rooms</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>