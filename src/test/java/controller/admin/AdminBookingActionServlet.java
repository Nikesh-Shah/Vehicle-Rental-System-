//package controller.admin;
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import dao.BookingDAO;
//import model.User;
//
//import java.io.IOException;
//import java.sql.SQLException;
//
//@WebServlet("/admin/booking-action")
//public class AdminBookingActionServlet extends HttpServlet {
//    private final BookingDAO bookingDAO = new BookingDAO();
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//        if (session == null || ((User) session.getAttribute("user")).getRole() != 1) {
//            response.sendRedirect("login");
//            return;
//        }
//
//        try {
//            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
//            String action = request.getParameter("action");
//
//            if (action == null) throw new Exception("No action specified");
//
//            if (action.equals("update")) {
//                String newStatus = request.getParameter("status");
//                bookingDAO.updateBookingStatus(bookingId, newStatus);
//            }
//            else if (action.equals("delete")) {
//                bookingDAO.deleteBooking(bookingId);
//            }
//
//            response.sendRedirect("bookings");
//
//        } catch (NumberFormatException e) {
//            request.setAttribute("error", "Invalid booking ID format");
//            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
//        } catch (SQLException e) {
//            request.setAttribute("error", "Database error: " + e.getMessage());
//            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
//        } catch (Exception e) {
//            request.setAttribute("error", "Error: " + e.getMessage());
//            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
//        }
//    }
//}