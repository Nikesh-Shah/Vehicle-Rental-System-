<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/category-management.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Categories</h1>
            <a href="${pageContext.request.contextPath}/admin/category-form" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Add New Category
            </a>
        </div>

        <c:choose>
            <c:when test="${empty categories}">
                <div class="no-data">
                    <i class="bi bi-folder-x"></i>
                    No categories found
                </div>
            </c:when>
            <c:otherwise>
                <div class="category-table-container">
                    <table class="category-table">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${categories}" var="category">
                            <tr>
                                <td><span class="category-name">${category.name}</span></td>
                                <td><div class="category-description">${category.description}</div></td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/category-form?id=${category.categoryId}" class="btn btn-warning btn-sm">
                                            <i class="bi bi-pencil"></i> Edit
                                        </a>
                                        <form action="${pageContext.request.contextPath}/admin/categories" method="post" style="display: inline;">
                                            <input type="hidden" name="id" value="${category.categoryId}">
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Delete this category?')">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>