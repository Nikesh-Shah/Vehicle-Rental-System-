package controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.PaymentService;
import model.User;
import model.Payment;
import java.util.List;


import java.io.IOException;

@WebServlet("/payments")
public class PaymentServlet extends HttpServlet {
    private PaymentService paymentService;

    @Override
    public void init() {
        this.paymentService = new PaymentService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");

            if ("processCOD".equals(action)) {
                // Handle COD payment submission
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                boolean success = paymentService.processCODPayment(bookingId);

                if (success) {
                    response.sendRedirect("payment-success.jsp?bookingId=" + bookingId);
                } else {
                    throw new RuntimeException("Failed to process COD payment");
                }
            }
            else if ("completeCOD".equals(action)) {
                // Admin marking COD as collected
                int paymentId = Integer.parseInt(request.getParameter("paymentId"));
                boolean success = paymentService.completeCODPayment(paymentId);

                if (success) {
                    response.sendRedirect("admin/payments.jsp?success=COD+payment+marked+as+completed");
                } else {
                    response.sendRedirect("admin/payments.jsp?error=Failed+to+complete+payment");
                }
            }

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/payment-error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For admin to view pending COD payments
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;

        if (user == null || !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            List<Payment> pendingPayments = paymentService.getPendingCODPayments();
            request.setAttribute("pendingPayments", pendingPayments);
            request.getRequestDispatcher("/admin/pending-cod.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
}