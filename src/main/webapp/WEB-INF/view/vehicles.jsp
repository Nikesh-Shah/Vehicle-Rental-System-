<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicles Available for Rent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vehicle.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<section class="vehicle">
<div class="container">
    <div class="page-title">
        <h1>Vehicles Available for Rent</h1>
        <p>Choose from our premium selection of vehicles</p>
    </div>

    <div class="vehicle-grid">    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">Popular</span>
                <img src="https://images.unsplash.com/photo-1580273916550-e323be2ae537?auto=format&fit=crop&w=500&h=300" alt="Tesla Model S">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>Tesla Model S</h3>
                    <div class="vehicle-price">Rs 5000<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 5 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 2 Bags</div>
                    <div class="spec"><i class="fas fa-bolt"></i> Electric</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Auto</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">Luxury</span>
                <img src="https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=500&h=300" alt="Mercedes S-Class">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>Mercedes S-Class</h3>
                    <div class="vehicle-price">Rs 5000<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 5 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 3 Bags</div>
                    <div class="spec"><i class="fas fa-gas-pump"></i> Hybrid</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Auto</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">SUV</span>
                <img src="https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=500&h=300" alt="Range Rover Sport">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>Range Rover Sport</h3>
                    <div class="vehicle-price">Rs 5000<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 7 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 4 Bags</div>
                    <div class="spec"><i class="fas fa-gas-pump"></i> Diesel</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Auto</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">Sport</span>
                <img src="https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=500&h=300" alt="Porsche 911">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>Porsche 911</h3>
                    <div class="vehicle-price">Rs 5000<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 2 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 1 Bag</div>
                    <div class="spec"><i class="fas fa-gas-pump"></i> Petrol</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Manual</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">Economy</span>
                <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&w=500&h=300" alt="Toyota Corolla">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>Toyota Corolla</h3>
                    <div class="vehicle-price">$89<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 5 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 2 Bags</div>
                    <div class="spec"><i class="fas fa-gas-pump"></i> Hybrid</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Auto</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">New</span>
                <img src="https://images.unsplash.com/photo-1609521263047-f8f205293f24?auto=format&fit=crop&w=500&h=300" alt="BMW i4">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>BMW i4</h3>
                    <div class="vehicle-price">Rs 5000<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 5 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 2 Bags</div>
                    <div class="spec"><i class="fas fa-bolt"></i> Electric</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Auto</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">Convertible</span>
                <img src="https://images.unsplash.com/photo-1583121274602-3e2820c69888?auto=format&fit=crop&w=500&h=300" alt="Audi A5 Cabriolet">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>Audi A5 Cabriolet</h3>
                    <div class="vehicle-price">$229<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 4 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 2 Bags</div>
                    <div class="spec"><i class="fas fa-gas-pump"></i> Petrol</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Auto</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>

        <div class="vehicle-card">
            <div class="vehicle-image">
                <span class="vehicle-tag">Compact</span>
                <img src="https://images.unsplash.com/photo-1580273916550-e323be2ae537?auto=format&fit=crop&w=500&h=300" alt="Volkswagen Golf">
            </div>
            <div class="vehicle-details">
                <div class="vehicle-name">
                    <h3>Volkswagen Golf</h3>
                    <div class="vehicle-price">Rs 5000<span>/day</span></div>
                </div>
                <div class="vehicle-specs">
                    <div class="spec"><i class="fas fa-user"></i> 5 Seats</div>
                    <div class="spec"><i class="fas fa-suitcase"></i> 2 Bags</div>
                    <div class="spec"><i class="fas fa-gas-pump"></i> Petrol</div>
                    <div class="spec"><i class="fas fa-tachometer-alt"></i> Manual</div>
                </div>
                <div class="vehicle-actions">
                    <a href="#" class="btn btn-outline">Learn More</a>
                    <a href="#" class="btn btn-primary">Rent Now</a>
                </div>
            </div>
        </div>
    </div>
</div>
</section>
<jsp:include page="/WEB-INF/view/common/footer.jsp" />

</body>
</html>
