<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Crave</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #e23744;
            --primary-dark: #d12f3c;
            --secondary-color: #2f3542;
            --background-color: #f1f2f6;
            --white: #ffffff;
            --gray-light: #dfe4ea;
            --gray-dark: #747d8c;
            --border-color: #e0e0e0;
            --success: #2ed573;
            --danger: #e23744;
            --shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: var(--background-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: var(--secondary-color);
            line-height: 1.6;
            padding: 1rem;
        }

        .page-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem 0;
        }

        .container {
            width: 100%;
            max-width: 500px;
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 2rem;
            margin: 0 auto;
        }

        .checkout-header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }

        .checkout-header h2 {
            color: var(--primary-color);
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .checkout-header p {
            color: var(--gray-dark);
            font-size: 0.9rem;
        }

        .back-button {
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            padding: 0.5rem;
            border-radius: 6px;
            transition: var(--transition);
        }

        .back-button:hover {
            background-color: var(--gray-light);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--secondary-color);
            font-size: 0.95rem;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid var(--gray-light);
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background-color: var(--white);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(226, 55, 68, 0.1);
        }

        .form-control::placeholder {
            color: var(--gray-dark);
            opacity: 0.7;
        }

        .payment-methods {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .payment-method {
            position: relative;
            border: 2px solid var(--gray-light);
            border-radius: 8px;
            padding: 1rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .payment-method:hover {
            border-color: var(--primary-color);
        }

        .payment-method input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .payment-method label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
        }

        .payment-method i {
            font-size: 1.2rem;
            color: var(--primary-color);
        }

        .payment-method input[type="radio"]:checked + label {
            color: var(--primary-color);
            font-weight: 600;
        }

        .payment-method input[type="radio"]:checked ~ .payment-method {
            border-color: var(--primary-color);
            background-color: rgba(226, 55, 68, 0.05);
        }

        .btn {
            width: 100%;
            padding: 1rem;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn i {
            font-size: 1.1rem;
        }

        .error-message {
            color: var(--danger);
            font-size: 0.8rem;
            margin-top: 0.25rem;
            display: none;
        }

        .error-message.visible {
            display: block;
        }

        .form-control.error {
            border-color: var(--danger);
        }

        .form-control.success {
            border-color: var(--success);
        }

        /* Loading State */
        .btn.loading {
            position: relative;
            color: transparent;
        }

        .btn.loading::after {
            content: "";
            position: absolute;
            width: 20px;
            height: 20px;
            border: 2px solid var(--white);
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }

            .checkout-header h2 {
                font-size: 1.5rem;
            }

            .payment-methods {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 0.5rem;
            }

            .container {
                padding: 1rem;
                border-radius: 8px;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-control {
                padding: 0.7rem;
                font-size: 0.95rem;
            }

            .btn {
                padding: 0.8rem;
            }

            .back-button {
                position: static;
                transform: none;
                margin-bottom: 1rem;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <div class="container">
            <div class="checkout-header">
                <a href="javascript:history.back()" class="back-button">
                    <i class="fas fa-arrow-left"></i>
                    Back
                </a>
                <h2>Secure Checkout</h2>
                <p>Please fill in your delivery and payment details</p>
            </div>

            <form action="CheckoutServlet" method="post" id="checkoutForm">
                <div class="form-group">
                    <label for="plot">Plot/Flat No.</label>
                    <input type="text" class="form-control" id="plot" name="plot" placeholder="Enter your plot/flat number" required>
                    <div class="error-message">Please enter a valid plot/flat number</div>
                </div>

                <div class="form-group">
                    <label for="street">Street Name</label>
                    <input type="text" class="form-control" id="street" name="street" placeholder="Enter street name" required>
                    <div class="error-message">Please enter a valid street name</div>
                </div>

                <div class="form-group">
                    <label for="pincode">Pincode</label>
                    <input type="text" class="form-control" id="pincode" name="pincode" placeholder="Enter 6-digit pincode" pattern="[0-9]{6}" required>
                    <div class="error-message">Please enter a valid 6-digit pincode</div>
                </div>

                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" class="form-control" id="city" name="city" placeholder="Enter city name" required>
                    <div class="error-message">Please enter a valid city name</div>
                </div>

                <div class="form-group">
                    <label>Payment Method</label>
                    <div class="payment-methods">
                        <div class="payment-method">
                            <input type="radio" id="cod" name="payment" value="Cash" checked>
                            <label for="cod">
                                <i class="fas fa-money-bill-wave"></i>
                                Cash on Delivery
                            </label>
                        </div>
                        <div class="payment-method">
                            <input type="radio" id="card" name="payment" value="Card">
                            <label for="card">
                                <i class="fas fa-credit-card"></i>
                                Card Payment
                            </label>
                        </div>
                        <div class="payment-method">
                            <input type="radio" id="upi" name="payment" value="UPI">
                            <label for="upi">
                                <i class="fas fa-mobile-alt"></i>
                                UPI
                            </label>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn" id="submitBtn">
                    <i class="fas fa-lock"></i>
                    Confirm Order
                </button>
            </form>
        </div>
    </div>

    <script>
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            let isValid = true;
            const inputs = this.querySelectorAll('input[type="text"]');
            const submitBtn = document.getElementById('submitBtn');
            
            inputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.classList.add('error');
                    input.nextElementSibling.classList.add('visible');
                } else {
                    input.classList.remove('error');
                    input.nextElementSibling.classList.remove('visible');
                }
            });

            // Pincode validation
            const pincode = document.getElementById('pincode');
            if (!/^[0-9]{6}$/.test(pincode.value)) {
                isValid = false;
                pincode.classList.add('error');
                pincode.nextElementSibling.classList.add('visible');
            }

            if (!isValid) {
                e.preventDefault();
            } else {
                submitBtn.classList.add('loading');
                submitBtn.disabled = true;
            }
        });

        // Real-time validation
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                if (this.value.trim()) {
                    this.classList.remove('error');
                    this.nextElementSibling.classList.remove('visible');
                }
            });
        });

        // Payment method selection enhancement
        const paymentMethods = document.querySelectorAll('.payment-method');
        paymentMethods.forEach(method => {
            method.addEventListener('click', function() {
                this.querySelector('input[type="radio"]').checked = true;
            });
        });
    </script>
</body>
</html>