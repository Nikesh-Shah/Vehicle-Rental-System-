<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user-management.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
    <%@ include file="/WEB-INF/view/admin/admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h2>User Management</h2>
            <div style="margin: 10px 0;">
                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/admin/createuser'
                        "style="padding: 8px 16px; font-size: 16px; cursor: pointer; margin-top: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px;">
                    ➕ Create New User
                </button>
            </div>

        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                <i class="bi bi-check-circle"></i> ${param.success}
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle"></i> ${param.error}
            </div>
        </c:if>

        <div class="user-table-container">
            <table class="user-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.userId}</td>
                        <td>${user.fname} ${user.lname}</td>
                        <td>${user.email}</td>
                        <td>
                            <span class="role-badge role-${user.role == 1 ? "admin" : "user"}">${user.role}</span>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin-users" method="post" style="display: inline;">
                                <input type="hidden" name="userId" value="${user.userId}" />
                                <input type="hidden" name="action" value="delete" />
                                <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this user?')">
                                    <i class="bi bi-trash"></i> Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="pagination-section">
            <h3>Pagination</h3>
            <div class="pagination-container">
                <a href="?page=${currentPage - 1}" class="page-link ${currentPage <= 1 ? 'disabled' : ''}">
                    <i class="bi bi-chevron-left"></i> Previous
                </a>

                <c:forEach begin="1" end="10" var="i">
                    <a href="?page=${i}" class="page-link ${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>

                <a href="?page=${currentPage + 1}" class="page-link">
                    Next <i class="bi bi-chevron-right"></i>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>