<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vehicles Available for Rent</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/vehicles.css" />
    <script>
        function handleRentClick(vehicleId) {
            var isLoggedIn = ${not empty sessionScope.userId ? 'true' : 'false'};
            if (!isLoggedIn) {
                if (confirm("You must be logged in to rent a vehicle. Do you want to log in now?")) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                }
                return false;
            } else {
                // Redirect to rent form with vehicleId
                window.location.href = '${pageContext.request.contextPath}/rent-form?vehicleId=' + vehicleId;
            }
        }
    </script>
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>
<section style="margin-top: 100px">
    <div class="container">
        <header class="page-header">
            <h1 class="page-title">Vehicles Available for Rent</h1>

            <div class="search-container">
                <form action="vehicles" method="get" style="width: 100%; display: flex;">
                    <input type="text" id="vehicle-search" name="query" class="search-input" placeholder="Find your perfect vehicle..." />
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i> Search
                    </button>
                </form>
            </div>
        </header>

        <c:if test="${not empty errorMessage}">
            <div id="error-container">${errorMessage}</div>
        </c:if>

        <div class="vehicles-grid" id="vehicles-container">
            <c:forEach var="vehicle" items="${vehicles}">
                <div class="vehicle-card">
                    <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}" class="vehicle-image" />
                    <div class="vehicle-details">
                        <h3 class="vehicle-brand">${vehicle.brand}</h3>
                        <p class="vehicle-model">${vehicle.model}</p>
                        <p class="vehicle-price">NRs${vehicle.pricePerDay} / day</p>
                        <span id="status-${vehicle.vehicleId}" class="vehicle-status ${vehicle.status == 'Available' ? 'status-available' : vehicle.status == 'Rented' ? 'status-rented' : 'status-maintenance'}">
                                ${vehicle.status}
                        </span>
                        <a href="javascript:void(0);" onclick="handleRentClick(${vehicle.vehicleId});" class="rent-now-button">
                            Rent Now
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>
