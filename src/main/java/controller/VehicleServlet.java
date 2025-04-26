package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet(name ="VehicleServlet", value= "/vehicles")
public class VehicleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("[DEBUG] Loading vehicles page...");
        request.getRequestDispatcher("/WEB-INF/view/vehicles.jsp").forward(request, response);
    }

}
