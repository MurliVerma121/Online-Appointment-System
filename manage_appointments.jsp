<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.nit.mv.appointment.model.User, java.sql.*, com.nit.mv.appointment.util.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Appointments</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            color: #333;
            padding: 40px;
        }

        h2, h3 {
            text-align: center;
            color: #007BFF;
            margin-bottom: 20px;
        }

        p {
            text-align: center;
            margin-bottom: 20px;
        }

        a {
            display: inline-block;
            margin: 10px 10px 30px;
            text-decoration: none;
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #218838;
        }

        table {
            width: 90%;
            margin: 0 auto 40px;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        form {
            margin: 0;
        }

        button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <h2>Your Appointments</h2>

    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
        } else {
    %>
        <p>Hello, <%= user.getName() %>! Here are your appointments:</p>
        <div style="text-align: center;">
            <a href="dashboard.jsp">Back to Dashboard</a>
            <a href="logout">Logout</a>
        </div>

        <h3>Upcoming Appointments</h3>
        <table>
            <tr>
                <th>Service Name</th>
                <th>Provider</th>
                <th>Appointment Date</th>
                <th>Action</th>
            </tr>
            <%
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT a.appointment_id, s.service_name, u.name AS provider, a.appointment_date " +
                    "FROM appointments a " +
                    "JOIN services s ON a.service_id = s.service_id " +
                    "JOIN users u ON s.provider_id = u.user_id " +
                    "WHERE a.user_id = ?"
                );
                ps.setInt(1, user.getUserId());
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("service_name") %></td>
                <td><%= rs.getString("provider") %></td>
                <td><%= rs.getString("appointment_date") %></td>
                <td>
                    <form action="cancelAppointment" method="post">
                        <input type="hidden" name="appointment_id" value="<%= rs.getInt("appointment_id") %>">
                        <button type="submit">Cancel</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>
