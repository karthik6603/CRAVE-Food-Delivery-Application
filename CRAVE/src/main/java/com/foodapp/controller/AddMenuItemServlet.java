package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.MenuDAO;
import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.model.Menu;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/AddMenuItemServlet")
public class AddMenuItemServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		MenuDAO menudao = new MenuDAOImpl();
		

		
		
		int status = menudao.addMenu(new Menu(
					req.getParameter("menuName"),
					Float.parseFloat(req.getParameter("menuPrice")),
					req.getParameter("menuDescription"),
					"assets/images/menu/"+(req.getParameter("menuName"))+".jpg",
					true,
					Integer.parseInt(req.getParameter("menurestaurantId")),
					4.3f
					
				));
		HttpSession session = req.getSession();
		
		User user = (User) session.getAttribute("user");
		
		session.setAttribute("restaurantId", Integer.parseInt(req.getParameter("menurestaurantId")));
		
		System.out.println(status);
		
		req.getRequestDispatcher("RestaurantDashBoard").forward(req, resp);
		
	}

}
