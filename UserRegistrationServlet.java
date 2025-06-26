package com.nit.mv.appointment.controller;

import com.nit.mv.appointment.dao.UserDAO;
import com.nit.mv.appointment.model.User;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User(0, name, email, password, role);
        boolean isRegistered = userDAO.registerUser(user);

        if (isRegistered) {
            response.sendRedirect("register_success.jsp");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed");
        }
    }
}
