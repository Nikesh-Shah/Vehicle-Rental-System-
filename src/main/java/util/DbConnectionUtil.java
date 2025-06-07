package util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DbConnectionUtil {

    private static String url;
    private static String user;
    private static String password;

    static {
        try (InputStream is = DbConnectionUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            System.out.println("[DEBUG] Loading database properties...");
            Properties prop = new Properties();
            prop.load(is);

            String driver = prop.getProperty("db.driver");
            System.out.println("[DEBUG] Database Driver: " + driver);
            Class.forName(driver);
            System.out.println("[DEBUG] Database driver loaded successfully");

            url = prop.getProperty("db.url");
            user = prop.getProperty("db.username");
            password = prop.getProperty("db.password");

            System.out.println("[DEBUG] DB URL: " + url);
            System.out.println("[DEBUG] DB User: " + user);

        } catch (Exception e) {
            System.err.println("[ERROR] Failed to load DB properties or initialize driver:");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        System.out.println("[DEBUG] Attempting to establish DB connection...");
        Connection conn = DriverManager.getConnection(url, user, password);
        System.out.println("[DEBUG] Connection established successfully");
        return conn;
    }
}
