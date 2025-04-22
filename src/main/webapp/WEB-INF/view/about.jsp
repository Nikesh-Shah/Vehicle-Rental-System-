<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - GORental</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/about.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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
            <div class="about-image">
                <img src="${pageContext.request.contextPath}/assets/images/1.jpg" alt="car">
            </div>
        </section>

        <section class="story-section">
            <h2>Our Story</h2>
            <p>Founded in 2010, our car rental service began with a small fleet of just 5 vehicles. Today, we've grown to become one of the leading car rental providers in the region with over 100 vehicles and multiple locations.</p>

            <div class="story-content">
                <div class="story-image">
                    <img src="${pageContext.request.contextPath}/assets/images/1.jpg" alt="BashuDev">
                </div>
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
<div class="container">
    <!-- Team Section -->
    <section class="team-section">
        <h1 class="section-title">Our Team</h1>
        <div class="underline"></div>
        <p class="section-description">Meet the dedicated professionals who lead our company and ensure we deliver exceptional service.</p>

        <div class="team-grid">
            <!-- Team Member 1 -->
            <div class="team-card" data-aos="fade-up">
                <div class="team-image">
                    <img src="${pageContext.request.contextPath}/assets/images/M2.jpg" alt="Nikesh">
                </div>
                <div class="team-info">
                    <h3 class="team-name">Nikesh Shah</h3>
                    <p class="team-position">Team Leader</p>
                    <p class="team-id">23056688</p>
                    <p class="team-bio">Leads our team with expertise in fleet management and customer service excellence.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
            </div>

            <!-- Team Member 2 -->
            <div class="team-card" data-aos="fade-up" data-aos-delay="100">
                <div class="team-image">
                    <img src="${pageContext.request.contextPath}/assets/images/sudish.jpg" alt="Sudish">
                </div>
                <div class="team-info">
                    <h3 class="team-name">Sudish karki</h3>
                    <p class="team-position">Member</p>
                    <p class="team-id">23056773</p>
                    <p class="team-bio">Specializes in vehicle maintenance and ensuring our fleet meets quality standards.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
            </div>

            <!-- Team Member 3 -->
            <div class="team-card" data-aos="fade-up" data-aos-delay="200">
                <div class="team-image">
                    <img src="${pageContext.request.contextPath}/assets/images/rejina.jpg" alt="Rejina">
                </div>
                <div class="team-info">
                    <h3 class="team-name">Rejina Dangal</h3>
                    <p class="team-position">Member</p>
                    <p class="team-id">23056714</p>
                    <p class="team-bio">Manages customer relations and ensures exceptional service delivery.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
            </div>

            <!-- Team Member 4 -->
            <div class="team-card" data-aos="fade-up" data-aos-delay="300">
                <div class="team-image">
                    <img src="${pageContext.request.contextPath}/assets/images/soohang.jpg" alt="Soohang">
                </div>
                <div class="team-info">
                    <h3 class="team-name">Soohang Lingkhim Limbu</h3>
                    <p class="team-position">Member</p>
                    <p class="team-id">23056769</p>
                    <p class="team-bio">Handles booking operations and fleet logistics for smooth service delivery.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
            </div>

            <!-- Team Member 5 -->
            <div class="team-card" data-aos="fade-up" data-aos-delay="400">
                <div class="team-image">
                    <img src="${pageContext.request.contextPath}/assets/images/vasu.jpg" alt="BashuDev">
                </div>
                <div class="team-info">
                    <h3 class="team-name">BashuDev Baidya</h3>
                    <p class="team-position">Member</p>
                    <p class="team-id">23056635</p>
                    <p class="team-bio">Focuses on technology integration and digital solutions for our services.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Achievement Section -->
    <section class="achievement-section">
        <h1 class="section-title">Our Achievement</h1>
        <div class="underline"></div>
        <p class="section-description">We're proud of our accomplishments and the recognition we've received for our service excellence.</p>

        <div class="achievement-grid">
            <!-- Recognition Column -->
            <div class="achievement-card" data-aos="fade-right">
                <div class="achievement-header">
                    <i class="fas fa-trophy"></i>
                    <h3>Achievement & Recognition</h3>
                </div>
                <ul class="achievement-list">
                    <li><i class="fas fa-check-circle"></i> Best Car Rental Service 2023 - City Business Awards</li>
                    <li><i class="fas fa-check-circle"></i> Customer Service Excellence Award 2022</li>
                    <li><i class="fas fa-check-circle"></i> Green Fleet Initiative Recognition 2021</li>
                    <li><i class="fas fa-check-circle"></i> Top 10 Car Rental Companies 2020-Industry Magazine</li>
                </ul>
            </div>

            <!-- Numbers Column -->
            <div class="achievement-card" data-aos="fade-left">
                <div class="achievement-header">
                    <i class="fas fa-chart-line"></i>
                    <h3>By the Numbers</h3>
                </div>
                <div class="stats-container">
                    <div class="stat-item">
                        <h2 class="counter">100+</h2>
                        <p>Vehicles in our fleet</p>
                    </div>
                    <div class="stat-item">
                        <h2 class="counter">15,000+</h2>
                        <p>Happy customers annually</p>
                    </div>
                    <div class="stat-item">
                        <h2 class="counter">5</h2>
                        <p>Locations across the region</p>
                    </div>
                    <div class="stat-item">
                        <h2 class="counter">98%</h2>
                        <p>Customer satisfaction rate</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="cta-content" data-aos="fade-right">
            <h2>Ready to Experience Our Service?</h2>
            <p>Browse our fleet of quality vehicles and book your next rental today. We're committed to making your journey comfortable and hassle-free.</p>
            <button class="cta-button">Browse Vehicle <i class="fas fa-arrow-right"></i></button>
        </div>
        <div class="cta-image" data-aos="fade-left">
            <img src="${pageContext.request.contextPath}/assets/images/1.jpg" alt="BashuDev">
        </div>
    </section>
</div>

<!-- AOS Animation Library -->
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
<script>
    // Initialize AOS animation
    AOS.init({
        duration: 800,
        once: false
    });

    // Counter animation for statistics
    document.addEventListener("DOMContentLoaded", function() {
        const counters = document.querySelectorAll('.counter');
        const speed = 200;

        counters.forEach(counter => {
            const updateCount = () => {
                const target = parseInt(counter.innerText);
                const count = parseInt(counter.innerText);

                if (count < target) {
                    counter.innerText = count + 1;
                    setTimeout(updateCount, speed);
                }
            };

            updateCount();
        });
    });
</script>
<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>