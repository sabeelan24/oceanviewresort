<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management | Ocean View Resort</title>
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
                <a href="userManagement" class="active">🔐 User Management</a>
                <a href="roomManagement">🏨 Room Management</a>
                <a href="financials">💰 Financials</a>
                <a href="help.jsp">💡 Help & Docs</a>
            </nav>
            <div class="sidebar-footer">
                <a href="../logout">🚪 Logout</a>
            </div>
        </div>

        <main class="main-content">
            <header class="top-bar">
                <div class="page-title">
                    <h2>Staff Account Management</h2>
                    <p>Manage user accounts and role-based access control</p>
                </div>
            </header>

            <div style="display:grid; grid-template-columns: 2fr 1fr; gap: 2rem;">
                <div class="card">
                    <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--primary-color); display: flex; align-items: center; gap: 10px;">
                        👥 System Users
                    </h3>
                    <div class="table-container">
                        <table>
                           <thead>
                               <tr>
                                   <th>Full Name</th>
                                   <th>Username</th>
                                   <th>Role</th>
                                   <th>Status</th>
                                   <th>Actions</th>
                               </tr>
                           </thead>
                           <tbody>
                               <c:forEach var="user" items="${users}">
                                   <tr>
                                       <td>
                                           <div style="font-weight: 600; color: var(--text-main);">
                                               <c:out value="${user.fullName}" />
                                           </div>
                                       </td>
                                       <td>
                                           <code style="background: #f1f5f9; padding: 4px 8px; border-radius: 4px; font-family: var(--font-mono); font-size: 0.85rem;">
                                               <c:out value="${user.username}" />
                                           </code>
                                       </td>
                                       <td>
                                           <c:choose>
                                               <c:when test="${user.role == 'ADMIN'}">
                                                   <span class="badge badge-danger">🔐 <c:out value="${user.role}" /></span>
                                               </c:when>
                                               <c:otherwise>
                                                   <span class="badge badge-info">👤 <c:out value="${user.role}" /></span>
                                               </c:otherwise>
                                           </c:choose>
                                       </td>
                                       <td><span class="badge badge-success">✓ Active</span></td>
                                       <td>
                                           <a href="userManagement?action=edit&id=${user.id}" class="btn" style="background: linear-gradient(135deg, #f1f5f9, #e2e8f0); color: var(--text-main); font-size: 0.8rem; padding: 8px 14px; text-decoration: none; display: inline-block;">⚙️ Edit</a>
                                       </td>
                                   </tr>
                               </c:forEach>
                           </tbody>
                        </table>
                        <c:if test="${empty users}">
                            <div class="empty-state">
                                <div class="empty-state-icon">👥</div>
                                <h3>No Users Found</h3>
                                <p>Create your first user account</p>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="card">
                    <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 3px solid var(--accent-color); display: flex; align-items: center; gap: 10px;">
                        <c:choose>
                            <c:when test="${not empty userToEdit}">✏️ Edit User</c:when>
                            <c:otherwise>➕ Create New User</c:otherwise>
                        </c:choose>
                    </h3>
                    <form action="userManagement" method="POST">
                        <input type="hidden" name="action" value="${not empty userToEdit ? 'update' : 'create'}">
                        <c:if test="${not empty userToEdit}">
                            <input type="hidden" name="id" value="${userToEdit.id}">
                        </c:if>
                        <div class="form-group">
                            <label>👤 Full Name</label>
                            <input type="text" name="fullName" value="${userToEdit.fullName}" placeholder="John Doe" required>
                        </div>
                        <div class="form-group">
                            <label>📝 Username</label>
                            <input type="text" name="username" value="${userToEdit.username}" placeholder="johndoe" required>
                        </div>
                        <div class="form-group">
                            <label>🔒 Password <c:if test="${not empty userToEdit}">(leave blank to keep current)</c:if></label>
                            <input type="password" name="password" placeholder="Strong password" <c:if test="${empty userToEdit}">required</c:if>>
                        </div>
                        <div class="form-group">
                            <label>🎯 Role</label>
                            <select name="role">
                                <option value="STAFF" ${userToEdit.role == 'STAFF' ? 'selected' : ''}>👤 Staff Member</option>
                                <option value="ADMIN" ${userToEdit.role == 'ADMIN' ? 'selected' : ''}>🔐 Administrator</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">
                            <c:choose>
                                <c:when test="${not empty userToEdit}">✓ Update User Account</c:when>
                                <c:otherwise>✓ Create User Account</c:otherwise>
                            </c:choose>
                        </button>
                    </form>
                    <div style="margin-top: 24px; padding: 16px; background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); border-radius: var(--radius-lg); border-left: 4px solid var(--warning);">
                        <div style="font-weight: 700; color: #78350f; margin-bottom: 6px; font-size: 0.9rem;">🔐 Security Notice</div>
                        <div style="color: #92400e; font-size: 0.85rem; line-height: 1.5;">Passwords are automatically hashed using BCrypt. Admin role grants full system access.</div>
                    </div>
                </div>
            </div>
            <div class="card" style="margin-top: 2rem;">
                <h3 style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #f0f0f0; display: flex; align-items: center; gap: 10px;">🔑 Role-Based Access Control (RBAC)</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem;">
                    <div style="padding: 1.5rem; background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%); border-radius: var(--radius-lg); border-left: 4px solid var(--danger);">
                        <div style="font-weight: 700; color: #7f1d1d; margin-bottom: 12px; font-size: 1.1rem;">🔐 Administrator</div>
                        <ul style="color: #991b1b; font-size: 0.9rem; line-height: 1.8; padding-left: 20px;">
                            <li>Full system access</li>
                            <li>Manage users & roles</li>
                            <li>View all reports & analytics</li>
                            <li>Configure room inventory</li>
                        </ul>
                    </div>
                    <div style="padding: 1.5rem; background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%); border-radius: var(--radius-lg); border-left: 4px solid var(--info);">
                        <div style="font-weight: 700; color: #1e3a8a; margin-bottom: 12px; font-size: 1.1rem;">👤 Staff Member</div>
                        <ul style="color: #1e40af; font-size: 0.9rem; line-height: 1.8; padding-left: 20px;">
                            <li>Create & manage reservations</li>
                            <li>Check room availability</li>
                            <li>View staff dashboard</li>
                            <li>Limited to operational tasks</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="info-box" style="margin-top: 2.5rem;">
                <h4>🛡️ Security & Compliance</h4>
                <p><strong>Password Hashing:</strong> BCrypt with salt | <strong>Session Management:</strong> HttpSession with timeout | <strong>Access Control:</strong> SecurityFilter middleware | <strong>Audit Trail:</strong> All actions logged</p>
            </div>
        </main>
    </div>
</body>
</html>
