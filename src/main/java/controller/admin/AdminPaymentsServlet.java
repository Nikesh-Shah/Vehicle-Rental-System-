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

    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        System.out.println("AdminPaymentsServlet initialized.");
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Handling GET request for payments.");

        try {
            getAllPayments(request);

            getTotalRevenue(request);
            getCompletedRevenue(request);
            getPendingRevenue(request);




            request.getRequestDispatcher("/WEB-INF/view/admin/admin-payments.jsp").forward(request, response);

        } catch (SQLException e) {
            System.err.println("Error occurred while fetching payments or total revenue: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error fetching payments or revenue.");
            request.getRequestDispatcher("/WEB-INF/view/admin/error.jsp").forward(request, response);
        }
    }

    // Fetch all payments and set as request attribute
    private void getAllPayments(HttpServletRequest request) throws SQLException {
        System.out.println("Fetching all payments from the database.");
        List<Payment> paymentList = paymentDAO.getAllPayments();
        for (Payment payment : paymentList) {
            System.out.println("Payment ID: " + payment.getPaymentId() + ", Status: " + payment.getStatus());
        }

        if (paymentList != null && !paymentList.isEmpty()) {
            System.out.println("Found " + paymentList.size() + " payments.");
        } else {
            System.out.println("No payments found.");
        }

        request.setAttribute("payments", paymentList);
    }

    // Fetch total revenue and set as request attribute
    private void getTotalRevenue(HttpServletRequest request) throws SQLException {
        System.out.println("Fetching total revenue from completed payments.");
        double totalRevenue = paymentDAO.calculateTotalRevenue();
        System.out.println("[DEBUG] Total Revenue: " + totalRevenue);

        // Setting it as a request attribute
        request.setAttribute("totalRevenue", totalRevenue);
    }
    private void getCompletedRevenue(HttpServletRequest request) throws SQLException {
        System.out.println("Fetching completed revenue from completed payments.");
        double totalCompletedRevenue = paymentDAO.calculateTotalCompletedRevenue();
        System.out.println("[DEBUG] totalCompletedRevenue: " + totalCompletedRevenue);
        request.setAttribute("totalCompletedRevenue", totalCompletedRevenue);
    }
    private void getPendingRevenue(HttpServletRequest request) throws SQLException {
        System.out.println("Fetching pending revenue from completed payments.");
        double totalPendingRevenue = paymentDAO.calculateTotalPendingRevenue();
        System.out.println("[DEBUG] totalPendingRevenue: " + totalPendingRevenue);
        request.setAttribute("totalPendingRevenue", totalPendingRevenue);
    }
@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Handling POST request for payments.");
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        String newStatus = request.getParameter("status");

        try {
            boolean isUpdated = paymentDAO.updatePaymentStatus(paymentId, newStatus);

            if (isUpdated) {
                System.out.println("[DEBUG] Payment status updated successfully for Payment ID: " + paymentId);
                response.sendRedirect(request.getContextPath() + "/admin/payments?status=success");
            } else {
                System.out.println("[ERROR] Failed to update payment status.");
                response.sendRedirect(request.getContextPath() + "/admin/payments?status=failure");
            }
        } catch (SQLException e) {
            System.out.println("[ERROR] Database error while updating payment status.");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/payments");
        }
    }


}
