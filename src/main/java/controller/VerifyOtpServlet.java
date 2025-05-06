package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "VerifyOtpServlet", value = "/verifyotp")
public class VerifyOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String otpInput = request.getParameter("otp");

        // Debug: print input values
        System.out.println("Received email: " + email);
        System.out.println("Received OTP input: " + otpInput);

        String validOtp = SendOtpServlet.getStoredOtp(email);

        // Debug: print stored OTP
        System.out.println("Stored OTP for " + email + ": " + validOtp);

        if (validOtp != null && validOtp.equals(otpInput)) {
            // Debug: OTP matched
            System.out.println("OTP verified successfully for email: " + email);

            SendOtpServlet.removeOtp(email); // Invalidate OTP
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/reset-password.jsp").forward(request, response);
        } else {
            // Debug: OTP did not match
            System.out.println("OTP verification failed for email: " + email);

            request.setAttribute("error", "Invalid OTP. Try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/verify-otp.jsp").forward(request, response);
        }
    }
}
