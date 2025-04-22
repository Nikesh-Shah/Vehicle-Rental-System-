package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.AuthService;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] GET /register - Loading registration page");
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] POST /register - Form submission received");

        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");

        System.out.println("[DEBUG] Form data received:");
        System.out.println("  First Name: " + fname);
        System.out.println("  Last Name: " + lname);
        System.out.println("  Email: " + email);
        System.out.println("  Phone: " + phone);
        // Do not print passwords in real applications. This is only for debugging.
        System.out.println("  Password: " + password);
        System.out.println("  Confirm Password: " + confirmPassword);

        AuthService.AuthResult result = AuthService.registerUser(fname, lname, email, password, confirmPassword, phone);

        if (result.isSuccess()) {
            System.out.println("[DEBUG] Registration successful, redirecting to login");
            response.sendRedirect("login?registerSuccess=true");
        } else {
            System.out.println("[DEBUG] Registration failed: " + result.getMessage());
            request.setAttribute("error", result.getMessage());
            request.setAttribute("fname", fname);
            request.setAttribute("lname", lname);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        }
    }
}
