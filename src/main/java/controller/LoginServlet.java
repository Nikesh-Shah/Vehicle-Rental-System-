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
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Debug: log the email received in the request
        System.out.println("[DEBUG] Login attempt received with email: " + email);

        AuthService.AuthResult result = AuthService.authenticate(email, password);

        // Debug: Check the result of authentication
        if (result.isSuccess()) {
            System.out.println("[DEBUG] Authentication successful for user: " + email);
            User user = result.getUser();
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Set session timeout to 30 minutes
            session.setMaxInactiveInterval(30 * 60);

            // Debug: Check if the user is an admin
            if (user.isAdmin()) {
                System.out.println("[DEBUG] User is an admin. Forwarding to admin dashboard.");
                request.getRequestDispatcher("/WEB-INF/view/protected/admindasboard.jsp").forward(request, response);
            } else {
                System.out.println("[DEBUG] User is not an admin. Forwarding to the homepage.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } else {
            System.out.println("[DEBUG] Authentication failed for user: " + email);
            System.out.println("[DEBUG] Error message: " + result.getMessage());

            request.setAttribute("error", result.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}
