package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/verifyotp")
public class VerifyOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String otpInput = request.getParameter("otp");

        String validOtp = SendOtpServlet.getStoredOtp(email);

        if (validOtp != null && validOtp.equals(otpInput)) {
            SendOtpServlet.removeOtp(email); // Invalidate OTP
            request.setAttribute("email", email);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid OTP. Try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/verify-otp.jsp").forward(request, response);
        }
    }
}
