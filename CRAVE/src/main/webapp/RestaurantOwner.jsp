<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.foodapp.model.Restaurant, com.foodapp.model.User, com.foodapp.model.Menu" %>
<%
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Restaurant Management Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', system-ui, sans-serif;
        line-height: 1.6;
        color: #2d3436;
        min-height: 100vh;
        background: #f8f9fa;
        padding-top: 80px; /* Increased padding-top to prevent content from hiding under navbar */
    }

    nav {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background-color: #e23744;
        z-index: 1000;
        padding: 15px 20px; /* Added horizontal padding */
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: nowrap; /* Prevent wrapping on larger screens */
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
        white-space: nowrap; /* Prevent logo from wrapping */
    }

    .nav-right {
        display: flex;
        align-items: center;
        gap: 20px;
        flex-wrap: nowrap; /* Prevent wrapping on larger screens */
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
        font-weight: 500;
        white-space: nowrap; /* Prevent text from wrapping */
    }

    .nav-item:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
    }

    .welcome-message {
        text-align: center;
        font-size: 2.5rem;
        background: linear-gradient(135deg, #e23744 0%, #ff6b81 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin: 1.5rem 0; /* Adjusted margin */
        padding: 1rem;
        font-weight: 700;
    }

    .form-container {
        max-width: 600px;
        margin: 2rem auto;
        padding: 2rem;
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        display: none;
    }

    .form-container h2 {
        color: #e23744;
        margin-bottom: 1.5rem;
        font-size: 1.8rem;
        border-bottom: 3px solid #e23744;
        padding-bottom: 0.5rem;
    }

    .form-container label {
        display: block;
        margin: 1rem 0 0.5rem;
        color: #2d3436;
        font-weight: 500;
    }

    .form-container input {
        width: 100%;
        padding: 0.8rem;
        border: 2px solid #dfe6e9;
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s;
    }

    .form-container input:focus {
        border-color: #e23744;
        box-shadow: 0 0 0 3px rgba(226, 55, 68, 0.1);
        outline: none;
    }

    .form-container button {
        background: #e23744;
        color: white;
        border: none;
        padding: 0.8rem 1.5rem;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1rem;
        font-weight: 500;
        margin-top: 1.5rem;
        transition: all 0.3s;
        width: 100%; /* Make buttons full width */
    }

    .form-container button:hover {
        background: #d63031;
        transform: translateY(-2px);
    }

    .menu-items-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); /* Responsive grid */
        gap: 1.5rem;
        padding: 1.5rem;
        max-width: 1400px;
        margin: 0 auto;
    }

    .menu-item-card {
        background: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        position: relative;
        display: flex;
        flex-direction: column;
        height: 100%; /* Ensure consistent height */
    }

    .menu-item-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }

    .menu-item-image {
        width: 100%;
        height: 200px; /* Fixed height for consistency */
        object-fit: cover;
        border-bottom: 1px solid #f0f0f0;
    }

    .menu-item-details {
        padding: 1rem;
        flex-grow: 1;
    }

    .menu-item-details h3 {
        font-size: 1.3rem;
        color: #2d3436;
        margin-bottom: 0.5rem;
        font-weight: 600;
    }

    .menu-item-details p {
        color: #636e72;
        margin: 0.25rem 0;
        font-size: 0.95rem;
        line-height: 1.6;
    }

    .menu-item-details strong {
        color: #2d3436;
        font-weight: 600;
    }

    .menu-item-actions {
        padding: 1rem;
        background: #f8f9fa;
        display: flex;
        justify-content: space-between;
        gap: 0.5rem;
        border-top: 1px solid #f0f0f0;
    }

    .menu-item-actions button {
        flex: 1;
        padding: 0.8rem;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
        font-size: 0.9rem;
        transition: all 0.3s;
    }

    .edit-button {
        background: #457b9d;
        color: white;
    }

    .delete-button {
        background: #e63946;
        color: white;
    }

    .edit-button:hover, .delete-button:hover {
        transform: translateY(-2px);
        opacity: 0.9;
    }

    .price-tag {
        position: absolute;
        top: 1rem;
        right: 1rem;
        background: rgba(255, 255, 255, 0.9);
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-weight: 600;
        color: #e23744;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    /* Responsive Design */
    @media (max-width: 1200px) {
        .menu-items-container {
            grid-template-columns: repeat(3, 1fr);
            padding: 1rem;
        }
    }

    @media (max-width: 992px) {
        .menu-items-container {
            grid-template-columns: repeat(2, 1fr);
        }
        
        .welcome-message {
            font-size: 2rem;
        }
    }

    @media (max-width: 768px) {
        body {
            padding-top: 120px; /* Increased for wrapped navbar */
        }

        .nav-container {
            flex-direction: column;
            gap: 1rem;
        }

        .nav-right {
            width: 100%;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .nav-item {
            padding: 8px 12px;
            font-size: 0.9rem;
        }

        .nav-item span {
            display: none;
        }

        .welcome-message {
            font-size: 1.5rem;
            margin: 1rem 0;
        }

        .menu-items-container {
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .menu-item-image {
            height: 160px;
        }

        .form-container {
            margin: 1rem;
            padding: 1.5rem;
        }
    }

    @media (max-width: 480px) {
        body {
            padding-top: 140px; /* Further increased for smaller screens */
        }

        .menu-items-container {
            grid-template-columns: 1fr;
        }

        .menu-item-card {
            margin: 0 0.5rem;
        }

        .welcome-message {
            font-size: 1.2rem;
            padding: 0.5rem;
        }

        .form-container {
            margin: 1rem 0.5rem;
            padding: 1rem;
        }

        .menu-item-actions {
            flex-direction: column;
        }

        .menu-item-actions button {
            width: 100%;
        }
    }
</style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <div class="nav-left">
                <a href="#" class="logo">CRAVE</a>
            </div>
            <div class="nav-right">
                <a href="#" class="nav-item" onclick="showSection('home'); return false;">
                    <i class="fa-solid fa-house"></i>
                    <span>Home</span>
                </a>
                <a href="#" class="nav-item" onclick="showSection('addMenu'); return false;">
                    <i class="fa-solid fa-plus"></i>
                    <span>Add Menu</span>
                </a>
                <a href="#" class="nav-item" onclick="showSection('editProfile'); return false;">
                    <i class="fas fa-user"></i>
                    <span>Profile</span>
                </a>
                <% if(isLoggedIn) { %>
                    <a href="Crave" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                <% } %>
            </div>
        </div>
    </nav>

    <div id="home" class="section">
        <div class="welcome-message">Your Menus</div>
        <div id="menuItemsList" class="menu-items-container">
            <% 
                List<Menu> menuItems = (List<Menu>) request.getAttribute("menuList");
                if (menuItems != null && !menuItems.isEmpty()) {
                    for (Menu menuItem : menuItems) {
            %>
            <div class="menu-item-card">
                <div class="price-tag">₹<%= menuItem.getPrice() %></div>
                <img src="<%= menuItem.getImagePath() %>" alt="<%= menuItem.getName() %>" class="menu-item-image">
                <div class="menu-item-details">
                    <h3><%= menuItem.getName() %></h3>
                    <p><strong>Description:</strong> <%= menuItem.getDescription() %></p>
                    <p><strong>Status:</strong> <%= menuItem.getAvailable() ? "Available" : "Not Available" %></p>
                    <p><strong>Rating:</strong> <%= menuItem.getRating() %> ⭐</p>
                </div>
                <div class="menu-item-actions">
                    <button class="edit-button" onclick="location.href='EditMenuItemServlet?menuId=<%= menuItem.getMenuId() %>'">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="delete-button" onclick="location.href='DeleteMenuItemServlet?id=<%= menuItem.getMenuId() %>'">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </div>
            </div>
            <% 
                    }
                } else { 
            %>
            <p>No menu items available.</p>
            <% 
                } 
            %>
        </div>
    </div>

    <div id="addMenu" class="form-container">
        <h2>Add Menu Item</h2>
        <% 
        Restaurant r = (Restaurant) request.getAttribute("restaurant");
        if (r != null) {
        %>
        <form action="AddMenuItemServlet">
            <label for="menuName">Menu Name:</label> 
            <input type="text" id="menuName" name="menuName" required>
            <label for="menuPrice">Price:</label> 
            <input type="number" id="menuPrice" name="menuPrice" required>
            <label for="menuDescription">Description:</label>
            <input type="text" id="menuDescription" name="menuDescription" required>
            <input type="hidden" id="menurestaurantId" name="menurestaurantId" value="<%=r.getRestaurantId() %>">
            <button type="submit">Add Menu Item</button>
        </form>
        <% 
            } else { 
        %>
        <p>No restaurant data available.</p>
        <% 
            } 
        %>
    </div>

    <div id="editMenu" class="form-container">
        <h2>Edit Menu Item</h2>
        <%
        Menu mm = (Menu) request.getAttribute("menu");
        if (mm != null) {
        %>
        <form action="EditMenuFormServlet" method="post">
            <input type="hidden" name="menuId" value="<%= mm.getMenuId() %>">
            <label for="menuName">Menu Name:</label> 
            <input type="text" id="menuName" name="menuName" value="<%= mm.getName()%>">
            <label for="menuPrice">Price:</label> 
            <input type="number" id="menuPrice" name="menuPrice" value="<%= mm.getPrice()%>">
            <label for="menuDescription">Description:</label>
            <input type="text" id="menuDescription" name="menuDescription" value="<%= mm.getDescription()%>">
            <label for="menuisAvailable">Available:</label> 
            <input type="checkbox" id="menuisAvailable" name="menuisAvailable" <%= mm.getAvailable() ? "checked" : "" %>>
            <input type="hidden" name="menuRestaurantId" value="<%=mm.getRestaurantId()%>">
            <label for="menuRating">Rating:</label>
            <input type="number" id="menuRating" name="menuRating" step="0.1" min="0" max="5" value="<%= mm.getRating()%>">
            <button type="submit">Save Changes</button>
        </form>
        <% 
            } else { 
        %>
        <p>No menu selected for editing</p>
        <% 
            } 
        %>
    </div>

    <div id="editProfile" class="form-container">
        <h2>Edit Restaurant Profile</h2>
        <% 
        Restaurant rrr = (Restaurant) request.getAttribute("restaurant");
        if(rrr != null) {
        %>
        <form action="EditRestaurantServlet" method="post">
            <input type="hidden" name="restaurantId" value="<%= rrr.getRestaurantId() %>">
            <label for="restaurantName">Restaurant Name:</label> 
            <input type="text" id="restaurantName" name="restaurantName" value="<%= rrr.getName() %>">
            <label for="restaurantCuisineType">Cuisine Type:</label> 
            <input type="text" id="restaurantCuisineType" name="restaurantCuisineType" value="<%= rrr.getCuisineType() %>">
            <label for="restaurantAddress">Address:</label> 
            <input type="text" id="restaurantAddress" name="restaurantAddress" value="<%= rrr.getAddress()%>">
            <label for="restaurantisActive">Active Status:</label> 
            <input type="checkbox" id="restaurantisActive" name="restaurantisActive" <%= "active".equals(rrr.getIsActive()) ? "checked" : "" %>>
            <button type="submit">Update Profile</button>
        </form>
        <% 
            } else { 
        %>
        <p>No profile available.</p>
        <% 
            } 
        %>
    </div>

    <script>
    function showSection(sectionId) {
        // First, update URL to remove menuId parameter
        const url = new URL(window.location.href);
        url.searchParams.delete('menuId');
        window.history.replaceState({}, '', url);

        // Hide all sections first
        document.querySelectorAll('.form-container, #home').forEach(section => {
            section.style.display = 'none';
        });

        // Show the selected section
        if (sectionId === 'home') {
            document.getElementById('home').style.display = 'block';
        } else {
            document.getElementById(sectionId).style.display = 'block';
        }

        // If showing home, ensure menu list is visible
        if (sectionId === 'home') {
            document.getElementById('menuItemsList').style.display = 'grid';
        }
    }

    // Handle edit button clicks
    function handleEdit(menuId) {
        // Show edit form
        document.querySelectorAll('.form-container, #home').forEach(section => {
            section.style.display = 'none';
        });
        document.getElementById('editMenu').style.display = 'block';
        
        // Update URL without page reload
        const url = new URL(window.location.href);
        url.searchParams.set('menuId', menuId);
        window.history.pushState({}, '', url);
    }

    // Initial page load
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('menuId')) {
            document.getElementById('editMenu').style.display = 'block';
            document.getElementById('home').style.display = 'none';
        } else {
            showSection('home');
        }
    };

    // Handle browser back/forward buttons
    window.onpopstate = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('menuId')) {
            document.getElementById('editMenu').style.display = 'block';
            document.getElementById('home').style.display = 'none';
        } else {
            showSection('home');
        }
    };
    </script>
</body>
</html>