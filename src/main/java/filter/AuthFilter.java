package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/user/*")
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            System.out.println("[DEBUG] Session not found or user not logged in. Checking cookies...");

            Cookie[] cookies = req.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("rememberEmail".equals(c.getName())) {
                        String email = c.getValue();

                        session = req.getSession(true);
                        session.setAttribute("user", email);

                        System.out.println("[DEBUG] Remember Me cookie found. Auto-logging in: " + email);
                        chain.doFilter(request, response);
                        return;
                    }
                }
            }

            System.out.println("[DEBUG] No valid session or remember-me cookie. Redirecting to login.jsp.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/login.jsp");
            dispatcher.forward(req, res);
            return;
        }

        System.out.println("[DEBUG] User session is valid. Proceeding with the request.");
        chain.doFilter(request, response);
    }
}
