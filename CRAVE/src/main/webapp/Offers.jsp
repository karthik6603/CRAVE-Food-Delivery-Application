<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exclusive Offers</title>
<style>
body {
    font-family: 'Poppins', sans-serif;
background: linear-gradient(45deg, #ff4757, #ffa502);



    margin: 0;
    padding: 20px;
    color: #333;
}

.container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

h1 {
    text-align: center;
    color: #2d3436;
    font-size: 2em;
    margin-bottom: 30px;
    padding-bottom: 10px;
    border-bottom: 3px solid #ff6b6b;
}

.offer {
    display: flex;
    align-items: center;
    margin: 20px 0;
    padding: 15px;
    border-radius: 8px;
    background: #fff;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    transition: transform 0.2s;
}

.offer:hover {
    transform: translateY(-3px);
}

.image-container {
    width: 80px;
    height: 80px;
    margin-right: 15px;
    border-radius: 8px;
    overflow: hidden;
}

.image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.emoji {
    font-size: 2em;
    margin: 0 15px;
}

.details {
    flex: 1;
}

.offer-title {
    font-size: 1.3em;
    color: #2d3436;
    margin-bottom: 5px;
    font-weight: 600;
}

.offer-description {
    color: #636e72;
    font-size: 0.95em;
    margin: 5px 0;
}

.discount {
    color: #2ecc71;
    font-weight: 600;
    margin: 5px 0;
}

.validity {
    color: #666;
    font-size: 0.85em;
}

@media (max-width: 600px) {
    .offer {
        flex-direction: column;
        text-align: center;
        padding: 15px;
    }

    .image-container {
        margin: 0 auto 10px;
    }

    .emoji {
        margin: 10px 0;
    }

    .details {
        padding: 0;
    }
}
</style>
</head>
<body>

	<div class="container">
		<h1>🎉 Exclusive Offers</h1>

		<!-- Offer 1 -->
		<div class="offer">
			<div class="image-container">
				<img src="assets/images/offers/Weekend Feast.jpeg" alt="Weekend Feast">
			</div>
			<div class="emoji">🍕</div>
			<div class="details">
				<div class="offer-title">Weekend Feast</div>
				<div class="offer-description">Savor a 25% discount on all
					orders above $50 every weekend!</div>
				<div class="discount">Discount: 25% Off</div>
				<div class="validity">Validity: Saturday & Sunday</div>
			</div>
		</div>

		<!-- Offer 2 -->
		<div class="offer">
			<div class="image-container">
				<img src="assets/images/offers/Lunch Combo.jpeg" alt="Lunch Combo">
			</div>
			<div class="emoji">🥪</div>
			<div class="details">
				<div class="offer-title">Lunch Combo</div>
				<div class="offer-description">Grab a sandwich combo with
					drink and dessert for just $15!</div>
				<div class="discount">Special Price: $15</div>
				<div class="validity">Validity: Weekdays, 12 PM - 3 PM</div>
			</div>
		</div>

		<!-- Offer 3 -->
		<div class="offer">
			<div class="image-container">
				<img src="assets/images/offers/Family Feast.jpeg" alt="Family Feast">
			</div>
			<div class="emoji">🍱</div>
			<div class="details">
				<div class="offer-title">Family Feast</div>
				<div class="offer-description">Order a family meal and get a
					free dessert platter.</div>
				<div class="discount">Free Dessert</div>
				<div class="validity">All days</div>
			</div>
		</div>

		<!-- Offer 4 -->
		<div class="offer">
			<div class="image-container">
				<img src="assets/images/offers/First Order Gift.jpeg" alt="First Order Gift">
			</div>
			<div class="emoji">🎁</div>
			<div class="details">
				<div class="offer-title">First Order Gift</div>
				<div class="offer-description">Sign up today and enjoy 30% off
					on your first order.</div>
				<div class="discount">Discount: 30% Off</div>
				<div class="validity">One-time offer</div>
			</div>
		</div>

		<!-- Offer 5 -->
		<div class="offer">
			<div class="image-container">
				<img src="assets/images/offers/Festival Bonanza.jpeg" alt="Festival Bonanza">
			</div>
			<div class="emoji">🌟</div>
			<div class="details">
				<div class="offer-title">Festival Bonanza</div>
				<div class="offer-description">Celebrate with a 35% discount
					on all items during the festive season.</div>
				<div class="discount">Discount: 35% Off</div>
				<div class="validity">Valid until New Year's Day</div>
			</div>
		</div>

		<!-- Offer 6 -->
		<div class="offer">
			<div class="image-container">
				<img src="assets/images/offers/Happy Hours.png" alt="Happy Hours">
			</div>
			<div class="emoji">⏰</div>
			<div class="details">
				<div class="offer-title">Happy Hours</div>
				<div class="offer-description">Enjoy 20% off on all orders
					placed from 4 PM to 6 PM daily.</div>
				<div class="discount">Discount: 20% Off</div>
				<div class="validity">Daily, 4 PM - 6 PM</div>
			</div>
		</div>
	</div>

</body>
</html>