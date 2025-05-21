package controller.admin;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.PasswordHashUtil;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/createuser") // fixed typo from "creteuser" to "createuser"
public class AdminCreateUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] Entering doGet: /admin/createuser");
        // Forward to the create user JSP page inside WEB-INF
        try {
            request.getRequestDispatcher("/WEB-INF/view/admin/createuser.jsp").forward(request, response);
            System.out.println("[DEBUG] Forwarded to /WEB-INF/view/admin/createuser.jsp successfully");
        } catch (Exception e) {
            System.err.println("[ERROR] Exception in doGet while forwarding to createuser.jsp: " + e.getMessage());
            throw e;
        }
        System.out.println("[DEBUG] Exiting doGet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] Entering doPost: /admin/createuser - form submission received");

        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String roleParam = request.getParameter("role"); // e.g. "1", "2", etc.

        System.out.println("[DEBUG] Form data received:");
        System.out.println("  First Name: " + fname);
        System.out.println("  Last Name: " + lname);
        System.out.println("  Email: " + email);
        System.out.println("  Phone: " + phone);
        System.out.println("  Role: " + roleParam);
        System.out.println("  Password: " + password);
        System.out.println("  Confirm Password: " + confirmPassword);

        int role = 0; // default role (e.g., customer)
        try {
            role = Integer.parseInt(roleParam);
        } catch (NumberFormatException e) {
            System.out.println("[WARN] Invalid role parameter '" + roleParam + "', defaulting to 1");
        }

        if (!password.equals(confirmPassword)) {
            System.out.println("[DEBUG] Passwords do not match, returning error to form");
            request.setAttribute("error", "Passwords do not match");
            forwardBackWithData(request, response, fname, lname, email, phone, roleParam);
            return;
        }

        String hashedPassword = PasswordHashUtil.hashPassword(password);
        System.out.println("[DEBUG] Password hashed successfully");

        User user = new User();
        user.setFname(fname);
        user.setLname(lname);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setPhone(phone);
        user.setRole(role);

        try {
            int newUserId = UserDAO.createUser(user);
            System.out.println("[DEBUG] New user created with ID: " + newUserId);

            response.sendRedirect(request.getContextPath() + "/admin-users?createSuccess=true");
            System.out.println("[DEBUG] Redirected to /admin/users with createSuccess=true");
        } catch (SQLException e) {
            System.err.println("[ERROR] SQLException while creating user: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Failed to create user: " + e.getMessage());
            forwardBackWithData(request, response, fname, lname, email, phone, roleParam);
        }

        System.out.println("[DEBUG] Exiting doPost");
    }

    private void forwardBackWithData(HttpServletRequest request, HttpServletResponse response,
                                     String fname, String lname, String email, String phone, String role) throws ServletException, IOException {
        System.out.println("[DEBUG] forwardBackWithData called, setting form attributes for re-display");
        request.setAttribute("fname", fname);
        request.setAttribute("lname", lname);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("role", role);
        request.getRequestDispatcher("/WEB-INF/view/admin/createuser.jsp").forward(request, response);
        System.out.println("[DEBUG] Forwarded back to /WEB-INF/view/admin/createuser.jsp with form data");
    }
}
