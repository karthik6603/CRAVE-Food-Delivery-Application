<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.foodapp.model.Restaurant, com.foodapp.model.Menu, com.foodapp.model.Cart, com.foodapp.model.CartItem, com.foodapp.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
   %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart | Crave</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    
    <style>
        :root {
            --primary-color: #e23744;
            --secondary-color: #2f3542;
            --background-color: #f1f2f6;
            --white: #ffffff;
            --gray-light: #dfe4ea;
            --gray-dark: #747d8c;
            --success: #2ed573;
            --danger: #e23744;
            --cart-item-bg: #ffffff;
            --cart-item-border: #e0e0e0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: var(--background-color);
            color: var(--secondary-color);
            line-height: 1.5;
        }
        
        /* Improved Navbar Styles */
nav {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background-color: #e23744;
    z-index: 1000;
    padding: 15px 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.nav-container {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nav-left {
    display: flex;
    align-items: center;
    gap: 30px;
}

.logo {
    font-size: 24px;
    font-weight: bold;
    color: white;
    text-decoration: none;
    transition: transform 0.3s;
}

.nav-right {
    display: flex;
    align-items: center;
    gap: 25px;
}

.nav-item {
    color: white;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    border-radius: 20px;
    transition: all 0.3s;
}

.nav-item:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-2px);
}

.nav-item i {
    font-size: 1.2em;
}

.cart {
	position: relative;
}

