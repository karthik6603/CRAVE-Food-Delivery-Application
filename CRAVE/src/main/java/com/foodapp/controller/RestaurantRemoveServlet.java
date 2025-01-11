package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.daoimpl.RestaurantDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/RestaurantRemoveServlet")
public class RestaurantRemoveServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RestaurantDAO restaurantdao = new RestaurantDAOImpl();
		int restaurantId = Integer.parseInt(req.getParameter("id"));
		restaurantdao.deleteRestaurant(restaurantId);
		req.getRequestDispatcher("RestaurantAllServlet").forward(req, resp);
		
	}

}
