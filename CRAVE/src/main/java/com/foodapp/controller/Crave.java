package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.dao.OrderDAO;
import com.foodapp.dao.RestaurantDAO;
import com.foodapp.daoimpl.OrderDAOImpl;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Order;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/Crave")
public class Crave extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RestaurantDAO restaurant = new RestaurantDAOImpl();
		List<Restaurant> restaurantList = restaurant.getAll();
		HttpSession session = req.getSession();
		OrderDAO order = new OrderDAOImpl();
//		List<Order> allOrders = order.getAll();
		List<Order> allOrders = order.getOrderbyStatus("Confirmed");
		
		session.setAttribute("restaurantList", restaurantList);
		session.setAttribute("allOrders", allOrders);
		req.getRequestDispatcher("Crave.jsp").forward(req, resp);
		
	}

}
