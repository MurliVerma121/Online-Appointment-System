package com.nit.mv.appointment.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.nit.mv.appointment.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/bookAppointment")
public class BookAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String appointmentDate = request.getParameter("appointment_date");
        
        String sql = "INSERT INTO appointments (user_id, service_id, appointment_date) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setString(3, appointmentDate);
            
            if (ps.executeUpdate() > 0) {
                response.sendRedirect("dashboard.jsp?success=Appointment booked successfully");
            } else {
                response.sendRedirect("dashboard.jsp?error=Failed to book appointment");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Database error");
        }
    }
}
