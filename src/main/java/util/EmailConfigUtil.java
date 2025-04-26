package util;

import java.io.InputStream;
import java.util.Properties;

public class EmailConfigUtil {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = EmailConfigUtil.class.getClassLoader().getResourceAsStream("email.properties")) {
            if (input != null) {
                properties.load(input);
            } else {
                System.out.println("Sorry, unable to find email.properties");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static String getFromEmail() {
        return properties.getProperty("fromEmail");
    }

    public static String getPassword() {
        return properties.getProperty("password");
    }

    public static String getAdminEmail() {
        return properties.getProperty("adminEmail");
    }
}
