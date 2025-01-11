<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.daoimpl.UserDAOImpl"%>
<%@ page import="com.foodapp.model.Cart"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | Tap Foods</title>
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
background-image: url("assets/images/landing.jpg");        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        color: var(--text);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        
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
        margin: 0;
    }

    form {
        background: var(--background);
        padding: 20px;
        border-radius: 16px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        backdrop-filter: blur(10px);
    }

    h2 {
        margin-bottom: 15px;
        font-size: 24px;
        font-weight: 600;
        text-align: center;
        color: var(--primary);
    }

    .form-group {
        margin-bottom: 12px;
    }

    form label {
        display: block;
        font-size: 13px;
        margin-bottom: 4px;
        color: var(--text);
        font-weight: 500;
    }

    form input[type="text"],
    form input[type="email"],
    form input[type="password"],
    form input[type="tel"] {
        width: 100%;
        padding: 8px 12px;
        border: 2px solid #e8e8e8;
        border-radius: 8px;
        font-size: 14px;
        color: var(--text);
        background: white;
        transition: all 0.3s ease;
    }

    form input[type="text"]:focus,
    form input[type="email"]:focus,
    form input[type="password"]:focus,
    form input[type="tel"]:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 0 4px rgba(226, 55, 68, 0.1);
    }

    .checkbox-container {
        display: flex;
        align-items: center;
        gap: 8px;
        margin: 12px 0;
    }

    .checkbox-container input[type="checkbox"] {
        width: 16px;
        height: 16px;
        accent-color: var(--primary);
    }

    .checkbox-container p {
        font-size: 12px;
        color: var(--text-light);
        margin: 0;
    }

    form input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: var(--primary);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 8px;
    }

    form input[type="submit"]:hover {
        background-color: var(--primary-dark);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(226, 55, 68, 0.2);
    }

    .login-link {
        text-align: center;
        margin-top: 12px;
        font-size: 13px;
        color: var(--text-light);
    }

    .login-link a {
        color: var(--primary);
        text-decoration: none;
        font-weight: 600;
        margin-left: 4px;
    }

    .login-link a:hover {
        text-decoration: underline;
    }

    .seller-buttons {
        display: flex;
        gap: 8px;
        margin-top: 12px;
    }

    .seller-button {
        flex: 1;
        padding: 8px;
        background-color: var(--primary);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        text-align: center;
    }

    .seller-button:hover {
        background-color: var(--primary-dark);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(226, 55, 68, 0.2);
    }

    @media (max-width: 480px) {
        .container {
            margin: 5px 0;
        }

        form {
            padding: 15px;
        }

        h2 {
            font-size: 22px;
            margin-bottom: 12px;
        }

        .form-group {
            margin-bottom: 10px;
        }

        form input[type="text"],
        form input[type="email"],
        form input[type="password"],
        form input[type="tel"] {
            padding: 8px 10px;
            font-size: 13px;
        }

        .seller-buttons {
            flex-direction: column;
            gap: 6px;
        }
    }
    </style>
</head>
<body>
  
    <div class="container">

        <form action="AgentSignUpServlet" method="post">
        	<h2>Create Account</h2>
        	
            <div class="form-group">
                <label class="form-label" for="name">Name</label>
                <input class="form-input" type="text" id="name" name="name" 
                       placeholder="Enter your full name" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" 
                       placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="phone">Phone Number</label>
                <input class="form-input" type="tel" id="phone" name="phone" 
                       placeholder="Enter your phone number" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="address">Address</label>
                <input class="form-input" type="text" id="address" name="address" 
                       placeholder="Enter your address" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <input class="form-input" type="text" id="username" name="username" 
                       placeholder="Choose a username" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" 
                       placeholder="Create a password" required>
            </div>

                        <div class="form-group">
                <label for="cpassword">Confirm Password</label>
                <input type="password" id="cpassword" name="cpassword" placeholder="Confirm your password" required>
            </div>

            <div class="checkbox-container">
                <input type="checkbox" id="terms" required>
                <p>I accept the Terms and Conditions and Privacy Policy</p>
            </div>

            <input type="submit" value="Sign Up">

            <div class="login-link">
                Already have an account? <a href="Login.jsp">Login here</a>
            </div>
            
            
        </form>
    </div>
</body>
</html>