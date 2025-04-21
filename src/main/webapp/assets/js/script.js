document.addEventListener("DOMContentLoaded", () => {
    // Mobile menu toggle
    const menuToggle = document.querySelector(".menu-toggle")
    const navMobile = document.querySelector(".nav-mobile")

    if (menuToggle && navMobile) {
        menuToggle.addEventListener("click", () => {
            navMobile.classList.toggle("active")

            // Change icon based on menu state
            const icon = menuToggle.querySelector("i")
            if (navMobile.classList.contains("active")) {
                icon.classList.remove("fa-bars")
                icon.classList.add("fa-times")
            } else {
                icon.classList.remove("fa-times")
                icon.classList.add("fa-bars")
            }
        })
    }

    // Form validation
    const forms = document.querySelectorAll("form")

    forms.forEach((form) => {
        form.addEventListener("submit", (event) => {
            const requiredFields = form.querySelectorAll("[required]")
            let isValid = true

            requiredFields.forEach((field) => {
                if (!field.value.trim()) {
                    isValid = false
                    field.classList.add("error")
                } else {
                    field.classList.remove("error")
                }
            })

            // Email validation
            const emailField = form.querySelector('input[type="email"]')
            if (emailField && emailField.value) {
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
                if (!emailPattern.test(emailField.value)) {
                    isValid = false
                    emailField.classList.add("error")
                }
            }

            // Password validation for signup
            const passwordField = form.querySelector('input[name="password"]')
            if (passwordField && form.closest(".auth-form") && form.action.includes("signup")) {
                if (passwordField.value.length < 8) {
                    isValid = false
                    passwordField.classList.add("error")
                }
            }

            if (!isValid) {
                event.preventDefault()

                // Show error message if not already present
                if (!form.querySelector(".alert.error")) {
                    const errorAlert = document.createElement("div")
                    errorAlert.className = "alert error"
                    errorAlert.innerHTML =
                        '<i class="fas fa-exclamation-circle"></i><span>Please fill in all required fields correctly.</span>'
                    form.prepend(errorAlert)
                }
            }
        })
    })

    // Date picker initialization (if using a date picker library)
    // This is a placeholder for where you would initialize a date picker

    // Booking form calculations
    const bookingForm = document.querySelector(".booking-form")
    if (bookingForm) {
        const startDateInput = bookingForm.querySelector("#startDate")
        const endDateInput = bookingForm.querySelector("#endDate")
        const pricePerDay = Number.parseFloat(bookingForm.dataset.pricePerDay) || 0
        const totalPriceElement = bookingForm.querySelector(".total-price")

        function calculateTotal() {
            if (startDateInput.value && endDateInput.value) {
                const startDate = new Date(startDateInput.value)
                const endDate = new Date(endDateInput.value)

                if (startDate && endDate && startDate <= endDate) {
                    const diffTime = Math.abs(endDate - startDate)
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) || 1

                    const subtotal = pricePerDay * diffDays
                    const serviceFee = subtotal * 0.1 // 10% service fee
                    const total = subtotal + serviceFee

                    if (totalPriceElement) {
                        totalPriceElement.textContent = `$${total.toFixed(2)}`
                    }

                    // Update days count and subtotal if those elements exist
                    const daysElement = bookingForm.querySelector(".days-count")
                    if (daysElement) {
                        daysElement.textContent = diffDays
                    }

                    const subtotalElement = bookingForm.querySelector(".subtotal")
                    if (subtotalElement) {
                        subtotalElement.textContent = `$${subtotal.toFixed(2)}`
                    }

                    const serviceFeeElement = bookingForm.querySelector(".service-fee")
                    if (serviceFeeElement) {
                        serviceFeeElement.textContent = `$${serviceFee.toFixed(2)}`
                    }
                }
            }
        }

        if (startDateInput && endDateInput) {
            startDateInput.addEventListener("change", calculateTotal)
            endDateInput.addEventListener("change", calculateTotal)
        }
    }

    // Vehicle filter functionality
    const filterForm = document.querySelector(".filter-form")
    if (filterForm) {
        const filterInputs = filterForm.querySelectorAll('select, input[type="checkbox"]')

        filterInputs.forEach((input) => {
            input.addEventListener("change", () => {
                filterForm.submit()
            })
        })
    }

    // Auto-hide alerts after 5 seconds
    const alerts = document.querySelectorAll(".alert")
    alerts.forEach((alert) => {
        setTimeout(() => {
            alert.style.opacity = "0"
            setTimeout(() => {
                alert.style.display = "none"
            }, 500)
        }, 5000)
    })
})
