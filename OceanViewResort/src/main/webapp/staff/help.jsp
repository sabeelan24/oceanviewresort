<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Help & Documentation | Ocean View Resort</title>
    <link rel="stylesheet" href="../assets/style.css">
    <style>
        .toc-container {
            background: linear-gradient(135deg, #f0f4f8 0%, #f8fafb 100%);
            border-left: 4px solid var(--primary-color);
            padding: 20px;
            border-radius: var(--radius-lg);
            margin-bottom: 30px;
        }
        .toc-container h4 {
            color: var(--primary-color);
            margin-top: 0;
        }
        .toc-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .toc-list li {
            padding: 8px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        .toc-list li:last-child {
            border-bottom: none;
        }
        .toc-list a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }
        .toc-list a:hover {
            color: var(--accent-color);
            padding-left: 5px;
        }
        .section-anchor {
            scroll-margin-top: 80px;
        }
        .step-box {
            background: #f8fafc;
            border-left: 4px solid var(--success);
            padding: 15px;
            margin: 15px 0;
            border-radius: 4px;
        }
        .step-number {
            display: inline-block;
            background: var(--success);
            color: white;
            width: 32px;
            height: 32px;
            line-height: 32px;
            border-radius: 50%;
            text-align: center;
            font-weight: bold;
            margin-right: 10px;
        }
        .tip-box {
            background: linear-gradient(135deg, #fef3c7 0%, #fef9c3 100%);
            border-left: 4px solid var(--warning);
            padding: 15px;
            margin: 15px 0;
            border-radius: 4px;
            border-top-right-radius: var(--radius-lg);
            border-bottom-right-radius: var(--radius-lg);
        }
        .warning-box {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            border-left: 4px solid var(--danger);
            padding: 15px;
            margin: 15px 0;
            border-radius: 4px;
        }
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .feature-card {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: var(--radius-lg);
            padding: 20px;
            transition: all 0.3s;
            cursor: pointer;
        }
        .feature-card:hover {
            border-color: var(--primary-color);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.15);
            transform: translateY(-2px);
        }
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        .timeline::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: var(--primary-color);
        }
        .timeline-item {
            position: relative;
            margin-bottom: 20px;
            padding-left: 20px;
        }
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -22px;
            top: 8px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--primary-color);
            border: 3px solid white;
            box-shadow: 0 0 0 2px var(--primary-color);
        }
        .code-block {
            background: #1e1e1e;
            color: #d4d4d4;
            padding: 15px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            margin: 15px 0;
            overflow-x: auto;
        }
        .comparison-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: white;
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .comparison-table th,
        .comparison-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }
        .comparison-table th {
            background: var(--primary-color);
            color: white;
            font-weight: 600;
        }
        .comparison-table tr:nth-child(even) {
            background: #f8fafc;
        }
        .comparison-table tr:hover {
            background: #e3f2fd;
        }
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8em;
            font-weight: 500;
        }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        .badge-info { background: #d1ecf1; color: #0c5460; }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard">📊 Dashboard</a>
                <a href="reservations">📋 Reservations</a>
                <a href="add_reservation.jsp">➕ New Booking</a>
                <a href="help.jsp" class="active">❓ Help System</a>
            </nav>
            <div class="sidebar-footer">
                <a href="../logout" style="color: #ff7675;">🚪 Logout</a>
            </div>
        </div>

        <main class="main-content">
            <div class="page-title">
                <h2>Staff Help & Documentation</h2>
                <p>Comprehensive tutorial guide for new staff members at Ocean View Resort.</p>
            </div>

            <!-- Table of Contents -->
            <div class="toc-container">
                <h4>📚 Table of Contents</h4>
                <ul class="toc-list">
                    <li><a href="#welcome">🎯 Welcome & First Steps</a></li>
                    <li><a href="#dashboard">📊 Dashboard Overview</a></li>
                    <li><a href="#bookings">📝 Creating New Bookings</a></li>
                    <li><a href="#reservations">📋 Managing Reservations</a></li>
                    <li><a href="#security">🔐 Security & Best Practices</a></li>
                    <li><a href="#troubleshooting">🔧 Troubleshooting & FAQ</a></li>
                </ul>
            </div>

            <!-- Section 1: Welcome & First Steps -->
            <section id="welcome" class="section-anchor">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px;">🎯 Section 1: Welcome & First Steps</h3>

                <p>Welcome to Ocean View Resort! As a staff member, you'll be responsible for managing guest reservations and ensuring smooth operations. This guide will walk you through everything you need to know.</p>

                <div class="timeline">
                    <div class="timeline-item">
                        <strong>Day 1: Account Setup</strong><br>
                        You'll receive login credentials from your administrator. Use these to access the staff portal.
                    </div>
                    <div class="timeline-item">
                        <strong>First Login</strong><br>
                        Navigate to the staff login page and enter your username/password. Remember to logout after each session.
                    </div>
                    <div class="timeline-item">
                        <strong>Explore the Dashboard</strong><br>
                        Familiarize yourself with the main dashboard showing current bookings and available rooms.
                    </div>
                    <div class="timeline-item">
                        <strong>Practice Booking</strong><br>
                        Try creating a test reservation (you can cancel it later) to understand the workflow.
                    </div>
                </div>

                <div class="tip-box">
                    <strong>💡 Pro Tip:</strong> Always double-check guest contact information - this is crucial for communication and serves as a unique identifier in our system.
                </div>
            </section>

            <!-- Section 2: Dashboard Overview -->
            <section id="dashboard" class="section-anchor" style="margin-top: 40px;">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px;">📊 Section 2: Dashboard Overview</h3>

                <p>The dashboard is your command center. It provides real-time insights into hotel operations and recent activity.</p>

                <div class="feature-grid">
                    <div class="feature-card">
                        <h4>📈 Total Bookings</h4>
                        <p>Shows the total number of reservations in the system, including all statuses (confirmed, pending, cancelled).</p>
                    </div>
                    <div class="feature-card">
                        <h4>🏨 Available Rooms</h4>
                        <p>Indicates room availability status. "Active" means rooms are available for booking.</p>
                    </div>
                    <div class="feature-card">
                        <h4>📋 Recent Reservations</h4>
                        <p>Displays the latest bookings with guest details, room assignments, dates, and billing information.</p>
                    </div>
                </div>

                <div class="tip-box">
                    <strong>💡 Business Insight:</strong> Monitor the dashboard regularly during peak hours to anticipate busy periods and prepare accordingly.
                </div>
            </section>

            <!-- Section 3: Creating New Bookings -->
            <section id="bookings" class="section-anchor" style="margin-top: 40px;">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px;">📝 Section 3: Creating New Bookings</h3>

                <p>Creating reservations is a two-step process designed to ensure accuracy and prevent double-bookings.</p>

                <h4>Step-by-Step Booking Process:</h4>

                <div class="step-box">
                    <span class="step-number">1</span>
                    <strong>Enter Guest Details</strong><br>
                    Navigate to "New Booking" from the sidebar. Fill in:
                    <ul style="margin-top: 10px;">
                        <li><strong>Guest Full Name:</strong> Required field</li>
                        <li><strong>Contact Number:</strong> Exactly 10 digits, numeric only</li>
                        <li><strong>Email:</strong> Optional but recommended</li>
                        <li><strong>Room Category:</strong> Select from Standard, Deluxe, or Suite</li>
                        <li><strong>Dates:</strong> Check-in and check-out dates</li>
                    </ul>
                </div>

                <div class="step-box">
                    <span class="step-number">2</span>
                    <strong>Select Specific Room</strong><br>
                    After submitting guest details, you'll see available rooms for the selected dates.
                    <ul style="margin-top: 10px;">
                        <li>Green rooms are available</li>
                        <li>Red rooms are occupied</li>
                        <li>Click on an available room to confirm the booking</li>
                        <li>The system automatically calculates the total bill</li>
                    </ul>
                </div>

                <div class="warning-box">
                    <strong>⚠️ Critical Validation Rules:</strong>
                    <ul style="margin: 10px 0;">
                        <li>Phone numbers must be exactly 10 digits</li>
                        <li>Check-out date must be after check-in date</li>
                        <li>Cannot book dates in the past</li>
                        <li>System prevents double-booking automatically</li>
                    </ul>
                </div>

                <h4>Billing Calculation:</h4>
                <div class="code-block">
Total Bill = (Room Price × Number of Nights) + Tax (10%)<br>
Example: Standard Room (LKR 15,000/night) × 3 nights = LKR 45,000<br>
Tax: LKR 4,500<br>
Grand Total: LKR 49,500
                </div>
            </section>

            <!-- Section 4: Managing Reservations -->
            <section id="reservations" class="section-anchor" style="margin-top: 40px;">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px;">📋 Section 4: Managing Reservations</h3>

                <p>The Reservations page shows all bookings with detailed information and management options.</p>

                <h4>Understanding Reservation Status:</h4>
                <table class="comparison-table">
                    <thead>
                        <tr>
                            <th>Status</th>
                            <th>Description</th>
                            <th>Actions Available</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span class="badge badge-success">Confirmed</span></td>
                            <td>Booking is finalized and room is reserved</td>
                            <td>Print Bill, View Details</td>
                        </tr>
                        <tr>
                            <td><span class="badge badge-warning">Pending</span></td>
                            <td>Awaiting confirmation or payment</td>
                            <td>View Details</td>
                        </tr>
                        <tr>
                            <td><span class="badge badge-danger">Cancelled</span></td>
                            <td>Booking has been cancelled</td>
                            <td>View Details Only</td>
                        </tr>
                    </tbody>
                </table>

                <div class="tip-box">
                    <strong>💡 Pro Tip:</strong> For confirmed bookings, always print the bill immediately after booking to provide guests with their receipt.
                </div>

                <h4>Key Features:</h4>
                <ul>
                    <li><strong>Print Bills:</strong> Available for confirmed reservations only</li>
                    <li><strong>Search/Filter:</strong> Use browser search (Ctrl+F) to find specific bookings</li>
                    <li><strong>Real-time Updates:</strong> Refresh the page to see latest changes</li>
                </ul>
            </section>

            <!-- Section 5: Security & Best Practices -->
            <section id="security" class="section-anchor" style="margin-top: 40px;">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px;">🔐 Section 5: Security & Best Practices</h3>

                <p>Maintaining security is crucial for protecting guest data and system integrity.</p>

                <div class="feature-grid">
                    <div class="feature-card">
                        <h4>🔑 Password Security</h4>
                        <p>Your password is encrypted using BCrypt hashing. Never share your credentials with others.</p>
                    </div>
                    <div class="feature-card">
                        <h4>⏰ Session Management</h4>
                        <p>Sessions automatically expire after 30 minutes of inactivity. Always logout when finished.</p>
                    </div>
                    <div class="feature-card">
                        <h4>🚫 Data Privacy</h4>
                        <p>Guest contact information is confidential. Only use for legitimate booking purposes.</p>
                    </div>
                </div>

                <div class="warning-box">
                    <strong>🚨 Security DO's and DON'Ts:</strong>
                    <ul style="margin: 10px 0;">
                        <li><strong>DO:</strong> Logout after each shift</li>
                        <li><strong>DO:</strong> Verify guest identity before sharing information</li>
                        <li><strong>DON'T:</strong> Leave your workstation unattended while logged in</li>
                        <li><strong>DON'T:</strong> Use the browser "Back" button after logout</li>
                        <li><strong>DON'T:</strong> Share login credentials</li>
                    </ul>
                </div>
            </section>

            <!-- Section 6: Troubleshooting & FAQ -->
            <section id="troubleshooting" class="section-anchor" style="margin-top: 40px;">
                <h3 style="color: var(--primary-color); border-bottom: 2px solid var(--primary-color); padding-bottom: 10px;">🔧 Section 6: Troubleshooting & FAQ</h3>

                <p>Common issues and their solutions:</p>

                <div class="feature-grid">
                    <div class="feature-card">
                        <h4>Q: "No rooms available for selected dates"</h4>
                        <p><strong>Solution:</strong> All rooms of that category are booked. Try different dates or suggest an alternative room type.</p>
                    </div>
                    <div class="feature-card">
                        <h4>Q: "Phone number validation error"</h4>
                        <p><strong>Solution:</strong> Enter exactly 10 numeric digits. Remove any spaces, dashes, or special characters.</p>
                    </div>
                    <div class="feature-card">
                        <h4>Q: "Check-out date before check-in"</h4>
                        <p><strong>Solution:</strong> Ensure check-out date is at least one day after check-in date.</p>
                    </div>
                    <div class="feature-card">
                        <h4>Q: "Cannot print bill"</h4>
                        <p><strong>Solution:</strong> Bills can only be printed for confirmed reservations. Check the status first.</p>
                    </div>
                    <div class="feature-card">
                        <h4>Q: "Dashboard shows old data"</h4>
                        <p><strong>Solution:</strong> Refresh the page (F5) or clear browser cache. Data updates automatically.</p>
                    </div>
                    <div class="feature-card">
                        <h4>Q: "Session expired"</h4>
                        <p><strong>Solution:</strong> Login again. Sessions expire after 30 minutes of inactivity.</p>
                    </div>
                </div>

                <div class="tip-box">
                    <strong>💡 Need Help?</strong> Contact your administrator for technical issues or questions not covered in this guide.
                </div>
            </section>

            <!-- Footer -->
            <div style="margin-top: 40px; padding: 20px; background: #f8fafc; border-radius: var(--radius-lg); text-align: center;">
                <p><strong>Staff Help Documentation</strong> | Ocean View Resort</p>
                <p style="color: var(--text-muted); font-size: 0.9em;">Updated: February 11, 2026 | Version 2.0</p>
            </div>
        </main>
    </div>
</body>
</html>