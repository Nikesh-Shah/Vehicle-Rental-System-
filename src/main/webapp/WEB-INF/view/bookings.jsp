<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bookings.css">--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">--%>
<%--    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">--%>
<%--<body>--%>
<%--<%@ include file="/WEB-INF/view/common/navbar.jsp" %>--%>

<%--<section class="bookings-section">--%>
<%--    <div class="container">--%>
<%--        <h1 class="section-title">My Bookings</h1>--%>

<%--        <div class="bookings-tabs">--%>
<%--            <button class="tab-btn active" data-tab="current">Current Bookings</button>--%>
<%--            <button class="tab-btn" data-tab="previous">Previous Bookings</button>--%>
<%--        </div>--%>

<%--        <div class="tab-content">--%>
<%--            <!-- Current Bookings Tab -->--%>
<%--            <div class="tab-pane active" id="current-bookings">--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${not empty currentBookings}">--%>
<%--                        <div class="bookings-grid">--%>
<%--                            <c:forEach var="booking" items="${currentBookings}">--%>
<%--                                <div class="booking-card">--%>
<%--                                    <div class="booking-image">--%>
<%--                                        <img src="${pageContext.request.contextPath}/assets/images/${vehicle.image}" alt="${booking.vehicleName}">--%>
<%--                                    </div>--%>
<%--                                    <div class="booking-info">--%>
<%--                                        <h3 class="booking-vehicle">${booking.vehicleName}</h3>--%>
<%--                                        <div class="booking-dates">--%>
<%--                                            <div class="date-group">--%>
<%--                                                <span class="date-label"><i class="fas fa-calendar-check"></i> Pickup</span>--%>
<%--                                                <span class="date-value">${booking.pickupDate} at ${booking.pickupTime}</span>--%>
<%--                                            </div>--%>
<%--                                            <div class="date-group">--%>
<%--                                                <span class="date-label"><i class="fas fa-calendar-times"></i> Return</span>--%>
<%--                                                <span class="date-value">${booking.returnDate} at ${booking.returnTime}</span>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                        <div class="booking-location">--%>
<%--                                            <i class="fas fa-map-marker-alt"></i> ${booking.location}--%>
<%--                                        </div>--%>
<%--                                        <div class="booking-status ${booking.status == 'Confirmed' ? 'confirmed' : 'pending'}">--%>
<%--                                            <i class="fas ${booking.status == 'Confirmed' ? 'fa-check-circle' : 'fa-clock'}"></i> ${booking.status}--%>
<%--                                        </div>--%>
<%--                                        <div class="booking-actions">--%>
<%--                                            <a href="${pageContext.request.contextPath}/bookings/details?id=${booking.id}" class="btn-details">View Details</a>--%>
<%--                                            <a href="${pageContext.request.contextPath}/bookings/cancel?id=${booking.id}" class="btn-cancel">Cancel</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </c:forEach>--%>
<%--                        </div>--%>
<%--                    </c:when>--%>
<%--                    <c:otherwise>--%>
<%--                        <div class="no-bookings">--%>
<%--                            <div class="no-bookings-icon">--%>
<%--                                <i class="fas fa-calendar-xmark"></i>--%>
<%--                            </div>--%>
<%--                            <h3>You don't have any current bookings</h3>--%>
<%--                            <p>Explore our collection of premium vehicles and book your next ride today!</p>--%>
<%--                            <a href="${pageContext.request.contextPath}/vehicles" class="btn-browse-vehicles">--%>
<%--                                <i class="fas fa-car"></i> Browse Vehicles--%>
<%--                            </a>--%>
<%--                        </div>--%>
<%--                    </c:otherwise>--%>
<%--                </c:choose>--%>
<%--            </div>--%>

<%--            <!-- Previous Bookings Tab -->--%>
<%--            <div class="tab-pane" id="previous-bookings">--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${not empty previousBookings}">--%>
<%--                        <div class="bookings-grid">--%>
<%--                            <c:forEach var="booking" items="${previousBookings}">--%>
<%--                                <div class="booking-card">--%>
<%--                                    <div class="booking-image">--%>
<%--                                        <img src="${pageContext.request.contextPath}/assets/images/${booking.vehicleImage}" alt="${booking.vehicleName}">--%>
<%--                                    </div>--%>
<%--                                    <div class="booking-info">--%>
<%--                                        <h3 class="booking-vehicle">${booking.vehicleName}</h3>--%>
<%--                                        <div class="booking-dates">--%>
<%--                                            <div class="date-group">--%>
<%--                                                <span class="date-label"><i class="fas fa-calendar-check"></i> Pickup</span>--%>
<%--                                                <span class="date-value">${booking.pickupDate} at ${booking.pickupTime}</span>--%>
<%--                                            </div>--%>
<%--                                            <div class="date-group">--%>
<%--                                                <span class="date-label"><i class="fas fa-calendar-times"></i> Return</span>--%>
<%--                                                <span class="date-value">${booking.returnDate} at ${booking.returnTime}</span>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                        <div class="booking-location">--%>
<%--                                            <i class="fas fa-map-marker-alt"></i> ${booking.location}--%>
<%--                                        </div>--%>
<%--                                        <div class="booking-status completed">--%>
<%--                                            <i class="fas fa-check-circle"></i> Completed--%>
<%--                                        </div>--%>
<%--                                        <div class="booking-actions">--%>
<%--                                            <a href="${pageContext.request.contextPath}/bookings/details?id=${booking.id}" class="btn-details">View Details</a>--%>
<%--                                            <a href="${pageContext.request.contextPath}/bookings/review?id=${booking.id}" class="btn-review">Write Review</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </c:forEach>--%>
<%--                        </div>--%>
<%--                    </c:when>--%>
<%--                    <c:otherwise>--%>
<%--                        <div class="no-bookings">--%>
<%--                            <div class="no-bookings-icon">--%>
<%--                                <i class="fas fa-history"></i>--%>
<%--                            </div>--%>
<%--                            <h3>No previous bookings found</h3>--%>
<%--                            <p>Your booking history will appear here once you've completed rentals.</p>--%>
<%--                            <a href="${pageContext.request.contextPath}/vehicles" class="btn-browse-vehicles">--%>
<%--                                <i class="fas fa-car"></i> Browse Vehicles--%>
<%--                            </a>--%>
<%--                        </div>--%>
<%--                    </c:otherwise>--%>
<%--                </c:choose>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="new-booking-cta">--%>
<%--            <a href="${pageContext.request.contextPath}/vehicles" class="btn-new-booking">--%>
<%--                <i class="fas fa-plus-circle"></i> Book a New Vehicle--%>
<%--            </a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</section>--%>

<%--<jsp:include page="/WEB-INF/view/common/footer.jsp" />--%>

<%--<script>--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        // Tab functionality--%>
<%--        const tabButtons = document.querySelectorAll('.tab-btn');--%>
<%--        const tabPanes = document.querySelectorAll('.tab-pane');--%>

<%--        tabButtons.forEach(button => {--%>
<%--            button.addEventListener('click', function() {--%>
<%--                // Remove active class from all buttons and panes--%>
<%--                tabButtons.forEach(btn => btn.classList.remove('active'));--%>
<%--                tabPanes.forEach(pane => pane.classList.remove('active'));--%>

<%--                // Add active class to clicked button--%>
<%--                this.classList.add('active');--%>

<%--                // Show corresponding tab pane--%>
<%--                const tabId = this.getAttribute('data-tab');--%>
<%--                document.getElementById(tabId + '-bookings').classList.add('active');--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<%--<jsp:include page="/WEB-INF/view/common/footer.jsp" />--%>
<%--</body>--%>

