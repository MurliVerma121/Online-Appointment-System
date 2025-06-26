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

@WebServlet("/cancelAppointment")
public class CancelAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
        
        String sql = "DELETE FROM appointments WHERE appointment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            
            if (ps.executeUpdate() > 0) {
                response.sendRedirect("manage_appointments.jsp?success=Appointment cancelled successfully");
            } else {
                response.sendRedirect("manage_appointments.jsp?error=Failed to cancel appointment");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manage_appointments.jsp?error=Database error");
        }
    }
}
