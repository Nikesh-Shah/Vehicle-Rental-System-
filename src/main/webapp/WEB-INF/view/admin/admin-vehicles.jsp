<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Vehicle List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vehicle-management.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Vehicle Management</h1>

            <a href="<c:url value='/admin-vehicles?action=add'/>" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Add Vehicle
            </a>
        </div>

        <div class="filter-section">
            <form class="search-form" action="${pageContext.request.contextPath}/admin-vehicles" method="get">
                <input type="text" name="search" placeholder="Search vehicles..." class="search-input">
                <button type="submit" class="search-button">
                    <i class="bi bi-search"></i>
                </button>
            </form>

            <div class="filter-group">
                <span class="filter-label">Category:</span>
                <select class="filter-select" name="category" onchange="this.form.submit()">
                    <option value="">All Categories</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}">${category.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="filter-group">
                <span class="filter-label">Status:</span>
                <select class="filter-select" name="status" onchange="this.form.submit()">
                    <option value="">All Statuses</option>
                    <option value="Available">Available</option>
                    <option value="Rented">Rented</option>
                    <option value="Maintenance">Maintenance</option>
                </select>
            </div>
        </div>

        <div class="vehicle-table-container">
            <table class="vehicle-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Status</th>
<%--                    <th>Category</th>--%>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="vehicle" items="${vehicles}">
                    <tr>
                        <td>${vehicle.vehicleId}</td>
                        <td>${vehicle.brand}</td>
                        <td>${vehicle.model}</td>
                        <td><span class="price">NRs ${vehicle.pricePerDay}</span>/day</td>
                        <td>${vehicle.quantity}</td>
                        <td>
                            <span class="status-badge status-${vehicle.status.toLowerCase()}">${vehicle.status}</span>
                        </td>

<%--                        <td>--%>
<%--                            <c:forEach var="cat" items="${categories}">--%>
<%--                                <c:if test="${cat.categoryId == vehicle.categoryId}">--%>
<%--                                    ${cat.categoryId}--%>
<%--&lt;%&ndash;                                    <span class="category-badge">${cat.categoryId}</span>&ndash;%&gt;--%>
<%--                                </c:if>--%>
<%--                            </c:forEach>--%>
<%--                        </td>--%>

                        <td>
                            <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}" class="vehicle-image"/>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <!-- Edit Button -->
                                <a href="<c:url value='/admin-vehicles?action=edit&vehicleId=${vehicle.vehicleId}'/>" class="btn btn-warning">
                                    <i class="bi bi-pencil"></i> Edit
                                </a>

                                <!-- Delete Button -->
                                <form action="<c:url value='/admin-vehicles'/>" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}"/>
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this vehicle?')">
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

        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="<c:url value='/admin-vehicles?page=${currentPage - 1}'/>" class="btn btn-primary">
                    <i class="bi bi-chevron-left"></i> Previous
                </a>
            </c:if>

            <c:if test="${currentPage < totalPages}">
                <a href="<c:url value='/admin-vehicles?page=${currentPage + 1}'/>" class="btn btn-primary">
                    Next <i class="bi bi-chevron-right"></i>
                </a>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>