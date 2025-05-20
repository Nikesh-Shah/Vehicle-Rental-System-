<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Vehicle</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vehicle-form.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Add New Vehicle</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle"></i> ${error}
            </div>
        </c:if>

        <div class="form-container">
            <form action="<c:url value='/admin-vehicles'/>" method="post" enctype="multipart/form-data" id="vehicleForm">
                <input type="hidden" name="action" value="add"/>

                <div class="form-group">
                    <label for="brand" class="form-label">Brand:</label>
                    <input type="text" id="brand" name="brand" class="form-control" required/>
                </div>

                <div class="form-group">
                    <label for="model" class="form-label">Model:</label>
                    <input type="text" id="model" name="model" class="form-control" required/>
                </div>

                <div class="form-group">
                    <label for="price" class="form-label">Price per Day (NRs):</label>
                    <input type="number" id="price" name="price" class="form-control" min="0" step="0.01" required/>
                </div>

                <div class="form-group">
                    <label for="status" class="form-label">Status:</label>
                    <select id="status" name="status" class="form-select" required>
                        <option value="Available">Available</option>
                        <option value="Rented">Rented</option>
                        <option value="Maintenance">Maintenance</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="categoryId" class="form-label">Category:</label>
                    <select id="categoryId" name="categoryId" class="form-select" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="quantity" class="form-label">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="image" class="form-label">Vehicle Image:</label>
                    <div class="file-upload">
                        <label for="image" class="file-upload-label">
                            <i class="bi bi-cloud-arrow-up"></i> Choose Image
                        </label>
                        <input type="file" id="image" name="image" accept="image/*" class="file-upload-input" required/>
                    </div>
                    <div id="imagePreview" class="file-preview">
                        <img id="preview" src="#" alt="Image Preview"/>
                    </div>
                </div>


                <div class="form-actions">
                    <button type="submit" class="btn btn-success btn-lg">
                        <i class="bi bi-plus-circle"></i> Add Vehicle
                    </button>

                    <a href="<c:url value='/admin-vehicles'/>" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Back to Vehicle List
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Image preview functionality
    document.getElementById('image').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            const preview = document.getElementById('preview');
            const imagePreview = document.getElementById('imagePreview');

            reader.onload = function(e) {
                preview.src = e.target.result;
                imagePreview.style.display = 'block';
            }

            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>