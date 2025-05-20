<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${empty category ? 'Add' : 'Edit'} Category</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/category-form.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h2>
                <i class="bi bi-folder-plus"></i>
                ${empty category ? 'Add New' : 'Edit'} Category
            </h2>
        </div>

        <div class="form-container">
            <form method="post" action="${pageContext.request.contextPath}/admin/category-form">
                <c:if test="${not empty category}">
                    <input type="hidden" name="id" value="${category.categoryId}">
                </c:if>

                <div class="form-group">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" id="name" name="name" value="${category.name}" class="form-control" required>
                </div>




                <div class="form-group">
                    <label for="description" class="form-label">Description</label>
                    <textarea id="description" name="description" rows="3" class="form-control form-textarea">${category.description}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check-circle"></i> Save Category
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>


</body>
</html>