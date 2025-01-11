<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.foodapp.model.Order"%>
<%@ page import="com.foodapp.model.User"%>
<%@ page import="com.foodapp.model.Restaurant"%>
<%@ page import="com.foodapp.model.OrderItem"%>
<%@ page import="com.foodapp.dao.OrderItemDAO"%>
<%@ page import="com.foodapp.daoimpl.OrderItemDAOImpl"%>
<%@ page import="com.foodapp.dao.RestaurantDAO"%>
<%@ page import="com.foodapp.daoimpl.RestaurantDAOImpl"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History | Crave</title>
    <link rel="icon" href="http://localhost:8080/tapfoods/Images/icon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        body {
            margin: 0;
            background-color: #f8f9fa;
            font-family: 'Segoe UI', system-ui, sans-serif;
            color: #1c1c1c;
        }

        /* Existing navbar styles remain the same */
       /* Navbar Styles */
nav {
	position: fixed;
	top: 0;
	
	width: 100%;
	background-color: #e23744;
	z-index: 1000;
	padding: 15px 15px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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

.logo:hover {
	transform: scale(1.05);
}

.location-div {
	display: flex;
	align-items: center;
	color: white;
	gap: 5px;
}

.location-select {
	width: 150px;
	padding: 10px;
	border: none;
	border-radius: 30px;
	background: white;
	font-size: 1em;
	outline: none;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
	gap: 5px;
	padding: 8px 12px;
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


        /* Updated Order History Styles */
        .page-title {
            margin: 100px auto 20px;
            max-width: 1200px;
            padding: 0 20px;
        }

        .page-title h1 {
            font-size: 28px;
            font-weight: 600;
            color: #1c1c1c;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto 30px;
            padding: 0 20px;
        }

        .order-box {
            background: #ffffff;
            border-radius: 16px;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        .order-header {
            padding: 20px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fafafa;
        }

        .restaurant-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .restaurant-name {
            font-size: 18px;
            font-weight: 600;
            color: #1c1c1c;
        }

        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        .status-delivered {
            background: #e6f4ea;
            color: #1e8e3e;
        }

        .status-processing {
            background: #fef7e6;
            color: #b06000;
        }

        .order-content {
            padding: 20px;
        }

        .order-items {
            margin-bottom: 20px;
        }

        .order-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .item-quantity {
            background: #f0f0f0;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
            color: #666;
        }

        .item-name {
            font-size: 15px;
            color: #1c1c1c;
        }

        .order-footer {
            padding: 15px 20px;
            border-top: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fafafa;
        }

        .order-total {
            font-size: 16px;
            font-weight: 600;
            color: #1c1c1c;
        }

        .view-details-btn {
            background: #e23744;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .view-details-btn:hover {
            background: #d32f2f;
            transform: translateY(-1px);
        }

        .no-orders {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 16px;
            margin-top: 30px;
        }

        .no-orders i {
            font-size: 48px;
            color: #e23744;
            margin-bottom: 20px;
        }

        .no-orders p {
            font-size: 18px;
            color: #666;
            margin-bottom: 24px;
        }

        .see-restaurants {
            background: #e23744;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .see-restaurants:hover {
            background: #d32f2f;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .page-title {
                margin-top: 80px;
            }
            
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .order-status {
                align-self: flex-start;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar remains the same -->
    <nav>
        <div class="nav-container">
            <div class="nav-left">
                <a href="" class="logo">CRAVE</a>
            </div>
            <div class="nav-right">
                <a href="Home.jsp" class="nav-item">
                    <i class="fa-solid fa-house"></i>
                    <span>Home</span>
                </a>
                <a href="Cart.jsp" class="nav-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Cart</span>
                </a>
            </div>
        </div>
    </nav>

    <div class="page-title">
        <h1>Order History</h1>
    </div>

    <div class="container">
        <% List<Order> AllOrderItems = (List<Order>) session.getAttribute("allOrderItems");
    
           if (AllOrderItems != null && !AllOrderItems.isEmpty()) {
               for (Order orderItems : AllOrderItems) { 
                   RestaurantDAO rdao = new RestaurantDAOImpl();
                   Restaurant r = rdao.getRestaurant(orderItems.getRestaurantId());
                   OrderItemDAO odao = new OrderItemDAOImpl();
                   
           %>
            <div class="order-box">
                <div class="order-header">
                    <div class="restaurant-info">
                        <div class="restaurant-name"><%=r.getName()%></div>
                        <div class="order-id">#<%=orderItems.getOrderId()%></div>
                    </div>
                    <div class="order-status <%= orderItems.getStatus().toLowerCase().equals("delivered") ? "status-delivered" : "status-processing" %>">
                        <%= orderItems.getStatus() %>
                    </div>
                </div>
                <!--  
                <div class="order-content">
                    <div class="order-items">
                        <% for(OrderItem item : odao.getAllByOrderId(orderItems.getOrderId())) { %>
                            <div class="order-item">
                                <span class="item-quantity"><%=item.getQuantity()%>x</span>
                                <span class="item-name"><%=item.getItemName()%></span>
                            </div>
                        <% } %>
                    </div>
                </div>
				-->
				
                <div class="order-footer">
                    <div class="order-total">
                        Total: ₹<%=orderItems.getTotalAmount()%>
                    </div>
                    <a href="viewOrderDetails?orderId=<%=orderItems.getOrderId()%>">
                        <button class="view-details-btn">View Details</button>
                    </a>
                </div>
            </div>
        <% } 
           } else { %>
        <div class="no-orders">
            <i class="fas fa-shopping-bag"></i>
            <p>You haven't placed any orders yet</p>
            <a href="Home.jsp">
                <button class="see-restaurants">Explore Restaurants</button>
            </a>
        </div>
        <% } %>
    </div>
</body>
</html>