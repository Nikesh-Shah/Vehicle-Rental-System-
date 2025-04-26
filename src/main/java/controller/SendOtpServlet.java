package controller;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailConfigUtil;
import util.EmailUtility;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class SendOtpServlet extends HttpServlet {

    private final String fromEmail = EmailConfigUtil.getFromEmail();
    private final String password = EmailConfigUtil.getPassword();
    private static final Map<String, String> otpMap = new HashMap<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = String.format("%06d",new Random().nextInt(999999));

        otpMap.put(email, otp);

        String subject = "Your Password Reset OTP";
        String message = "Your OTP for password reset is: " + otp;
        try {
            EmailUtility.sendOTP(fromEmail, password, email,subject,message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("email", email);
        request.setAttribute("message", "OTP sent to your email.");
        request.getRequestDispatcher("/verify-otp.jsp").forward(request, response);
    }
    public static String getStoredOtp(String email) {
        return otpMap.get(email);
    }

    public static void removeOtp(String email) {
        otpMap.remove(email);
    }

}
