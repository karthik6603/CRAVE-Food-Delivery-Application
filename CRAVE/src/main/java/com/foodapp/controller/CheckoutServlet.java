package com.foodapp.controller;

import java.io.IOException;
import java.util.Map;

import com.foodapp.dao.OrderDAO;
import com.foodapp.dao.OrderHistoryDAO;
import com.foodapp.dao.OrderItemDAO;
import com.foodapp.daoimpl.OrderDAOImpl;
import com.foodapp.daoimpl.OrderHistoryDAOImpl;
import com.foodapp.daoimpl.OrderItemDAOImpl;
import com.foodapp.model.Cart;
import com.foodapp.model.CartItem;
import com.foodapp.model.Order;
import com.foodapp.model.OrderHistory;
import com.foodapp.model.OrderItem;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	
	private OrderDAO orderdao;
	
	public void init() {
		orderdao = new OrderDAOImpl();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String payment = req.getParameter("payment");
		
		HttpSession session = req.getSession();
		
		// address sesction
		
		String address = req.getParameter("plot")+", "+req.getParameter("street");
		String pincode = req.getParameter("pincode");
		String city = req.getParameter("city");
		session.setAttribute("city", city);
		session.setAttribute("pincode", pincode);
		session.setAttribute("address", address);
		
		//
		
		Cart cart = (Cart) session.getAttribute("cart");
		User user = (User) session.getAttribute("user");
		if(user != null) {
			int userId = user.getUserId();
			int restaurantId = (int) session.getAttribute("restaurantId");
			double totalPrice = 0.0;
			
			if(cart != null) {
				totalPrice = 0;
				for(CartItem item : cart.getItems().values()) {
					totalPrice+=item.getPrice() * item.getQuantity();
				}
				session.setAttribute("totalPrice", totalPrice);
			}
			
			Order order = new Order(restaurantId, userId, (double) session.getAttribute("totalPrice"), payment, "confirmed");
			OrderDAO orderdao = new OrderDAOImpl();
			orderdao.addOrder(order);
			
			int orderId = orderdao.getOrder(order);
			
			session.setAttribute("orderId", orderId);
			
			OrderHistory orderHistory = new OrderHistory(userId, orderId);
			OrderHistoryDAO orderHistorydao = new OrderHistoryDAOImpl();
			orderHistorydao.addOrderHistoryItem(orderHistory);
			
			OrderItemDAO orderItemdao = new OrderItemDAOImpl();
			if(cart != null) {
				Map<Integer, CartItem> items = cart.getItems();
				for(Map.Entry<Integer, CartItem> entry : items.entrySet()) {
					CartItem item = entry.getValue();
					int menuId = entry.getKey();
					
					int quantity = item.getQuantity();
					String name = item.getName();
					double price = item.getPrice();
					
					OrderItem orderItem = new OrderItem(userId, restaurantId, menuId, name, quantity, price, totalPrice, orderId);
					orderItemdao.addOrderItem(orderItem);
				}
			}
			resp.sendRedirect("Confirmation.jsp");
		}
		else {
			resp.sendRedirect("Login.jsp");
		}
		
		
	}
	
}
