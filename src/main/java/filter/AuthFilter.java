package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/user/*")
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Debugging: check if the session exists and whether the user is logged in
        if (session == null) {
            System.out.println("[DEBUG] No session found for the request.");
        } else {
            System.out.println("[DEBUG] Session found. Checking for user attribute.");
        }

        if (session == null || session.getAttribute("user") == null) {
            System.out.println("[DEBUG] User not logged in or session expired. Forwarding to login.jsp.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/login.jsp");
            dispatcher.forward(req, res);
            return; // to prevent further processing
        }
else {
            System.out.println("[DEBUG] User logged in. Proceeding with the request.");
            chain.doFilter(request, response);
        }
    }
}
