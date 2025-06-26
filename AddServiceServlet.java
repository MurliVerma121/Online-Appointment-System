package com.nit.mv.appointment.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.nit.mv.appointment.model.User;
import com.nit.mv.appointment.util.DBConnection;

@WebServlet("/addService")
public class AddServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.getRole().equals("provider")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String serviceName = request.getParameter("service_name");
        String description = request.getParameter("description");
        int providerId = user.getUserId();
        
        String sql = "INSERT INTO services (service_name, description, provider_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, serviceName);
            ps.setString(2, description);
            ps.setInt(3, providerId);
            
            if (ps.executeUpdate() > 0) {
                response.sendRedirect("manage_services.jsp?success=Service added successfully");
            } else {
                response.sendRedirect("manage_services.jsp?error=Failed to add service");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manage_services.jsp?error=Database error");
        }
    }
}
