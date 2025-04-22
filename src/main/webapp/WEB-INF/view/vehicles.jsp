<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicles - GoRental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vehicle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>
<section class="vehicle">
    <div class="container">
        <h1 class="section-title">Explore Our Premium Vehicles</h1>

        <div class="search-filter-container">
            <div class="search-box">
                <input type="text" placeholder="Search by make, model, or type..." class="search-input">
                <span class="search-icon"><i class="fas fa-search"></i></span>
            </div>

            <div class="filter-options">
                <div class="dropdown">
                    <button class="dropdown-btn">All Categories <span class="dropdown-arrow"><i class="fas fa-chevron-down"></i></span></button>
                </div>

                <div class="filter-btn">
                    <span class="filter-icon"><i class="fas fa-sliders-h"></i></span> Filter
                </div>

                <div class="dropdown">
                    <button class="dropdown-btn">Price <span class="dropdown-arrow"><i class="fas fa-chevron-down"></i></span></button>
                </div>
            </div>
        </div>

        <div class="vehicles-grid">
            <!-- Vehicle 1 -->
            <div class="vehicle-card">
                <div class="vehicle-image">
                    <div class="featured-tag">Featured</div>
                    <img src="${pageContext.request.contextPath}/assets/images/toyota-ae86.jpg" alt="Toyota AE86 Sprinter Trueno">
                </div>
                <div class="vehicle-info">
                    <h2 class="vehicle-title">Toyota AE86 Sprinter Trueno</h2>
                    <p class="vehicle-price">$59/day</p>
                    <div class="vehicle-details">
                        <p class="vehicle-model">AE86</p>
                        <div class="vehicle-specs">
                            <div class="spec">
                                <span class="spec-label">Seats</span>
                                <span class="spec-value">4</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Transmission</span>
                                <span class="spec-value">Manual</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Fuel</span>
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
                    <p class="vehicle-price">$89/day</p>
                    <div class="vehicle-details">
                        <p class="vehicle-model">Skyline</p>
                        <div class="vehicle-specs">
                            <div class="spec">
                                <span class="spec-label">Seats</span>
                                <span class="spec-value">4</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Transmission</span>
                                <span class="spec-value">Manual</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Fuel</span>
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
                    <img src="${pageContext.request.contextPath}/assets/images/honda-s2000.jpg" alt="Honda S2000">
                </div>
                <div class="vehicle-info">
                    <h2 class="vehicle-title">Honda S2000</h2>
                    <p class="vehicle-price">$65/day</p>
                    <div class="vehicle-details">
                        <p class="vehicle-model">S2000</p>
                        <div class="vehicle-specs">
                            <div class="spec">
                                <span class="spec-label">Seats</span>
                                <span class="spec-value">2</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Transmission</span>
                                <span class="spec-value">Manual</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Fuel</span>
                                <span class="spec-value">Gasoline</span>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/rent?vehicle=honda-s2000" class="btn-view-details">Rent Now</a>
                </div>
            </div>

            <!-- Vehicle 4 -->
            <div class="vehicle-card">
                <div class="vehicle-image">
                    <img src="${pageContext.request.contextPath}/assets/images/mazda-rx7.jpg" alt="Mazda RX-7 FD">
                </div>
                <div class="vehicle-info">
                    <h2 class="vehicle-title">Mazda RX-7 FD</h2>
                    <p class="vehicle-price">$75/day</p>
                    <div class="vehicle-details">
                        <p class="vehicle-model">RX-7</p>
                        <div class="vehicle-specs">
                            <div class="spec">
                                <span class="spec-label">Seats</span>
                                <span class="spec-value">2</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Transmission</span>
                                <span class="spec-value">Manual</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Fuel</span>
                                <span class="spec-value">Gasoline</span>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/rent?vehicle=mazda-rx7" class="btn-view-details">Rent Now</a>
                </div>
            </div>

            <!-- Vehicle 5 -->
            <div class="vehicle-card">
                <div class="vehicle-image">
                    <div class="featured-tag">Featured</div>
                    <img src="${pageContext.request.contextPath}/assets/images/mitsubishi-lancer-evo.jpg" alt="Mitsubishi Lancer Evolution IX">
                </div>
                <div class="vehicle-info">
                    <h2 class="vehicle-title">Mitsubishi Lancer Evolution IX</h2>
                    <p class="vehicle-price">$79/day</p>
                    <div class="vehicle-details">
                        <p class="vehicle-model">Lancer Evo IX</p>
                        <div class="vehicle-specs">
                            <div class="spec">
                                <span class="spec-label">Seats</span>
                                <span class="spec-value">5</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Transmission</span>
                                <span class="spec-value">Manual</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Fuel</span>
                                <span class="spec-value">Gasoline</span>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/rent?vehicle=mitsubishi-lancer-evo" class="btn-view-details">Rent Now</a>
                </div>
            </div>

            <!-- Vehicle 6 -->
            <div class="vehicle-card">
                <div class="vehicle-image">
                    <img src="${pageContext.request.contextPath}/assets/images/subaru-wrx-sti.jpg" alt="Subaru WRX STI">
                </div>
                <div class="vehicle-info">
                    <h2 class="vehicle-title">Subaru WRX STI</h2>
                    <p class="vehicle-price">$72/day</p>
                    <div class="vehicle-details">
                        <p class="vehicle-model">WRX STI</p>
                        <div class="vehicle-specs">
                            <div class="spec">
                                <span class="spec-label">Seats</span>
                                <span class="spec-value">5</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Transmission</span>
                                <span class="spec-value">Manual</span>
                            </div>
                            <div class="spec">
                                <span class="spec-label">Fuel</span>
                                <span class="spec-value">Gasoline</span>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/rent?vehicle=subaru-wrx-sti" class="btn-view-details">Rent Now</a>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <a href="#" class="page-link active">1</a>
            <a href="#" class="page-link">2</a>
            <a href="#" class="page-link">3</a>
            <a href="#" class="page-link"><i class="fas fa-chevron-right"></i></a>
        </div>
    </div>

</section>

<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>