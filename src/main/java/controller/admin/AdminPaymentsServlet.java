package controller.admin;

import dao.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Payment;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/admin/payments")
    public class AdminPaymentsServlet extends HttpServlet {
        private final PaymentDAO paymentDAO = new PaymentDAO();

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            try {
                List<Payment> payments = paymentDAO.getAllPayments();
                request.setAttribute("payments", payments);
                request.getRequestDispatcher("/WEB-INF/view/admin/admin-payments.jsp").forward(request, response);
            } catch (SQLException e) {
                // Handle error
            }
        }
    }

