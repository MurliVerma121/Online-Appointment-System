<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.nit.mv.appointment.model.User, java.sql.*, com.nit.mv.appointment.util.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Services</title>
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
            margin: 10px;
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

        form {
            max-width: 600px;
            margin: 0 auto 30px;
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        form input[type="text"],
        form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            resize: vertical;
        }

        form button {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #0056b3;
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

        table form {
            margin: 0;
        }

        table button {
            background-color: #dc3545;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        table button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <h2>Manage Your Services</h2>

    <%
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("provider")) {
            response.sendRedirect("login.jsp");
        } else {
    %>
        <p>Hello, <%= user.getName() %>! Here you can manage your services.</p>
        <div style="text-align: center;">
            <a href="dashboard.jsp">Back to Dashboard</a>
            <a href="logout">Logout</a>
        </div>

        <h3>Add New Service</h3>
        <form action="addService" method="post">
            <label>Service Name:</label>
            <input type="text" name="service_name" required>

            <label>Description:</label>
            <textarea name="description" required></textarea>

            <button type="submit">Add Service</button>
        </form>

        <h3>Your Services</h3>
        <table>
            <tr>
                <th>Service Name</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
            <%
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT service_id, service_name, description FROM services WHERE provider_id = ?");
                ps.setInt(1, user.getUserId());
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("service_name") %></td>
                <td><%= rs.getString("description") %></td>
                <td>
                    <form action="deleteService" method="post" style="display:inline;">
                        <input type="hidden" name="service_id" value="<%= rs.getInt("service_id") %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>
