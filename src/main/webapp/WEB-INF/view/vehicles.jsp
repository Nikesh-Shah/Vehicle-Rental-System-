<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicles Available for Rent</title>
    <link rel="stylesheet" href=${pageContext.request.contextPath}/assets/css/vehicles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>

        /* Search Container */
        .search-container {
            max-width: 600px;
            margin: 0 auto 30px;
        }

        .search-input {
            width: 100%;
            padding: 12px 20px;
            border: 2px solid #ddd;
            border-radius: 30px 0 0 30px;
            font-size: 16px;
            outline: none;
            transition: border-color 0.3s;
        }

        .search-input:focus {
            border-color: #3498db;
        }

        .search-button {
            padding: 12px 25px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 0 30px 30px 0;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .search-button:hover {
            background-color: #2980b9;
        }

        /* Error Message */
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

    </style>
</head>
<body style="margin-top: 50px">
<section>
<!-- Include navbar -->
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<div class="container">
    <header class="page-header">
        <h1 class="page-title">Vehicles Available for Rent</h1>

        <div class="search-container">
            <form onsubmit="return handleSearch()" style="width: 100%; display: flex;">
                <input type="text" id="vehicle-search" class="search-input" placeholder="Find your perfect vehicle...">
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i> Search
                </button>
            </form>
        </div>
    </header>



    <!-- Error message if there are issues loading the vehicles -->
    <c:if test="${not empty errorMessage}">
        <div id="error-container">${errorMessage}</div>
    </c:if>


    <div class="vehicles-grid" id="vehicles-container">
        <!-- Vehicle cards will be populated here -->
        <c:forEach var="vehicle" items="${vehicles}">
            <div class="vehicle-card">
                <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}" class="vehicle-image">
                <div class="vehicle-details">
                    <h3 class="vehicle-brand">${vehicle.brand}</h3>
                    <p class="vehicle-model">${vehicle.model}</p>
                    <p class="vehicle-price">$${vehicle.pricePerDay} / day</p>
                    <span id="status-${vehicle.vehicleId}" class="vehicle-status ${vehicle.status == 'Available' ? 'status-available' : vehicle.status == 'Rented' ? 'status-rented' : 'status-maintenance'}">
                            ${vehicle.status}
                    </span>
                    <p class="vehicle-category">Category: ${vehicle.categoryId}</p>
                    <div class="vehicle-actions">
                        <button id="rent-btn-${vehicle.vehicleId}" class="btn btn-primary" onclick="rentVehicle(${vehicle.vehicleId})" ${vehicle.status != 'Available' ? 'disabled' : ''}>
                            Rent Now
                        </button>
                        <button class="btn btn-secondary" onclick="learnMore(${vehicle.vehicleId})">
                            Learn More
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>


    <div class="pagination">
        <button class="pagination-button" onclick="navigatePage('previous')">
            <i class="fas fa-chevron-left"></i> Previous
        </button>
        <button class="pagination-button" onclick="navigatePage('next')">
            Next <i class="fas fa-chevron-right"></i>
        </button>
    </div>
</div>
</div>
</section>

<!-- Include footer -->
<jsp:include page="/WEB-INF/view/common/footer.jsp" />

<!-- JavaScript -->
<script src="/public/js/vehicle-scripts.js"></script>
</body>
</html>
