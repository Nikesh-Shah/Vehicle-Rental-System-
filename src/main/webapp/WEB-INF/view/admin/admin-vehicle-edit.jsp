<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Edit Vehicle #${vehicle.vehicleId}</title>--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/edit-vehicle.css">--%>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<%@ include file="admin-sidebar.jsp" %>--%>

<%--<div class="container mt-5">--%>
<%--    <h2>Edit Vehicle #${vehicle.vehicleId}</h2>--%>

<%--    <!-- show server‐side errors if any -->--%>
<%--    <c:if test="${not empty error}">--%>
<%--        <div class="alert alert-danger">${error}</div>--%>
<%--    </c:if>--%>

<%--    <form action="${pageContext.request.contextPath}/admin-vehicles" method="post" enctype="multipart/form-data" class="form-class">--%>

<%--        <input type="hidden" name="action"    value="update"/>--%>
<%--        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}"/>--%>

<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Brand:</label>--%>
<%--            <input type="text" class="form-control"--%>
<%--                   name="brand" value="${vehicle.brand}" required/>--%>
<%--        </div>--%>

<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Model:</label>--%>
<%--            <input type="text" class="form-control"--%>
<%--                   name="model" value="${vehicle.model}" required/>--%>
<%--        </div>--%>

<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Price/Day:</label>--%>
<%--            <input type="number" step="0.01" class="form-control"--%>
<%--                   name="price" value="${vehicle.pricePerDay}" required/>--%>
<%--        </div>--%>
<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Quantity:</label>--%>
<%--            <input type="number"  class="form-control"--%>
<%--                   name="quantity" value="${vehicle.quantity}" required/>--%>
<%--        </div>--%>

<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Status:</label>--%>
<%--            <select class="form-select" name="status" required>--%>
<%--                <option value="Available" ${vehicle.status == 'Available' ? 'selected' : ''}>--%>
<%--                    Available--%>
<%--                </option>--%>
<%--                <option value="Unavailable" ${vehicle.status == 'Unavailable' ? 'selected' : ''}>--%>
<%--                    Unavailable--%>
<%--                </option>--%>
<%--            </select>--%>
<%--        </div>--%>


<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Category:</label>--%>
<%--            <select class="form-select" name="categoryId" required>--%>
<%--                <c:forEach var="cat" items="${categories}">--%>
<%--                    <option value="${cat.categoryId}"--%>
<%--                        ${cat.categoryId == vehicle.categoryId ? 'selected' : ''}>--%>
<%--                            ${cat.name}--%>
<%--                    </option>--%>
<%--                </c:forEach>--%>
<%--            </select>--%>
<%--        </div>--%>

<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Image:</label>--%>
<%--            <input type="file" class="form-control" name="image" accept="image/*"/>--%>
<%--            <p class="mt-2">Current image:</p>--%>
<%--            <img src="${pageContext.request.contextPath}/${vehicle.image}"--%>
<%--                 width="150" alt="current vehicle image"/>--%>
<%--        </div>--%>

<%--        <button type="submit" class="btn btn-primary">Save Changes</button>--%>
<%--        <a href="${pageContext.request.contextPath}/admin-vehicles"--%>
<%--           class="btn btn-secondary ms-2">Cancel</a>--%>
<%--    </form>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vehicle #${vehicle.vehicleId}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/edit-vehicle.css">
</head>
<body>
<%@ include file="admin-sidebar.jsp" %>

<div class="main-content">
    <div class="page-header">
        <h1>Edit Vehicle #${vehicle.vehicleId}</h1>
    </div>

    <!-- show server‐side errors if any -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/admin-vehicles" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}"/>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Brand:</label>
                    <input type="text" name="brand" value="${vehicle.brand}" class="form-control" required/>
                </div>

                <div class="form-group">
                    <label class="form-label">Model:</label>
                    <input type="text" name="model" value="${vehicle.model}" class="form-control" required/>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Price/Day:</label>
                    <input type="number" step="0.01" name="price" value="${vehicle.pricePerDay}" class="form-control" required/>
                </div>

                <div class="form-group">
                    <label class="form-label">Quantity:</label>
                    <input type="number" name="quantity" value="${vehicle.quantity}" class="form-control" required/>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Status:</label>
                    <select name="status" class="form-select" required>
                        <option value="Available" ${vehicle.status == 'Available' ? 'selected' : ''}>
                            Available
                        </option>
                        <option value="Unavailable" ${vehicle.status == 'Unavailable' ? 'selected' : ''}>
                            Unavailable
                        </option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Category:</label>
                    <select name="categoryId" class="form-select" required>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}"
                                ${cat.categoryId == vehicle.categoryId ? 'selected' : ''}>
                                    ${cat.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Image:</label>
                <div class="file-upload">
                    <label class="file-upload-label">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                            <polyline points="17 8 12 3 7 8"></polyline>
                            <line x1="12" y1="3" x2="12" y2="15"></line>
                        </svg>
                        Choose a file
                        <input type="file" name="image" accept="image/*" class="file-upload-input"/>
                    </label>
                </div>
                <div class="current-image">
                    <p>Current image:</p>
                    <img src="${pageContext.request.contextPath}/${vehicle.image}" alt="current vehicle image"/>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <a href="${pageContext.request.contextPath}/admin-vehicles" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script>
    document.querySelector('.file-upload-input').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                const img = document.querySelector('.current-image img');
                img.src = event.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>
