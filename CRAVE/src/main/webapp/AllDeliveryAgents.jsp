<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import=" com.foodapp.model.OrderItem"%>
<%@ page import=" com.foodapp.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delivery Agents</title>
</head>
<style>
/* General Styles */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

h1 {
    color: var(--primary-color);
    font-size: 2.5rem;
    font-weight: 600;
    margin-top: 2rem;
    text-align: center;
}

/* Preparing Orders Section */
.preparingOrders-cards-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3 cards per row */
    gap: 20px;
    margin: 30px auto;
    max-width: 1200px;
    padding: 0 1.5rem;
}

.items {
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    overflow: hidden;
    transition: transform 0.3s ease;
    padding: 20px;
    position: relative; /* For positioning the profile picture */
}

.items:hover {
    transform: translateY(-8px);
}

.profile-pic {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #ccc;
    
    position: absolute; /* Positioning relative to the card */
    top: 15px; /* Distance from the top of the card */
    left: 15px; /* Distance from the left of the card */
}

.container1 {
    margin-left: 80px; /* To avoid overlapping with the profile picture */
    display: flex;
    flex-direction: column;
}

.container1 .name {
    font-size: 1.4rem;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
}

.container1 .price,
.container1 .quan,
.container1 .userId,
.container1 .itemName {
    font-size: 1.1rem;
    color: #555;
    margin-bottom: 10px;
}

.reorder {
    display: inline-block;
    background-color: #4caf50; /* Green color for the button */
    color: white;
    padding: 12px 20px;
    border-radius: 8px;
    text-align: center;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
    font-size: 1rem;
    margin-top: 10px;
    font-weight: 500;
}

.reorder:hover {
    background-color: #388e3c; /* Darker green on hover */
    transform: translateY(-2px);
}

a {
    text-decoration: none;
}

/* No Agents Text */
.text {
    font-size: 1.4rem;
    color: #777;
    text-align: center;
}

.container3 {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.additemstext {
    font-size: 1.3rem;
    color: #007BFF;
    cursor: pointer;
    text-align: center;
}

.additemstext:hover {
    color: #0056b3; /* Hover color */
}

/* Responsive Styles */
@media (max-width: 1024px) {
    .preparingOrders-cards-container {
        grid-template-columns: repeat(2, 1fr); /* 2 cards per row */
    }
}

@media (max-width: 768px) {
    .preparingOrders-cards-container {
        grid-template-columns: 1fr; /* 1 card per row */
    }
    h1 {
        font-size: 2rem;
    }
}
</style>

<body>
    <center><h1>Delivery Agents</h1></center>
    <div id="preparingOrders" class="preparingOrders-cards-container">
        <% 
        List<User> DeliveryAgents = (List<User>)session.getAttribute("DeliveryAgents");
        if(DeliveryAgents != null && !DeliveryAgents.isEmpty()) {
            for(User deliveryAgent : DeliveryAgents) {
        %>
        <div class="items">
    <!-- Profile Picture -->
    <img src="assets/images/admin/delivery-agent.jpg" alt="Profile Picture" class="profile-pic">

    <!-- Agent Details -->
    <div class="container1">
        <div class="name"><%= deliveryAgent.getName() %></div>
        <div class="price"><%= deliveryAgent.getEmail() %></div>
        <div class="quan"><%= deliveryAgent.getPhoneNo() %></div>
        <div class="userId"><%= deliveryAgent.getUserName() %></div>
        <div class="itemName"><%= deliveryAgent.getUserId() %></div>
        <a href="AssignAgentServlet?agentid=<%= deliveryAgent.getUserId() %>&orderid=<%=(int)session.getAttribute("orderId") %>">
            <div class="reorder">Assign To This Agent</div>
        </a>
    </div>
</div>

        <% 
            }
        } else { 
        %>
        <div class="items">
            <div class="container1">
                <div class="text">It looks like there are no agents available.</div>
                <div class="container3">
                    <a href=""><div class="additemstext">SEE Agents &nbsp; &#10140;</div></a>
                </div>
            </div>
        </div>
        <% 
        }
        %>
    </div>
</body>

</html>