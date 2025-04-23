<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/home.css" />

<!-- Testimonials Section -->
<section class="testimonials-section">
    <div class="container">
        <h1>What Our Customers Say</h1>
        <p class="subtitle">Don't just take our word for it. See what our satisfied customers have to say about their rental experience.</p>

        <div class="testimonials-container">
            <div class="testimonial-controls">
                <button class="control-btn prev-btn" aria-label="Previous testimonial">
                    <i class="fas fa-chevron-left"></i>
                </button>
            </div>

            <div class="testimonials-slider">
                <!-- Testimonial 1 -->
                <div class="testimonial-card active">
                    <div class="testimonial-content">
                        <div class="quote-icon">
                            <i class="fas fa-quote-left"></i>
                        </div>
                        <p class="testimonial-text">The rental process was incredibly smooth from start to finish. The car was in perfect condition, and the staff was friendly and professional. I'll definitely be using GoRental for all my future trips!</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                    <div class="testimonial-author">
                        <div class="author-image">
                            <img src="${pageContext.request.contextPath}/assets/images/testimonial1.jpg" alt="Sarah Johnson" onerror="this.src='https://ui-avatars.com/api/?name=Sarah+Johnson&background=4361ee&color=fff'">
                        </div>
                        <div class="author-info">
                            <h4>Madan Bhandari</h4>
                            <p>Business Traveler</p>
                        </div>
                    </div>
                </div>

                <!-- Testimonial 2 -->
                <div class="testimonial-card">
                    <div class="testimonial-content">
                        <div class="quote-icon">
                            <i class="fas fa-quote-left"></i>
                        </div>
                        <p class="testimonial-text">I rented a luxury car for my anniversary, and it made our special day even more memorable. The vehicle was spotless, and the pickup/drop-off process was quick and efficient. Highly recommend!</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                    <div class="testimonial-author">
                        <div class="author-image">
                            <img src="${pageContext.request.contextPath}/assets/images/testimonial2.jpg" alt="Michael Chen" onerror="this.src='https://ui-avatars.com/api/?name=Michael+Chen&background=4361ee&color=fff'">
                        </div>
                        <div class="author-info">
                            <h4>Rohan Rai</h4>
                            <p>Frequent Customer</p>
                        </div>
                    </div>
                </div>

                <!-- Testimonial 3 -->
                <div class="testimonial-card">
                    <div class="testimonial-content">
                        <div class="quote-icon">
                            <i class="fas fa-quote-left"></i>
                        </div>
                        <p class="testimonial-text">As someone who travels frequently for work, I've used many rental services, but GoRental stands out. Their customer service is exceptional, and they always have the perfect vehicle for my needs.</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                    </div>
                    <div class="testimonial-author">
                        <div class="author-image">
                            <img src="${pageContext.request.contextPath}/assets/images/testimonial3.jpg" alt="Emily Rodriguez" onerror="this.src='https://ui-avatars.com/api/?name=Emily+Rodriguez&background=4361ee&color=fff'">
                        </div>
                        <div class="author-info">
                            <h4>Munal Limbu</h4>
                            <p>Corporate Client</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="testimonial-controls">
                <button class="control-btn next-btn" aria-label="Next testimonial">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>

        <div class="testimonial-indicators">
            <span class="indicator active" data-index="0"></span>
            <span class="indicator" data-index="1"></span>
            <span class="indicator" data-index="2"></span>
        </div>
    </div>
</section>

<!-- Why Choose Us Section -->
<section class="benefits-section">
    <div class="container">
        <h1>Why Choose GoRental</h1>
        <p class="subtitle">We're committed to providing exceptional service and value with every rental. Here's what sets us apart.</p>

        <div class="benefits-grid">
            <!-- Benefit 1 -->
            <div class="benefit-card">
                <div class="benefit-icon">
                    <i class="fas fa-car"></i>
                </div>
                <h3>Premium Fleet</h3>
                <p>Our vehicles are regularly maintained and never more than two years old, ensuring you get a safe, reliable, and comfortable ride every time.</p>
            </div>

            <!-- Benefit 2 -->
            <div class="benefit-card">
                <div class="benefit-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <h3>Transparent Pricing</h3>
                <p>No hidden fees or surprise charges. Our pricing is clear and competitive, with all taxes and insurance options clearly explained upfront.</p>
            </div>

            <!-- Benefit 3 -->
            <div class="benefit-card">
                <div class="benefit-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <h3>24/7 Support</h3>
                <p>Our customer service team is available around the clock to assist with any questions or issues that may arise during your rental period.</p>
            </div>

            <!-- Benefit 4 -->
            <div class="benefit-card">
                <div class="benefit-icon">
                    <i class="fas fa-bolt"></i>
                </div>
                <h3>Quick Booking</h3>
                <p>Our streamlined booking process lets you reserve your vehicle in minutes, with instant confirmation and paperless transactions.</p>
            </div>

            <!-- Benefit 5 -->
            <div class="benefit-card">
                <div class="benefit-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <h3>Convenient Locations</h3>
                <p>With multiple pickup and drop-off locations across the city, including airport terminals, we're always conveniently located.</p>
            </div>

            <!-- Benefit 6 -->
            <div class="benefit-card">
                <div class="benefit-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3>Comprehensive Insurance</h3>
                <p>Choose from a range of insurance options to ensure peace of mind during your rental period, with 24/7 roadside assistance included.</p>
            </div>
        </div>

        <div class="cta-container">
            <p>Ready to experience the GoRental difference?</p>
            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-primary">Browse Our Fleet <i class="fas fa-arrow-right"></i></a>
        </div>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Testimonials slider functionality
        const testimonials = document.querySelectorAll('.testimonial-card');
        const indicators = document.querySelectorAll('.testimonial-indicators .indicator');
        const prevBtn = document.querySelector('.prev-btn');
        const nextBtn = document.querySelector('.next-btn');
        let currentIndex = 0;

        function showTestimonial(index) {
            // Hide all testimonials
            testimonials.forEach(testimonial => {
                testimonial.classList.remove('active');
            });

            // Update indicators
            indicators.forEach(indicator => {
                indicator.classList.remove('active');
            });

            // Show the selected testimonial
            testimonials[index].classList.add('active');
            indicators[index].classList.add('active');
            currentIndex = index;
        }

        // Next button click
        nextBtn.addEventListener('click', function() {
            let nextIndex = currentIndex + 1;
            if (nextIndex >= testimonials.length) {
                nextIndex = 0;
            }
            showTestimonial(nextIndex);
        });

        // Previous button click
        prevBtn.addEventListener('click', function() {
            let prevIndex = currentIndex - 1;
            if (prevIndex < 0) {
                prevIndex = testimonials.length - 1;
            }
            showTestimonial(prevIndex);
        });

        // Indicator clicks
        indicators.forEach((indicator, index) => {
            indicator.addEventListener('click', function() {
                showTestimonial(index);
            });
        });

        // Auto-rotate testimonials every 5 seconds
        setInterval(function() {
            let nextIndex = currentIndex + 1;
            if (nextIndex >= testimonials.length) {
                nextIndex = 0;
            }
            showTestimonial(nextIndex);
        }, 5000);
    });
</script>