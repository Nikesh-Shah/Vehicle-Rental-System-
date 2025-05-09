<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - GORental</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/contact.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">

</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>
<div class="contact-container">
    <section class="contact-header">
        <h1 class="fade-in">Contact Us</h1>
        <p class="subtitle fade-in-delay">
            Have questions or need assistance? We're here to help. Reach out to our team using the
            contact information below or fill out the form.
        </p>
    </section>

    <section class="info-cards">
        <div class="card slide-in-left">
            <div class="icon-container">
                <i class="fas fa-map-marker-alt"></i>
            </div>
            <h3>Our Location</h3>
            <p>123 Main Street, Downtown</p>
            <p>Bhanuchowk, Dharan, Sunsari</p>
            <p>Dulari Sadak, Dulari, Sunsari</p>
        </div>

        <div class="card slide-in-up">
            <div class="icon-container">
                <i class="fas fa-phone-alt"></i>
            </div>
            <h3>Phone & Email</h3>
            <p>Customer Service: (555) 123-4567</p>
            <p>Reservation: (555) 123-4567</p>
            <p>Email: email@example.com</p>
        </div>

        <div class="card slide-in-right">
            <div class="icon-container">
                <i class="far fa-clock"></i>
            </div>
            <h3>Our Time</h3>
            <p>Monday - Friday: 8:00 AM - 6:00 PM</p>
            <p>Saturday: 9:00 AM - 6:00 PM</p>
            <p>Sunday: 10:00 AM - 4:00 PM</p>
        </div>
    </section>

    <div class="content-wrapper">
        <section class="contact-form fade-in-delay">
            <h2>Send Us a Message</h2>
            <form action="${pageContext.request.contextPath}/sendmessage" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>

                <div class="form-group">
                    <label for="inquiryType">Inquiry Type</label>
                    <select id="inquiryType" name="inquiryType" required>
                        <option value="" disabled selected>Select Inquiry Type</option>
                        <option value="reservation">Reservation</option>
                        <option value="cancellation">Cancellation</option>
                        <option value="pricing">Pricing</option>
                        <option value="feedback">Feedback</option>
                        <option value="other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message" rows="6" required></textarea>
                </div>

                <button type="submit" class="send-btn">
                    <i class="fas fa-paper-plane"></i> Send Message
                </button>
            </form>

            <!-- Server-side success popup (this will be shown if the server returns a success message) -->
            <c:if test="${not empty success}">
                <div id="popupOverlay" class="popup-overlay show"></div>
                <div id="popupBox" class="popup-box success show">
                    <span class="close-btn" onclick="closePopup()">&times;</span>
                    <div class="popup-icon success">
                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                            <polyline points="22 4 12 14.01 9 11.01"></polyline>
                        </svg>
                    </div>
                    <h2>Success</h2>
                    <p>${success}</p>
                    <button class="popup-btn" onclick="closePopup()">OK</button>
                </div>
            </c:if>

            <!-- Server-side error popup (you can add this if your server returns error messages) -->
            <c:if test="${not empty error}">
                <div id="popupOverlay" class="popup-overlay show"></div>
                <div id="popupBox" class="popup-box error show">
                    <span class="close-btn" onclick="closePopup()">&times;</span>
                    <div class="popup-icon error">
                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10"></circle>
                            <line x1="12" y1="8" x2="12" y2="12"></line>
                            <line x1="12" y1="16" x2="12.01" y2="16"></line>
                        </svg>
                    </div>
                    <h2>Error</h2>
                    <p>${error}</p>
                    <button class="popup-btn" onclick="closePopup()">OK</button>
                </div>
            </c:if>
        </section>


        <section class="faq fade-in-delay">
            <h2>Frequently Asked Questions</h2>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>What documents do I need to rent a car?</h3>
                    <span class="toggle-icon">+</span>
                </div>
                <div class="faq-answer">
                    <p>You'll need a valid driver's license, a credit card in your name, and proof of insurance. International customers may need additional documentation.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Can I modify or cancel my reservation?</h3>
                    <span class="toggle-icon">+</span>
                </div>
                <div class="faq-answer">
                    <p>Yes, you can modify or cancel your reservation up to 24 hours before the scheduled pickup time without any penalty.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Is there a security deposit required?</h3>
                    <span class="toggle-icon">+</span>
                </div>
                <div class="faq-answer">
                    <p>Yes, we require a security deposit that varies based on the vehicle type. The deposit is fully refundable upon return of the vehicle in its original condition.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Do you offer airport pickup and drop-off?</h3>
                    <span class="toggle-icon">+</span>
                </div>
                <div class="faq-answer">
                    <p>Yes, we offer convenient airport pickup and drop-off services at all major airports in our service areas.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Do I need to return the car with a full tank?</h3>
                    <span class="toggle-icon">+</span>
                </div>
                <div class="faq-answer">
                    <p>Our vehicles are provided with a full tank of fuel, and we ask that you return the vehicle with a full tank. If not, a refueling fee will apply.</p>
                </div>
            </div>
        </section>
    </div>

    <section class="find-us">
        <h2 class="fade-in">Find Us</h2>
        <p class="subtitle fade-in-delay">Visit our main office or one of our convenient locations throughout the city.</p>

        <div class="map-container fade-in-delay">
            <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3571.064402808135!2d87.27939931503567!3d26.81605338316528!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190a341f9bd9%3A0x42c6d382c8b2bdab!2sDharan!5e0!3m2!1sen!2snp!4v1650222941712!5m2!1sen!2snp"
                    width="100%"
                    height="100%"
                    style="border:0;"
                    allowfullscreen=""
                    loading="lazy">
            </iframe>
        </div>
    </section>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.faq-question').forEach(function(question) {
            question.addEventListener('click', function() {
                this.parentNode.classList.toggle('active');
                var toggleIcon = this.querySelector('.toggle-icon');
                toggleIcon.textContent = toggleIcon.textContent === '+' ? '-' : '+';
            });
        });

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.slide-in-left, .slide-in-right, .slide-in-up, .fade-in, .fade-in-delay').forEach(element => {
            observer.observe(element);
        });
    });

</script>

<jsp:include page="/WEB-INF/view/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/assets/js/popup.js"></script>
</body>
</html>