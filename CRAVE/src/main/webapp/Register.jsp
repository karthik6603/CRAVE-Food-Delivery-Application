<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | Food Delivery</title>
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
            background-attachment: fixed;
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
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 0;
        }

        .container {
            position: relative;
            width: 100%;
            max-width: 450px;
            margin: 20px auto;
            z-index: 1;
        }

        form {
            background: var(--background);
            padding: clamp(20px, 5vw, 40px);
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            backdrop-filter: blur(10px);
            width: 100%;
        }

        h2 {
            margin-bottom: clamp(15px, 4vw, 25px);
            font-size: clamp(24px, 5vw, 28px);
            font-weight: 600;
            text-align: center;
            color: var(--primary);
        }

        .form-group {
            margin-bottom: clamp(12px, 3vw, 16px);
        }

        form label {
            display: block;
            font-size: clamp(13px, 2.5vw, 14px);
            margin-bottom: 4px;
            color: var(--text);
            font-weight: 500;
        }

        form input[type="text"],
        form input[type="email"],
        form input[type="password"],
        form input[type="tel"] {
            width: 100%;
            padding: clamp(8px, 2vw, 12px);
            border: 2px solid #e8e8e8;
            border-radius: 8px;
            font-size: clamp(14px, 2.5vw, 16px);
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
            align-items: flex-start;
            gap: 8px;
            margin: clamp(12px, 3vw, 16px) 0;
        }

        .checkbox-container input[type="checkbox"] {
            width: 16px;
            height: 16px;
            accent-color: var(--primary);
            margin-top: 2px;
        }

        .checkbox-container p {
            font-size: clamp(12px, 2.5vw, 13px);
            color: var(--text-light);
            margin: 0;
            line-height: 1.4;
        }

        form input[type="submit"] {
            width: 100%;
            padding: clamp(10px, 2.5vw, 14px);
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: clamp(15px, 3vw, 16px);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: clamp(8px, 2vw, 12px);
        }

        form input[type="submit"]:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(226, 55, 68, 0.2);
        }

        .login-link {
            text-align: center;
            margin-top: clamp(12px, 3vw, 16px);
            font-size: clamp(13px, 2.5vw, 14px);
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
            gap: clamp(8px, 2vw, 12px);
            margin-top: clamp(12px, 3vw, 16px);
        }

        .seller-button {
            flex: 1;
            padding: clamp(8px, 2vw, 12px);
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: clamp(13px, 2.5vw, 14px);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            white-space: nowrap;
        }

        .seller-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(226, 55, 68, 0.2);
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .container {
                margin: 10px auto;
            }

            form {
                padding: 20px;
            }

            .seller-buttons {
                flex-direction: column;
            }

            .seller-button {
                width: 100%;
            }
        }

        @media (max-height: 800px) {
            body {
                align-items: flex-start;
                padding-top: 40px;
            }

            .container {
                margin-bottom: 40px;
            }
        }

        @media (min-width: 1200px) {
            .container {
                max-width: 500px;
            }

            form {
                padding: 40px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) {
            form input[type="submit"]:active,
            .seller-button:active {
                transform: scale(0.98);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="RegisterServlet" method="post">
            <h2>Create Account</h2>
            
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your name" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" required>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Enter your address" required>
            </div>

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Choose a username" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
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

            <div class="seller-buttons">
                <a href="RestaurantSignUp.jsp" class="seller-button">🏛️ Become a Seller</a>
                <a href="AgentSignup.jsp" class="seller-button">👨🏻‍💼 Delivery Agent</a>
            </div>
        </form>
    </div>
</body>
</html>