package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.MenuDAO;
import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.model.Cart;
import com.foodapp.model.CartItem;
import com.foodapp.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		Cart cart = (Cart) session.getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			session.setAttribute("cart", cart);
		}
		
		String action = req.getParameter("action");
		
		if(action != null) {
			if(action.equals("add")) {
				addItemToCart(req, cart);
			}else if(action.equals("update")) {
				updateCartItem(req, cart);
			}else if(action.equals("remove")) {
				removeItemFromCart(req, cart);
			}else if (action.equals("clear")) {
				clearCart(req, cart);
			}
		}
		
		session.setAttribute("cart", cart);
		resp.sendRedirect("Cart.jsp");
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("Cart.jsp").forward(req, resp);
	}
	
	private void addItemToCart(HttpServletRequest req, Cart cart) {
		
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		int quantity = 1;
		
		MenuDAO menudao = new MenuDAOImpl();
		Menu menuItem = menudao.getMenu(itemId);
		
		HttpSession session = req.getSession();
		session.setAttribute("restaurantId", menuItem.getRestaurantId());
		
		if(menuItem != null) {
			cart.addItem( new CartItem(
						menuItem.getMenuId(),
						menuItem.getRestaurantId(),
						menuItem.getName(),
						quantity,
						menuItem.getPrice()
					));
		}
		session.setAttribute("message", "Item added to cart.");
	
	}
	
	private void updateCartItem(HttpServletRequest req, Cart cart) {
		
		HttpSession session = req.getSession();
		
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		cart.updateItem(itemId, quantity);
		session.setAttribute("message", "Item quantity updated.");
	}
	
	private void removeItemFromCart(HttpServletRequest req, Cart cart) {
		
		HttpSession session = req.getSession();
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		cart.removeItem(itemId);
		session.setAttribute("message", "Item removed from cart.");
		
	}
	
	private void clearCart(HttpServletRequest req, Cart cart) {
		HttpSession session = req.getSession();
		cart.clear();
		session.setAttribute("message", "Item removed from cart.");
	}

}
