<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guest Audit | Ocean View Admin</title>
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
                <a href="guestAudit" class="active">👥 Guest Audit</a>
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
                    <h2>Guest Relationship Audit</h2>
                    <p>Customer lifetime value and behavioral intelligence</p>
                </div>
            </header>

            <div class="card">
                <div class="info-box">
                    <h4>📊 Customer Intelligence Overview</h4>
                    <p>
                        This audit provides insights into guest behavior patterns, identifies VIP clients based on lifetime value,
                        and helps optimize marketing strategies for repeat business. Customer segmentation is automatically
                        calculated based on spending and visit frequency.
                    </p>
                </div>

                <div class="table-container" style="margin-top: 24px;">
                    <table>
                        <thead>
                            <tr>
                                <th>Guest Identity</th>
                                <th>Contact Information</th>
                                <th style="text-align: center;">Visit Frequency</th>
                                <th style="text-align: right;">Lifetime Value</th>
                                <th style="text-align: center;">Customer Tier</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="g" items="${guestReport}">
                                <tr>
                                    <td>
                                        <div style="font-weight: 700; color: var(--primary-color); font-size: 1.05rem;">
                                            ${g.name}
                                        </div>
                                    </td>
                                    <td>
                                        <div style="line-height: 1.6;">
                                            <div style="font-weight: 500; color: var(--text-main);">📞 ${g.contact}</div>
                                            <div style="color: var(--text-secondary); font-size: 0.9rem;">✉️ ${g.email}</div>
                                        </div>
                                    </td>
                                    <td style="text-align: center;">
                                        <span class="badge badge-info">
                                            ${g.visits} visit<c:if test="${g.visits != 1}">s</c:if>
                                        </span>
                                    </td>
                                    <td style="text-align: right;">
                                        <div style="font-weight: 700; color: var(--success); font-size: 1.1rem;">
                                            LKR <fmt:formatNumber value="${g.spent}" pattern="#,###.00"/>
                                        </div>
                                    </td>
                                    <td style="text-align: center;">
                                        <c:choose>
                                            <c:when test="${g.spent > 100000}">
                                                <span class="badge badge-success">⭐ VIP Client</span>
                                            </c:when>
                                            <c:when test="${g.visits > 2}">
                                                <span class="badge badge-info">🔄 Regular</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning">👤 Standard</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <c:if test="${empty guestReport}">
                        <div class="empty-state">
                            <div class="empty-state-icon">👥</div>
                            <h3>No Guest Data Available</h3>
                            <p>Guest information will appear here once bookings are made.</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- CUSTOMER SEGMENTATION LEGEND -->
            <div class="card" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #f0f0f0; display: flex; align-items: center; gap: 10px;">
                    🎯 Customer Segmentation Criteria
                </h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;">
                    <div style="padding: 1.25rem; background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%); border-radius: var(--radius-lg); border-left: 4px solid var(--success);">
                        <div style="font-weight: 700; color: #065f46; margin-bottom: 8px; font-size: 1.1rem;">⭐ VIP Client</div>
                        <div style="color: #047857; font-size: 0.9rem;">Lifetime spend > LKR 100,000</div>
                    </div>
                    <div style="padding: 1.25rem; background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%); border-radius: var(--radius-lg); border-left: 4px solid var(--info);">
                        <div style="font-weight: 700; color: #1e40af; margin-bottom: 8px; font-size: 1.1rem;">🔄 Regular Customer</div>
                        <div style="color: #1e3a8a; font-size: 0.9rem;">More than 2 visits</div>
                    </div>
                    <div style="padding: 1.25rem; background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); border-radius: var(--radius-lg); border-left: 4px solid var(--warning);">
                        <div style="font-weight: 700; color: #92400e; margin-bottom: 8px; font-size: 1.1rem;">👤 Standard Guest</div>
                        <div style="color: #78350f; font-size: 0.9rem;">New or occasional visitor</div>
                    </div>
                </div>
            </div>

            <!-- DATA SOURCE FOOTER -->
            <div class="info-box" style="margin-top: 2.5rem;">
                <h4>📌 Audit Intelligence</h4>
                <p>
                    <strong>Powered By:</strong> 5-table JOIN analysis (guests + reservations) |
                    <strong>Segmentation:</strong> VIP (>LKR 100K), Regular (>2 visits), Standard |
                    <strong>Metrics:</strong> Lifetime value, visit frequency, contact history
                </p>
            </div>
        </main>
    </div>
</body>
</html>