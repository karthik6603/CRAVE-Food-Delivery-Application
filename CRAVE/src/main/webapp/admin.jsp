<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.model.Restaurant"%>
<%@ page import="java.util.*"%>
<%@ page import=" com.foodapp.model.Order"%>
<%@ page import=" com.foodapp.model.User"%>
<%
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Crave</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --primary-color: #e23744;
            --secondary-color: #f8f9fa;
            --accent-color: #ff6b6b;
            --text-primary: #2d3436;
            --text-secondary: #636e72;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: var(--secondary-color);
            color: var(--text-primary);
            line-height: 1.6;
            padding-top: 80px; /* Increased padding to prevent content from hiding under navbar */
        }

        /* Navigation Styles */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: var(--primary-color);
            z-index: 1000;
            padding: 1rem;
            box-shadow: var(--shadow);
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .nav-left {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            letter-spacing: 1px;
            transition: transform 0.3s ease;
            white-space: nowrap;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            flex-wrap: nowrap;
        }

        .nav-item {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.2rem;
            border-radius: 50px;
            transition: all 0.3s ease;
            font-weight: 500;
            white-space: nowrap;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        /* Home Attributes Styles */
        .home-attributes {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .home-attributes a {
            position: relative;
            background: white;
            border-radius: 20px;
            text-decoration: none;
            color: var(--text-primary);
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            overflow: hidden;
            aspect-ratio: 1;
            display: flex;
            flex-direction: column;
        }

        .home-attributes a:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        .home-attributes .card-image {
            width: 100%;
            height: 65%;
            overflow: hidden;
            border-radius: 20px 20px 0 0;
        }

        .home-attributes img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .home-attributes a:hover img {
            transform: scale(1.1);
        }

        .home-attributes .card-content {
            padding: 1.5rem;
            background: white;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            border-radius: 0 0 20px 20px;
        }

        .home-attributes h3 {
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }

        .home-attributes p {
            color: var(--text-secondary);
            font-size: 0.95rem;
            margin: 0;
        }

        /* Form Styles */
        .form-container {
            display: none;
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: var(--shadow);
            max-width: 600px;
            margin: 2rem auto;
            transition: all 0.3s ease;
        }

        .form-container h2 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.8rem;
        }

        .form-container input {
            width: 100%;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--secondary-color);
        }

        .form-container input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(226, 55, 68, 0.1);
            outline: none;
        }

        .form-container button {
            width: 100%;
            padding: 1rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .form-container button:hover {
            background: #d42d3a;
            transform: translateY(-2px);
        }

        /* Restaurant Cards Styles */
        .restaurant-cards-container {
            display: none;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .restaurant-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
        }

        .restaurant-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        .restaurant-image-container {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
        }

        .restaurant-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .restaurant-card:hover .restaurant-image {
            transform: scale(1.1);
        }

        .restaurant-details {
            padding: 2rem;
        }

        .restaurant-details h3 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 1.4rem;
        }

        .restaurant-details p {
            margin: 1rem 0;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-size: 1.1rem;
        }

        .restaurant-details strong {
            color: var(--text-primary);
            min-width: 90px;
            font-weight: 600;
        }

        .restaurant-actions {
            display: flex;
            gap: 1rem;
            padding: 1.5rem 2rem;
            background: var(--secondary-color);
        }

        .edit-button, .delete-button {
            flex: 1;
            padding: 1rem;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .edit-button {
            background: var(--success-color);
            color: white;
        }

        .delete-button {
            background: var(--danger-color);
            color: white;
        }

        .edit-button:hover, .delete-button:hover {
            transform: translateY(-2px);
            filter: brightness(110%);
        }

        /* Orders Section Styles */
        .orders-container {
            display: none;
            padding: 2rem 1.5rem;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .orders-container h2 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .orders-container button {
            background: linear-gradient(45deg, var(--primary-color), #ff5757);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            margin: 0.4rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 0.9rem;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }

        .orders-container button:hover {
            transform: translateY(-2px);
            background: linear-gradient(45deg, #d42d3a, #ff5757);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
        }

        /* Preparing Orders Styles */
        .preparingOrders-list-container {
            display: none;
            padding: 2rem 1.5rem;
            max-width: 500px;
            margin: 0 auto;
        }

        .items {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            border: 1px solid #f0f0f0;
            margin-bottom: 1.5rem;
        }

        .items:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
            border-color: var(--primary-color);
        }

        .container1 {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
            font-size: 1rem;
            color: #333;
        }

        .container1 div {
            padding: 0.5rem;
            border-radius: 8px;
            background: var(--secondary-color);
            font-weight: 500;
            color: #444;
        }

        .reorder {
            display: inline-block;
            background: #4caf50;
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            margin-top: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            font-weight: 500;
        }

        .reorder:hover {
            background: #388e3c;
            transform: translateY(-2px);
        }

        .text {
            font-size: 1.2rem;
            color: #777;
        }

        .additemstext {
            background: var(--primary-color);
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 12px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .additemstext:hover {
            background: #d42d3a;
            transform: translateY(-2px);
        }

        .container3 {
            display: flex;
            justify-content: center;
            margin-top: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .home-attributes {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                padding: 1.5rem;
            }

            .restaurant-cards-container {
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            body {
                padding-top: 120px;
            }

            .nav-container {
                padding: 0 1rem;
            }

            .home-attributes {
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            body {
                padding-top: 140px;
            }

            .nav-container {
                flex-direction: column;
                gap: 1rem;
            }

            .nav-right {
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
                gap: 0.5rem;
            }

            .nav-item {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }

            .nav-item span {
                display: none;
            }

            .home-attributes {
                padding: 1rem;
            }

            .form-container {
                margin: 1rem;
                padding: 1.5rem;
            }

            .restaurant-cards-container {
                padding: 1rem;
            }

            .restaurant-card {
                margin: 0;
            }

            .orders-container button {
                width: calc(50% - 0.8rem);
                margin: 0.4rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding-top: 160px;
            }

            .home-attributes {
                grid-template-columns: 1fr;
            }

            .form-container {
                padding: 1rem;
            }

            .restaurant-details {
                padding: 1rem;
            }

            .restaurant-actions {
                flex-direction: column;
                padding: 1rem;
            }

            .orders-container button {
                width: 100%;
                margin: 0.4rem 0;
            }
        }
    </style>
</head>
<body>
    <!-- Rest of the HTML remains exactly the same as in your original code -->
    <!-- Navigation -->
    <nav>
        <div class="nav-container">
            <div class="nav-left">
                <a href="#" class="logo">CRAVE</a>
            </div>
            <div class="nav-right">
                <a href="#" class="nav-item" onclick="setActiveNavItem(this); showHome()">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="#" class="nav-item" onclick="setActiveNavItem(this); showViewOrders()">
                    <i class="fas fa-shopping-bag"></i>
                    <span>Orders</span>
                </a>
                <a href="#" class="nav-item" onclick="setActiveNavItem(this); showRemoveRestaurantForm()">
                    <i class="fas fa-store"></i>
                    <span>Restaurants</span>
                </a>
               
                <% //if(isLoggedIn) { %>
                    <a href="Crave" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                <%// } %>
            </div>
        </div>
    </nav>

    <!-- Home Section -->
    <div id="Home" class="home-attributes">
        <!-- Your existing home section content -->
        <a href="#" onclick="showAddRestaurantForm()">
            <div class="card-image">
                <img src="assets/images/admin/add-restaurant.jpg" alt="Add Restaurant">
            </div>
            <div class="card-content">
                <h3>Add Restaurant</h3>
                <p>Add New Restaurant to the Platform</p>
            </div>
        </a>
        <a href="#" onclick="showRemoveRestaurantForm()">
            <div class="card-image">
                <img src="assets/images/admin/remove-restaurant.jpg" alt="Remove Restaurant">
            </div>
            <div class="card-content">
                <h3>Remove Restaurant</h3>
                <p>Remove A Restaurant from the Platform</p>
            </div>
        </a>
        <a href="#" onclick="showViewOrders()">
            <div class="card-image">
                <img src="assets/images/admin/view-orders.jpg" alt="View Orders">
            </div>
            <div class="card-content">
                <h3>View Orders</h3>
                <p>View All Incoming Orders</p>
            </div>
        </a>
        <a href="#" onclick="showRegistrationForm()">
            <div class="card-image">
                <img src="assets/images/admin/add-agent.jpg" alt="Add Delivery Agent">
            </div>
            <div class="card-content">
                <h3>Add Delivery Agent</h3>
                <p>Add New Delivery Agent to the Platform</p>
            </div>
        </a>
    </div>

    <!-- Registration Form -->
    <div id="registrationForm" class="form-container">
        <!-- Your existing registration form content -->
        <h2>Delivery Agent Registration</h2>
        <form action="DeliveryAgent" method="POST">
            <input type="text" id="name" name="name" placeholder="Name" required>
            <input type="email" id="email" name="email" placeholder="Email" required>
            <input type="tel" id="phone" name="phone" placeholder="Phone Number" required>
            <input type="text" id="address" name="address" placeholder="Address" required>
            <input type="text" id="username" name="username" placeholder="Username" required>
            <input type="password" id="password" name="password" placeholder="Password" required>
            <button type="submit">Register</button>
        </form>
    </div>

    <!-- Add Restaurant Form -->
    <div id="addRestaurantForm" class="form-container">
        <!-- Your existing add restaurant form content -->
        <h2>Add Restaurant</h2>
        <form action="RestaurantAddServlet" method="POST">
            <input type="text" id="restaurantName" name="restaurantName" placeholder="Restaurant Name" required>
            <input type="text" id="rating" name="rating" placeholder="Rating" required>
            <input type="text" id="eta" name="eta" placeholder="ETA" required>
            <input type="text" id="cuisineType" name="cuisineType" placeholder="Cuisine Type" required>
            <input type="text" id="restaurantAddress" name="restaurantAddress" placeholder="Address" required>
            <input type="text" id="isactive" name="isactive" placeholder="Is Active" required>
            <input type="number" id="restaurantOwnerId" name="restaurantOwnerId" placeholder="Restaurant Owner ID" required>
            <button type="submit">Add Restaurant</button>
        </form>
    </div>

    <!-- Remove Restaurant Section -->
    <div id="removeRestaurantForm" class="restaurant-cards-container">
        <!-- Your existing restaurant cards content -->
        <% 
            List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
            if (restaurants != null) {
                for (Restaurant restaurant : restaurants) {
        %>
            <div class="restaurant-card">
                <div class="restaurant-image-container">
                    <img src="<%= restaurant.getImagePath() %>" alt="Restaurant Image" class="restaurant-image">
                </div>
                <div class="restaurant-details">
                    <h3><%= restaurant.getName() %></h3>
                    
                    
                    <p><strong>Rating:</strong> <%= restaurant.getRating() %> <i class="fas fa-star" style="color: #ffd700;"></i></p>
                    <p><strong>ETA:</strong> <%= restaurant.getEta() %> mins</p>
                    <p><strong>Cuisine:</strong> <%= restaurant.getCuisineType() %></p>
                    <p><strong>Address:</strong> <%= restaurant.getAddress() %></p>
<p><strong>Status:</strong> 
    <span style="color: <%= "open".equalsIgnoreCase(restaurant.getIsActive() != null ? restaurant.getIsActive().trim() : "") ? "var(--success-color)" : "var(--danger-color)" %>">
        <%= "open".equalsIgnoreCase(restaurant.getIsActive() != null ? restaurant.getIsActive().trim() : "") ? "Active" : "Inactive" %>
    </span>
</p>

                </div>
                <div class="restaurant-actions">
                    <button class="edit-button" onclick="editRestaurant('<%= restaurant.getRestaurantId() %>')">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="delete-button" onclick="deleteRestaurant('<%= restaurant.getRestaurantId() %>')">
                        <i class="fas fa-trash-alt"></i> Delete
                    </button>
                </div>
            </div>
        <% 
                }
            } else { 
        %>
            <p>No restaurants available.</p>
        <% 
            } 
        %>
    </div>

    <!-- View Orders Section -->
    <div id="viewOrders" class="orders-container">
        <!-- Your existing view orders content -->
        <h2>View Orders</h2>
        <div>
            <button onclick="showpreparingOrders()">Preparing Order</button>
            <button>Dispatched Order</button>
            <button>On the Way Order</button>
            <button>Delivered Order</button>
        </div>
    </div>

    <!-- Preparing Orders Section -->
    <div id="preparingOrders" class="preparingOrders-list-container">
        <!-- Your existing preparing orders content -->
        <% List<Order> AllOrderItems=(List<Order>)session.getAttribute("allOrders");
        if(AllOrderItems != null && !AllOrderItems.isEmpty()) { 
            for(Order orderItems: AllOrderItems) { %>
                <div class="items">
                    <div class="container1">
                        <div class="name">Order ID: <%= orderItems.getOrderId() %></div>
                        <div class="price">₹ <%= orderItems.getTotalAmount() %></div>
                        <div class="quan">Status: <%= orderItems.getStatus() %></div>
                        <div class="restaurantId">Payment: <%= orderItems.getModeOfPayment() %></div>
                        <div class="userId">User ID: <%= orderItems.getUserId() %></div>
                        <div class="itemName">Restaurant ID: <%= orderItems.getRestaurantId() %></div>
                        <div class="totalAmount">Total: ₹ <%= orderItems.getTotalAmount() %></div>
                        <a href="AgentServlet?orderId=<%= orderItems.getOrderId() %>&userid=<%= orderItems.getUserId() %>&restaurantid=<%= orderItems.getRestaurantId() %>">
                            <div class="reorder">Assign To Agent</div>
                        </a>
                    </div>
                </div>
        <% 
            }
        } else { %>
            <div class="items">
                <div class="container1">
                    <div class="text">It looks like there's no Order History</div>
                    <div class="container3">
                        <a href=""><div class="additemstext">SEE Order History &nbsp; &#10140;</div></a>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <script>
        // Your existing JavaScript code remains the same
        function setActiveNavItem(element) {
            document.querySelectorAll('.nav-item').forEach(item => {
                item.classList.remove('active');
            });
            element.classList.add('active');
        }

        function hideAllSections() {
            const sections = [
                'Home',
                'registrationForm',
                'addRestaurantForm',
                'removeRestaurantForm',
                'viewOrders',
                'preparingOrders'
            ];
            
            sections.forEach(section => {
                document.getElementById(section).style.display = 'none';
            });
        }

        function showHome() {
            hideAllSections();
            document.getElementById('Home').style.display = 'grid';
        }

        function showRegistrationForm() {
            hideAllSections();
            document.getElementById('registrationForm').style.display = 'block';
        }

        function showAddRestaurantForm() {
            hideAllSections();
            document.getElementById('addRestaurantForm').style.display = 'block';
        }

        function showRemoveRestaurantForm() {
            hideAllSections();
            document.getElementById('removeRestaurantForm').style.display = 'grid';
        }

        function showViewOrders() {
            hideAllSections();
            document.getElementById('viewOrders').style.display = 'block';
        }

        function showpreparingOrders() {
            hideAllSections();
            document.getElementById('preparingOrders').style.display = 'block';
        }

        function editRestaurant(restaurantId) {
            window.location.href = `editRestaurant.jsp?restaurantId=${restaurantId}`;
        }

        function deleteRestaurant(restaurantId) {
            if (confirm('Are you sure you want to delete this restaurant?')) {
                window.location.href = `DeleteRestaurantServlet?restaurantId=${restaurantId}`;
            }
        }

        // Initialize the dashboard
        window.onload = function() {
            showHome();
            document.querySelector('.nav-item').classList.add('active');
        };
    </script>
</body>
</html>