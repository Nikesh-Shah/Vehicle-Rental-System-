<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <%@ include file="admin-sidebar.jsp" %>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Vehicle Management</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVehicleModal">
                        <i class="bi bi-plus-lg"></i> Add Vehicle
                    </button>
                </div>
            </div>

            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show">
                        ${param.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show">
                        ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Brand/Model</th>
                        <th>Category</th>
                        <th>Price/Day</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${vehicles}" var="vehicle">
                        <tr>
                            <td>${vehicle.vehicleId}</td>
                            <td><img src="${vehicle.image}" width="60" class="rounded"></td>
                            <td>${vehicle.brand} ${vehicle.model}</td>
                            <td>${vehicle.categoryName}</td>
                            <td><fmt:formatNumber value="${vehicle.pricePerDay}" type="currency"/></td>
                            <td>
                                        <span class="badge bg-${vehicle.status == 'Available' ? 'success' : 'danger'}">
                                                ${vehicle.status}
                                        </span>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary edit-vehicle-btn"
                                        data-id="${vehicle.vehicleId}"
                                        data-brand="${vehicle.brand}"
                                        data-model="${vehicle.model}"
                                        data-price="${vehicle.pricePerDay}"
                                        data-status="${vehicle.status}"
                                        data-image="${vehicle.image}"
                                        data-category="${vehicle.categoryId}">
                                    <i class="bi bi-pencil"></i> Edit
                                </button>
                                <form action="admin/delete-vehicle" method="post" class="d-inline">
                                    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger"
                                            onclick="return confirm('Are you sure you want to delete this vehicle?')">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                    </li>
                    <c:forEach begin="1" end="10" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                    </li>
                </ul>
            </nav>
        </main>
    </div>
</div>

<!-- Add Vehicle Modal -->
<div class="modal fade" id="addVehicleModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="admin/add-vehicle" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Vehicle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Brand</label>
                        <input type="text" name="brand" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Model</label>
                        <input type="text" name="model" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price Per Day</label>
                        <input type="number" step="0.01" name="price" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select" required>
                            <option value="Available">Available</option>
                            <option value="Maintenance">Maintenance</option>
                            <option value="Booked">Booked</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <select name="categoryId" class="form-select" required>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.categoryId}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Image</label>
                        <input type="file" name="image" class="form-control" accept="image/*">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Vehicle</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Vehicle Modal -->
<div class="modal fade" id="editVehicleModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="admin/update-vehicle" method="post" enctype="multipart/form-data">
                <input type="hidden" name="vehicleId" id="editVehicleId">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Vehicle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Brand</label>
                        <input type="text" name="brand" id="editVehicleBrand" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Model</label>
                        <input type="text" name="model" id="editVehicleModel" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price Per Day</label>
                        <input type="number" step="0.01" name="price" id="editVehiclePrice" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select name="status" id="editVehicleStatus" class="form-select" required>
                            <option value="Available">Available</option>
                            <option value="Maintenance">Maintenance</option>
                            <option value="Booked">Booked</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <select name="categoryId" id="editVehicleCategory" class="form-select" required>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.categoryId}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Image</label>
                        <input type="file" name="image" class="form-control" accept="image/*">
                        <small class="text-muted">Leave blank to keep current image</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Handle edit button clicks
    document.querySelectorAll('.edit-vehicle-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const modal = new bootstrap.Modal(document.getElementById('editVehicleModal'));
            document.getElementById('editVehicleId').value = this.dataset.id;
            document.getElementById('editVehicleBrand').value = this.dataset.brand;
            document.getElementById('editVehicleModel').value = this.dataset.model;
            document.getElementById('editVehiclePrice').value = this.dataset.price;
            document.getElementById('editVehicleStatus').value = this.dataset.status;
            document.getElementById('editVehicleCategory').value = this.dataset.category;
            modal.show();
        });
    });
</script>
</body>
</html>