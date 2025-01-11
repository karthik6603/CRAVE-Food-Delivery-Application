<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.model.*"%>
<%
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery Partner Dashboard | Crave</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #e23744;
            --primary-hover: #c62828;
            --secondary: #2d3436;
            --success: #2ecc71;
            --warning: #f1c40f;
            --danger: #e74c3c;
            --light: #f8f9fa;
            --dark: #343a40;
            --shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        body {
            background: #f5f6fa;
        }

        .section {
            display: none;
        }

        .section.active {
            display: block;
        }

        /* Navbar Styles */
        .navbar {
            background: var(--primary);
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow);
        }

        .nav-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
            transition: transform 0.3s;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            transition: all 0.3s;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        /* Dashboard Section */
        .dashboard-section {
            margin-top: 80px;
            padding: 2rem;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 60px;
            object-fit: cover;
            border: 3px solid var(--primary);
        }

        .profile-info h1 {
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .rating {
            color: var(--warning);
            margin-bottom: 0.5rem;
        }

        .status-badge {
            background: #e6f4ea;
            color: #1e8e3e;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            display: inline-block;
            font-weight: 500;
        }
        
        

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: var(--shadow);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-card i{
        	color: var(--primary);
        }

        .stat-icon {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--secondary);
            font-size: 0.9rem;
        }

        /* Orders Section */
        .orders-section {
            background: white;
            border-radius: 15px;
            max-width: 1200px;
            margin: 80px auto;
            padding: 2rem;
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
            border-collapse: collapse;
        }

        .orders-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .order-filter {
            padding: 0.75rem;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .orders-table {
            width: 100%;            
            border-collapse: collapse;
            margin-top: 1rem;
            border-radius: 10px;
            overflow: hidden;
        }

        .orders-table th, .orders-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .orders-table th {
            background-color: var(--primary);
            color: white;
            font-weight: bold;
        }

        .order-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .order-info h3 {
            margin-bottom: 0.5rem;
            color: var(--dark);
        }

        .order-meta {
            color: var(--secondary);
            font-size: 0.9rem;
        }

        .order-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }

        .status-pending {
            background: #fff3e0;
            color: #f57c00;
        }

        .status-delivered {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .action-button {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .action-button:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .profile-card {
                flex-direction: column;
                text-align: center;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .orders-table {
                display: block;
                overflow-x: auto;
            }
        }
        
        /* Profile Edit Section */
        .profile-edit {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: var(--shadow);
            max-width: 600px;
            margin: 80px auto;
        }

        .profile-edit h2 {
            color: var(--primary);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--secondary);
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(226, 55, 68, 0.1);
            outline: none;
        }

        .submit-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-content">
            <a href="#" class="logo">Crave</a>
            <div class="nav-links">
                <a href="#" class="nav-link" onclick="showSection('dashboard')">
                    <i class="fas fa-home"></i>
                    Dashboard
                </a>
                <a href="#" class="nav-link" onclick="showSection('orders')">
                    <i class="fas fa-motorcycle"></i>
                    Orders
                </a>
                <a href="#" class="nav-link" onclick="showSection('profile')">
                    <i class="fas fa-user"></i>
                    Profile
                </a>
                <a href="Crave" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Dashboard Section -->
    <section id="dashboard" class="section dashboard-section">
        <div class="profile-card">
            <img src="assets/images/profile/profile.jpg" alt="Profile" class="profile-image">
            <div>
                <h2><%= user.getName() %></h2>
                <div class="rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                    <span>4.8</span>
                </div>
                <span class="status-badge">
                    <i class="fas fa-circle"></i>
                    Active Now
                </span>
            </div>
        </div>

        <div class="stats-grid">
        	<div class="stat-card">
                <i class="fa-solid fa-chart-line"></i>
                <h3>98 %</h3>
                <p>Acceptance rate</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-route"></i>
                <h3>56</h3>
                <p>Total Deliveries</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock"></i>
                <h3>95 %</h3>
                <p>On Time Delivery</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-wallet"></i>
                <h3>₹3,240</h3>
                <p>Today's Earnings</p>
            </div>
            
        </div>
    </section>

    <!-- Orders Section -->
    <section id="orders" class="section orders-section">
        <div class="orders-header">
            <h2>Active Orders</h2>
            <select class="order-filter" onchange="filterOrders()">
                <option value="all">All Orders</option>
                <option value="confirmed">Pending</option>
                <option value="delivered">Delivered</option>
            </select>
        </div>

        <table class="orders-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                AgentOrders agentOrders = (AgentOrders) session.getAttribute("agentOrders");
                if (agentOrders != null && !agentOrders.getOrders().isEmpty()) {
                    for (DeliveryAgentOrders order : agentOrders.getOrders().values()) {
                        if (user.getUserId() == order.getAgentId()) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getName() %></td>
                    <td><%= order.getAddress() %></td>
                    <td class="status" id="status-<%= order.getOrderId() %>">
                        <%= (order.getStatus().equals("Confirmed")) ? "Pending" : "Delivered" %>
                    </td>
                    <td>
                        <button class="action-button" onclick="markAsDelivered(<%= order.getOrderId() %>)">
                            Pending
                        </button>
                    </td>
                </tr>
                <% 
                        }
                    }
                } 
                %>
            </tbody>
        </table>
    </section>
    
    <!-- Profile Edit Section -->
    <section id="profile" class="section profile-edit">
        <h2>Edit Profile</h2>
        <form action="EditDeliveryAgentServlet" method="post">
        	<input type="hidden" name="userId" value="<%= user.getUserId() %>">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" value="<%= user.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" value="<%= user.getPhoneNo() %>" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="<%= user.getAddress() %>" required>
            </div>
            <button type="submit" class="submit-btn">Update Profile</button>
        </form>
    </section>

    <script>
        // Show/Hide Sections
        function showSection(sectionId) {
            document.querySelectorAll('.section').forEach(section => {
                section.style.display = 'none';
            });
            document.getElementById(sectionId).style.display = 'block';
            
            // Update active nav link
            document.querySelectorAll('.nav-link').forEach(link => {
                link.classList.remove('active');
            });
            event.currentTarget.classList.add('active');
        }

        // Mark order as delivered
        function markAsDelivered(orderId) {
            const statusElement = document.getElementById(`status-${orderId}`);
            statusElement.textContent = 'Delivered';
            statusElement.classList.remove('status-pending');
            statusElement.classList.add('status-delivered');
            
            // Disable the button
            event.currentTarget.disabled = true;
            event.currentTarget.textContent = 'Delivered';
        }

        // Filter orders
        function filterOrders() {
            const filter = event.target.value;
            const rows = document.querySelectorAll('.orders-table tbody tr');
            
            rows.forEach(row => {
                const status = row.querySelector('.status').textContent.toLowerCase();
                row.style.display = (filter === 'all' || status.includes(filter)) ? '' : 'none';
            });
        }

        // Show dashboard by default when the window loads
        window.onload = function() {
            showSection('dashboard');
            document.querySelector('.nav-link[onclick="showSection(\'dashboard\')"]').classList.add('active');
        };
    </script>
</body>
</html>

