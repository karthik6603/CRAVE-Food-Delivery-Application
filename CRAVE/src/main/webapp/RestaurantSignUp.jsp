<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant SignUp</title>
    <style>
        :root {
            --primary: #e23744;
            --primary-dark: #cb202d;
            --text: #1c1c1c;
            --text-light: #686b78;
            --background: rgba(255, 255, 255, 0.95);
            --error: #ff6b6b;
            --input-border: #e8e8e8;
            --input-focus: rgba(226, 55, 68, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url("https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: var(--text);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem 1rem;
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
            max-width: 800px;
            margin: 0 auto;
            z-index: 1;
        }

        form {
            background: var(--background);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            backdrop-filter: blur(10px);
        }

        h2 {
            margin-bottom: 1.5rem;
            font-size: 2rem;
            font-weight: 600;
            text-align: center;
            color: var(--primary);
            position: relative;
            padding-bottom: 1rem;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background-color: var(--primary);
            border-radius: 2px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
            color: var(--text);
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid var(--input-border);
            border-radius: 8px;
            font-size: 1rem;
            color: var(--text);
            background: white;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 4px var(--input-focus);
        }

        input[type="submit"] {
            background-color: var(--primary);
            color: white;
            font-weight: 600;
            cursor: pointer;
            padding: 1rem;
            margin-top: 1rem;
            border: none;
            transition: all 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(226, 55, 68, 0.2);
        }

        .login-link {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.875rem;
            color: var(--text-light);
        }

        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            margin-left: 0.25rem;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            form {
                padding: 1.5rem;
            }

            h2 {
                font-size: 1.75rem;
            }

            .container {
                max-width: 500px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem 0.5rem;
            }

            form {
                padding: 1.25rem;
                border-radius: 16px;
            }

            h2 {
                font-size: 1.5rem;
                margin-bottom: 1.25rem;
            }

            input {
                padding: 0.625rem 0.875rem;
                font-size: 0.875rem;
            }

            .form-group {
                margin-bottom: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="RestaurantSignUpServlet" method="POST">
            <h2>Restaurant SignUp</h2>
            <div class="form-grid">
                <!-- Restaurant Details -->
                <div class="form-group">
                    <label for="restaurantName">Restaurant Name</label>
                    <input type="text" id="restaurantName" name="restaurantName" placeholder="Enter restaurant name" required>
                </div>
                <div class="form-group">
                    <label for="cuisineType">Cuisine Type</label>
                    <input type="text" id="cuisineType" name="cuisineType" placeholder="e.g., Italian, Indian, Chinese" required>
                </div>
                <div class="form-group full-width">
                    <label for="image">Restaurant Image URL</label>
                    <input type="text" id="image" name="image" placeholder="Enter image URL" required>
                </div>
                <div class="form-group">
                    <label for="rating">Initial Rating</label>
                    <input type="number" id="rating" name="rating" min="0" max="5" step="0.1" placeholder="Enter rating (0-5)" required>
                </div>
                <div class="form-group">
                    <label for="eta">Average Delivery Time</label>
                    <input type="text" id="eta" name="eta" placeholder="e.g., 30 mins" required>
                </div>
                <div class="form-group full-width">
                    <label for="restaurantAddress">Restaurant Address</label>
                    <input type="text" id="restaurantAddress" name="restaurantAddress" placeholder="Full restaurant address" required>
                </div>

                <!-- Owner Details -->
                <div class="form-group">
                    <label for="name">Owner Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="Enter phone number" required>
                </div>
                <div class="form-group">
                    <label for="address">City</label>
                    <input type="text" id="address" name="address" placeholder="Enter your city" required>
                </div>

                <!-- Account Details -->
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Choose a username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>

                <!-- Hidden Fields -->
                <input type="hidden" id="isactive" name="isactive" value="true">
                <input type="hidden" id="restaurantOwnerId" name="restaurantOwnerId" value="<%= System.currentTimeMillis() %>">
            </div>

            <input type="submit" value="Register Restaurant">
            
            <div class="login-link">
                Already have an account? <a href="Login.jsp">Login here</a>
            </div>
        </form>
    </div>
</body>
</html>