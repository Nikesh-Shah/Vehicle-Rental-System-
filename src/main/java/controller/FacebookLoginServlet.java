package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class FacebookLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String fbId = request.getParameter("fbId");
        String fbName = request.getParameter("fbName");
        String fbEmail = request.getParameter("fbEmail");
        System.out.println("Facebook ID:"+fbId);
        System.out.println("Facebook Name:"+fbName);
        System.out.println("Facebook Email:"+fbEmail);


        HttpSession session = request.getSession();
        session.setAttribute("fbId", fbId);
        session.setAttribute("fbName", fbName);
        session.setAttribute("fbEmail", fbEmail);

        response.sendRedirect("index.jsp");
    }
}
