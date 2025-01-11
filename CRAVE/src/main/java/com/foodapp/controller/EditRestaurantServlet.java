package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/EditRestaurantServlet")
public class EditRestaurantServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RestaurantDAO rest = new RestaurantDAOImpl();
		
		rest.updateRestaurant(new Restaurant(
					Integer.parseInt(req.getParameter("restaurantId").trim()),
					req.getParameter("restaurantName"),
					req.getParameter("restaurantCuisinrType"),
					req.getParameter("restaurantAddress"),
					req.getParameter("restaurantisActive")
				));
		resp.sendRedirect("RestaurantDashBoard");
		
	}

}
