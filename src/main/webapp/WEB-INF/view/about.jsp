<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - GORental</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/about.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">

</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<section class="about">
<div class="container">

    <section class="about-header">
        <div class="about-text">
            <h1>About Our Company</h1>
            <p>We're dedicated to providing exceptional car rental services with a focus on quality, convenience, and customer satisfaction.</p>
            <a href="#" class="btn">Browse our Fleet</a>
            <a href="#" class="btn outline">Contact Us</a>
        </div>
        <div class="about-image"></div>
    </section>

    <section class="story-section">
        <h2>Our Story</h2>
        <p>Founded in 2010, our car rental service began with a small fleet of just 5 vehicles. Today, we've grown to become one of the leading car rental providers in the region with over 100 vehicles and multiple locations.</p>

        <div class="story-content">
            <div class="story-image"></div>
            <div class="story-text">
                <h3>From Small Beginnings to Industry Leader</h3>
                <p>What started as a small family business has grown into a trusted name in the car rental industry. Our journey has been defined by our commitment to quality service and customer satisfaction.</p>
                <p>We've continuously expanded our fleet to include the latest models and a wide range of vehicle types to meet every customer's needs - from economy cars to luxury vehicles and everything in between.</p>
                <p>Throughout our growth, we've maintained our core values of transparency, reliability, and exceptional service that have been the foundation of our success.</p>
            </div>
        </div>
    </section>

    <section class="values-section">
        <h2>Our Values</h2>
        <p>Our core values guide everything we do, from how we maintain our vehicles to how we interact with our customers.</p>

        <div class="values-grid">
            <div class="value-card">
                <div class="value-icon">🚗</div>
                <h3>Quality</h3>
                <p>We maintain a modern fleet of well-serviced vehicles to ensure reliability and safety.</p>
            </div>

            <div class="value-card">
                <div class="value-icon">✓</div>
                <h3>Reliability</h3>
                <p>We deliver on our promises and ensure a hassle-free rental experience every time.</p>
            </div>

            <div class="value-card">
                <div class="value-icon">👥</div>
                <h3>Customer Focus</h3>
                <p>We put our customers first and strive to exceed expectations with every interaction.</p>
            </div>

            <div class="value-card">
                <div class="value-icon">⏱</div>
                <h3>Efficiency</h3>
                <p>We value your time and have streamlined our processes for quick and easy rentals.</p>
            </div>
        </div>
    </section>
</div>
</section>
<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>