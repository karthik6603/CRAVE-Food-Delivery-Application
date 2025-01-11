<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.text.DecimalFormat, java.util.*, com.foodapp.model.CartItem, com.foodapp.model.Cart, com.foodapp.model.User, com.foodapp.model.Order, com.foodapp.model.OrderIdGenerator" %>
<%@ page import="com.foodapp.model.OrderIdGenerator" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | FoodApp</title>
    <!-- Add Font Awesome for the copy icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* ... (keep all existing styles) ... */
        
        /* Add new styles for the copy button */
        .copy-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 4px 8px;
            color: #ECEBDE;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            margin-left: 8px;
        }

        .copy-btn:hover {
            color: #C1BAA1;
        }

        .copy-btn i {
            font-size: 1rem;
        }

        /* Toast notification styles */
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

        /* Keep all your existing styles here */
        :root {
            --primary-color: #e23744;
            --secondary-color: #1a3a99;
            --text-color: #2d3436;
            --border-color: #e2e8f0;
            --background-color: #f7f9fc;
            --surface-color: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.4;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .card {
            background: var(--surface-color);
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            overflow: hidden;
        }

        .card-header {
            background: var(--primary-color);
            padding: 1.5rem;
            text-align: center;
            color: white;
        }

        .card-header h1 {
            font-size: 1.75rem;
            font-weight: 600;
            margin: 0;
        }

        .card-body {
            padding: 1.5rem;
        }

        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: #f8fafb;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .order-info-item {
            display: flex;
            flex-direction: column;
        }

        .order-info-label {
            color: #64748b;
            font-size: 0.85rem;
        }

        .order-info-value {
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .order-summary {
            width: 100%;
            border-collapse: collapse;
            margin: 1rem 0;
            font-size: 0.95rem;
        }

        .order-summary th {
            background: #f8fafb;
            padding: 0.75rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid var(--border-color);
        }

        .order-summary td {
            padding: 0.75rem;
            border-bottom: 1px solid var(--border-color);
        }

        .order-summary tr:last-child td {
            border-bottom: none;
        }

        .quantity {
            background: #f1f5f9;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.85rem;
        }

        .subtotal-section {
            border-top: 2px solid var(--border-color);
            margin-top: 0.5rem;
        }

        .subtotal-section td {
            padding: 0.5rem 0.75rem;
        }

        .total-row {
            background: #f8fafb;
            font-weight: 600;
        }

        .total-row td {
            padding: 0.75rem;
            border-top: 2px solid var(--border-color);
        }

        .delivery-address {
            background: #f8fafb;
            padding: 1rem;
            border-radius: 8px;
            margin: 1.5rem 0;
        }

        .delivery-address h3 {
            font-size: 1rem;
            color: #64748b;
            margin-bottom: 0.5rem;
        }

        .delivery-address p {
            font-size: 0.95rem;
            line-height: 1.5;
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            color: #ffffff;
            border: none;
        }

        .btn-primary:hover {
            background: #d32f2f;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn-secondary {
            background: #384B70;
            color: #ffffff;
            border: none;
        }

        .btn-secondary:hover {
            background: #193993;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 1.5rem;
            gap: 1rem;
        }

        .actions .btn {
            flex: 1;
            margin: 0.25rem;
        }

        @media (max-width: 640px) {
            .container {
                margin: 0;
            }
            
            .card {
                
                border-radius: 12px;
            }
            
            .card-header{
            	margin-top: 30px;
            	border-radius: 15px 15px 0 0;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1>Order Confirmation</h1>
            </div>
            
            <% 
                int orderId = (Integer) session.getAttribute("orderId");
            %>
            
            <div class="card-body">
                <div class="order-info">
                    <div class="order-info-item">
                        <span class="order-info-label">Order ID</span>
                        <span class="order-info-value">
                            <%= orderId %>
                            <button class="copy-btn" onclick="copyToClipboard('<%= orderId %>')" title="Copy Order ID">
                                <i class="fas fa-copy"></i>
                            </button>
                        </span>
                    </div>
                    <div class="order-info-item">
                        <span class="order-info-label">Date</span>
                        <span class="order-info-value">
                            <%= new SimpleDateFormat("MMM d, yyyy").format(new Date()) %>
                        </span>
                    </div>
                    <div class="order-info-item">
                        <span class="order-info-label">Time</span>
                        <span class="order-info-value">
                            <%= new SimpleDateFormat("HH:mm").format(new Date()) %>
                        </span>
                    </div>
                </div>

                <div class="delivery-address">
                    <h3>Delivery Address</h3>
                    <p>
                    <% User user = (User) session.getAttribute("user"); %>
                        <%= user.getName() %><br>
                        <%= session.getAttribute("address") %><br>
                        <%= session.getAttribute("city") %>, <%= session.getAttribute("pincode") %><br>
                        Phone: <%= user.getPhoneNo() %>
                    </p>
                </div>

                <table class="order-summary">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Price</th>
                            <th>Qty</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            Cart cart = (Cart) session.getAttribute("cart");
                            if (cart != null) {
                                double totalPrice = (double) session.getAttribute("totalPrice");
                                double deliveryFee = 40.0;
                                double gst = totalPrice * 0.12;
                                double finalTotal = totalPrice + deliveryFee + gst;
                                DecimalFormat df = new DecimalFormat("#.##");

                                for (CartItem item : cart.getItems().values()) {
                                    double itemTotal = item.getPrice() * item.getQuantity();
                        %>
                        <tr>
                            <td><%= item.getName() %></td>
                            <td>₹<%= df.format(item.getPrice()) %></td>
                            <td><span class="quantity"><%= item.getQuantity() %></span></td>
                            <td>₹<%= df.format(itemTotal) %></td>
                        </tr>
                        <% 
                                }
                        %>
                        <tr>
                            <td colspan="3">Subtotal</td>
                            <td>₹<%= df.format(totalPrice) %></td>
                        </tr>
                        <tr>
                            <td colspan="3">Delivery Fee</td>
                            <td>₹<%= df.format(deliveryFee) %></td>
                        </tr>
                        <tr>
                            <td colspan="3">GST (12%)</td>
                            <td>₹<%= df.format(gst) %></td>
                        </tr>
                        <tr class="total-row">
                            <td colspan="3">Total Amount</td>
                            <td>₹<%= df.format(finalTotal) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <div class="actions">
                    <button onclick="window.location.href='Checkout.jsp'" class="btn btn-secondary">
                        Go Back
                    </button>
                    <button onclick="window.location.href='confirmation2.jsp'" class="btn btn-primary">
                        Confirm Order
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast notification -->
    <div id="toast" class="toast">Order ID copied to clipboard!</div>
    
    <script>
        function copyToClipboard(orderId) {
            navigator.clipboard.writeText(orderId).then(() => {
                // Show toast notification
                const toast = document.getElementById('toast');
                toast.classList.add('show');
                
                // Hide toast after 2 seconds
                setTimeout(() => {
                    toast.classList.remove('show');
                }, 2000);
            }).catch(err => {
                console.error("Failed to copy Order ID: ", err);
            });
        }
    </script>
</body>
</html>