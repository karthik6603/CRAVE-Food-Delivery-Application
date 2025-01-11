<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.foodapp.model.Menu, com.foodapp.model.Restaurant"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f9f9f9;
	color: #333;
	line-height: 1.6;
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

/* Container styles */
.container {
	max-width: 1200px;
	margin: 2rem auto;
	padding: 0 1rem;
	margin-top: 5rem;
}

/* Header styles */
h1 {
	text-align: center;
	color: #2c3e50;
	margin-bottom: 2rem;
	font-size: 2.5rem;
	position: relative;
	padding-bottom: 1rem;
}

h1::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 120px;
	height: 4px;
	background-color: #e23744;
	border-radius: 2px;
}

/* Menu list styles */
.menu {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 1.5rem;
	padding: 1rem;
}

/* Menu item styles */
.menu-item {
	background: #fff;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	display: flex;
	flex-direction: column;
}

.menu-item:hover {
	transform: scale(1.02);
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
}

.menu-item img {
	width: 100%;
	height: 180px;
	object-fit: cover;
	border-bottom: 1px solid #ddd;
}

.menu-item-content {
	padding: 1.5rem;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	flex-grow: 1;
}

.menu-item h3 {
	color: #2c3e50;
	font-size: 1.4rem;
	margin-bottom: 0.5rem;
}

.menu-item p {
	color: #666;
	font-size: 0.95rem;
	margin-bottom: 1rem;
}

.menu-item .price {
	color: #e67e22;
	font-weight: bold;
	font-size: 1.2rem;
	margin-top: auto;
	padding: 0.3rem 0.8rem;
	background-color: #fef6e4;
	border-radius: 6px;
	text-align: center;
}

/* Previous styles remain the same */

/* Add to Cart button styles */
.add-to-cart-btn {
	background-color: #e23744;
	color: white;
	border: none;
	padding: 0.8rem 1.5rem;
	border-radius: 6px;
	font-weight: 600;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-top: 1rem;
	width: 100%;
	font-size: 1rem;
}

.add-to-cart-btn:hover {
	background-color: #c82333;
}

.add-to-cart-btn:disabled {
	background-color: #ccc;
	cursor: not-allowed;
}

/* Animation for button click */
.add-to-cart-btn:active {
	transform: scale(0.98);
}
/* Unavailable menu items */
.unavailable {
	opacity: 0.8;
	background-color: #fdf6f6;
}

.unavailable-tag {
	display: inline-block;
	background-color: #ff4757;
	color: white;
	padding: 0.3rem 0.8rem;
	border-radius: 20px;
	font-size: 0.85rem;
	margin-top: 0.5rem;
	text-align: center;
}

/* Empty menu message */
.empty-menu {
	text-align: center;
	padding: 3rem;
	background: white;
	border-radius: 12px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	font-size: 1.2rem;
	color: #666;
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.menu-item {
		flex-direction: column;
	}
	.menu-item img {
		height: 150px;
	}
}

/* Footer Styles */
footer {
	background: #1a1a1a;
	color: white;
	padding: 40px 20px;
	margin-top: auto;
}

