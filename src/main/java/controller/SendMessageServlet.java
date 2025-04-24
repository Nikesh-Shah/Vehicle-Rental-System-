package controller;

import com.mysql.cj.Session;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.*;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.*;

public class SendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form fields
        String name = request.getParameter("name");
        String userEmail = request.getParameter("email");
        String userMessage = request.getParameter("message");

        // Your email credentials
        final String fromEmail = "nikeshah0454@gmail.com";
        final String password = "pxma azjs ljvb iuvf";

        // Admin (you) will receive user's message
        final String adminEmail = "nikeshah0454@gmail.com";

        // SMTP properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // 1. Email to Admin (you)
            Message msgToAdmin = new MimeMessage((MimeMessage) session);
            msgToAdmin.setFrom(new InternetAddress(fromEmail));
            msgToAdmin.setRecipient(Message.RecipientType.TO, new InternetAddress(adminEmail));
            msgToAdmin.setSubject("New Contact Message from: " + name);
            msgToAdmin.setText("Name: " + name + "\nEmail: " + userEmail + "\n\nMessage:\n" + userMessage);
            Transport.send(msgToAdmin);

            // 2. Confirmation email to user
            Message msgToUser = new MimeMessage((MimeMessage) session);
            msgToUser.setFrom(new InternetAddress(fromEmail));
            msgToUser.setRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
            msgToUser.setSubject("We've received your message!");
            msgToUser.setText("Hi " + name + ",\n\nThanks for reaching out. We've received your message and will get back to you soon.\n\nBest regards,\nBRJ Furniture Team");

            Transport.send(msgToUser);

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Your message has been sent. Check your email for confirmation.</h3>");

        } catch (MessagingException e) {
            e.printStackTrace();
            response.getWriter().println("Error sending email: " + e.getMessage());
        }
    }
}
