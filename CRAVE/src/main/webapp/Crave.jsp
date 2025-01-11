<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.foodapp.model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Crave - Delicious Food Delivered</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', system-ui, sans-serif;
	line-height: 1.6;
	color: #333;
	min-height: 100vh;
	background: #f5f5f5;
}

nav {
	position: absolute;
	top: 0;
	width: 100%;
	z-index: 1000;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px 30px;
}

nav ul {
	width: 100%;
	justify-content: flex-end;
	list-style: none;
	display: flex;
	align-items: center;
	margin: 0;
}

nav li {
	margin: 0 15px;
}

nav a {
	color: white;
	padding: 8px 16px;
	text-decoration: none;
	display: flex;
	align-items: center;
	font-size: 1.1em;
	border-radius: 20px;
	transition: all 0.3s;
}

nav a:hover {
	background: rgba(255, 255, 255, 0.1);
	color: #e23744;
}

nav li:first-child {
	margin-right: auto;
	font-weight: bolder;
	font-size: 24px;
}

nav li:first-child a {
	color: #e23744;
}

.sidebar {
	position: fixed;
	top: 0;
	right: 0;
	height: 100vh;
	width: 250px;
	z-index: 999;
	background-color: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	box-shadow: -10px 0 10px rgba(0, 0, 0, 0.1);
	display: none;
	flex-direction: column;
	align-items: flex-start;
	justify-content: flex-start;
	padding-top: 60px;
}

.sidebar li {
	width: 100%;
}

.sidebar a {
	width: 100%;
	color: #333;
	padding: 15px 25px;
}

.menu-button {
	display: none;
}
.hero {
	text-align: center;
	height: 60vh;
	background-image: url('assets/images/landing2.jpg');
	background-size: cover;
	background-position: center;
	color: white;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);
	padding: 0 20px;
	padding-top: 20px;
	margin-bottom: 0;
}

.hero h1 {
	font-size: 3.5em;
	margin-bottom: 15px;
}

.hero p {
	font-size: 1.6em;
	margin-bottom: 30px;
}

.search-box {
    display: flex;
    flex: 1;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border-radius: 30px;
    overflow: hidden;
    background: white;
    position: relative;
}

.location-select {
    width: 150px;
    padding: 15px;
    border: none;
    background: white;
    font-size: 1em;
    outline: none;
    border-right: 1px solid #e0e0e0;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    padding-right: 30px;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%23666' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 8px center;
    background-size: 16px;
}

.location-select:focus {
    outline: none;
}

.search-box input {
    flex: 1;
    padding: 15px 25px;
    border: none;
    outline: none;
    font-size: 1em;
}

.search-box button {
    padding: 15px 35px;
    background-color: #ff4757;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s;
}

.search-box button:hover {
    background-color: #ff2e43;
}

.search-container {
    display: flex;
    width: 90%;
    max-width: 800px;
    justify-content: center;
}