.footer-content {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 40px;
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.footer-section {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.footer-section h4 {
	font-size: 1.2em;
	color: #ff4757;
	margin-bottom: 15px;
	position: relative;
	padding-bottom: 10px;
}

.footer-section h4::after {
	content: '';
	position: absolute;
	left: 0;
	bottom: 0;
	width: 50px;
	height: 2px;
	background-color: #ff4757;
}

.footer-section ul {
	list-style: none;
	padding: 0;
}

.footer-section ul li {
	margin-bottom: 10px;
}

.footer-section ul a {
	color: #999;
	text-decoration: none;
	transition: color 0.3s;
	display: inline-block;
}

.footer-section ul a:hover {
	color: #ff4757;
	transform: translateX(5px);
}

.social-icons {
	display: flex;
	gap: 15px;
}

.social-icons a {
	color: white;
	background: #333;
	width: 40px;
	height: 40px;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	transition: all 0.3s;
}

.social-icons a:hover {
	background: #ff4757;
	transform: translateY(-3px);
}

.footer-bottom {
	color: #999;
	text-align: center;
	margin-top: 40px;
	padding-top: 20px;
	border-top: 1px solid #333;
}
</style>
</head>
<body>

	<%
	List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
	String restaurantName = (String) request.getAttribute("restaurantName");
	%>
	
	    <!-- Navbar -->
    <nav>
        <div class="nav-container">
            <div class="nav-left">
                <a href="#" class="logo">CRAVE</a>
               
            </div>
            <div class="nav-right">
            
            <a href="Home.jsp" class="nav-item" id="profile">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                    </a>
                
                <a href="Cart.jsp" class="nav-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Cart</span>
                </a>
                <a href="OrderHistoryServlet" class="nav-item">
                    <i class="fas fa-history"></i>
                    <span>Orders</span>
                </a>
                
             <!--     <% //if(isLoggedIn) { %>
                    <a href="Crave" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                <%// } %>  -->
            </div>
        </div>
    </nav>
	


	<main class="container">
		<header>
		<h1>
			Menu for
			<%=restaurantName != null ? restaurantName : "Unavailable"%></h1>
	</header>
		<%
		if (menuList != null && !menuList.isEmpty()) {
		%>
		<ul class="menu">
			<%
			for (Menu menu : menuList) {
			%>
			<li class="menu-item"<%=!menu.getAvailable() ? "unavailable" : ""%>">
				<div class="menu-img">
					<img src="<%=menu.getImagePath()%>" alt="<%=menu.getName()%>" />
				</div>
				<div class="menu-item-content">
					<h3><%=menu.getName()%></h3>
					<p><%=menu.getDescription()%></p>
					<span class="price">Price: ₹<%=menu.getPrice()%></span>
					<%
					if (!menu.getAvailable()) {
					%>
					<span class="unavailable-tag">Currently Unavailable</span>
					<%
					}
					%>
					<form action="CartServlet" method="post">
						<input type="hidden" name="action" value="add">
						<input type="hidden" name="itemId" value="<%=menu.getMenuId()%>">
						<input type="hidden" name="restaurantId" value="<%=menu.getRestaurantId()%>">
						<button type="submit" class="add-to-cart-btn">Add to Cart</button>
					</form>
				</div>
			</li>
			<%
			}
			%>
		</ul>
		<%
		} else {
		%>
		<div class="empty-menu">
			<p>No menu items available for this restaurant.</p>
		</div>
		<%
		}
		%>
	</main>


	<!-- Footer -->
	<footer>
		<div class="footer-content">
			<div class="footer-section">
				<h4>About Crave</h4>
				<p>Your go-to platform for discovering amazing food experiences.</p>
				<div class="social-icons">
					<a href="#"><i class="fab fa-facebook-f"></i></a> <a href="#"><i
						class="fab fa-twitter"></i></a> <a href="#"><i
						class="fab fa-instagram"></i></a> <a href="#"><i
						class="fab fa-youtube"></i></a>
				</div>
			</div>
			<div class="footer-section">
				<h4>For Restaurants</h4>
				<ul>
					<li><a href="#">Partner With Us</a></li>
					<li><a href="#">Apps For You</a></li>
					<li><a href="#">Restaurant Dashboard</a></li>
				</ul>
			</div>
			<div class="footer-section">
				<h4>Learn More</h4>
				<ul>
					<li><a href="#">Privacy Policy</a></li>
					<li><a href="#">Security</a></li>
					<li><a href="#">Terms</a></li>
					<li><a href="#">Sitemap</a></li>
				</ul>
			</div>
			<div class="footer-section">
				<h4>Help & Support</h4>
				<ul>
					<li><a href="#">Customer Support</a></li>
					<li><a href="#">Partner Support</a></li>
					<li><a href="#">Contact Us</a></li>
					<li><a href="#">FAQ</a></li>
				</ul>
			</div>
		</div>
		<div class="footer-bottom">
			<p>By continuing past this page, you agree to our Terms of
				Service, Cookie Policy, Privacy Policy and Content Policies. All
				trademarks are properties of their respective owners.</p>
			<p>2024-2030 &copy; Crave™ Ltd. All rights reserved.</p>
		</div>
	</footer>
</body>
</html>