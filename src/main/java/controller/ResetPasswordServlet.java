package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        boolean updated = false;
        try {
            updated = UserDAO.updatePassword(email, newPassword);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (updated) {
            request.setAttribute("success", "Password updated Successfully");
        }else {
            request.setAttribute("error", "Password update Failed");
        }
        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);

    }
}
