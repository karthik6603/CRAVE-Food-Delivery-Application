package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/RestaurantAddServlet")
public class RestaurantAddServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RestaurantDAO restaurantdao = new RestaurantDAOImpl();
		
		restaurantdao.addRestaurant(new Restaurant(
					req.getParameter("restaurantName"),
					"assets/images/restaurants/"+req.getParameter("restaurantName")+".jpg",
					Float.parseFloat(req.getParameter("rating")),
					req.getParameter("eta"),
					req.getParameter("cuisineType"),
					req.getParameter("restaurantAddress"),
					"opened",
					Integer.parseInt(req.getParameter("restaurantOwnerId"))	
				));
		req.getRequestDispatcher("RestaurantAllServlet").forward(req, resp);
	}

}
