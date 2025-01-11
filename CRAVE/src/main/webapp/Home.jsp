<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.foodapp.model.Restaurant, com.foodapp.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
    List<Restaurant> originalRestaurantList = (List<Restaurant>) session.getAttribute("restaurantList");
    List<Restaurant> restaurantList = (originalRestaurantList != null) ? new ArrayList<>(originalRestaurantList) : new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Crave | Food Delivery</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
	padding-top: 70px;
	/* Added to prevent content from going under navbar */
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

/* Profile Details Card Styling */
.profile-details {
    display: none;
    position: fixed; /* Changed from absolute to fixed */
    top: 70px;
    right: 20px;
    width: 300px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    padding: 20px;
    z-index: 1000;
    max-height: calc(100vh - 90px); /* Ensure it doesn't go off screen */
    overflow-y: auto; /* Add scroll if content is too long */
}

.profile-image {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    margin: 0 auto 20px;
    border: 3px solid #ff4757;
    overflow: hidden;
}

.profile-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.name {
    text-align: center;
    font-size: 1.2em;
    font-weight: 600;
    color: #333;
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 12px;
    font-size: 0.9em;
}

.titles {
    color: #666;
    font-weight: 500;
}

.values {
    color: #333;
    font-weight: 500;
}

.values a {
    color: #ff4757;
    text-decoration: none;
}

.values a:hover {
    text-decoration: underline;
}

.logout-edit {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
    padding-top: 15px;
    border-top: 1px solid #eee;
}

.logout-edit a {
    padding: 8px 16px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 0.9em;
    font-weight: 500;
    transition: all 0.3s ease;
}

.logout-edit a:last-child {
    background: #ff4757;
    color: white;
}

.logout-edit a:first-child {
    background: #f0f0f0;
    color: #333;
}

