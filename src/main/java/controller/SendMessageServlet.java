package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailUtility;

import java.io.IOException;


@WebServlet(name = "/SendMessageServlet", value="/sendmessage")
public class SendMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Your email credentials (app password recommended)
    private final String fromEmail = "nikeshah0454@gmail.com";
    private final String password = "pxma azjs ljvb iuvf";
    private final String adminEmail = "nikeshah0454@gmail.com";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String userEmail = request.getParameter("email");
        String phone = request.getParameter("phone");
        String inquiryType = request.getParameter("inquiryType");
        String message = request.getParameter("message");
        String fullName = firstName + " " + lastName;

        // Compose messages
        String adminSubject = "New Inquiry: " + inquiryType;
        String adminMessage = "You have received a new message:\n\n"
                + "Name: " + fullName + "\n"
                + "Email: " + userEmail + "\n"
                + "Phone: " + phone + "\n"
                + "Inquiry Type: " + inquiryType + "\n"
                + "Message:\n" + message;

        String confirmationSubject = "Thank you for contacting us!";
        String confirmationMessage = "Dear " + fullName + ",\n\n"
                + "We have received your message regarding \"" + inquiryType + "\".\n"
                + "Our team will get back to you as soon as possible.\n\n"
                + "Your Message:\n" + message + "\n\n"
                + "Best regards,\nBRJ Furniture Stores";

        try {
            // Send emails using a utility class
            EmailUtility.sendEmail(fromEmail, password, adminEmail, adminSubject, adminMessage);
            EmailUtility.sendEmail(fromEmail, password, userEmail, confirmationSubject, confirmationMessage);

            request.setAttribute("success", "Your message has been sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong while sending the message.");
        }

        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}
