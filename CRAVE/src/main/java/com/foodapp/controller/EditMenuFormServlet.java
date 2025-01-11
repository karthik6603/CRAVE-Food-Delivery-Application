package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.MenuDAO;
import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/EditMenuFormServlet")
public class EditMenuFormServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MenuDAO menudao = new MenuDAOImpl();
		
		menudao.updateMenu(new Menu(
					Integer.parseInt(req.getParameter("menuId")),
					req.getParameter("menuName"),
					Float.parseFloat(req.getParameter("menuPrice")),
					req.getParameter("menuDescription"),
					Boolean.parseBoolean(req.getParameter("menuisAvailable")),
					Integer.parseInt(req.getParameter("menuRestaurantId").trim()),
					Float.parseFloat(req.getParameter("menuRating"))
					
				));
		
		resp.sendRedirect("RestaurantDashBoard");

		
	}

}
