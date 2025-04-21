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
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AuthService.AuthResult result = AuthService.authenticate(email, password);

        if (result.isSuccess()) {
            User user = result.getUser();
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Set session timeout to 30 minutes
            session.setMaxInactiveInterval(30 * 60);

            // Redirect based on role
            if (user.isAdmin()) {
                response.sendRedirect("/WEB-INF/view/protected/admindasboard.jsp");
            } else {
                response.sendRedirect("/WEB-INF/index.jsp");
            }
        } else {
            request.setAttribute("error", result.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}