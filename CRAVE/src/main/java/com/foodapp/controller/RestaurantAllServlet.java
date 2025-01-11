package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/RestaurantAllServlet")
public class RestaurantAllServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RestaurantDAO restaurantdao = new RestaurantDAOImpl();
		List<Restaurant> restaurantList = restaurantdao.getAll();
		HttpSession session = req.getSession();
		req.setAttribute("restaurantList", restaurantList);
		req.getRequestDispatcher("admin.jsp").forward(req, resp);
		
	}

}
