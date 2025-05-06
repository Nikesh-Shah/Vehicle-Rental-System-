package controller;

import dao.UserDAO;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailConfigUtil;
import util.EmailUtility;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

@WebServlet(name = "SendOtpServlet", value = "/sendotp")
public class SendOtpServlet extends HttpServlet {

    private final String fromEmail = EmailConfigUtil.getFromEmail();
    private final String password = EmailConfigUtil.getPassword();

    // Make thread-safe
    private static final Map<String, String> otpMap = new ConcurrentHashMap<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email").trim().toLowerCase();

        // ✅ Check if email exists
        try {
            if (!UserDAO.emailExists(email)) {
                request.setAttribute("error", "This email is not registered.");
                request.getRequestDispatcher("/WEB-INF/view/forgot-password.jsp").forward(request, response);
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error checking email existence.");
            request.getRequestDispatcher("/WEB-INF/view/forgot-password.jsp").forward(request, response);
            return;
        }

        // ✅ Generate and store OTP (overwriting old if exists)
        String otp = String.format("%06d", new Random().nextInt(999999));
        otpMap.put(email, otp);  // automatically overwrites old OTP

        // ✅ Send Email
        String subject = "Your Password Reset OTP";
        String message = "Your OTP for password reset is: " + otp;

        try {
            EmailUtility.sendOTP(fromEmail, password, email, subject, message);
        } catch (MessagingException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to send OTP.");
            request.getRequestDispatcher("/WEB-INF/view/forgot-password.jsp").forward(request, response);
            return;
        }

        request.setAttribute("email", email);
        request.setAttribute("message", "OTP sent to your email.");
        request.getRequestDispatcher("/WEB-INF/view/verify-otp.jsp").forward(request, response);
    }

    public static String getStoredOtp(String email) {
        return otpMap.get(email.trim().toLowerCase());
    }

    public static void removeOtp(String email) {
        otpMap.remove(email.trim().toLowerCase());
    }
}
