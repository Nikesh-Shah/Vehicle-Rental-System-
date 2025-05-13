<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/home.css" />



<section class="faq-section">
    <h1>Frequently Asked Questions</h1>
    <p class="subtitle">Find answers to common questions about our vehicle rental services.</p>

    <div class="faq-container">
        <div class="faq-item">
            <div class="faq-question">
                <span>What are the requirements to rent a vehicle?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>Requirements typically include a valid driver's license, minimum age requirement (usually 21 or 25), and a credit card for the security deposit.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question">
                <span>How does pricing work?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>Our pricing is based on the vehicle type, rental duration, and additional services selected. Insurance and fuel options may add to the base price.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question">
                <span>How do I make a reservation?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>You can make a reservation online through our website, by calling our reservation center, or by visiting any of our branch locations.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question">
                <span>What is your cancellation policy?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>Cancellations made 48 hours before pickup time receive a full refund. Later cancellations may incur a fee equivalent to one day's rental.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question">
                <span>What happens if I return the vehicle late?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>Late returns are charged at an hourly rate up to a maximum of one additional day's rental fee. Please notify us in advance if you expect to be late.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question">
                <span>What insurance options are available?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>We offer several insurance options including collision damage waiver, liability coverage, personal accident insurance, and personal effects coverage.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question">
                <span>Can I pick up the vehicle at one location and return it to another?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>Yes, we offer one-way rentals between most of our locations. An additional drop-off fee may apply depending on the locations.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question">
                <span>What should I do in case of an accident or breakdown?</span>
                <span class="toggle-icon">&#8964;</span>
            </div>
            <div class="faq-answer">
                <p>In case of an accident, contact local authorities first, then call our 24/7 emergency hotline. For breakdowns, call our roadside assistance number provided in your rental agreement.</p>
            </div>
        </div>
    </div>

    <div class="support-box">
        <p class="support-heading">Still have questions?</p>
        <p class="support-text">Our customer support team is here to help you with any other questions you might have.</p>
        <div class="button-group">
            <button class="btn btn-primary">Contact Us</button>
            <button class="btn btn-secondary">Call Us</button>
        </div>
    </div>
</section>




<script>
    document.addEventListener('DOMContentLoaded', function() {

        const faqQuestions = document.querySelectorAll('.faq-question');

        faqQuestions.forEach(question => {
            question.addEventListener('click', function() {
                const parent = this.parentElement;
                parent.classList.toggle('active');
            });
        });
    });
</script>
