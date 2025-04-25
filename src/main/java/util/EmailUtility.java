package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtility {

    private static void send(String fromEmail, String password, String toEmail, String subject, String body) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        msg.setSubject(subject);
        msg.setText(body);

        Transport.send(msg);
    }

    public static void sendEmail(String fromEmail, String password, String toEmail, String subject, String body) throws MessagingException {
        send(fromEmail, password, toEmail, subject, body);
    }

    public static void sendOTP(String fromEmail, String password, String toEmail, String subject, String body) throws MessagingException {
        send(fromEmail, password, toEmail, subject, body);
    }
}