.logout-edit a:hover {
    transform: translateY(-2px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* Category Section */
.main-content {
	margin-top: 20px;
	padding: 20px;
	max-width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

.category-section {
	background: white;
	border-radius: 12px;
	padding: 20px;
	margin-bottom: 30px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.section-title {
	font-size: 24px;
	color: #333;
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

/* Filters Section */
/* Filter Styles */
.filters {
    background: white;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    position: relative;
}
.filter-list {
	display: flex;
	gap: 15px;
	flex-wrap: wrap;
	list-style: none;
}

.filter-button {
    background: #f4f4f4;
    border: none;
    padding: 8px 16px;
    border-radius: 20px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 14px;
}

.filter-button:hover {
    background: #e0e0e0;
}



/* Add styles for the filter dropdown */
.filter-dropdown {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 10px;
    z-index: 100;
    min-width: 200px;
    margin-top: 5px;
}

.filter-dropdown label {
    display: block;
    padding: 8px;
    cursor: pointer;
}

.filter-dropdown label:hover {
    background: #f5f5f5;
}

/* Responsive improvements */
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

    .profile-details {
        width: 90%;
        left: 50%;
        transform: translateX(-50%);
        max-height: 80vh;
    }

    .restaurant-grid {
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1rem;
        padding: 1rem 0;
    }

    .filter-list {
        display: flex;
        gap: 10px;
        overflow-x: auto;
        padding-bottom: 5px;
        -ms-overflow-style: none;
        scrollbar-width: none;
    }

    .filter-list::-webkit-scrollbar {
        display: none;
    }

    .filter-button {
        white-space: nowrap;
        padding: 6px 12px;
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

    .restaurant-grid {
        grid-template-columns: 1fr;
    }

    .restaurant-card {
        margin: 0;
    }
}

.main-container {
    padding: 2rem;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

h1 {
    font-size: 2.5rem;
    color: #1a1a1a;
    margin-bottom: 2rem;
    font-weight: 700;
}

/* Restaurant Grid Fixes */
.restaurant-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 1.5rem;
    padding: 1.5rem 0;
    margin: 0;
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
    margin: 0;
    height: 100%;
    display: flex;
    flex-direction: column;
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

/* Responsive Design */
@media (max-width: 768px) {
    .main-content {
        padding: 1rem;
    }

    h1 {
        font-size: 2rem;
        margin-bottom: 1.5rem;
    }

    .restaurant-grid {
        grid-template-columns: 1fr;
    }

    .navbar {
        padding: 1rem;
    }
}

@media (max-width: 480px) {
    .restaurant-info {
        flex-direction: column;
        gap: 0.5rem;
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
    <!-- Navbar -->
    <nav>
        <div class="nav-container">
            <div class="nav-left">
                <a href="Home.jsp" class="logo">CRAVE</a>
               
            </div>
            <div class="nav-right">
                
                <a href="Cart.jsp" class="nav-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Cart</span>
                </a>
                <a href="OrderHistoryServlet" class="nav-item">
                    <i class="fas fa-history"></i>
                    <span>Orders</span>
                </a>
                <a href="" class="nav-item" id="profile">
                    <i class="fas fa-user"></i>
                    <span>Profile</span>
                    </a>
             <!--     <% if(isLoggedIn) { %>
                    <a href="Crave" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                <% } %>  -->
            </div>
        </div>
    </nav>

<!-- Profile details -->

<div class="profile-details" id="profile-details">
    <div class="profile-image">
                <img src="assets/images/profile/profile.jpg" 
                     alt="Profile">
            </div>
    <div class="name"><%=user.getName()%></div>
    <div class="info">
        <span class="titles">USERNAME</span>
        <span class="values"><%=user.getUserName()%></span>
    </div>
    <div class="info">
        <span class="titles">EMAIL</span>
        <span class="values"><%=user.getEmail()%></span>
    </div>
    <div class="info">
        <span class="titles">PHONE</span>
        <span class="values"><%=user.getPhoneNo()%></span>
    </div>
    <div class="info">
        <span class="titles">ADDRESS</span>
        <span class="values">
            <% if(user.getAddress()!=null) { %>
                <%=user.getAddress()%>
            <% } else { %>
                <a href="calledit?menu=menu">Add Address</a>
            <% } %>
        </span>
    </div>
    <div class="logout-edit">
        <a href="EditUserDetails.jsp">Edit</a>
        <% if(isLoggedIn) { %>
                    <a href="Crave" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>Logout</a>
                        </a>
                <% } %>
    </div>
</div>


    <!-- Main Content -->
    <div class="main-content">
        <!-- Category Section -->
        <div class="category-section">
            <h2 class="section-title">What's on your mind?</h2>
            <div class="scroll-container">
                <div class="category-scroll">
                    <% for(int i = 1; i <= 18; i++) { %>
                    <div class="category-item">
                        <img src="assets/images/scroll/scroll-<%=i%>.png" alt="Category <%=i%>">
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    

 <!-- Filters Section -->
 <!-- Updated Filters Section -->
        <div class="filters">
            <ul class="filter-list">
                <li>
                    <button class="filter-button" id="cuisineFilter">
                        <i class="bi bi-funnel"></i>Cuisine
                    </button>
                    <div class="filter-dropdown" id="cuisineDropdown">
                        <label><input type="checkbox" value="American"> American</label>
                        <label><input type="checkbox" value="Japanese"> Japanese</label>
                        <label><input type="checkbox" value="Mexican"> Mexican</label>
                        <label><input type="checkbox" value="Italian"> Italian</label>
                        <label><input type="checkbox" value="Indian"> Indian</label>
                        <label><input type="checkbox" value="Chinese"> Chinese</label>
                        <label><input type="checkbox" value="Thai"> Thai</label>
                        <label><input type="checkbox" value="Mediterranean"> Mediterranean</label>
                    </div>
                </li>
                <li>
                    <button class="filter-button" id="sortFilter">
                        <i class="bi bi-sort-down"></i>Sort By
                    </button>
                    <div class="filter-dropdown" id="sortDropdown">
                        <label><input type="radio" name="sort" value="etaAsc"> ETA (Low to High)</label>
                        <label><input type="radio" name="sort" value="etaDesc"> ETA (High to Low)</label>
                        <label><input type="radio" name="sort" value="ratingDesc"> Rating (High to Low)</label>
                    </div>
                </li>
                <li><button class="filter-button" id="ratingFilter"><i class="bi bi-star-fill"></i>Ratings 4.0+</button></li>
                <!-- Other filter buttons remain the same -->
            </ul>
        </div>

        
    <!-- Restaurant grid -->
<!-- Main Content -->
    <main class="main-container">
    <% 
            //List<Restaurant> restaurantList = (List<Restaurant>) session.getAttribute("restaurantList");
            if(restaurantList != null && !restaurantList.isEmpty()) {
                
            %>
        <main class="container">
            <h1>Restaurants Near You</h1>
            
            <div class="restaurant-grid">
                <% for(Restaurant r : restaurantList){
				%>
				<a href="MenuServlet?restaurantId=<%= r.getRestaurantId() %>&name=<%= r.getName() %>&cuisine=<%= r.getCuisineType() %>">
                <div class="restaurant-card">
				        <img src="<%= (r.getImagePath()) %>" 
                         alt="The Italian Corner">
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
        </main>
    </main>
        
	</div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h4>About Crave</h4>
                <p>Your go-to platform for discovering amazing food experiences.</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
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
            <p>By continuing past this page, you agree to our Terms of Service, Cookie Policy, Privacy Policy and Content Policies. All trademarks are properties of their respective owners.</p>
            <p>2024-2030 &copy; Crave™ Ltd. All rights reserved.</p>
        </div>
    </footer>
    
       <script>
       // Toggle profile details
       const profileBtn = document.getElementById("profile");
       const profileDetails = document.getElementById("profile-details");
       let isProfileVisible = false;

       profileBtn.addEventListener('click', function(e) {
           e.preventDefault(); // Prevent default link behavior
           isProfileVisible = !isProfileVisible;
           profileDetails.style.display = isProfileVisible ? "block" : "none";
       });

       // Close profile details when clicking outside
       document.addEventListener('click', function(e) {
           if (!profileBtn.contains(e.target) && !profileDetails.contains(e.target)) {
               isProfileVisible = false;
               profileDetails.style.display = "none";
           }
       });
       
    // Filter functionality
       const cuisineFilter = document.getElementById('cuisineFilter');
       const sortFilter = document.getElementById('sortFilter');
       const cuisineDropdown = document.getElementById('cuisineDropdown');
       const sortDropdown = document.getElementById('sortDropdown');
       const ratingFilter = document.getElementById('ratingFilter');
       const restaurantGrid = document.querySelector('.restaurant-grid');
       const restaurantLinks = document.querySelectorAll('.restaurant-grid > a');

    // Toggle dropdowns
       cuisineFilter.addEventListener('click', () => {
           cuisineDropdown.style.display = cuisineDropdown.style.display === 'block' ? 'none' : 'block';
           sortDropdown.style.display = 'none';
       });

       sortFilter.addEventListener('click', () => {
           sortDropdown.style.display = sortDropdown.style.display === 'block' ? 'none' : 'block';
           cuisineDropdown.style.display = 'none';
       });

       // Close dropdowns when clicking outside
       document.addEventListener('click', (e) => {
           if (!cuisineFilter.contains(e.target) && !cuisineDropdown.contains(e.target)) {
               cuisineDropdown.style.display = 'none';
           }
           if (!sortFilter.contains(e.target) && !sortDropdown.contains(e.target)) {
               sortDropdown.style.display = 'none';
           }
       });

       // Filter by cuisine
       const cuisineCheckboxes = cuisineDropdown.querySelectorAll('input[type="checkbox"]');
       cuisineCheckboxes.forEach(checkbox => {
           checkbox.addEventListener('change', filterRestaurants);
       });

       // Sort functionality
       const sortRadios = sortDropdown.querySelectorAll('input[type="radio"]');
       sortRadios.forEach(radio => {
           radio.addEventListener('change', sortRestaurants);
       });

       function filterRestaurants() {
           const selectedCuisines = Array.from(cuisineCheckboxes)
               .filter(cb => cb.checked)
               .map(cb => cb.value);

           const restaurants = Array.from(restaurantLinks);
           const container = restaurantGrid;
           
           // Clear the container first
           container.innerHTML = '';
           
           // Filter and append restaurants
           restaurants.forEach(link => {
               const cuisine = link.querySelector('.cuisine-tag').textContent;
               if (selectedCuisines.length === 0 || selectedCuisines.includes(cuisine)) {
                   container.appendChild(link.cloneNode(true));
               }
           });
       }

       function sortRestaurants() {
           const selectedSort = document.querySelector('input[name="sort"]:checked').value;
           const restaurants = Array.from(restaurantLinks);
           const container = restaurantGrid;
           
           // Clear the container first
           container.innerHTML = '';
           
           // Sort restaurants
           restaurants.sort((a, b) => {
               if (selectedSort === 'etaAsc' || selectedSort === 'etaDesc') {
                   const etaA = parseInt(a.querySelector('.restaurant-info span').textContent);
                   const etaB = parseInt(b.querySelector('.restaurant-info span').textContent);
                   return selectedSort === 'etaAsc' ? etaA - etaB : etaB - etaA;
               } else if (selectedSort === 'ratingDesc') {
                   const ratingA = parseFloat(a.querySelector('.rating span').textContent);
                   const ratingB = parseFloat(b.querySelector('.rating span').textContent);
                   return ratingB - ratingA;
               }
               return 0;
           });

           // Append sorted restaurants
           restaurants.forEach(link => {
               container.appendChild(link.cloneNode(true));
           });
       }

       // Rating filter
       ratingFilter.addEventListener('click', () => {
           const restaurants = Array.from(restaurantLinks);
           const container = restaurantGrid;
           
           // Clear the container first
           container.innerHTML = '';
           
           // Filter and append restaurants
           restaurants.forEach(link => {
               const rating = parseFloat(link.querySelector('.rating span').textContent);
               if (rating >= 4.0) {
                   container.appendChild(link.cloneNode(true));
               }
           });
       });
       
    </script>
</body>
</html>