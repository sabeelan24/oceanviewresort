<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financials | Ocean View Resort</title>
    <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="sidebar-header">OCEAN VIEW</div>
            <nav class="sidebar-nav">
                <a href="dashboard">📊 Strategic Dashboard</a>
                <a href="reservations">📋 Reservations</a>
                <a href="guestAudit">👥 Guest Audit</a>
                <a href="userManagement">🔐 User Management</a>
                <a href="roomManagement">🏨 Room Management</a>
                <a href="financials" class="active">💰 Financials</a>
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
                    <h2>Financial Analytics & Reports</h2>
                    <p>Detailed revenue insights and performance metrics</p>
                </div>
            </header>
            
            <!-- KEY FINANCIAL METRICS -->
            <div class="stats-grid">
                <div class="card stat-card">
                    <h3>💰 Gross Revenue</h3>
                    <div class="value">LKR <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/></div>
                    <p>From confirmed bookings</p>
                </div>
            </div>

            <!-- FINANCIAL TABLES -->
            <div style="display:grid; grid-template-columns: 1.5fr 1fr; gap: 2rem; margin-top:2rem;">
                
                <!-- MONTHLY REVENUE TREND -->
                <div class="card">
                    <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #f0f0f0; display: flex; align-items: center; gap: 10px;">
                        📈 Monthly Financial Growth
                    </h3>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Financial Month</th>
                                    <th style="text-align: right;">Revenue Collected</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trend" items="${monthlyTrend}">
                                    <tr>
                                        <td style="font-weight: 600;">${trend.key}</td>
                                        <td style="text-align: right; font-weight: 700; color: var(--success);">
                                            LKR <fmt:formatNumber value="${trend.value}" pattern="#,###.00"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty monthlyTrend}">
                                    <tr>
                                        <td colspan="2" class="empty-state">
                                            <div class="empty-state-icon">📭</div>
                                            <p>No historical data available yet</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- ROOM PROFITABILITY AUDIT -->
                <div class="card">
                    <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #f0f0f0; display: flex; align-items: center; gap: 10px;">
                        🏆 Top Performing Rooms
                    </h3>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Room #</th>
                                    <th>Type</th>
                                    <th style="text-align: right;">Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${roomReport}" end="4">
                                    <tr>
                                        <td><span class="badge badge-info">${room.roomNumber}</span></td>
                                        <td style="font-weight: 500;">${room.typeName}</td>
                                        <td style="text-align: right; font-weight: 700; color: var(--primary-color);">
                                            LKR <fmt:formatNumber value="${room.revenue}" pattern="#,###"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty roomReport}">
                                    <tr>
                                        <td colspan="3" class="empty-state">
                                            <div class="empty-state-icon">🏨</div>
                                            <p>No room performance data</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- REVENUE DISTRIBUTION CHART -->
            <div class="card" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #f0f0f0; display: flex; align-items: center; gap: 10px;">
                    📊 Revenue Distribution by Room Category
                </h3>
                
                <div style="margin-top: 20px;">
                    <c:if test="${not empty revenueChartData and revenueChartData.size() > 0}">
                        <c:forEach var="entry" items="${revenueChartData}">
                            <div style="margin-bottom: 24px;">
                                <div style="display:flex; justify-content:space-between; font-size:0.95rem; margin-bottom:10px;">
                                    <strong style="color: var(--text-main); font-weight: 600;">${entry.key}</strong>
                                    <span style="font-weight: 700; color: var(--primary-color);">
                                        LKR <fmt:formatNumber value="${entry.value}" pattern="#,###.00"/>
                                    </span>
                                </div>
                                
                                <div class="progress-bar">
                                    <div class="progress-bar-fill" style="width: ${(entry.value / totalRevenue) * 100}%;">
                                        <c:if test="${(entry.value / totalRevenue) * 100 > 10}">
                                            <span style="color: white; font-size: 0.75rem; padding-right: 10px; font-weight: 700;">
                                                <fmt:formatNumber value="${(entry.value / totalRevenue) * 100}" maxFractionDigits="0"/>%
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    
                    <c:if test="${empty revenueChartData or revenueChartData.size() == 0}">
                        <div class="empty-state">
                            <div class="empty-state-icon">📊</div>
                            <h3>No Revenue Data Available</h3>
                            <p>Confirmed bookings will appear here</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- DATA SOURCE FOOTER -->
            <div class="info-box" style="margin-top: 2.5rem;">
                <h4>📌 Financial Intelligence</h4>
                <p>
                    <strong>Powered By:</strong> ReportDAO aggregations | 
                    <strong>Schema:</strong> Revenue calculations from bookings and room data |
                    <strong>Real-time Updates:</strong> On page refresh
                </p>
            </div>
        </main>
    </div>
</body>
</html>