<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Help & Documentation | Ocean View Resort</title>
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
        .feature-card h4 {
            margin-top: 0;
            color: var(--primary-color);
            font-size: 1.1rem;
        }
        .feature-card p {
            margin: 0;
            color: var(--text-secondary);
            font-size: 0.9rem;
            line-height: 1.6;
        }
        .workflow-timeline {
            position: relative;
            padding-left: 40px;
        }
        .workflow-timeline::before {
            content: '';
            position: absolute;
            left: 14px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: var(--primary-color);
        }
        .timeline-item {
            position: relative;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e2e8f0;
        }
        .timeline-item:last-child {
            border-bottom: none;
        }
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -32px;
            top: 2px;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: var(--primary-color);
            border: 3px solid white;
            box-shadow: 0 0 0 2px var(--primary-color);
        }
        .code-block {
            background: #1e293b;
            color: #e2e8f0;
            padding: 15px;
            border-radius: var(--radius-lg);
            overflow-x: auto;
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            margin: 15px 0;
        }
    </style>
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
                <a href="help.jsp" class="active">💡 Help & Docs</a>
            </nav>
            <div class="sidebar-footer">
                <a href="../logout">🚪 Logout</a>
            </div>
        </div>

        <main class="main-content">
            <header class="top-bar">
                <div class="page-title">
                    <h2>👋 Welcome to Ocean View Resort Admin Portal</h2>
                    <p>Complete tutorial guide for new administrators</p>
                </div>
            </header>

            <!-- TABLE OF CONTENTS -->
            <div class="toc-container">
                <h4>📑 Table of Contents</h4>
                <ul class="toc-list">
                    <li><a href="#welcome-section">🎯 Welcome & First Steps</a></li>
                    <li><a href="#dashboard-section">📊 Dashboard Overview</a></li>
                    <li><a href="#rooms-section">🏨 Room Management Setup</a></li>
                    <li><a href="#reservations-section">📋 Managing Reservations</a></li>
                    <li><a href="#guests-section">👥 Guest Analytics & VIP Management</a></li>
                    <li><a href="#staff-section">👨‍💼 Staff Account Management</a></li>
                    <li><a href="#financials-section">💰 Financial Reports & Analysis</a></li>
                    <li><a href="#security-section">🔐 Security & Best Practices</a></li>
                    <li><a href="#troubleshooting-section">🔧 Troubleshooting & FAQ</a></li>
                </ul>
            </div>
            
            <!-- SECTION 1: WELCOME & FIRST STEPS -->
            <div class="card section-anchor" id="welcome-section">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--primary-color); display: flex; align-items: center; gap: 10px;">
                    🎯 Welcome & First Steps
                </h3>
                <p style="font-size: 1.05rem; color: var(--text-secondary); line-height: 1.8; margin-bottom: 20px;">
                    You've been granted ADMIN access to the Ocean View Resort Management System. As an administrator, 
                    you have complete control over the system including room inventory, reservations, guest management, 
                    financial reporting, and staff accounts.
                </p>

                <div class="workflow-timeline">
                    <div class="timeline-item">
                        <h4>Step 1: Understand Your Dashboard</h4>
                        <p>Your first login brings you to the Strategic Dashboard. This displays real-time metrics including total revenue, booking counts, and occupancy rates. Review these KPIs regularly to monitor hotel performance.</p>
                    </div>
                    <div class="timeline-item">
                        <h4>Step 2: Set Up Room Categories & Inventory</h4>
                        <p>Before accepting any bookings, you must configure your room inventory. Go to <strong>Room Management</strong> to create room types (e.g., Standard, Deluxe, Suite) with base prices, then add physical room numbers to each category.</p>
                    </div>
                    <div class="timeline-item">
                        <h4>Step 3: Create Staff Accounts</h4>
                        <p>Navigate to <strong>User Management</strong> and create staff accounts with STAFF role. These users will handle day-to-day operations while you oversee the business.</p>
                    </div>
                    <div class="timeline-item">
                        <h4>Step 4: Monitor Reservations & Financials</h4>
                        <p>Once your system is configured, view bookings in <strong>Reservations</strong>, analyze guest behavior in <strong>Guest Audit</strong>, and track revenue in <strong>Financials</strong>.</p>
                    </div>
                </div>

                <div class="tip-box">
                    <strong>💡 Pro Tip:</strong> Bookmark the dashboard and check it daily. It provides at-a-glance insights into your hotel's performance and helps you identify trends.
                </div>
            </div>

            <!-- SECTION 2: DASHBOARD OVERVIEW -->
            <div class="card section-anchor" id="dashboard-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--info); display: flex; align-items: center; gap: 10px;">
                    📊 Dashboard Overview & Real-Time Metrics
                </h3>

                <div class="step-box">
                    <span class="step-number">1</span>
                    <strong>Access the Dashboard</strong>
                    <p style="margin: 5px 0 0 42px;">Click "Strategic Dashboard" in the sidebar. You'll see 3 main metric cards.</p>
                </div>

                <h4 style="margin-top: 25px; color: var(--text-secondary);">Key Metrics Explained:</h4>
                <div class="feature-grid">
                    <div class="feature-card">
                        <h4>💰 Gross Revenue</h4>
                        <p><strong>What it shows:</strong> Total money earned from CONFIRMED bookings.<br><br>
                        <strong>Format:</strong> LKR (Lankan Rupees) with comma formatting<br><br>
                        <strong>Use case:</strong> Track overall business profitability and growth trends.</p>
                    </div>
                    <div class="feature-card">
                        <h4>📅 Total Bookings</h4>
                        <p><strong>What it shows:</strong> Count of ALL reservations in the system (CONFIRMED, PENDING, CANCELLED).<br><br>
                        <strong>Format:</strong> Simple number<br><br>
                        <strong>Use case:</strong> Monitor booking volume and business activity.</p>
                    </div>
                    <div class="feature-card">
                        <h4>🏨 Occupancy Rate</h4>
                        <p><strong>What it shows:</strong> Active rooms / Total rooms.<br><br>
                        <strong>Example:</strong> 15 / 40 rooms occupied<br><br>
                        <strong>Use case:</strong> Understand room utilization and capacity planning.</p>
                    </div>
                </div>

                <div class="warning-box">
                    <strong>⚠️ Important:</strong> These metrics update only when you refresh the page. There is no real-time push notifications. Always refresh for current data.
                </div>
            </div>

            <!-- SECTION 3: ROOM MANAGEMENT SETUP -->
            <div class="card section-anchor" id="rooms-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--accent-color); display: flex; align-items: center; gap: 10px;">
                    🏨 Room Inventory Management - Complete Setup Guide
                </h3>

                <p style="background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%); padding: 15px; border-radius: var(--radius-lg); margin-bottom: 20px;">
                    Room management has TWO components: <strong>Room Categories</strong> (types with pricing) and <strong>Physical Rooms</strong> (actual room numbers in inventory).
                </p>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Part A: Creating Room Categories</h4>

                <div class="step-box">
                    <span class="step-number">1</span>
                    <strong>Navigate to Room Management</strong>
                    <p style="margin: 5px 0 0 42px;">Click "Room Management" in the sidebar → You'll see a two-column layout.</p>
                </div>

                <div class="step-box">
                    <span class="step-number">2</span>
                    <strong>Fill the Category Form (Left Column)</strong>
                    <p style="margin: 5px 0 0 42px;">
                        <strong>Category Name:</strong> e.g., "Standard Room", "Deluxe Suite", "Presidential Penthouse"<br>
                        <strong>Base Price (LKR):</strong> e.g., 8,500.00 (this is per night)<br>
                        <strong>Description:</strong> e.g., "Oceanfront suite with hot tub and garden view"<br>
                        → Click "✓ Create Category"
                    </p>
                </div>

                <div class="tip-box">
                    <strong>💡 Pricing Tip:</strong> The base price you set here is multiplied by the number of nights to calculate the subtotal. A 10% tax is automatically added. For a 3-night stay at 8,500 LKR:<br>
                    Subtotal = 8,500 × 3 = 25,500<br>
                    Tax (10%) = 2,550<br>
                    Total = 28,050 LKR
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Part B: Adding Physical Rooms to Inventory</h4>

                <div class="step-box">
                    <span class="step-number">3</span>
                    <strong>Create Physical Room Records</strong>
                    <p style="margin: 5px 0 0 42px;">
                        <strong>Room Number:</strong> e.g., "101", "205", "A-301" (use your hotel's numbering)<br>
                        <strong>Category:</strong> Select from dropdown (must create categories first)<br>
                        → Click "+ Add to Inventory"
                    </p>
                </div>

                <div class="step-box">
                    <span class="step-number">4</span>
                    <strong>Repeat for All Rooms</strong>
                    <p style="margin: 5px 0 0 42px;">
                        Add EVERY physical room you own. Example for a 40-room hotel:<br>
                        10 rooms as "Standard" (Category ID 1)<br>
                        20 rooms as "Deluxe" (Category ID 2)<br>
                        10 rooms as "Suite" (Category ID 3)
                    </p>
                </div>

                <div class="warning-box">
                    <strong>⚠️ Critical:</strong> Do NOT skip room numbers. If you tell staff "Room 105 is available" but it's not in the system, 
                    bookings will fail. Ensure your physical rooms table matches your actual property layout.
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Room Availability Logic</h4>
                <p>When staff (or you) try to make a reservation, the system checks:</p>
                <div class="code-block">
IF date range conflicts with existing CONFIRMED booking
    → Room marked as OCCUPIED (can't book)
ELSE IF room number exists in physical_rooms table
    → Room marked as AVAILABLE (can book)
ELSE
    → Error (room not found in system)
                </div>
            </div>

            <!-- SECTION 4: RESERVATIONS MANAGEMENT -->
            <div class="card section-anchor" id="reservations-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--success); display: flex; align-items: center; gap: 10px;">
                    📋 Reservations Management - Booking Workflow
                </h3>

                <p style="font-size: 0.95rem; color: var(--text-secondary); margin-bottom: 20px;">
                    This section covers the complete reservation lifecycle: viewing, creating, editing, and generating invoices.
                </p>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Viewing All Reservations</h4>

                <div class="step-box">
                    <span class="step-number">1</span>
                    <strong>Open Reservations Page</strong>
                    <p style="margin: 5px 0 0 42px;">Click "Reservations" in sidebar. You'll see a comprehensive table with all bookings.</p>
                </div>

                <h4 style="color: var(--text-secondary); font-size: 0.95rem; margin-top: 15px;">Table Columns Explained:</h4>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div style="padding: 12px; background: #f8fafc; border-radius: 4px;">
                        <strong>Reservation ID:</strong> Unique booking number (e.g., #1, #2, #3)
                    </div>
                    <div style="padding: 12px; background: #f8fafc; border-radius: 4px;">
                        <strong>Guest Info:</strong> Name + contact number
                    </div>
                    <div style="padding: 12px; background: #f8fafc; border-radius: 4px;">
                        <strong>Room Details:</strong> Room type + physical room number
                    </div>
                    <div style="padding: 12px; background: #f8fafc; border-radius: 4px;">
                        <strong>Check-In/Out:</strong> Booking dates
                    </div>
                    <div style="padding: 12px; background: #f8fafc; border-radius: 4px;">
                        <strong>Total Bill:</strong> LKR amount (base + 10% tax)
                    </div>
                    <div style="padding: 12px; background: #f8fafc; border-radius: 4px;">
                        <strong>Status:</strong> CONFIRMED / PENDING / CANCELLED
                    </div>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Creating a New Reservation (Advanced Method)</h4>

                <div class="step-box">
                    <span class="step-number">2</span>
                    <strong>Click "+ New Reservation" Button</strong>
                    <p style="margin: 5px 0 0 42px;">Opens a step-by-step booking wizard (STEP 1: Guest Details)</p>
                </div>

                <div class="step-box">
                    <span class="step-number">3</span>
                    <strong>STEP 1: Enter Guest Information</strong>
                    <p style="margin: 5px 0 0 42px;">
                        <strong>Guest Full Name:</strong> John Smith<br>
                        <strong>Contact Number:</strong> 10 digits exactly (e.g., 0712345678)<br>
                        <strong>Email (Optional):</strong> john@example.com<br>
                        <strong>Room Category:</strong> Select from dropdown<br>
                        <strong>Check-In Date:</strong> Today or future only<br>
                        <strong>Check-Out Date:</strong> Must be after Check-In<br>
                        → Click "Check for Specific Rooms"
                    </p>
                </div>

                <div class="step-box">
                    <span class="step-number">4</span>
                    <strong>STEP 2: Select Specific Room</strong>
                    <p style="margin: 5px 0 0 42px;">
                        You'll see a grid of all rooms in that category.<br>
                        <strong>Green rooms:</strong> Available for your dates → Click to book<br>
                        <strong>Red rooms:</strong> Already booked → Cannot select<br>
                        After selection, system calculates bill with 10% tax and confirms booking.
                    </p>
                </div>

                <div class="tip-box">
                    <strong>💡 Booking Tip:</strong> The system prevents double-booking. If a guest's check-in overlaps with 
                    an existing CONFIRMED booking, that room shows as unavailable. This ensures data consistency.
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Printing Invoices</h4>

                <div class="step-box">
                    <span class="step-number">5</span>
                    <strong>For CONFIRMED Reservations Only</strong>
                    <p style="margin: 5px 0 0 42px;">
                        A "🖨️ Print Bill" button appears only for CONFIRMED bookings.<br>
                        Click it to open a professional invoice in print view.<br>
                        Invoice shows:<br>
                        • Hotel letterhead<br>
                        • Guest details<br>
                        • Room & stay information<br>
                        • Subtotal + 10% tax breakdown<br>
                        • Grand total in LKR<br>
                        Press Ctrl+P (Cmd+P on Mac) to print or save as PDF.
                    </p>
                </div>

                <div class="warning-box">
                    <strong>⚠️ Important:</strong> PENDING bookings don't show print option. Only CONFIRMED bookings have formal invoices.
                </div>
            </div>

            <!-- SECTION 5: GUEST AUDIT & VIP MANAGEMENT -->
            <div class="card section-anchor" id="guests-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid #be185d; display: flex; align-items: center; gap: 10px;">
                    👥 Guest Relationship Audit & VIP Management
                </h3>

                <p style="font-size: 0.95rem; color: var(--text-secondary); margin-bottom: 20px;">
                    The Guest Audit portal provides customer intelligence for targeted marketing and VIP service strategies.
                </p>

                <div class="step-box">
                    <span class="step-number">1</span>
                    <strong>Open Guest Audit Portal</strong>
                    <p style="margin: 5px 0 0 42px;">Click "Guest Audit" in sidebar. You'll see a table with all guests and their metrics.</p>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Key Metrics Explained:</h4>
                <div class="feature-grid">
                    <div class="feature-card">
                        <h4>📊 Lifetime Value</h4>
                        <p>Total amount a guest has spent across ALL their bookings. Calculated as: Sum of all confirmed reservation amounts.</p>
                    </div>
                    <div class="feature-card">
                        <h4>🔄 Visit Frequency</h4>
                        <p>How many times a guest has visited. Counts confirmed bookings only. Helps identify loyal customers.</p>
                    </div>
                    <div class="feature-card">
                        <h4>⭐ Customer Tier</h4>
                        <p>Automatic segmentation based on spending and visits. VIP, Regular, or Standard classification.</p>
                    </div>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Understanding Customer Tiers:</h4>

                <div style="background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%); padding: 15px; border-radius: var(--radius-lg); border-left: 4px solid var(--success); margin: 15px 0;">
                    <div style="font-weight: 700; color: #065f46; font-size: 1.1rem; margin-bottom: 8px;">⭐ VIP Client</div>
                    <div style="color: #047857; font-size: 0.9rem;">
                        <strong>Criteria:</strong> Lifetime spending > LKR 100,000<br>
                        <strong>Why it matters:</strong> These are your most valuable customers. Consider loyalty rewards, exclusive perks, and personalized service.<br>
                        <strong>Action:</strong> Keep their contact info updated. Send special offers and early booking notifications.
                    </div>
                </div>

                <div style="background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%); padding: 15px; border-radius: var(--radius-lg); border-left: 4px solid var(--info); margin: 15px 0;">
                    <div style="font-weight: 700; color: #1e40af; font-size: 1.1rem; margin-bottom: 8px;">🔄 Regular Customer</div>
                    <div style="color: #1e3a8a; font-size: 0.9rem;">
                        <strong>Criteria:</strong> More than 2 visits (regardless of spending)<br>
                        <strong>Why it matters:</strong> These guests show loyalty patterns. They're likely to book again.<br>
                        <strong>Action:</strong> Offer returning customer discounts to encourage repeat bookings.
                    </div>
                </div>

                <div style="background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); padding: 15px; border-radius: var(--radius-lg); border-left: 4px solid var(--warning); margin: 15px 0;">
                    <div style="font-weight: 700; color: #92400e; font-size: 1.1rem; margin-bottom: 8px;">👤 Standard Guest</div>
                    <div style="color: #78350f; font-size: 0.9rem;">
                        <strong>Criteria:</strong> 1-2 visits or low lifetime spending<br>
                        <strong>Why it matters:</strong> New or occasional visitors. They could become regular or VIP with right experience.<br>
                        <strong>Action:</strong> Ensure excellent service to convert them to repeat customers.
                    </div>
                </div>

                <div class="tip-box">
                    <strong>💡 Marketing Insight:</strong> Use the Guest Audit to identify trends. For example, if 30% of your guests are VIP, focus on retention. 
                    If only 10% are VIP, focus on conversion strategies and premium offerings.
                </div>
            </div>

            <!-- SECTION 6: STAFF MANAGEMENT -->
            <div class="card section-anchor" id="staff-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--primary-color); display: flex; align-items: center; gap: 10px;">
                    👨‍💼 Staff Account Management & Role-Based Access Control
                </h3>

                <p style="background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%); padding: 15px; border-radius: var(--radius-lg); margin-bottom: 20px; border-left: 4px solid var(--danger);">
                    <strong>⚠️ Admin Access:</strong> Only you (ADMIN) have access to User Management. Staff cannot view or edit user accounts.
                </p>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Creating a New Staff Account</h4>

                <div class="step-box">
                    <span class="step-number">1</span>
                    <strong>Navigate to User Management</strong>
                    <p style="margin: 5px 0 0 42px;">Click "User Management" in sidebar. You'll see existing users on the left, create form on the right.</p>
                </div>

                <div class="step-box">
                    <span class="step-number">2</span>
                    <strong>Fill the User Creation Form</strong>
                    <p style="margin: 5px 0 0 42px;">
                        <strong>Full Name:</strong> e.g., "Priya Sharma" (display name)<br>
                        <strong>Username:</strong> e.g., "priya.sharma" (for login, must be unique)<br>
                        <strong>Password:</strong> e.g., "SecurePass@123" (will be hashed with BCrypt)<br>
                        <strong>Role:</strong> Select "👤 Staff Member" (limited access) or "🔐 Administrator" (full access)<br>
                        → Click "✓ Create User Account"
                    </p>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Role Comparison Matrix:</h4>

                <div style="overflow-x: auto; margin: 20px 0;">
                    <table style="width: 100%; border-collapse: collapse; background: white;">
                        <thead>
                            <tr style="background: #f1f5f9; border-bottom: 2px solid var(--primary-color);">
                                <th style="padding: 12px; text-align: left; font-weight: 700; color: var(--primary-color);">Feature</th>
                                <th style="padding: 12px; text-align: center; font-weight: 700; color: #047857;">STAFF</th>
                                <th style="padding: 12px; text-align: center; font-weight: 700; color: var(--danger);">ADMIN</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 12px;">View Dashboard</td>
                                <td style="padding: 12px; text-align: center;">✓ (Staff version)</td>
                                <td style="padding: 12px; text-align: center;">✓ (Full version)</td>
                            </tr>
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 12px;">View/Create Reservations</td>
                                <td style="padding: 12px; text-align: center;">✓</td>
                                <td style="padding: 12px; text-align: center;">✓</td>
                            </tr>
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 12px;">View Guest Audit</td>
                                <td style="padding: 12px; text-align: center;">✗</td>
                                <td style="padding: 12px; text-align: center;">✓</td>
                            </tr>
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 12px;">Manage Users</td>
                                <td style="padding: 12px; text-align: center;">✗</td>
                                <td style="padding: 12px; text-align: center;">✓</td>
                            </tr>
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 12px;">Manage Rooms</td>
                                <td style="padding: 12px; text-align: center;">✗</td>
                                <td style="padding: 12px; text-align: center;">✓</td>
                            </tr>
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 12px;">View Financials</td>
                                <td style="padding: 12px; text-align: center;">✗</td>
                                <td style="padding: 12px; text-align: center;">✓</td>
                            </tr>
                            <tr>
                                <td style="padding: 12px;">Access Admin Panel</td>
                                <td style="padding: 12px; text-align: center;">✗</td>
                                <td style="padding: 12px; text-align: center;">✓</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="warning-box">
                    <strong>⚠️ Security Notice:</strong> Passwords are hashed using BCrypt before storage. Even you (the admin) cannot see staff passwords. 
                    If a staff member forgets their password, create a new account with a temporary password and ask them to change it on first login.
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Editing Existing Users</h4>

                <div class="step-box">
                    <span class="step-number">3</span>
                    <strong>Click "⚙️ Edit" Button Next to User</strong>
                    <p style="margin: 5px 0 0 42px;">The form will populate with their current details.</p>
                </div>

                <div class="step-box">
                    <span class="step-number">4</span>
                    <strong>Modify Details and Update</strong>
                    <p style="margin: 5px 0 0 42px;">
                        You can update: Full Name, Username, Role<br>
                        <strong>Password field:</strong> Leave blank to keep current password. Fill to change it.<br>
                        → Click "✓ Update User Account"
                    </p>
                </div>
            </div>

            <!-- SECTION 7: FINANCIAL REPORTS -->
            <div class="card section-anchor" id="financials-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--warning); display: flex; align-items: center; gap: 10px;">
                    💰 Financial Reports & Revenue Analysis
                </h3>

                <p style="font-size: 0.95rem; color: var(--text-secondary); margin-bottom: 20px;">
                    The Financials page provides comprehensive revenue tracking, profitability analysis, and business intelligence.
                </p>

                <div class="step-box">
                    <span class="step-number">1</span>
                    <strong>Open Financials Page</strong>
                    <p style="margin: 5px 0 0 42px;">Click "Financials" in sidebar. Three sections appear: Gross Revenue, Monthly Trends, Top Rooms.</p>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Section 1: Gross Revenue Metric</h4>
                <p style="color: var(--text-secondary); margin-bottom: 15px;">
                    A single large card showing total revenue from ALL confirmed bookings. Updated in real-time when you refresh.
                </p>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Section 2: Monthly Financial Growth (Table)</h4>
                <p style="color: var(--text-secondary); margin-bottom: 15px;">
                    Shows revenue by month. Helps identify seasonal trends:
                </p>

                <div style="background: #f8fafc; padding: 15px; border-radius: 4px; margin-bottom: 15px;">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; font-size: 0.9rem;">
                        <div><strong>January 2026:</strong> LKR 450,000</div>
                        <div><strong>February 2026:</strong> LKR 625,000</div>
                        <div><strong>March 2026:</strong> LKR 510,000</div>
                        <div><strong>April 2026:</strong> LKR 785,000</div>
                    </div>
                    <p style="margin-top: 12px; color: var(--text-secondary); font-size: 0.85rem;">
                        💡 <strong>Insight:</strong> April shows highest revenue. Plan marketing and room availability accordingly for similar months in future years.
                    </p>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Section 3: Top Performing Rooms (Profitability Analysis)</h4>
                <p style="color: var(--text-secondary); margin-bottom: 15px;">
                    Lists rooms ranked by total revenue generated. Useful for identifying which room types are most profitable:
                </p>

                <div style="background: #f8fafc; padding: 15px; border-radius: 4px; margin-bottom: 15px;">
                    <table style="width: 100%; border-collapse: collapse;">
                        <tr style="border-bottom: 1px solid #e2e8f0;">
                            <td style="padding: 8px; font-weight: 600;">Room #105</td>
                            <td style="padding: 8px;">Deluxe Suite</td>
                            <td style="padding: 8px; text-align: right; color: var(--success); font-weight: 700;">LKR 125,000</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #e2e8f0;">
                            <td style="padding: 8px; font-weight: 600;">Room #201</td>
                            <td style="padding: 8px;">Presidential Suite</td>
                            <td style="padding: 8px; text-align: right; color: var(--success); font-weight: 700;">LKR 180,000</td>
                        </tr>
                        <tr>
                            <td style="padding: 8px; font-weight: 600;">Room #302</td>
                            <td style="padding: 8px;">Standard Room</td>
                            <td style="padding: 8px; text-align: right; color: var(--success); font-weight: 700;">LKR 95,000</td>
                        </tr>
                    </table>
                </div>

                <div class="tip-box">
                    <strong>💡 Business Insight:</strong> If Room #201 generates 60% more revenue than Room #105 despite same category, 
                    consider: Better location? Premium view? Use this data to optimize room assignments and pricing strategies.
                </div>
            </div>

            <!-- SECTION 8: SECURITY & BEST PRACTICES -->
            <div class="card section-anchor" id="security-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--success); display: flex; align-items: center; gap: 10px;">
                    🔐 Security Best Practices & System Architecture
                </h3>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Authentication & Authorization</h4>

                <div style="background: linear-gradient(135deg, #dbeafe 0%, #e0f2fe 100%); padding: 15px; border-radius: var(--radius-lg); border-left: 4px solid var(--primary-color); margin: 15px 0;">
                    <div style="font-weight: 700; color: var(--primary-color); margin-bottom: 8px;">🔐 Password Security</div>
                    <div style="color: var(--text-secondary); font-size: 0.9rem; line-height: 1.6;">
                        <strong>Algorithm:</strong> BCrypt with salt<br>
                        <strong>What it means:</strong> Passwords are never stored as plain text. Each password is transformed using BCrypt, making it extremely difficult to reverse.<br>
                        <strong>Your responsibility:</strong> Never share your admin password. Change it regularly. Never ask staff for their passwords.
                    </div>
                </div>

                <div style="background: linear-gradient(135deg, #dcfce7 0%, #d1fae5 100%); padding: 15px; border-radius: var(--radius-lg); border-left: 4px solid var(--success); margin: 15px 0;">
                    <div style="font-weight: 700; color: #065f46; margin-bottom: 8px;">👥 Role-Based Access Control (RBAC)</div>
                    <div style="color: var(--text-secondary); font-size: 0.9rem; line-height: 1.6;">
                        <strong>How it works:</strong> Each user has a role (ADMIN or STAFF) stored in database. Every page checks your role before displaying.<br>
                        <strong>Example:</strong> Staff cannot visit /admin/financials. The system redirects them to their staff dashboard.<br>
                        <strong>Your responsibility:</strong> Assign roles carefully. Only create ADMIN accounts for trusted team members.
                    </div>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Session Management</h4>

                <div style="background: linear-gradient(135deg, #fef3c7 0%, #fef9c3 100%); padding: 15px; border-radius: var(--radius-lg); border-left: 4px solid var(--warning); margin: 15px 0;">
                    <div style="font-weight: 700; color: #92400e; margin-bottom: 8px;">⏱️ Session Timeout</div>
                    <div style="color: var(--text-secondary); font-size: 0.9rem; line-height: 1.6;">
                        <strong>Duration:</strong> 30 minutes of inactivity<br>
                        <strong>What happens:</strong> After 30 minutes without action, your session expires. You're automatically logged out and must log in again.<br>
                        <strong>Why:</strong> Protects against unauthorized access if you leave your computer unattended.
                    </div>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">System Architecture Overview</h4>

                <div style="background: #1e293b; color: #e2e8f0; padding: 20px; border-radius: var(--radius-lg); margin: 15px 0;">
                    <div style="margin-bottom: 15px;">
                        <div style="font-weight: 700; color: #60a5fa;">🗄️ Database Layer</div>
                        <div style="font-size: 0.9rem; color: #cbd5e1; margin-top: 5px;">MySQL 8.0+ with 5 tables:</div>
                        <div style="font-size: 0.85rem; color: #94a3b8; padding-left: 15px; margin-top: 8px;">
                            • users (login credentials, roles)<br>
                            • guests (guest names, contacts)<br>
                            • room_types (categories like Standard, Suite)<br>
                            • rooms (physical inventory: room numbers)<br>
                            • reservations (bookings: dates, amounts, status)
                        </div>
                    </div>
                    <div style="margin-bottom: 15px;">
                        <div style="font-weight: 700; color: #34d399;">⚙️ Application Layer</div>
                        <div style="font-size: 0.9rem; color: #cbd5e1; margin-top: 5px;">Java Servlets with DAO (Data Access Object) pattern</div>
                        <div style="font-size: 0.85rem; color: #94a3b8; padding-left: 15px; margin-top: 8px;">
                            Handles business logic: availability checks, price calculations, tax computation
                        </div>
                    </div>
                    <div>
                        <div style="font-weight: 700; color: #fbbf24;">🎨 Presentation Layer</div>
                        <div style="font-size: 0.9rem; color: #cbd5e1; margin-top: 5px;">JSP (Java Server Pages) + JSTL (Java Standard Tag Library)</div>
                        <div style="font-size: 0.85rem; color: #94a3b8; padding-left: 15px; margin-top: 8px;">
                            Renders HTML with dynamic data (JSTL for loops, conditionals)
                        </div>
                    </div>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Important Security Rules</h4>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin: 15px 0;">
                    <div style="padding: 12px; background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%); border-radius: 4px; border-left: 4px solid var(--danger);">
                        <strong style="color: #991b1b;">❌ DO NOT:</strong>
                        <p style="margin: 8px 0 0 0; font-size: 0.85rem; color: #7f1d1d;">
                            Share your admin credentials<br>
                            Store passwords in plain text<br>
                            Use weak passwords<br>
                            Leave system unattended
                        </p>
                    </div>
                    <div style="padding: 12px; background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%); border-radius: 4px; border-left: 4px solid var(--success);">
                        <strong style="color: #065f46;">✓ DO:</strong>
                        <p style="margin: 8px 0 0 0; font-size: 0.85rem; color: #047857;">
                            Change password monthly<br>
                            Use strong passwords (12+ chars)<br>
                            Audit user accounts regularly<br>
                            Log out when finished
                        </p>
                    </div>
                </div>
            </div>

            <!-- SECTION 9: TROUBLESHOOTING & FAQ -->
            <div class="card section-anchor" id="troubleshooting-section" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--accent-color); display: flex; align-items: center; gap: 10px;">
                    🔧 Troubleshooting & Frequently Asked Questions
                </h3>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Q1: "No rooms available for my selected dates"</h4>
                <p style="color: var(--text-secondary); margin-bottom: 10px;">
                    <strong>Possible causes & solutions:</strong>
                </p>
                <ul style="color: var(--text-secondary); line-height: 1.8; padding-left: 24px; margin-bottom: 20px;">
                    <li><strong>Room doesn't exist in system:</strong> Go to Room Management → add physical rooms for that category</li>
                    <li><strong>All rooms booked:</strong> Check Reservations page for overlapping CONFIRMED bookings. System blocks occupied rooms.</li>
                    <li><strong>Wrong category selected:</strong> Verify you selected the correct room type in the booking form</li>
                </ul>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Q2: "I can't see Financials or Guest Audit"</h4>
                <p style="color: var(--text-secondary); margin-bottom: 10px;">
                    <strong>Possible cause:</strong> You might be logged in as STAFF, not ADMIN.
                </p>
                <p style="color: var(--text-secondary); margin-bottom: 20px;">
                    <strong>Solution:</strong> Contact your system administrator and request ADMIN role upgrade.
                </p>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Q3: "How do I reset a staff member's password?"</h4>
                <p style="color: var(--text-secondary); margin-bottom: 10px;">
                    <strong>Process:</strong>
                </p>
                <ul style="color: var(--text-secondary); line-height: 1.8; padding-left: 24px; margin-bottom: 20px;">
                    <li>Go to User Management</li>
                    <li>Click "⚙️ Edit" next to their name</li>
                    <li>Enter a new temporary password in the password field</li>
                    <li>Click "✓ Update User Account"</li>
                    <li>Share the temporary password with them securely</li>
                    <li>Ask them to change it on their first login</li>
                </ul>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Q4: "What does 'Status: PENDING' vs 'Status: CONFIRMED' mean?"</h4>
                <p style="color: var(--text-secondary); margin-bottom: 10px;">
                    <strong>Status Meanings:</strong>
                </p>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin: 15px 0;">
                    <div style="padding: 12px; background: #fef9c3; border-radius: 4px; border-left: 4px solid var(--warning);">
                        <div style="font-weight: 700; color: var(--warning);">🟡 PENDING</div>
                        <p style="margin: 8px 0 0 0; font-size: 0.85rem; color: var(--text-secondary);">
                            Booking exists but not yet confirmed. Guest hasn't completed payment or provided all details.<br><br>
                            <strong>Bill visible:</strong> No (PENDING bookings don't have print option)
                        </p>
                    </div>
                    <div style="padding: 12px; background: #d1fae5; border-radius: 4px; border-left: 4px solid var(--success);">
                        <div style="font-weight: 700; color: var(--success);">🟢 CONFIRMED</div>
                        <p style="margin: 8px 0 0 0; font-size: 0.85rem; color: var(--text-secondary);">
                            Booking is finalized. Room is reserved and payment is secure.<br><br>
                            <strong>Bill visible:</strong> Yes (can print professional invoice)
                        </p>
                    </div>
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Q5: "How is the bill calculated?"</h4>
                <p style="color: var(--text-secondary); margin-bottom: 10px;">
                    <strong>Calculation Formula:</strong>
                </p>
                <div class="code-block">
Number of Nights = Check-Out Date - Check-In Date
Subtotal = Room Base Price × Number of Nights
Tax (10%) = Subtotal × 0.10
Grand Total = Subtotal + Tax

Example:
Room: Deluxe Suite (Base Price: LKR 10,000/night)
Check-In: Feb 11, 2026
Check-Out: Feb 14, 2026
Nights: 3
---
Subtotal = 10,000 × 3 = LKR 30,000
Tax = 30,000 × 0.10 = LKR 3,000
Grand Total = LKR 33,000
                </div>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Q6: "I accidentally cancelled a reservation. Can I undo it?"</h4>
                <p style="color: var(--text-secondary); margin-bottom: 10px;">
                    <strong>Short answer:</strong> Not directly through the UI. CANCELLED reservations are marked in the system and cannot be reverted automatically.
                </p>
                <p style="color: var(--text-secondary); margin-bottom: 20px;">
                    <strong>Solution:</strong> Create a new reservation with the same guest and dates. This bypasses the cancelled record.
                </p>

                <h4 style="color: var(--primary-color); margin-top: 25px;">Q7: "Why does the dashboard show old data?"</h4>
                <p style="color: var(--text-secondary); margin-bottom: 10px;">
                    <strong>Reason:</strong> The system doesn't auto-refresh. Data updates only when you refresh the page (F5 or Cmd+R).
                </p>
                <p style="color: var(--text-secondary); margin-bottom: 20px;">
                    <strong>Solution:</strong> Refresh your browser to see the latest metrics.
                </p>

                <div class="warning-box">
                    <strong>⚠️ Contact Support:</strong> If you encounter issues not covered here, contact your system administrator or developer team. 
                    Provide specific details: What were you trying to do? What error message appeared? When did this happen?
                </div>
            </div>
        </main>
    </div>
</body>
</html>