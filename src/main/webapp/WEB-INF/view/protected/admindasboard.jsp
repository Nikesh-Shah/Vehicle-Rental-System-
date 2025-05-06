<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GoRent Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="admin-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <h2>GoRent Admin</h2>
        </div>
        <ul class="nav-links">
            <li class="active">
                <a href="#" onclick="showTab('dashboard')">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="#" onclick="showTab('vehicles')">
                    <i class="fas fa-car"></i>
                    <span>Vehicles</span>
                </a>
            </li>
            <li>
                <a href="#" onclick="showTab('bookings')">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Bookings</span>
                </a>
            </li>
            <li>
                <a href="#" onclick="showTab('users')">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                </a>
            </li>
            <li>
                <a href="#" onclick="showTab('categories')">
                    <i class="fas fa-tags"></i>
                    <span>Categories</span>
                </a>
            </li>
            <li>
                <a href="#" onclick="showTab('reports')">
                    <i class="fas fa-chart-bar"></i>
                    <span>Reports</span>
                </a>
            </li>
            <li>
                <a href="#" onclick="showTab('settings')">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </li>
            <li>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                    <button type="submit" style="background:none; border:none; padding:0; cursor:pointer; color: white">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </button>
                </form>
            </li>

        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header">
            <div class="menu-toggle">
                <i class="fas fa-bars"></i>
            </div>
            <div class="user-info">
                <span>Welcome, Admin</span>
                <i class="fas fa-user-circle"></i>
            </div>
        </div>

        <!-- Content -->
        <div class="content">
            <!-- Dashboard Tab -->
            <div id="dashboard" class="tab-content active">
                <h2>Dashboard Overview</h2>

                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <div class="stat-info">
                            <h3>${stats.totalVehicles}</h3>
                            <p>25</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Total Bookings</h3>
                            <p>${stats.totalBookings}</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Registered Users</h3>
                            <p>${stats.totalUsers}</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Total Revenue</h3>
                            <p><fmt:formatNumber value="${stats.totalRevenue}" type="currency"/></p>
                        </div>
                    </div>
                </div>

                <div class="chart-container">
                    <h3>Monthly Revenue</h3>
                    <div class="chart">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>

                <!-- Recent Bookings (Dynamic Version) -->
                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Recent Bookings</h5>
                                <a href="admin/bookings" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover data-table">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Customer</th>
                                            <th>Vehicle</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${stats.recentBookings}" var="booking">
                                            <tr>
                                                <td>${booking.bookingId}</td>
                                                <td>${booking.customerName}</td>
                                                <td>${booking.vehicleName}</td>
                                                <td>${booking.startDate}</td>
                                                <td>${booking.endDate}</td>
                                                <td>$${booking.amount}</td>
                                                <td>
                                        <span class="status
                                            ${booking.status == 'Active' ? 'active' :
                                              booking.status == 'Completed' ? 'completed' :
                                              booking.status == 'Pending' ? 'pending' : ''}">
                                                ${booking.status}
                                        </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            <!-- Vehicles Tab -->
            <div id="vehicles" class="tab-content">
                <div class="section-header">
                    <h2>Vehicle Management</h2>
                    <button class="add-btn" onclick="showAddVehicleForm()">Add Vehicle</button>
                </div>

                <div class="search-filter">
                    <input type="text" id="vehicleSearch" placeholder="Search vehicles..." onkeyup="filterVehicles()">
                    <select id="statusFilter" onchange="filterVehicles()">
                        <option value="">All Statuses</option>
                        <option value="Available">Available</option>
                        <option value="Rented">Rented</option>
                        <option value="Maintenance">Maintenance</option>
                    </select>
                </div>

                <table class="data-table" id="vehiclesTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Brand</th>
                        <th>Model</th>
                        <th>Price/Day</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>Toyota</td>
                        <td>Camry</td>
                        <td>$75.00</td>
                        <td><span class="status available">Available</span></td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showEditVehicleForm(1, 'Toyota', 'Camry', 75, 'Available')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn" onclick="confirmDelete(1)">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Honda</td>
                        <td>CR-V</td>
                        <td>$95.00</td>
                        <td><span class="status rented">Rented</span></td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showEditVehicleForm(2, 'Honda', 'CR-V', 95, 'Rented')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn" onclick="confirmDelete(2)">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Ford</td>
                        <td>F-150</td>
                        <td>$120.00</td>
                        <td><span class="status maintenance">Maintenance</span></td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showEditVehicleForm(3, 'Ford', 'F-150', 120, 'Maintenance')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn" onclick="confirmDelete(3)">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>Tesla</td>
                        <td>Model 3</td>
                        <td>$150.00</td>
                        <td><span class="status available">Available</span></td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showEditVehicleForm(4, 'Tesla', 'Model 3', 150, 'Available')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn" onclick="confirmDelete(4)">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>BMW</td>
                        <td>X5</td>
                        <td>$180.00</td>
                        <td><span class="status available">Available</span></td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showEditVehicleForm(5, 'BMW', 'X5', 180, 'Available')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn" onclick="confirmDelete(5)">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <!-- Add Vehicle Form (hidden by default) -->
                <div id="addVehicleForm" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="hideAddVehicleForm()">&times;</span>
                        <h3>Add New Vehicle</h3>
                        <form action="#" method="post">
                            <div class="form-group">
                                <label for="vehicle_brand">Brand:</label>
                                <input type="text" id="vehicle_brand" name="vehicle_brand" required>
                            </div>
                            <div class="form-group">
                                <label for="vehicle_model">Model:</label>
                                <input type="text" id="vehicle_model" name="vehicle_model" required>
                            </div>
                            <div class="form-group">
                                <label for="vehicle_price_per_day">Price Per Day:</label>
                                <input type="number" id="vehicle_price_per_day" name="vehicle_price_per_day" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label for="vehicle_status">Status:</label>
                                <select id="vehicle_status" name="vehicle_status" required>
                                    <option value="Available">Available</option>
                                    <option value="Rented">Rented</option>
                                    <option value="Maintenance">Maintenance</option>
                                </select>
                            </div>
                            <button type="submit" class="submit-btn">Add Vehicle</button>
                        </form>
                    </div>
                </div>

                <!-- Edit Vehicle Form (hidden by default) -->
                <div id="editVehicleForm" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="hideEditVehicleForm()">&times;</span>
                        <h3>Edit Vehicle</h3>
                        <form action="#" method="post" id="editVehicleFormContent">
                            <input type="hidden" id="edit_vehicleId" name="vehicleId">
                            <div class="form-group">
                                <label for="edit_vehicle_brand">Brand:</label>
                                <input type="text" id="edit_vehicle_brand" name="vehicle_brand" required>
                            </div>
                            <div class="form-group">
                                <label for="edit_vehicle_model">Model:</label>
                                <input type="text" id="edit_vehicle_model" name="vehicle_model" required>
                            </div>
                            <div class="form-group">
                                <label for="edit_vehicle_price_per_day">Price Per Day:</label>
                                <input type="number" id="edit_vehicle_price_per_day" name="vehicle_price_per_day" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label for="edit_vehicle_status">Status:</label>
                                <select id="edit_vehicle_status" name="vehicle_status" required>
                                    <option value="Available">Available</option>
                                    <option value="Rented">Rented</option>
                                    <option value="Maintenance">Maintenance</option>
                                </select>
                            </div>
                            <button type="submit" class="submit-btn">Update Vehicle</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Bookings Tab -->
            <div id="bookings" class="tab-content">
                <h2>Booking Management</h2>

                <div class="search-filter">
                    <input type="text" id="bookingSearch" placeholder="Search bookings..." onkeyup="filterBookings()">
                    <select id="bookingStatusFilter" onchange="filterBookings()">
                        <option value="">All Statuses</option>
                        <option value="Active">Active</option>
                        <option value="Completed">Completed</option>
                        <option value="Cancelled">Cancelled</option>
                        <option value="Pending">Pending</option>
                    </select>
                </div>

                <table class="data-table" id="bookingsTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Vehicle</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Status</th>
                        <th>Amount</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>B001</td>
                        <td>John Smith</td>
                        <td>Toyota Camry</td>
                        <td>2023-04-15</td>
                        <td>2023-04-20</td>
                        <td><span class="status active">Active</span></td>
                        <td>$375.00</td>
                        <td class="actions">
                            <button class="view-btn" onclick="viewBookingDetails('B001')">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="edit-btn" onclick="showUpdateStatusForm('B001', 'Active')">
                                <i class="fas fa-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>B002</td>
                        <td>Sarah Johnson</td>
                        <td>Honda CR-V</td>
                        <td>2023-04-10</td>
                        <td>2023-04-17</td>
                        <td><span class="status completed">Completed</span></td>
                        <td>$665.00</td>
                        <td class="actions">
                            <button class="view-btn" onclick="viewBookingDetails('B002')">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="edit-btn" onclick="showUpdateStatusForm('B002', 'Completed')">
                                <i class="fas fa-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>B003</td>
                        <td>Michael Brown</td>
                        <td>Ford F-150</td>
                        <td>2023-04-18</td>
                        <td>2023-04-25</td>
                        <td><span class="status pending">Pending</span></td>
                        <td>$840.00</td>
                        <td class="actions">
                            <button class="view-btn" onclick="viewBookingDetails('B003')">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="edit-btn" onclick="showUpdateStatusForm('B003', 'Pending')">
                                <i class="fas fa-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>B004</td>
                        <td>Emily Davis</td>
                        <td>Tesla Model 3</td>
                        <td>2023-04-05</td>
                        <td>2023-04-12</td>
                        <td><span class="status completed">Completed</span></td>
                        <td>$1,050.00</td>
                        <td class="actions">
                            <button class="view-btn" onclick="viewBookingDetails('B004')">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="edit-btn" onclick="showUpdateStatusForm('B004', 'Completed')">
                                <i class="fas fa-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>B005</td>
                        <td>David Wilson</td>
                        <td>BMW X5</td>
                        <td>2023-04-22</td>
                        <td>2023-04-29</td>
                        <td><span class="status pending">Pending</span></td>
                        <td>$1,260.00</td>
                        <td class="actions">
                            <button class="view-btn" onclick="viewBookingDetails('B005')">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="edit-btn" onclick="showUpdateStatusForm('B005', 'Pending')">
                                <i class="fas fa-edit"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <!-- Booking Details Modal -->
                <div id="bookingDetailsModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="hideBookingDetails()">&times;</span>
                        <h3>Booking Details</h3>
                        <div id="bookingDetailsContent">
                            <!-- Content will be dynamically populated -->
                        </div>
                    </div>
                </div>

                <!-- Update Status Modal -->
                <div id="updateStatusModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="hideUpdateStatusForm()">&times;</span>
                        <h3>Update Booking Status</h3>
                        <form action="#" method="post">
                            <input type="hidden" id="update_bookingId" name="bookingId">
                            <div class="form-group">
                                <label for="booking_status">Status:</label>
                                <select id="booking_status" name="booking_status" required>
                                    <option value="Active">Active</option>
                                    <option value="Completed">Completed</option>
                                    <option value="Cancelled">Cancelled</option>
                                    <option value="Pending">Pending</option>
                                </select>
                            </div>
                            <button type="submit" class="submit-btn">Update Status</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Users Tab -->
            <div id="users" class="tab-content">
                <h2>User Management</h2>

                <div class="search-filter">
                    <input type="text" id="userSearch" placeholder="Search users..." onkeyup="filterUsers()">
                    <select id="userRoleFilter" onchange="filterUsers()">
                        <option value="">All Roles</option>
                        <option value="Admin">Admin</option>
                        <option value="Customer">Customer</option>
                    </select>
                </div>

                <table class="data-table" id="usersTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Registered Date</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>U001</td>
                        <td>John Smith</td>
                        <td>john@example.com</td>
                        <td>555-123-4567</td>
                        <td><span class="role customer">Customer</span></td>
                        <td>2023-01-15</td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showUpdateRoleForm('U001', 'Customer')">
                                <i class="fas fa-user-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>U002</td>
                        <td>Sarah Johnson</td>
                        <td>sarah@example.com</td>
                        <td>555-987-6543</td>
                        <td><span class="role customer">Customer</span></td>
                        <td>2023-02-20</td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showUpdateRoleForm('U002', 'Customer')">
                                <i class="fas fa-user-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>U003</td>
                        <td>Michael Brown</td>
                        <td>michael@example.com</td>
                        <td>555-456-7890</td>
                        <td><span class="role customer">Customer</span></td>
                        <td>2023-03-05</td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showUpdateRoleForm('U003', 'Customer')">
                                <i class="fas fa-user-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>U004</td>
                        <td>Emily Davis</td>
                        <td>emily@example.com</td>
                        <td>555-789-0123</td>
                        <td><span class="role customer">Customer</span></td>
                        <td>2023-03-10</td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showUpdateRoleForm('U004', 'Customer')">
                                <i class="fas fa-user-edit"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>U005</td>
                        <td>David Wilson</td>
                        <td>david@example.com</td>
                        <td>555-234-5678</td>
                        <td><span class="role admin">Admin</span></td>
                        <td>2023-03-25</td>
                        <td class="actions">
                            <button class="edit-btn" onclick="showUpdateRoleForm('U005', 'Admin')">
                                <i class="fas fa-user-edit"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <!-- Update Role Modal -->
                <div id="updateRoleModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="hideUpdateRoleForm()">&times;</span>
                        <h3>Update User Role</h3>
                        <form action="#" method="post">
                            <input type="hidden" id="update_userId" name="userId">
                            <div class="form-group">
                                <label for="role">Role:</label>
                                <select id="role" name="role" required>
                                    <option value="Customer">Customer</option>
                                    <option value="Admin">Admin</option>
                                </select>
                            </div>
                            <button type="submit" class="submit-btn">Update Role</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Categories Tab -->
            <div id="categories" class="tab-content">
                <div class="section-header">
                    <h2>Category Management</h2>
                    <button class="add-btn" onclick="showAddCategoryForm()">Add Category</button>
                </div>

                <div class="search-filter">
                    <input type="text" id="categorySearch" placeholder="Search categories..." onkeyup="filterCategories()">
                </div>

                <table class="data-table" id="categoriesTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>Sedan</td>
                        <td>Standard 4-door passenger cars</td>
                        <td><img src="images/sedan.jpg" alt="Sedan" style="width: 50px; height: 50px; object-fit: cover;"></td>
                        <td class="actions">
                            <button class="edit-btn">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>SUV</td>
                        <td>Sport Utility Vehicles with higher ground clearance</td>
                        <td><img src="images/suv.jpg" alt="SUV" style="width: 50px; height: 50px; object-fit: cover;"></td>
                        <td class="actions">
                            <button class="edit-btn">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Truck</td>
                        <td>Pickup trucks for hauling and towing</td>
                        <td><img src="images/truck.jpg" alt="Truck" style="width: 50px; height: 50px; object-fit: cover;"></td>
                        <td class="actions">
                            <button class="edit-btn">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>Luxury</td>
                        <td>Premium vehicles with high-end features</td>
                        <td><img src="images/luxury.jpg" alt="Luxury" style="width: 50px; height: 50px; object-fit: cover;"></td>
                        <td class="actions">
                            <button class="edit-btn">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="delete-btn">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <!-- Add Category Form (hidden by default) -->
                <div id="addCategoryForm" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="hideAddCategoryForm()">&times;</span>
                        <h3>Add New Category</h3>
                        <form action="#" method="post">
                            <div class="form-group">
                                <label for="category_name">Name:</label>
                                <input type="text" id="category_name" name="category_name" required>
                            </div>
                            <div class="form-group">
                                <label for="category_description">Description:</label>
                                <textarea id="category_description" name="category_description" rows="3" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="category_image">Image URL:</label>
                                <input type="text" id="category_image" name="category_image">
                            </div>
                            <button type="submit" class="submit-btn">Add Category</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Reports Tab -->
            <div id="reports" class="tab-content">
                <h2>Reports</h2>

                <div class="chart-container">
                    <h3>Monthly Bookings</h3>
                    <div class="chart">
                        <canvas id="bookingsChart"></canvas>
                    </div>
                </div>

                <div class="chart-container">
                    <h3>Vehicle Popularity</h3>
                    <div class="chart">
                        <canvas id="vehiclesChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Settings Tab -->
            <div id="settings" class="tab-content">
                <h2>System Settings</h2>

                <div class="recent-section">
                    <h3>General Settings</h3>
                    <form action="#" method="post">
                        <div class="form-group">
                            <label for="site_name">Site Name:</label>
                            <input type="text" id="site_name" name="site_name" value="GoRent Vehicle Rental">
                        </div>
                        <div class="form-group">
                            <label for="admin_email">Admin Email:</label>
                            <input type="email" id="admin_email" name="admin_email" value="admin@gorent.com">
                        </div>
                        <div class="form-group">
                            <label for="currency">Currency:</label>
                            <select id="currency" name="currency">
                                <option value="USD" selected>USD ($)</option>
                                <option value="EUR">EUR (€)</option>
                                <option value="GBP">GBP (£)</option>
                            </select>
                        </div>
                        <button type="submit" class="submit-btn">Save Settings</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Toggle sidebar on mobile
    document.addEventListener('DOMContentLoaded', function() {
        const menuToggle = document.querySelector('.menu-toggle');
        if (menuToggle) {
            menuToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });
        }

        // Initialize charts
        initCharts();
    });

    // Tab switching
    function showTab(tabId) {
        // Hide all tabs
        const tabs = document.querySelectorAll('.tab-content');
        tabs.forEach(tab => {
            tab.classList.remove('active');
        });

        // Show selected tab
        document.getElementById(tabId).classList.add('active');

        // Update active state in sidebar
        const navLinks = document.querySelectorAll('.nav-links li');
        navLinks.forEach(link => {
            link.classList.remove('active');
        });

        // Find the clicked link and add active class
        const clickedLink = document.querySelector(`.nav-links li a[onclick="showTab('${tabId}')"]`).parentNode;
        clickedLink.classList.add('active');
    }

    // Vehicle management functions
    function showAddVehicleForm() {
        document.getElementById('addVehicleForm').style.display = 'block';
    }

    function hideAddVehicleForm() {
        document.getElementById('addVehicleForm').style.display = 'none';
    }

    function showEditVehicleForm(id, brand, model, price, status) {
        document.getElementById('edit_vehicleId').value = id;
        document.getElementById('edit_vehicle_brand').value = brand;
        document.getElementById('edit_vehicle_model').value = model;
        document.getElementById('edit_vehicle_price_per_day').value = price;
        document.getElementById('edit_vehicle_status').value = status;
        document.getElementById('editVehicleForm').style.display = 'block';
    }

    function hideEditVehicleForm() {
        document.getElementById('editVehicleForm').style.display = 'none';
    }

    function confirmDelete(id) {
        if (confirm('Are you sure you want to delete this item?')) {
            // In a real application, this would send a request to delete the item
            alert('Item deleted (this is just a UI demo)');
        }
    }

    // Booking management functions
    function viewBookingDetails(id) {
        // In a real application, you would fetch booking details via AJAX
        // For this demo, we'll just show a placeholder
        document.getElementById('bookingDetailsContent').innerHTML =
            `<div class="form-group">
                    <label>Booking ID:</label>
                    <p>${id}</p>
                </div>
                <div class="form-group">
                    <label>Customer Details:</label>
                    <p>Name: John Smith</p>
                    <p>Email: john@example.com</p>
                    <p>Phone: 555-123-4567</p>
                </div>
                <div class="form-group">
                    <label>Vehicle Details:</label>
                    <p>Toyota Camry (Sedan)</p>
                    <p>License Plate: ABC-1234</p>
                </div>
                <div class="form-group">
                    <label>Booking Period:</label>
                    <p>Start: 2023-04-15</p>
                    <p>End: 2023-04-20</p>
                    <p>Duration: 5 days</p>
                </div>
                <div class="form-group">
                    <label>Payment Details:</label>
                    <p>Amount: $375.00</p>
                    <p>Payment Method: Credit Card</p>
                    <p>Payment Status: Paid</p>
                </div>`;
        document.getElementById('bookingDetailsModal').style.display = 'block';
    }

    function hideBookingDetails() {
        document.getElementById('bookingDetailsModal').style.display = 'none';
    }

    function showUpdateStatusForm(id, status) {
        document.getElementById('update_bookingId').value = id;
        document.getElementById('booking_status').value = status;
        document.getElementById('updateStatusModal').style.display = 'block';
    }

    function hideUpdateStatusForm() {
        document.getElementById('updateStatusModal').style.display = 'none';
    }

    // User management functions
    function showUpdateRoleForm(id, role) {
        document.getElementById('update_userId').value = id;
        document.getElementById('role').value = role;
        document.getElementById('updateRoleModal').style.display = 'block';
    }

    function hideUpdateRoleForm() {
        document.getElementById('updateRoleModal').style.display = 'none';
    }

    // Category management functions
    function showAddCategoryForm() {
        document.getElementById('addCategoryForm').style.display = 'block';
    }

    function hideAddCategoryForm() {
        document.getElementById('addCategoryForm').style.display = 'none';
    }

    // Filter functions
    function filterVehicles() {
        const input = document.getElementById('vehicleSearch');
        const filter = input.value.toUpperCase();
        const statusFilter = document.getElementById('statusFilter').value;
        const table = document.getElementById('vehiclesTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const brandCol = tr[i].getElementsByTagName('td')[1];
            const modelCol = tr[i].getElementsByTagName('td')[2];
            const statusCol = tr[i].getElementsByTagName('td')[4];

            if (brandCol && modelCol && statusCol) {
                const brandText = brandCol.textContent || brandCol.innerText;
                const modelText = modelCol.textContent || modelCol.innerText;
                const statusText = statusCol.textContent || statusCol.innerText;

                const matchesSearch = brandText.toUpperCase().indexOf(filter) > -1 ||
                    modelText.toUpperCase().indexOf(filter) > -1;
                const matchesStatus = statusFilter === '' || statusText.trim() === statusFilter;

                if (matchesSearch && matchesStatus) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }
    }

    function filterBookings() {
        const input = document.getElementById('bookingSearch');
        const filter = input.value.toUpperCase();
        const statusFilter = document.getElementById('bookingStatusFilter').value;
        const table = document.getElementById('bookingsTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const idCol = tr[i].getElementsByTagName('td')[0];
            const customerCol = tr[i].getElementsByTagName('td')[1];
            const statusCol = tr[i].getElementsByTagName('td')[5];

            if (idCol && customerCol && statusCol) {
                const idText = idCol.textContent || idCol.innerText;
                const customerText = customerCol.textContent || customerCol.innerText;
                const statusText = statusCol.textContent || statusCol.innerText;

                const matchesSearch = idText.toUpperCase().indexOf(filter) > -1 ||
                    customerText.toUpperCase().indexOf(filter) > -1;
                const matchesStatus = statusFilter === '' || statusText.trim() === statusFilter;

                if (matchesSearch && matchesStatus) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }
    }

    function filterUsers() {
        const input = document.getElementById('userSearch');
        const filter = input.value.toUpperCase();
        const roleFilter = document.getElementById('userRoleFilter').value;
        const table = document.getElementById('usersTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const nameCol = tr[i].getElementsByTagName('td')[1];
            const emailCol = tr[i].getElementsByTagName('td')[2];
            const roleCol = tr[i].getElementsByTagName('td')[4];

            if (nameCol && emailCol && roleCol) {
                const nameText = nameCol.textContent || nameCol.innerText;
                const emailText = emailCol.textContent || emailCol.innerText;
                const roleText = roleCol.textContent || roleCol.innerText;

                const matchesSearch = nameText.toUpperCase().indexOf(filter) > -1 ||
                    emailText.toUpperCase().indexOf(filter) > -1;
                const matchesRole = roleFilter === '' || roleText.trim() === roleFilter;

                if (matchesSearch && matchesRole) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }
    }

    function filterCategories() {
        const input = document.getElementById('categorySearch');
        const filter = input.value.toUpperCase();
        const table = document.getElementById('categoriesTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const nameCol = tr[i].getElementsByTagName('td')[1];
            const descCol = tr[i].getElementsByTagName('td')[2];

            if (nameCol && descCol) {
                const nameText = nameCol.textContent || nameCol.innerText;
                const descText = descCol.textContent || descCol.innerText;

                if (nameText.toUpperCase().indexOf(filter) > -1 ||
                    descText.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }
    }

    // Initialize charts
    function initCharts() {
        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart');
        if (revenueCtx) {
            new Chart(revenueCtx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Monthly Revenue ($)',
                        data: [5000, 7500, 8200, 9800, 8500, 10200, 11500, 12800, 11000, 9500, 8800, 10500],
                        backgroundColor: '#3498db'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }

        // Bookings Chart
        const bookingsCtx = document.getElementById('bookingsChart');
        if (bookingsCtx) {
            new Chart(bookingsCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Number of Bookings',
                        data: [42, 55, 60, 75, 65, 80, 95, 102, 88, 72, 68, 85],
                        borderColor: '#2ecc71',
                        tension: 0.1,
                        fill: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }

        // Vehicles Chart
        const vehiclesCtx = document.getElementById('vehiclesChart');
        if (vehiclesCtx) {
            new Chart(vehiclesCtx, {
                type: 'pie',
                data: {
                    labels: ['Sedan', 'SUV', 'Truck', 'Luxury', 'Electric'],
                    datasets: [{
                        data: [35, 25, 15, 15, 10],
                        backgroundColor: ['#3498db', '#2ecc71', '#f39c12', '#9b59b6', '#1abc9c']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }
    }

    // Close modals when clicking outside
    window.onclick = function(event) {
        const modals = document.getElementsByClassName('modal');
        for (let i = 0; i < modals.length; i++) {
            if (event.target == modals[i]) {
                modals[i].style.display = 'none';
            }
        }
    }
</script>
</body>
</html>