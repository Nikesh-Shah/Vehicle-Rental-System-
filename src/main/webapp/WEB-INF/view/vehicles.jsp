<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicles - GoRental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vehicle.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<div class="container">
    <h1 class="section-title">Available Vehicles</h1>

    <div class="search-filter-container">
        <div class="search-box">
            <input type="text" placeholder="Search Vehicles..." class="search-input">
            <span class="search-icon">🔍</span>
        </div>

        <div class="filter-options">
            <div class="dropdown">
                <button class="dropdown-btn">All Categories <span class="dropdown-arrow">▼</span></button>
            </div>

            <div class="filter-btn">
                <span class="filter-icon">⚙️</span> Filter
            </div>

            <div class="dropdown">
                <button class="dropdown-btn">Price <span class="dropdown-arrow">▼</span></button>
            </div>
        </div>
    </div>

    <div class="vehicles-grid">
        <!-- Vehicle 1 -->
        <div class="vehicle-card">
            <div class="vehicle-image">
                <img src="${pageContext.request.contextPath}/assets/images/toyota-ae86.jpg" alt="Toyota AE86 Sprinter Trueno">
            </div>
            <div class="vehicle-info">
                <h2 class="vehicle-title">Toyota AE86 Sprinter Trueno</h2>
                <p class="vehicle-price">$59/day</p>
                <div class="vehicle-details">
                    <p class="vehicle-model">EA86</p>
                    <div class="vehicle-specs">
                        <div class="spec">
                            <span class="spec-label">Seats:</span>
                            <span class="spec-value">4</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Transmission:</span>
                            <span class="spec-value">Manual</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Fuel:</span>
                            <span class="spec-value">Gasoline</span>
                        </div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/rent?vehicle=toyota-ae86" class="btn-view-details">Rent Now</a>
            </div>
        </div>

        <!-- Vehicle 2 -->
        <div class="vehicle-card">
            <div class="vehicle-image">
                <img src="${pageContext.request.contextPath}/assets/images/nissan-skyline-r34.jpg" alt="1999 Nissan Skyline GTR R34">
            </div>
            <div class="vehicle-info">
                <h2 class="vehicle-title">1999 Nissan Skyline GTR R34</h2>
                <p class="vehicle-price">$59/day</p>
                <div class="vehicle-details">
                    <p class="vehicle-model">Skyline</p>
                    <div class="vehicle-specs">
                        <div class="spec">
                            <span class="spec-label">Seats:</span>
                            <span class="spec-value">4</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Transmission:</span>
                            <span class="spec-value">Manual</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Fuel:</span>
                            <span class="spec-value">Gasoline</span>
                        </div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/rent?vehicle=nissan-skyline-r34" class="btn-view-details">Rent Now</a>
            </div>
        </div>

        <!-- Vehicle 3 -->
        <div class="vehicle-card">
            <div class="vehicle-image">
                <img src="${pageContext.request.contextPath}/assets/images/toyota-ae86.jpg" alt="Toyota AE86 Sprinter Trueno">
            </div>
            <div class="vehicle-info">
                <h2 class="vehicle-title">Toyota AE86 Sprinter Trueno</h2>
                <p class="vehicle-price">$59/day</p>
                <div class="vehicle-details">
                    <p class="vehicle-model">EA86</p>
                    <div class="vehicle-specs">
                        <div class="spec">
                            <span class="spec-label">Seats:</span>
                            <span class="spec-value">4</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Transmission:</span>
                            <span class="spec-value">Manual</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Fuel:</span>
                            <span class="spec-value">Gasoline</span>
                        </div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/rent?vehicle=toyota-ae86-2" class="btn-view-details">Rent Now</a>
            </div>
        </div>

        <!-- Vehicle 4 -->
        <div class="vehicle-card">
            <div class="vehicle-image">
                <img src="${pageContext.request.contextPath}/assets/images/nissan-skyline-r34.jpg" alt="1999 Nissan Skyline GTR R34">
            </div>
            <div class="vehicle-info">
                <h2 class="vehicle-title">1999 Nissan Skyline GTR R34</h2>
                <p class="vehicle-price">$59/day</p>
                <div class="vehicle-details">
                    <p class="vehicle-model">Skyline</p>
                    <div class="vehicle-specs">
                        <div class="spec">
                            <span class="spec-label">Seats:</span>
                            <span class="spec-value">4</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Transmission:</span>
                            <span class="spec-value">Manual</span>
                        </div>
                        <div class="spec">
                            <span class="spec-label">Fuel:</span>
                            <span class="spec-value">Gasoline</span>
                        </div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/rent?vehicle=nissan-skyline-r34-2" class="btn-view-details">Rent Now</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>