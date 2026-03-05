<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management | Ocean View Resort</title>
    <link rel="stylesheet" href="../assets/style.css">
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
                <a href="roomManagement" class="active">🏨 Room Management</a>
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
                    <h2>Room Inventory Control</h2>
                    <p>Manage room categories and physical inventory</p>
                </div>
            </header>
             
            <!-- Flash Messages -->
            <c:if test="${not empty sessionScope.flashMessage}">
                <div class="alert alert-${sessionScope.flashType}">
                    <c:out value="${sessionScope.flashMessage}" />
                </div>
                <c:remove var="flashMessage" scope="session"/>
                <c:remove var="flashType" scope="session"/>
            </c:if>

            <!-- TWO-COLUMN LAYOUT: Categories vs Physical Inventory -->
            <div style="display:grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
                
                <!-- ====== SECTION 1: MANAGE CATEGORIES ====== -->
                <div class="card">
                    <h3 style="padding-bottom: 15px; margin-bottom: 20px; border-bottom: 3px solid var(--primary-color); display: flex; align-items: center; gap: 10px;">
                        🏷️ Room Categories
                    </h3>
                    
                    <!-- CREATE CATEGORY FORM -->
                    <form action="roomManagement" method="POST" style="background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); padding: 20px; border-radius: var(--radius-lg); margin-bottom: 24px; border: 1px solid #e2e8f0;">
                        <input type="hidden" name="action" value="createType">
                        <h4 style="margin-bottom: 18px; color: var(--text-main); font-size: 1.05rem;">➕ Create New Category</h4>
                        
                        <div class="form-group">
                            <label>📝 Category Name</label>
                            <input type="text" name="typeName" placeholder="e.g., Penthouse, Suite, Standard" required>
                        </div>
                        <div class="form-group">
                            <label>💵 Base Price (LKR)</label>
                            <input type="number" step="0.01" name="basePrice" placeholder="e.g., 15000.00" required>
                        </div>
                        <div class="form-group">
                            <label>📄 Description</label>
                            <textarea name="description" placeholder="e.g., A luxurious room with ocean view" rows="3"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">✓ Create Category</button>
                    </form>

                    <!-- CATEGORIES TABLE -->
                    <div>
                        <h4 style="margin-bottom: 15px; color: var(--text-secondary); font-size: 0.95rem; font-weight: 600;">
                            📋 Existing Categories
                        </h4>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Category</th>
                                        <th style="text-align: right;">Price (LKR)</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="type" items="${roomTypes}">
                                        <tr>
                                            <td><span class="badge badge-info">${type.name}</span></td>
                                            <td style="text-align: right; font-weight: 700; color: var(--success);">
                                                <fmt:formatNumber value="${type.basePrice}" pattern="#,###.00"/>
                                            </td>
                                            <td style="font-size: 0.9rem; color: var(--text-secondary);">${type.description}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${empty roomTypes}">
                                <div class="empty-state">
                                    <div class="empty-state-icon">🏷️</div>
                                    <p>No categories created yet</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- ====== SECTION 2: MANAGE PHYSICAL INVENTORY ====== -->
                <div class="card">
                    <h3 style="padding-bottom: 15px; margin-bottom: 20px; border-bottom: 3px solid var(--accent-color); display: flex; align-items: center; gap: 10px;">
                        🔑 Physical Inventory
                    </h3>
                    
                    <!-- ADD PHYSICAL ROOM FORM -->
                    <form action="roomManagement" method="POST" style="background: linear-gradient(135deg, #fef3c7 0%, #fde68a 30%, #fef3c7 100%); padding: 20px; border-radius: var(--radius-lg); margin-bottom: 24px; border: 1px solid #fbbf24;">
                        <input type="hidden" name="action" value="addPhysical">
                        <h4 style="margin-bottom: 18px; color: #78350f; font-size: 1.05rem;">➕ Add Physical Room</h4>
                        
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                            <div class="form-group">
                                <label>🚪 Room Number</label>
                                <input type="text" name="roomNumber" placeholder="e.g., 305, A101" required>
                            </div>
                            <div class="form-group">
                                <label>🏷️ Category</label>
                                <select name="typeId" required>
                                    <option value="">Select Category...</option>
                                    <c:forEach var="type" items="${roomTypes}">
                                        <option value="${type.typeId}">${type.name} (LKR <fmt:formatNumber value="${type.basePrice}" pattern="#,###"/>)</option>
                                    </c:forEach>
                                    <c:if test="${empty roomTypes}">
                                        <option disabled>No categories available</option>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-accent btn-block" <c:if test="${empty roomTypes}">disabled</c:if>>
                            + Add to Inventory
                        </button>
                    </form>

                    <!-- PHYSICAL ROOMS TABLE -->
                    <div>
                        <h4 style="margin-bottom: 15px; color: var(--text-secondary); font-size: 0.95rem; font-weight: 600;">
                            📦 Room Inventory 
                            <span class="badge badge-success" style="font-size: 0.8rem; margin-left: 8px;">
                                <c:out value="${physicalRooms.size()}" default="0" /> rooms
                            </span>
                        </h4>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Room #</th>
                                        <th>Category</th>
                                        <th style="text-align: center;">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="room" items="${physicalRooms}">
                                        <tr>
                                            <td>
                                                <span style="font-weight: 700; color: var(--primary-color); font-size: 1.05rem;">
                                                    ${room.roomNumber}
                                                </span>
                                            </td>
                                            <td style="font-weight: 500;">${room.roomTypeName}</td>
                                            <td style="text-align: center;">
                                                <span class="badge badge-success">${room.status}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${empty physicalRooms}">
                                <div class="empty-state">
                                    <div class="empty-state-icon">🔑</div>
                                    <p>No physical rooms added yet</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- DATABASE SCHEMA INFO -->
            <div class="info-box" style="margin-top: 2.5rem;">
                <h4>📊 Database Architecture</h4>
                <p>
                    Room Categories stored in <code style="background: #e2e8f0; padding: 2px 6px; border-radius: 4px; font-family: var(--font-mono);">room_types</code> table | 
                    Physical Rooms stored in <code style="background: #e2e8f0; padding: 2px 6px; border-radius: 4px; font-family: var(--font-mono);">rooms</code> table with foreign key to category
                </p>
            </div>
        </main>
    </div>
</body>
</html>