@media (max-width: 768px) {
    .search-box {
        flex-direction: column;
        border-radius: 15px;
    }
    
    .location-select {
        width: 100%;
        border-right: none;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .search-box input {
        width: 100%;
    }
    
    .search-box button {
        width: 100%;
    }
}

.main-content {
	margin-top: 10px;
	padding: 20px;
	max-width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

/* Category Section */
.category-section {
	background: white;
	border-radius: 12px;
	padding: 20px;
	margin-bottom: 30px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.section-title {
	font-size: 24px;
	color: var(--dark);
	margin-bottom: 20px;
	padding-left: 10px;
}

.scroll-container {
	position: relative;
	overflow: hidden;
}

.category-scroll {
	display: flex;
	gap: 20px;
	overflow-x: auto;
	padding: 10px 0;
	scroll-behavior: smooth;
	-ms-overflow-style: none;
	scrollbar-width: none;
}

.category-scroll::-webkit-scrollbar {
	display: none;
}

.category-item {
	flex: 0 0 auto;
	text-align: center;
}

.category-item img {
	width: 120px;
	height: 120px;
	border-radius: none;
	object-fit: cover;
	transition: transform 0.3s ease;
	border: 2px solid transparent;
}

.category-item:hover img {
	transform: scale(1.05);
}

/* Restaurant card styles */


.main-container {
    padding: 0rem;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

.container h1 {
    font-size: 2.5rem;
    color: #1a1a1a;
    margin-bottom: 2rem;
    font-weight: 700;
}

.restaurant-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 1.5rem;
}

.restaurant-grid a{
	text-decoration: none;
}
.restaurant-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s, box-shadow 0.2s;
}

.restaurant-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.restaurant-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.card-content {
    padding: 1.25rem;
}

.restaurant-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1rem;
}

.restaurant-header h2 {
    font-size: 1.25rem;
    color: #1a1a1a;
    font-weight: 600;
}

.rating {
    background-color: #e6f4ea;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    display: flex;
    align-items: center;
    gap: 0.25rem;
}

.rating i {
    color: #ffd700;
}

.rating span {
    color: #1a1a1a;
    font-weight: 500;
    font-size: 0.875rem;
}

.restaurant-info {
    display: flex;
    gap: 1rem;
    margin-bottom: 1rem;
    color: #666;
    font-size: 0.875rem;
}

.restaurant-info span {
    display: flex;
    align-items: center;
    gap: 0.375rem;
}

.tags {
    display: flex;
    justify-content: space-between;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.cuisine-tag {
    background-color: #fff3e6;
    color: #e65c00;
    padding: 0.25rem 0.75rem;
    border-radius: 999px;
    font-size: 0.875rem;
    font-weight: 500;
}

.status-tag{
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 999px;
    font-size: 0.875rem;
    font-weight: 500;
}

.status-tag.active{
	background-color: #118B50;
}

.status-tag.inactive{
	background-color: #FF4545;
}

.app-download-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    display: flex;
    align-items: center;
    gap: 60px;
}

/* App preview section */
.app-preview {
    flex: 1;
    max-width: 450px;
}

.app-phones {
    width: 100%;
    height: auto;
    object-fit: contain;
}

/* Download content section */
.download-content {
    flex: 1;
    max-width: 450px;
}

.download-content h1 {
    font-size: 44px;
    font-weight: 500;
    margin-bottom: 16px;
    color: #1c1c1c;
}

.download-content p {
    font-size: 18px;
    color: #666666;
    margin-bottom: 32px;
}

.highlight {
    color: #1c1c1c;
}

/* Form styles */
.share-form {
    margin-bottom: 40px;
}

.radio-group {
    display: flex;
    gap: 24px;
    margin-bottom: 16px;
}

.radio-label {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    padding: 8px 12px;
    border-radius: 8px;
    transition: background-color 0.2s;
}

.radio-label:hover {
    background-color: #f8f8f8;
}

.radio-label.active {
    color: #ff4757;
}

.radio-label input {
    accent-color: #ff4757;
}

.input-group {
    display: flex;
    gap: 12px;
}

.contact-input {
    flex: 1;
    padding: 14px 16px;
    border: 1px solid #e8e8e8;
    border-radius: 8px;
    font-size: 16px;
    outline: none;
    transition: border-color 0.2s;
}

.contact-input:focus {
    border-color: #ff4757;
}

.share-button {
    padding: 14px 28px;
    background-color: #ff4757;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
}

.share-button:hover {
    background-color: #ff3344;
}

/* Store links section */
.store-links p {
    margin-bottom: 16px;
}

.store-buttons {
    display: flex;
    gap: 24px;
}

.store-badge {
    height: 40px;
    width: auto;
    transition: transform 0.2s;
}

.store-badge:hover {
    transform: scale(1.05);
}

/* Responsive design */
@media (max-width: 968px) {
    .app-download-container {
        flex-direction: column;
        text-align: center;
        gap: 40px;
    }

    .app-preview, .download-content {
        max-width: 100%;
    }

    .radio-group {
        justify-content: center;
    }

    .store-buttons {
        justify-content: center;
    }
}

@media (max-width: 480px) {
    h1 {
    	margin-top: 15px;
        font-size: 25px;
    }

    .input-group {
        flex-direction: column;
    }

    .share-button {
        width: 100%;
    }

    .store-buttons {
        flex-direction: column;
        align-items: center;
        gap: 16px;
    }

    .store-badge {
        height: 48px;
    }
}
        
footer {
	background: #1a1a1a;
	color: white;
	padding: 40px 20px;
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
	text-decoration: none;
	text-align: center;
	margin-top: 40px;
	padding-top: 20px;
	border-top: 1px solid #333;
}

@media ( max-width : 768px) {
	.logo {
		display: none;
	}
	.hero {
                padding-top: 30px; /* Increased padding for mobile */
            }
	.hero h1 {
		font-size: 2em;
	}
	.hero p {
		font-size: 1.2em;
	}
	.search-container {
		flex-direction: column;
	}
	
            .search-box input {
                width: 100%;
                padding-right: 50px; /* Space for search icon */
            }

            .search-box button {
                position: absolute;
                right: 0;
                top: 50%;
                transform: translateY(-50%);
                width: auto;
                padding: 15px;
                background: none;
                color: #ff4757;
            }

            .search-box button span {
                display: none;
            }

            .search-box button i {
                display: block;
                font-size: 1.2em;
            }
	.location-select {
		width: 100%;
	}
	.hideOnMobile {
		display: none;
	}
	.menu-button {
		display: block;
	}
}

@media ( max-width : 400px) {
	.sidebar {
		width: 60%
	}
}

        /* Add search icon for mobile */
        .search-icon {
            display: none;
        }

        @media (max-width: 768px) {
        	
        	.main-container .container h1{
        		font-size: 2rem;
        		margin-bottom: 10px;
        	}
        
            .search-icon {
                display: block;
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #ff4757;
                font-size: 1.2em;
            }

            .search-box button {
                display: none;
            }
            .category-section{
            	padding-bottom: 0;
            }
            .app-download-container{
            	padding: 0;
            	}
        }
        
        
        .search-input-wrapper {
    position: relative;
    flex: 1;
    display: flex;
    align-items: center;
}

.search-input-wrapper input {
    width: 100%;
    padding: 15px 40px 15px 15px;
    border: none;
    outline: none;
    font-size: 1em;
}

.search-icon {
    position: absolute;
    right: 15px;
    color: #666;
    font-size: 1.2em;
    cursor: pointer;
}

@media (max-width: 768px) {
    .search-button {
        display: none;
    }
    
    .search-input-wrapper {
        width: 100%;
    }
    
    .search-icon {
        color: #ff4757;
    }
}

</style>
</head>
<body>

<nav>
    <ul class="sidebar">
        <li onclick="hideSidebar()"><a href="#"><i class="fas fa-times"></i></a></li>
        <li><a href="Offers.jsp">Offers</a></li>
        <li><a href="Login.jsp">Login</a></li>
        <li><a href="Register.jsp">Sign up</a></li>
    </ul>
    <ul>
        <li class="logo"><a href="#">Crave</a></li>
        <li class="hideOnMobile"><a href="Offers.jsp">Offers</a></li>
        <li class="hideOnMobile"><a href="Login.jsp">Login</a></li>
        <li class="hideOnMobile"><a href="Register.jsp">Sign up</a></li>
        <li class="menu-button" onclick="showSidebar()"><a href="#"><i class="fas fa-bars"></i></a></li>
    </ul>
</nav>


 <div class="hero">
        <h1 class="head1">Discover the Best Food & Restaurants</h1>
        <p>Your guide to amazing food experiences</p>
        <div class="search-container">
            <div class="search-box">
                <select class="location-select" id="location-select">
                    <option value="">Your location</option>
                    <option value="mumbai">Mumbai</option>
                    <option value="delhi">Delhi</option>
                    <option value="bangalore">Bangalore</option>
                    <option value="chennai">Chennai</option>
                    <option value="kolkata">Kolkata</option>
                </select>
                <div class="search-input-wrapper">
            <input type="text" placeholder="Search for food, restaurants...">
            <i class="fas fa-search search-icon"></i>
        </div>
                <button>Search</button>
            </div>
        </div>
    </div>

	<!-- Main Content -->
	<main class="main-content">
		<!-- Category Section -->
		<div class="category-section">
			<h2 class="section-title">What's on your mind?</h2>
			<div class="scroll-container">
				<div class="category-scroll">
					<%
					for (int i = 1; i <= 18; i++) {
					%>
					<div class="category-item">
						<img src="assets/images/scroll/scroll-<%=i%>.png"
							alt="Category <%=i%>">
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>
	

	<!-- Restaurant Grid -->
<div class="main-container">
    <% 
            List<Restaurant> restaurantList = (List<Restaurant>) session.getAttribute("restaurantList");
            if(restaurantList != null && !restaurantList.isEmpty()) {
                
            %>
        <div class="container">
            <h1>Restaurants Near You</h1>
            
            <div class="restaurant-grid">
                <% for(Restaurant r : restaurantList){
				%>
				<a href="MenuServlet?restaurantId=<%= r.getRestaurantId() %>&name=<%= r.getName() %>&cuisine=<%= r.getCuisineType() %>">
                <div class="restaurant-card">
				        <img src="<%= (r.getImagePath()) %>" 
                         alt="<%=(r.getName()) %>">
                    <div class="card-content">
                        <div class="restaurant-header">
                            <h2><%=(r.getName()) %></h2>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <span><%=(r.getRating()) %></span>
                            </div>
                        </div>
                        <div class="restaurant-info">
                            <span><i class="far fa-clock"></i> <%= r.getEta() %></span>
                            <span><i class="fas fa-map-marker-alt"></i> <%= r.getAddress() %></span>
                        </div>
                        <div class="tags">
                            <span class="cuisine-tag"><%=(r.getCuisineType()) %></span>
                            <span class="status-tag <%= r.getIsActive()  %>">
							</span>

                        </div>
                    </div>
                </div>
                 </a>
                
                <%
        	}
        	}
        	else {
                %>
                <p>No restaurants available</p>
                <% } %>
            </div>
        </div>
    </div>
    
    
    <div class="app-download-container">
        <div class="app-preview">
            <img src="assets/images/Home/apps.png" 
                 alt="Zomato App Preview" 
                 class="app-phones">
        </div>
        
        <div class="download-content">
            <h1>Get the Crave app</h1>
            <p>We will send you a link, open it on your phone to download <span class="highlight">the app</span></p>

            <form class="share-form">
                <div class="radio-group">
                    <label class="radio-label active">
                        <input type="radio" name="contactMethod" checked>
                        <span>Email</span>
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="contactMethod">
                        <span>Phone</span>
                    </label>
                </div>

                <div class="input-group">
                    <input type="email" placeholder="Email" class="contact-input">
                    <button type="submit" class="share-button">Share App Link</button>
                </div>
            </form>

            <div class="store-links">
                <p>Download app from</p>
                <div class="store-buttons">
                    <a href="https://play.google.com/store" target="_blank" rel="noopener noreferrer">
                        <img src="https://b.zmtcdn.com/data/webuikit/23e930757c3df49840c482a8638bf5c31556001144.png" 
                             alt="Get it on Google Play" 
                             class="store-badge">
                    </a>
                    <a href="https://apps.apple.com" target="_blank" rel="noopener noreferrer">
                        <img src="https://b.zmtcdn.com/data/webuikit/9f0c85a5e33adb783fa0aef667075f9e1556003622.png" 
                             alt="Download on the App Store" 
                             class="store-badge">
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    
</main>

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

	<script>
		function showSidebar() {
			const sidebar = document.querySelector('.sidebar')
			sidebar.style.display = 'flex'
		}
		function hideSidebar() {
			const sidebar = document.querySelector('.sidebar')
			sidebar.style.display = 'none'
		}
		
		function showSidebar() {
            const sidebar = document.querySelector('.sidebar')
            sidebar.style.display = 'flex'
        }
        
        function hideSidebar() {
            const sidebar = document.querySelector('.sidebar')
            sidebar.style.display = 'none'
        }

        // Location detection functionality
        window.addEventListener('load', () => {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        const { latitude, longitude } = position.coords;
                        
                        // Using reverse geocoding to get city name
                        fetch(`https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${latitude}&longitude=${longitude}&localityLanguage=en`)
                            .then(response => response.json())
                            .then(data => {
                                const city = data.city;
                                const locationSelect = document.getElementById('location-select');
                                
                                // Check if the detected city is in our list
                                const cityExists = Array.from(locationSelect.options)
                                    .some(option => option.text.toLowerCase() === city.toLowerCase());
                                
                                if (cityExists) {
                                    // If city exists in our list, select it
                                    locationSelect.value = city.toLowerCase();
                                } else {
                                    // If city doesn't exist in our list, add it and select it
                                    const newOption = new Option(city, city.toLowerCase());
                                    locationSelect.add(newOption, 0);
                                    locationSelect.value = city.toLowerCase();
                                }
                            })
                            .catch(error => {
                                console.error('Error getting city:', error);
                            });
                    },
                    (error) => {
                        console.error('Error getting location:', error);
                    }
                );
            }
        });
		

	
		
	</script>
</body>
</html>