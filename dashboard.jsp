<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.nit.mv.appointment.model.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DashBoard</title>
    <style>
        /* === BASE STYLES === */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            color: #333;
            padding: 40px;
            text-align: center;
        }

        h2 {
            color: #007BFF;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        a {
            display: inline-block;
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #c82333;
        }

        @media (max-width: 600px) {
            body {
                padding: 20px;
            }

            a {
                display: block;
                margin: 10px auto;
            }

            p {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <h2>Welcome to the Dashboard</h2>

    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
        } else {
    %>
        <p>Hello, <%= user.getName() %>! You are logged in as <%= user.getRole() %>.</p>
        <a href="logout">Logout</a>
    <%
        }
    %>
</body>
</html>
