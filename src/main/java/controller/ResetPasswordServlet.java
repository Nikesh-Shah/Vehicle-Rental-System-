package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ResetPasswordServlet", value = "/resetpassword")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        // Debug: print received inputs
        System.out.println("ResetPasswordServlet: Received email = " + email);
        System.out.println("ResetPasswordServlet: Received new password = " + newPassword);

        boolean updated = false;
        try {
            updated = UserDAO.updatePassword(email, newPassword);
            // Debug: print update status
            System.out.println("ResetPasswordServlet: Password update status = " + updated);
        } catch (SQLException e) {
            // Debug: print exception details
            System.out.println("ResetPasswordServlet: SQLException occurred");
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        if (updated) {
            System.out.println("ResetPasswordServlet: Password updated successfully for " + email);
            request.setAttribute("success", "Password updated Successfully");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        } else {
            System.out.println("ResetPasswordServlet: Password update failed for " + email);
            request.setAttribute("error", "Password update Failed");
            request.getRequestDispatcher("/WEB-INF/view/reset-password.jsp").forward(request, response);
        }
    }
}
