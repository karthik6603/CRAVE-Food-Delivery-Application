<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.foodapp.model.OrderItem" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>OrderItems</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }

    .order-container {
        margin: 2% auto;
        width: 90%;
        background-color: #fff;
        padding: 2%;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
    }

    .order-header, .order-item {
        display: flex;
        justify-content: space-between;
        padding: 10px 5%;
        border-bottom: 1px solid #e0e0e0;
    }

    .order-header {
        font-weight: bold;
        background-color: #f0f8ff;
        padding: 15px 5%;
    }

    .header-item, .item-name, .item-price, .item-quantity, .item-total {
        width: 20%;
        text-align: center;
    }

    .order-item:last-child {
        border-bottom: none;
    }

    .back-button {
        display: block;
        margin: 20px auto;
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 10px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 1vw;
    }

    .back-button:hover {
        background-color: #0056b3;
    }

    .no-items {
        text-align: center;
        padding: 20px;
    }

    .no-items p {
        font-size: 1.5vw;
        margin-bottom: 20px;
    }
</style>

</head>
<body>
<%
    // Retrieve the order items from the session or database
    List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("itemslist");

    if (orderItems != null && !orderItems.isEmpty()) {
%>
<div class="order-container">
    <h2>Order Items</h2>
    <div class="order-header">
        <div class="header-item">Item Name</div>
        <div class="header-item">Price</div>
        <div class="header-item">Quantity</div>
        <div class="header-item">Total</div>
    </div>
    <% for (OrderItem item : orderItems) { %>
    <div class="order-item">
        <div class="item-name"><%= item.getItemName() %></div>
        <div class="item-price">₹ <%= item.getPrice() %></div>
        <div class="item-quantity"><%= item.getQuantity() %></div>
        <div class="item-total">₹ <%= item.getPrice() * item.getQuantity() %></div>
    </div>
    <% } %>
</div>
<a href="OrderHistory.jsp">
    <button class="back-button">Back to Orders</button>
</a>
<%
    } else {
%>
<div class="no-items">
    <p>No items found for this order!</p>
    <a href="OrderHistory.jsp">
        <button class="back-button">Back to Orders</button>
    </a>
</div>
<%
    }
%>
</body>
</html>



