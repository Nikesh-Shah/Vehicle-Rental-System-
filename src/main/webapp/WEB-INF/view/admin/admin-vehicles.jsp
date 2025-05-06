<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Vehicles</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<button class="sidebar-toggle" id="sidebarToggle"><span>☰</span></button>
<%@ include file="admin-sidebar.jsp" %>

<div class="container mt-5">
    <h2>Vehicle Management</h2>

    <!-- Add Vehicle Form -->
    <form id="vehicleForm" action="${pageContext.request.contextPath}/admin-vehicles" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="add"/>
        <div class="mb-3">
            <label for="brand" class="form-label">Brand:</label>
            <input type="text" class="form-control" id="brand" name="brand" required/>
        </div>
        <div class="mb-3">
            <label for="model" class="form-label">Model:</label>
            <input type="text" class="form-control" id="model" name="model" required/>
        </div>
        <div class="mb-3">
            <label for="price" class="form-label">Price per Day:</label>
            <input type="number" step="0.01" class="form-control" id="price" name="price" required/>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Status:</label>
            <select class="form-select" id="status" name="status" required>
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="categoryId" class="form-label">Category:</label>
            <select class="form-select" id="categoryId" name="categoryId" required>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryId}">${category.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label for="image" class="form-label">Image:</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*" required/>
        </div>
        <button type="submit" class="btn btn-primary">Add Vehicle</button>
    </form>
    <hr/>

    <!-- Vehicle List -->
    <h4 class="mt-4">Vehicle List</h4>
    <table class="table table-bordered table-hover mt-3">
        <thead>
        <tr>
            <th>ID</th><th>Brand</th><th>Model</th><th>Price/Day</th>
            <th>Status</th><th>Category</th><th>Image</th><th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="vehicle" items="${vehicles}">
            <tr>
                <td>${vehicle.vehicleId}</td>
                <td>${vehicle.brand}</td>
                <td>${vehicle.model}</td>
                <td>${vehicle.pricePerDay}</td>
                <td>${vehicle.status}</td>
                <td>${vehicle.categoryId}</td>
                <td><img src="${pageContext.request.contextPath}/${vehicle.image}" width="100"/></td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin-vehicles?action=edit&vehicleId=${vehicle.vehicleId}"
                       class="btn btn-info btn-sm me-1">Edit</a>
                    <button type="button"
                            class="btn btn-danger btn-sm"
                            onclick="deleteVehicle(${vehicle.vehicleId});">
                        Delete
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- MESSAGE POPUP -->
<div class="modal fade" id="popupModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog"><div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">Message</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body" id="popupMessage"></div>
    </div></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add Vehicle
    $('#vehicleForm').submit(function(e){
        e.preventDefault();
        let data = new FormData(this);
        $.post({
            url: `${pageContext.request.contextPath}/admin-vehicles`,
            data, processData:false, contentType:false
        }).done(res=>{
            showPopup(res.message);
            if(res.success) setTimeout(()=>location.reload(),1500);
        }).fail(xhr=>{
            showPopup(xhr.responseJSON?.message||'Error!');
        });
    });

    // Delete Vehicle
    function deleteVehicle(id){
        $.post(`${pageContext.request.contextPath}/admin-vehicles`,{ action:'delete', vehicleId:id })
            .done(res=>{ showPopup(res.message); if(res.success) setTimeout(()=>location.reload(),1500); })
            .fail(xhr=> showPopup(xhr.responseJSON?.message||'Delete failed!'));
    }

    // Popup Message
    function showPopup(msg){
        $('#popupMessage').text(msg);
        new bootstrap.Modal($('#popupModal')).show();
    }

    // Sidebar Toggle
    $('#sidebarToggle').click(()=>{
        $('.admin-sidebar').toggleClass('collapsed');
        $('.container').toggleClass('expanded');
    });
</script>
</body>
</html>
