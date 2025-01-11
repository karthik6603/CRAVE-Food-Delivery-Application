<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Your Order</title>
    <style>
        :root {
            --primary-color: #e23744;
            --primary-hover: #d42735;
            --primary-light: rgba(226, 55, 68, 0.1);
            --text-dark: #2d3436;
            --text-light: #636e72;
            --bg-gradient: linear-gradient(135deg, #fff5f5 0%, #ffe5e6 100%);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: var(--bg-gradient);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 500px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .header {
            background: var(--primary-color);
            padding: 30px;
            text-align: center;
            color: white;
        }

        .header h2 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .header p {
            opacity: 0.9;
            font-size: 16px;
        }

        .content {
            padding: 30px;
        }

        .search-box {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 16px;
            margin-bottom: 25px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            color: var(--text-dark);
            font-weight: 500;
            margin-bottom: 8px;
        }

        .input-group input {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: white;
        }

        .input-group input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px var(--primary-light);
            outline: none;
        }

        .track-btn {
            width: 100%;
            padding: 16px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .track-btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(226, 55, 68, 0.3);
        }

                .help-section {
            margin-top: 30px;
            padding: 25px;
            background: #f8f9fa;
            border-radius: 16px;
        }

        .help-section h3 {
            color: var(--text-dark);
            font-size: 18px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .help-section h3 svg {
            width: 20px;
            height: 20px;
            color: var(--primary-color);
        }

        .help-cards {
            display: grid;
            gap: 15px;
            grid-template-columns: repeat(2, 1fr);
        }

        .help-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
        }

        .help-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .help-card h4 {
            color: var(--primary-color);
            font-size: 16px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .help-card h4 svg {
            width: 16px;
            height: 16px;
        }

        .help-card p {
            color: var(--text-light);
            font-size: 14px;
            line-height: 1.5;
        }

        .support-contact {
            margin-top: 20px;
            padding: 15px;
            background: var(--primary-light);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .support-text {
            color: var(--text-dark);
            font-size: 14px;
        }

        .support-phone {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .support-phone:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .help-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
        <div class="container">
        <div class="header">
            <h2>Track Your Order</h2>
            <p>Real-time updates on your delivery</p>
        </div>
        
        <div class="content">
            <form action="trackOrderStatus.jsp" method="post" id="trackForm">
                <div class="search-box">
                    <div class="input-group">
                        <label for="orderId">Order ID</label>
                        <input 
                            type="text" 
                            id="orderId" 
                            name="orderId" 
                            placeholder="Enter your order ID" 
                            required
                            pattern="[A-Za-z0-9]+"
                            title="Please enter a valid order ID"
                        >
                    </div>
                    <button type="submit" class="track-btn">Track Now</button>
                </div>
            </form>

            <div class="help-section">
                <h3>
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                        <line x1="12" y1="17" x2="12.01" y2="17"></line>
                    </svg>
                    Need Help?
                </h3>
                <div class="help-cards">
                    <div class="help-card">
                        <h4>
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                            </svg>
                            Find Order ID
                        </h4>
                        <p>Check your order confirmation email or SMS for the order ID</p>
                    </div>
                    <div class="help-card">
                        <h4>
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 16 14"></polyline>
                            </svg>
                            Delivery Time
                        </h4>
                        <p>Typical delivery takes 30-45 minutes based on your location</p>
                    </div>
                </div>
                
                <div class="support-contact">
                    <span class="support-text">Need immediate assistance?</span>
                    <a href="tel:1800123456" class="support-phone">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                        </svg>
                        1-800-123-456
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        function trackOrder(orderId) {
            document.getElementById('orderId').value = orderId;
            document.getElementById('trackForm').submit();
        }

     // Form validation
        document.getElementById('trackForm').addEventListener('submit', function(e) {
            const orderId = document.getElementById('orderId').value.trim();
            
            if (!orderId) {
                e.preventDefault();
                alert('Please enter an order ID');
                return;
            }

            if (!/^[A-Za-z0-9]+$/.test(orderId)) {
                e.preventDefault();
                alert('Please enter a valid order ID (letters and numbers only)');
                return;
            }
        });

        // Auto-focus on input
        window.addEventListener('load', function() {
            document.getElementById('orderId').focus();
        });
    </script>
</body>
</html>