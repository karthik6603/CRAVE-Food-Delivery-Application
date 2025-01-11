<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: linear-gradient(135deg, #f5fafd 0%, #dfe6ed 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: #ffffff;
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
            text-align: center;
            max-width: 550px;
            width: 100%;
        }

        .success-checkmark {
            width: 100px;
            height: 100px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #4CAF50;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: scaleIn 0.5s ease-out;
        }

        @keyframes scaleIn {
            0% { transform: scale(0); opacity: 0; }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); opacity: 1; }
        }

        .success-checkmark svg {
            width: 60px;
            height: 60px;
            fill: white;
        }

        h2 {
            color: #2c3e50;
            font-size: 32px;
            margin-bottom: 16px;
            font-weight: bold;
        }

        .message {
            color: #636e72;
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .progress-tracker {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 40px 0;
            position: relative;
        }

        .progress-step {
            flex: 1;
            text-align: center;
            position: relative;
        }

        .step-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #ffffff;
            border: 3px solid #3498db;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            position: relative;
            z-index: 2;
        }

        .step-label {
            font-size: 14px;
            color: #636e72;
            font-weight: 500;
        }

        .progress-line {
            position: absolute;
            top: 25px;
            left: 0;
            right: 0;
            height: 4px;
            background: #e9ecef;
            z-index: 1;
        }

        .progress-line-fill {
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            background: #3498db;
            transition: width 2s ease;
        }

        .track-btn {
            background: #e23744;
            color: white;
            text-decoration: none;
            padding: 16px 40px;
            border-radius: 50px;
            font-size: 18px;
            font-weight: bold;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: 0 6px 15px rgba(52, 152, 219, 0.3);
        }

        .track-btn:hover {
            transform: translateY(-2px);
            background: #217dbb;
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.4);
        }

        .estimated-time {
            margin-top: 20px;
            color: #636e72;
            font-size: 16px;
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
            }

            h2 {
                font-size: 24px;
            }

            .message {
                font-size: 16px;
            }

            .track-btn {
                padding: 14px 30px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-checkmark">
            <svg viewBox="0 0 24 24">
                <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"/>
            </svg>
        </div>
        
        <h2>Order Confirmed!</h2>
        <p class="message">
            Thank you for your order! Your food is being prepared with care and love.
        </p>
<!-- 
        <div class="progress-tracker">
            <div class="progress-line">
                <div class="progress-line-fill" id="progressLine"></div>
            </div>
            <div class="progress-step">
                <div class="step-icon">👨‍🍳</div>
                <div class="step-label">Preparing</div>
            </div>
            <div class="progress-step">
                <div class="step-icon">✓</div>
                <div class="step-label">Quality Check</div>
            </div>
            <div class="progress-step">
                <div class="step-icon">🛵</div>
                <div class="step-label">On the Way</div>
            </div>
        </div>
  -->       
        <a href="Trackorder.jsp" class="track-btn">Track Your Order</a>
        
        <div class="estimated-time">
            Estimated delivery time: <span id="estimatedTime">35-45</span> minutes
        </div>
    </div>

    <script>
        const progressFill = document.getElementById('progressLine');
        const steps = document.querySelectorAll('.progress-step');

        function updateProgress() {
            steps.forEach((step, index) => {
                step.classList.add('active');
            });
            progressFill.style.width = '100%';
        }

        // Trigger progress animation
        setTimeout(updateProgress, 500);
    </script>
</body>
</html>
