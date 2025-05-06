//package filter;
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.User;
//import java.io.IOException;
//
//@WebFilter("/admin/*")
//public class AdminFilter implements Filter {
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//        HttpServletRequest req = (HttpServletRequest) request;
//        HttpServletResponse res = (HttpServletResponse) response;
//        HttpSession session = req.getSession(false);
//
//        if (session == null) {
//            System.out.println("[DEBUG] No session found for the request.");
//        } else {
//            System.out.println("[DEBUG] Session exists. Checking user attributes...");
//        }
//
//        if (session == null || session.getAttribute("user") == null) {
//            System.out.println("[DEBUG] User not logged in or session expired. Redirecting to login...");
//            res.sendRedirect(req.getContextPath() + "/login");
//        } else {
//            User user = (User) session.getAttribute("user");
//            System.out.println("[DEBUG] Session contains user: " + user.getEmail());
//
//            if (!user.isAdmin()) {
//                System.out.println("[DEBUG] User is not an admin. Forbidden access attempt.");
//                res.sendError(HttpServletResponse.SC_FORBIDDEN);  // 403 Forbidden
//            } else {
//                System.out.println("[DEBUG] User is an admin. Granting access to admin area.");
//                chain.doFilter(request, response);  // Proceed with the filter chain
//            }
//        }
//    }
//}
package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session == null) {
            System.out.println("[DEBUG] No session found. Redirecting to login...");
            res.sendRedirect(req.getContextPath() + "/login?error=Admin+access+required");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            System.out.println("[DEBUG] No user in session. Redirecting to login...");
            res.sendRedirect(req.getContextPath() + "/login?error=Admin+access+required");
        } else if (!user.isAdmin()) {
            System.out.println("[DEBUG] User is not an admin. Access denied.");
            res.sendError(HttpServletResponse.SC_FORBIDDEN);
        } else {
            System.out.println("[DEBUG] Admin user verified. Continuing to admin area...");
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
