<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | Food Delivery</title>
<style>
    :root {
        --primary: #e23744;
        --primary-dark: #cb202d;
        --text: #1c1c1c;
        --text-light: #686b78;
        --background: rgba(255, 255, 255, 0.95);
        --error: #ff6b6b;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-image: url("assets/images/landing.jpg");
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        color: var(--text);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
        position: relative;
    }

    body::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.4);
    }

    .container {
        position: relative;
        width: 100%;
        max-width: 400px;
    }

    .error-message {
        background: var(--error);
        color: white;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 20px;
        text-align: center;
        font-size: 14px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    form {
        background: var(--background);
        padding: 40px 30px;
        border-radius: 16px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        backdrop-filter: blur(10px);
    }

    h2 {
        margin-bottom: 30px;
        font-size: 28px;
        font-weight: 600;
        text-align: center;
        color: var(--primary);
    }

    .form-group {
        margin-bottom: 24px;
    }

    form label {
        display: block;
        font-size: 14px;
        margin-bottom: 8px;
        color: var(--text);
        font-weight: 500;
    }

    form input[type="text"],
    form input[type="password"] {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid #e8e8e8;
        border-radius: 8px;
        font-size: 15px;
        color: var(--text);
        background: white;
        transition: all 0.3s ease;
    }

    form input[type="text"]:focus,
    form input[type="password"]:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 0 4px rgba(226, 55, 68, 0.1);
    }

    form input[type="submit"] {
        width: 100%;
        padding: 14px;
        background-color: var(--primary);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 10px;
    }

    form input[type="submit"]:hover {
        background-color: var(--primary-dark);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(226, 55, 68, 0.2);
    }

    form input[type="submit"]:active {
        transform: translateY(0);
    }

    .register-link {
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
        color: var(--text-light);
    }

    .register-link a {
        color: var(--primary);
        text-decoration: none;
        font-weight: 600;
        margin-left: 5px;
    }

    .register-link a:hover {
        text-decoration: underline;
    }

    @media (max-width: 480px) {
        form {
            padding: 30px 20px;
        }

        h2 {
            font-size: 24px;
        }

        form input[type="text"],
        form input[type="password"] {
            padding: 10px 14px;
            font-size: 14px;
        }

        .error-message {
            font-size: 13px;
            padding: 10px;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <%
        String error = request.getParameter("error");
        if (error != null) {
        %>
        <div class="error-message">
            <%
            if (error.equals("max_attempts")) {
            %>
            Maximum login attempts reached. Please try again later.
            <%
            } else if (error.equals("invalid_credentials")) {
            %>
            Invalid credentials. Please check your username and password.
            <%
            }
            %>
        </div>
        <%
        }
        %>

        <form action="LoginServlet" method="post">
            <h2>Welcome Back</h2>
            
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <input type="submit" value="Log in">
            
            <div class="register-link">
                Don't have an account?<a href="Register.jsp">Register here</a>
            </div>
        </form>
    </div>
</body>
</html>