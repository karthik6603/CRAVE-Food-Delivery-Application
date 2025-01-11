<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Profile | Crave</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: #f5f5f5;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.container {
    width: 100%;
    max-width: 450px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

.profile-header {
    text-align: center;
    margin-bottom: 0;
}

.profile-header h1 {
    color: #333;
    font-size: 24px;
    margin-bottom: 0;
}

.profile-image {
    width: 100px;
    height: 100px;
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

.form-group {
    margin-bottom: 15px;
    position: relative;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #666;
    font-size: 14px;
    font-weight: 500;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 15px;
    transition: all 0.3s ease;
}

.form-group input:focus {
    border-color: #ff4757;
    box-shadow: 0 0 0 2px rgba(255, 71, 87, 0.1);
    outline: none;
}

.error-message {
    color: #ff4757;
    font-size: 12px;
    margin-top: 5px;
    display: none;
}

.buttons {
    display: flex;
    gap: 15px;
    margin-top: 30px;
}

.btn {
    flex: 1;
    padding: 12px;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
    text-decoration: none;
}

.btn-primary {
    background: #ff4757;
    color: white;
}

.btn-secondary {
    background: #f0f0f0;
    color: #333;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.btn-primary:hover {
    background: #ff3344;
}

.btn-secondary:hover {
    background: #e4e4e4;
}

@media (max-width: 480px) {
    .container {
        padding: 20px;
    }

    .profile-header h1 {
        font-size: 20px;
    }

    .profile-image {
        width: 80px;
        height: 80px;
    }

    .buttons {
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
        <%
        User user = (User) session.getAttribute("user");
        %>
        <div class="profile-header">
            <div class="profile-image">
                <img src="assets/images/profile/profile.jpg" 
                     alt="Profile">
            </div>
            <h1>Edit Profile</h1>
        </div>

        <form action="UpdateUserProfile" method="post" onsubmit="return validateForm()">
        
        	<input type="hidden" name="userId" value="<%= user.getUserId() %>">
        		
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%=user.getName()%>" required>
                <span id="name-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="userName">Username</label>
                <input type="text" id="userName" name="userName" value="<%=user.getUserName()%>" required>
                <span id="username-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%=user.getEmail()%>" required>
                <span id="email-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="phoneNo">Phone Number</label>
                <input type="tel" id="phoneNo" name="phoneNo" value="<%=user.getPhoneNo()%>" required>
                <span id="phoneNo-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" 
                       value="<%=user.getAddress() != null ? user.getAddress() : ""%>" required>
                <span id="address-error" class="error-message"></span>
            </div>

            <div class="buttons">
                <a href="javascript:history.back()" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </div>
        </form>
    </div>

    <script>
    function validateForm() {
        let isValid = true;
        const errorMessages = document.querySelectorAll('.error-message');
        errorMessages.forEach(msg => msg.style.display = 'none');

        // Name validation
        const name = document.getElementById('name').value.trim();
        if (!/^[A-Za-z\s]{3,}$/.test(name)) {
            document.getElementById('name-error').textContent = 'Please enter a valid name (minimum 3 letters)';
            document.getElementById('name-error').style.display = 'block';
            isValid = false;
        }

        // Username validation
        const userName = document.getElementById('userName').value.trim();
        if (!/^[a-zA-Z][a-zA-Z0-9_]{2,}$/.test(userName)) {
            document.getElementById('username-error').textContent = 'Username must start with a letter';
            document.getElementById('username-error').style.display = 'block';
            isValid = false;
        }

        // Email validation
        const email = document.getElementById('email').value.trim();
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            document.getElementById('email-error').textContent = 'Please enter a valid email';
            document.getElementById('email-error').style.display = 'block';
            isValid = false;
        }

        // Phone validation
        const phoneNo = document.getElementById('phoneNo').value.trim();
        if (!/^[6-9][0-9]{9}$/.test(phoneNo)) {
            document.getElementById('phoneNo-error').textContent = 'Please enter a valid 10-digit phone number';
            document.getElementById('phoneNo-error').style.display = 'block';
            isValid = false;
        }

        // Address validation
        const address = document.getElementById('address').value.trim();
        if (address.length < 5) {
            document.getElementById('address-error').textContent = 'Please enter a valid address (minimum 5 characters)';
            document.getElementById('address-error').style.display = 'block';
            isValid = false;
        }

        return isValid;
    }
    </script>
</body>
</html>