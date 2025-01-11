<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.model.Restaurant, com.foodapp.daoimpl.RestaurantDAOImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Your Order | Tap Foods</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #e23744;
            --primary-hover: #e65a2d;
            --secondary: #334756;
            --background: #f8f9fa;
            --surface: #ffffff;
            --text: #2d3436;
            --text-light: #636e72;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --highlight: #ffd6a5;
            --success: #2ecc71;
            --pending: #f1c40f;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: var(--background);
            color: var(--text);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 800px;
            padding: 2rem;
            background-color: var(--surface);
            border-radius: 16px;
            box-shadow: var(--shadow);
            transform: translateY(0);
            transition: transform 0.3s ease;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
        }

        h2 {
            color: var(--secondary);
            font-size: 2rem;
            margin-bottom: 0.5rem;
            position: relative;
            padding-bottom: 10px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: var(--primary);
            border-radius: 2px;
        }

        .order-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .order-id-section {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .order-id {
            font-weight: 600;
            color: var(--secondary);
            background: rgba(51, 71, 86, 0.1);
            padding: 4px 12px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .copy-btn {
            background: none;
            border: none;
            color: grey;
            cursor: pointer;
            padding: 4px;
            transition: color 0.3s ease;
        }

        .copy-btn:hover {
            color: darkgrey;
        }

        .estimated-time {
            background: var(--highlight);
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 500;
        }

        /* Timeline styles */
        .timeline {
            margin: 2rem 0;
            position: relative;
            padding: 20px 0;
        }

        .timeline-track {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 24px;
            width: 2px;
            background: #e0e0e0;
        }

        .timeline-progress {
            position: absolute;
            top: 0;
            left: 24px;
            width: 2px;
            background: var(--success);
            transition: height 0.3s ease;
        }

        .timeline-items {
            position: relative;
            z-index: 1;
        }

        .timeline-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            padding-left: 50px;
            position: relative;
        }

        .timeline-icon {
            position: absolute;
            left: 12px;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background: var(--surface);
            border: 2px solid var(--text-light);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
        }

        .timeline-item.completed .timeline-icon {
            background: var(--success);
            border-color: var(--success);
            color: white;
        }

        .timeline-item.active .timeline-icon {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
        }

        .timeline-content {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            flex: 1;
        }

        .timeline-content h4 {
            margin-bottom: 0.5rem;
            color: var(--secondary);
        }

        .timeline-content p {
            color: var(--text-light);
            font-size: 0.9rem;
            margin: 0;
        }

        /* Delivery Partner Section */
        .delivery-partner {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 12px;
            margin: 2rem 0;
        }

        .partner-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .partner-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .partner-info h4 {
            color: var(--secondary);
            margin-bottom: 0.25rem;
        }

        .partner-info p {
            color: var(--text-light);
            font-size: 0.9rem;
            margin: 0;
        }

        .partner-contact {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .contact-btn {
            padding: 8px 16px;
            border-radius: 20px;
            border: none;
            background: var(--surface);
            color: var(--text);
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .contact-btn:hover {
            background: var(--primary);
            color: white;
        }

        /* Map Container */
        .map-container {
            height: 200px;
            background: #f8f9fa;
            border-radius: 12px;
            margin: 2rem 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 2rem;
        }

        .back-btn, .cancel-btn {
            flex: 1;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .back-btn {
            background-color: var(--primary);
            color: var(--surface);
        }

        .cancel-btn {
            background-color: var(--secondary);
            color: var(--surface);
        }

        .back-btn:hover, .cancel-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Toast Notification */
        .toast {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: #333;
            color: white;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 0.9rem;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .toast.show {
            opacity: 1;
            visibility: visible;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }

            .order-meta {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .order-id-section {
                justify-content: center;
            }

            .partner-contact {
                flex-direction: column;
            }

            .contact-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Track Your Order</h2>
        </div>

        <div class="order-meta">
            <div class="order-id-section">
                Order ID: 
                <span class="order-id">
                    <%= request.getParameter("orderId") %>
                    <button class="copy-btn" onclick="copyToClipboard('<%= request.getParameter("orderId") %>')" title="Copy Order ID">
                        <i class="fas fa-copy"></i>
                    </button>
                </span>
            </div>
            <div class="estimated-time">
         
                <i class="far fa-clock"></i>
                Estimated Delivery: 25-30 mins
            </div>
        </div>

        <div class="timeline">
            <div class="timeline-track"></div>
            <div class="timeline-progress" style="height: 25%;"></div>
            <div class="timeline-items">
                <div class="timeline-item completed">
                    <div class="timeline-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="timeline-content">
                        <h4>Order Confirmed</h4>
                        <p>Your order has been received and confirmed</p>
                    </div>
                </div>
                <div class="timeline-item active">
                    <div class="timeline-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="timeline-content">
                        <h4>Preparing Your Food</h4>
                        <p>Our chefs are preparing your delicious meal</p>
                    </div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-icon">
                        <i class="fas fa-motorcycle"></i>
                    </div>
                    <div class="timeline-content">
                        <h4>Out for Delivery</h4>
                        <p>Your order will be picked up by our delivery partner</p>
                    </div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <div class="timeline-content">
                        <h4>Delivered</h4>
                        <p>Enjoy your meal!</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="delivery-partner">
            <div class="partner-header">
                <div class="partner-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="partner-info">
                    <h4>Your Delivery Partner</h4>
                    <p>Will be assigned soon</p>
                </div>
            </div>
            <div class="partner-contact">
                <button class="contact-btn" disabled>
                    <i class="fas fa-phone"></i>
                    Call Partner
                </button>
                <button class="contact-btn" disabled>
                    <i class="fas fa-comment"></i>
                    Chat with Partner
                </button>
            </div>
        </div>

        <div class="map-container">
            <p><i class="fas fa-map-marker-alt"></i> Live tracking will be available once your order is picked up</p>
        </div>

        <div class="button-container">
            <button class="cancel-btn" onclick="window.location.href='Home.jsp'">
                <i class="fas fa-home"></i>
                Go to Home
            </button>
        </div>
    </div>

    <!-- Toast notification -->
    <div id="toast" class="toast">Order ID copied to clipboard!</div>

    <script>
        function copyToClipboard(orderId) {
            navigator.clipboard.writeText(orderId).then(() => {
                const toast = document.getElementById('toast');
                toast.classList.add('show');
                setTimeout(() => {
                    toast.classList.remove('show');
                }, 2000);
            }).catch(err => {
                console.error("Failed to copy Order ID: ", err);
            });
        }

        // Simulate order progress (for demo purposes)
        setTimeout(() => {
            document.querySelector('.timeline-progress').style.height = '50%';
        }, 3000);
    </script>
</body>
</html>