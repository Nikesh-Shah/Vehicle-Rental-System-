// Function to show popup
function showPopup(type, message) {
    // Check if popup already exists
    let popupOverlay = document.getElementById("popupOverlay")
    let popupBox = document.getElementById("popupBox")

    // Create elements if they don't exist
    if (!popupOverlay) {
        popupOverlay = document.createElement("div")
        popupOverlay.id = "popupOverlay"
        popupOverlay.className = "popup-overlay"
        document.body.appendChild(popupOverlay)
    }

    if (!popupBox) {
        popupBox = document.createElement("div")
        popupBox.id = "popupBox"
        popupBox.className = "popup-box"
        document.body.appendChild(popupBox)
    }

    // Set content based on type
    let iconSvg = ""
    if (type === "success") {
        iconSvg =
            '<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>'
        popupBox.className = "popup-box success"
    } else {
        iconSvg =
            '<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>'
        popupBox.className = "popup-box error"
    }

    // Set popup content
    popupBox.innerHTML = `
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <div class="popup-icon ${type}">
            ${iconSvg}
        </div>
        <h2>${type === "success" ? "Success" : "Error"}</h2>
        <p>${message}</p>
        <button class="popup-btn" onclick="closePopup()">OK</button>
    `

    // Show popup with animation
    setTimeout(() => {
        popupOverlay.classList.add("show")
        popupBox.classList.add("show")
    }, 10)

    // Add event listener to overlay
    popupOverlay.addEventListener("click", closePopup)
}

// Function to close popup
function closePopup() {
    const popupOverlay = document.getElementById("popupOverlay")
    const popupBox = document.getElementById("popupBox")

    if (popupOverlay && popupBox) {
        popupOverlay.classList.remove("show")
        popupBox.classList.remove("show")

        // Remove elements after animation completes
        setTimeout(() => {
            if (!popupBox.classList.contains("show")) {
                popupOverlay.style.display = "none"
                popupBox.style.display = "none"
            }
        }, 300)
    }
}

// Make closePopup available globally
window.closePopup = closePopup

// Document ready function
document.addEventListener("DOMContentLoaded", () => {
    // Get form element
    const form = document.querySelector(".contact-form form")

    // Check if success popup is already shown (from server-side)
    const existingPopup = document.getElementById("popupBox")
    const existingOverlay = document.getElementById("popupOverlay")

    // If there's no server-side popup, set up client-side validation
    if (!existingPopup || !existingPopup.classList.contains("show")) {
        form.addEventListener("submit", (e) => {
            // Prevent the default form submission for client-side validation
            e.preventDefault()

            // Get form fields
            const firstName = document.getElementById("firstName").value.trim()
            const lastName = document.getElementById("lastName").value.trim()
            const email = document.getElementById("email").value.trim()
            const phone = document.getElementById("phone").value.trim()
            const inquiryType = document.getElementById("inquiryType").value
            const message = document.getElementById("message").value.trim()

            // Basic validation
            if (!firstName || !lastName || !email || !phone || !inquiryType || !message) {
                showPopup("error", "Please fill in all required fields.")
                return
            }

            // Email validation
            if (!isValidEmail(email)) {
                showPopup("error", "Please enter a valid email address.")
                return
            }

            // Phone validation
            if (!isValidPhone(phone)) {
                showPopup("error", "Please enter a valid phone number.")
                return
            }

            // If all validations pass, show loading state
            const submitBtn = form.querySelector(".send-btn")
            const originalBtnText = submitBtn.innerHTML
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...'
            submitBtn.disabled = true

            // Simulate form submission (remove this in production and use the actual form submission)
            setTimeout(() => {
                // For demo: 80% chance of success
                const isSuccess = Math.random() < 0.8

                if (isSuccess) {
                    // In production, this would be handled by the server response
                    showPopup("success", "Your message has been sent successfully! We will get back to you soon.")
                    form.reset()
                } else {
                    showPopup("error", "There was a problem sending your message. Please try again later.")
                }

                // Reset button state
                submitBtn.innerHTML = originalBtnText
                submitBtn.disabled = false
            }, 1500)

            // In production, uncomment this to submit the form to the server
            form.submit();
        })
    }
})

// Validate email format
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    return emailRegex.test(email)
}

// Validate phone format (basic validation)
function isValidPhone(phone) {
    const phoneRegex = /^[0-9\-+\s()]{10,15}$/
    return phoneRegex.test(phone)
}
