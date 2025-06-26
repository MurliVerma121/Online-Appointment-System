<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home | Appointment Booking System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }

        header {
            text-align: center;
            padding: 30px 0;
            background-color: #007BFF;
            color: white;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        nav {
            text-align: center;
            margin-bottom: 30px;
        }

        nav a {
            text-decoration: none;
            color: white;
            background-color: #28a745;
            padding: 10px 20px;
            border-radius: 5px;
            margin: 0 10px;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        nav a:hover {
            background-color: #218838;
        }

        main {
            text-align: center;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        footer {
            text-align: center;
            font-size: 0.9em;
            color: #777;
            padding: 20px 0;
            border-top: 1px solid #ccc;
        }

        @media (max-width: 600px) {
            nav a {
                display: block;
                margin: 10px auto;
            }

            body {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to the Appointment Booking System</h1>
        <p>Book services with ease and manage your appointments efficiently.</p>
    </header>

    <nav>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    </nav>

    <main>
        <h2>Our Services</h2>
        <p>Find professional services and book appointments online.</p>
    </main>

    <footer>
        <p>&copy; 2025 Appointment Booking System. All rights reserved.</p>
    </footer>
</body>
</html>