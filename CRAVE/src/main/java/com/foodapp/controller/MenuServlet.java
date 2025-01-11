package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.dao.MenuDAO;
import com.foodapp.dao.RestaurantDAO;
import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Menu;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		MenuDAO menudao = new MenuDAOImpl();
		RestaurantDAO rdao = new RestaurantDAOImpl();
		
		List<Menu> menuList = menudao.getMenuByResto(restaurantId);
		Restaurant r = rdao.getRestaurant(restaurantId);
		String restaurantName = r.getName();
		req.setAttribute("menuList", menuList);
		req.setAttribute("restaurantName", restaurantName);
		
		req.getRequestDispatcher("Menu.jsp").forward(req, resp);
		
	}
	
}
