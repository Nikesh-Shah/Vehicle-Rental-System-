<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Vehicle #${vehicle.vehicleId}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body>
<%@ include file="admin-sidebar.jsp" %>

<div class="container mt-5">
    <h2>Edit Vehicle #${vehicle.vehicleId}</h2>

    <!-- show server‐side errors if any -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin-vehicles"
          method="post" enctype="multipart/form-data">
        <input type="hidden" name="action"    value="update"/>
        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}"/>

        <div class="mb-3">
            <label class="form-label">Brand:</label>
            <input type="text" class="form-control"
                   name="brand" value="${vehicle.brand}" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Model:</label>
            <input type="text" class="form-control"
                   name="model" value="${vehicle.model}" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Price/Day:</label>
            <input type="number" step="0.01" class="form-control"
                   name="price" value="${vehicle.pricePerDay}" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Status:</label>
            <select class="form-select" name="status" required>
                <option value="Available" ${vehicle.status == 'Available' ? 'selected' : ''}>
                    Available
                </option>
                <option value="Unavailable" ${vehicle.status == 'Unavailable' ? 'selected' : ''}>
                    Unavailable
                </option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Category:</label>
            <select class="form-select" name="categoryId" required>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.categoryId}"
                        ${cat.categoryId == vehicle.categoryId ? 'selected' : ''}>
                            ${cat.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Image:</label>
            <input type="file" class="form-control" name="image" accept="image/*"/>
            <p class="mt-2">Current image:</p>
            <img src="${pageContext.request.contextPath}/${vehicle.image}"
                 width="150" alt="current vehicle image"/>
        </div>

        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="${pageContext.request.contextPath}/admin-vehicles"
           class="btn btn-secondary ms-2">Cancel</a>
    </form>
</div>
</body>
</html>
