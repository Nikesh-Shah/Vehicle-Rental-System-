package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailConfigUtil;
import util.EmailUtility;

import java.io.IOException;

@WebServlet(name = "/SendMessageServlet", value = "/sendmessage")
public class SendMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String fromEmail = EmailConfigUtil.getFromEmail();
    private final String password = EmailConfigUtil.getPassword();
    private final String adminEmail = EmailConfigUtil.getAdminEmail();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String userEmail = request.getParameter("email");
        String phone = request.getParameter("phone");
        String inquiryType = request.getParameter("inquiryType");
        String message = request.getParameter("message");
        String fullName = firstName + " " + lastName;

        // Debug print form data
        System.out.println("Received form submission:");
        System.out.println("First Name: " + firstName);
        System.out.println("Last Name: " + lastName);
        System.out.println("Email: " + userEmail);
        System.out.println("Phone: " + phone);
        System.out.println("Inquiry Type: " + inquiryType);
        System.out.println("Message: " + message);

        // Compose email messages
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
                + "Best regards,\nGoRent";

        try {
            // Debug email sending
            System.out.println("Sending email to admin...");
            EmailUtility.sendEmail(fromEmail, password, adminEmail, adminSubject, adminMessage);
            System.out.println("Admin email sent successfully.");

            System.out.println("Sending confirmation email to user...");
            EmailUtility.sendEmail(fromEmail, password, userEmail, confirmationSubject, confirmationMessage);
            System.out.println("User confirmation email sent successfully.");

            request.setAttribute("success", "Your message has been sent successfully!");
        } catch (Exception e) {
            System.err.println("Error while sending emails:");
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong while sending the message.");
        }

        System.out.println("Forwarding to contact.jsp...");
        request.getRequestDispatcher("/WEB-INF/view/contact.jsp").forward(request, response);
    }
}