.cart span {
	position: absolute;
	top: -8px;
	right: -8px;
	background: white;
	color: #ff4757;
	border-radius: 50%;
	padding: 2px 6px;
	font-size: 0.8em;
	font-weight: bold;
}

        .cart-container {
            max-width: 900px;
            margin: 7rem auto;
            padding: 1.5rem;
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .cart-header {
            text-align: center;
            margin-bottom: 1.5rem;
            padding-bottom: 0.8rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .cart-header h1 {
            font-size: 2rem;
            color: var(--primary-color);
            font-weight: 600;
        }

        .empty-cart {
            text-align: center;
            padding: 2rem 1rem;
        }

        .empty-cart p {
            font-size: 1rem;
            color: var(--gray-dark);
            margin-bottom: 1rem;
        }

        .btn {
            display: inline-block;
            padding: 0.6rem 1.2rem;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }

        .btn-primary:hover {
            background-color: #d12f3c;
            transform: translateY(-2px);
        }

        .cart-item {
            background-color: var(--cart-item-bg);
            border: 1px solid var(--cart-item-border);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            transition: transform 0.2s ease;
        }

        .cart-item:hover {
            transform: translateY(-2px);
        }

        .item-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.8rem;
        }

        .item-info h3 {
            font-size: 1rem;
            color: var(--secondary-color);
            margin-bottom: 0.4rem;
        }

        .item-price {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 1rem;
        }

        .item-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 0.4rem;
            /* border-top: 1px solid var(--gray-light); */
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .quantity-btn {
            background-color: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        .quantity-btn:hover {
            background-color: var(--primary-color);
            color: var(--white);
        }

        .quantity-display {
            font-size: 1rem;
            font-weight: 600;
            color: var(--secondary-color);
            min-width: 36px;
            text-align: center;
        }

        .remove-btn {
            background-color: var(--danger);
            color: var(--white);
            padding: 0.8rem 1.6rem;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.8rem;
        }

        .remove-btn:hover {
            background-color: #d12f3c;
        }

        .cart-summary {
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid var(--gray-light);
            text-align: right;
        }

        .total-amount {
            font-size: 1.3rem;
            color: var(--secondary-color);
            margin-bottom: 1rem;
        }

        .total-amount span {
            color: var(--primary-color);
            font-weight: 600;
        }

        .cart-actions {
            display: flex;
            justify-content: flex-end;
            gap: 0.8rem;
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            color: var(--white);
        }

        .btn-secondary:hover {
            background-color: #272b33;
        }

        .btn-success {
            background-color: var(--success);
            color: var(--white);
        }

        .btn-success:hover {
            background-color: #26bc62;
        }

        @media (max-width: 768px) {
            .cart-container {
                margin: 1rem;
                padding: 1rem;
            }

            .item-details {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .cart-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }
        
        /* Responsive Styles */
@media (max-width: 768px) {
    nav {
        padding: 10px;
    }

    .nav-container {
        flex-wrap: wrap;
        gap: 15px;
    }

    .nav-right {
        width: 100%;
        justify-content: space-between;
        order: 2;
    }

    .nav-left {
        width: 100%;
        justify-content: center;
        order: 1;
    }

    .logo {
        font-size: 22px;
    }

    .nav-item {
        padding: 6px 12px;
        font-size: 0.9em;
    }
}

@media (max-width: 480px) {
    .nav-item span {
        display: none;
    }

    .nav-item {
        padding: 8px;
    }

    .nav-item i {
        font-size: 1.3em;
        margin: 0;
    }
}
    </style>
</head>
<body>

	<!-- Navbar -->
    <nav>
        <div class="nav-container">
            <div class="nav-left">
                <a href="Home.jsp" class="logo">CRAVE</a>
               
            </div>
            <div class="nav-right">
                
                <a href="Home.jsp" class="nav-item">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </a>
                <a href="OrderHistoryServlet" class="nav-item">
                    <i class="fas fa-history"></i>
                    <span>Orders</span>
                </a>
                
             
            </div>
        </div>
    </nav>

    <div class="cart-container">
        <div class="cart-header">
            <h1>Your Cart</h1>
        </div>
        
        <%
        Cart cart = (Cart) session.getAttribute("cart");
        
        if(cart == null || cart.getItems().isEmpty()) {
        %>
            <div class="empty-cart">
                <p>Your cart is empty</p>
                <a href="Home.jsp" class="btn btn-primary">Browse Menu</a>
            </div>
        <%
        } else {
            int restaurantId = 0;
            if(!cart.getItems().isEmpty()) {
                restaurantId = cart.getItems().values().iterator().next().getRestautantId();
            }
        %>
            <div class="cart-items">
                <%
                double totalAmount = 0;
                for(Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                    CartItem item = entry.getValue();
                    totalAmount += item.getPrice() * item.getQuantity();
                %>
                <div class="cart-item">
                    <div class="item-details">
                        <div class="item-info">
                            <h3><%= item.getName() %></h3>
                            <div class="item-price">₹<%= item.getPrice() %></div>
                        </div>
                        <div class="item-total">
                            Total: ₹<%=  item.getPrice() * item.getQuantity() %>
                        </div>
                    </div>
                    <div class="item-actions">
                        <div class="quantity-controls">
                            <form action="CartServlet" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                <button type="submit" name="quantity" value="<%= item.getQuantity() - 1 %>" 
                                        class="quantity-btn" <%= item.getQuantity() <= 1 ? "disabled" : "" %>>-</button>
                            </form>
                            
                            <span class="quantity-display"><%= item.getQuantity() %></span>
                            
                            <form action="CartServlet" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                <button type="submit" name="quantity" value="<%= item.getQuantity() + 1 %>" 
                                        class="quantity-btn">+</button>
                            </form>
                        </div>
                        
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </div>
                </div>
                <%
                }
                %>
            </div>
            
            <div class="cart-summary">
                <div class="total-amount">
                    Total Amount: <span>₹<%=  totalAmount %></span>
                    <% session.setAttribute("totalAmount", totalAmount); %>
                </div>
                <div class="cart-actions">
                    <a href="MenuServlet?restaurantId=<%= restaurantId %>" class="btn btn-secondary">Add More Items</a>
                    <a href="Checkout.jsp" class="btn btn-success">Proceed to Checkout</a>
                </div>
            </div>
        <%
        }
        %>
    </div>
</body>
</html>
