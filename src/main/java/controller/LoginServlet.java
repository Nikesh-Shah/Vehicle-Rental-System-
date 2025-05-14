package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.AuthService;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] Loading login page...");
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Get form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("rememberMe");

        System.out.println("[DEBUG] Login attempt received with email: " + email);

        // Step 2: Authenticate the user
        AuthService.AuthResult result = AuthService.authenticate(email, password);

        if (result.isSuccess()) {
            System.out.println("[DEBUG] Authentication successful for user: " + email);

            User user = result.getUser();
            HttpSession session = request.getSession();

            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());

            System.out.println("[DEBUG] userId stored in session: " + user.getUserId());

            // Step 4: Handle "Remember Me" functionality
            if ("true".equals(remember)) {
                Cookie cookie = new Cookie("rememberEmail", email);
                cookie.setMaxAge(60 * 60 * 24 * 7);
                response.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("rememberEmail", "");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }

            // Step 5: Redirect based on admin status
            if (user.isAdmin()) {
                System.out.println("[DEBUG] User is an admin. Redirecting to admin dashboard servlet.");
                response.sendRedirect("admin-dashboard");
            } else {
                System.out.println("[DEBUG] User is not an admin. Forwarding to the homepage.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } else {
            System.out.println("[DEBUG] Authentication failed for user: " + email);
            System.out.println("[DEBUG] Error message: " + result.getMessage());

            // Step 6: Forward back to login page with error message
            request.setAttribute("error", result.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}
