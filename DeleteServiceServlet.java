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

@WebServlet("/deleteService")
public class DeleteServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.getRole().equals("provider")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        
        String sql = "DELETE FROM services WHERE service_id = ? AND provider_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            ps.setInt(2, user.getUserId());
            
            if (ps.executeUpdate() > 0) {
                response.sendRedirect("manage_services.jsp?success=Service deleted successfully");
            } else {
                response.sendRedirect("manage_services.jsp?error=Failed to delete service");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manage_services.jsp?error=Database error");
        }
    }
}
