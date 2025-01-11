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

//@WebServlet("/EditMenuItemServlet")
public class EditMenuItemServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(false); // Use false to not create a new session if one doesn't exist
        User user = (User) session.getAttribute("user");

        // Check if the user is logged in
        if (user == null) {
            // If the user is not logged in, redirect to the login page or handle the case
            resp.sendRedirect("login.jsp"); // Redirect to login page
            return; // Exit the servlet if the user is not logged in
        }

		int menuId = Integer.parseInt(req.getParameter("menuId"));
		
		MenuDAO menudao = new MenuDAOImpl();
		Menu menu = menudao.getMenu(menuId);
		
		req.setAttribute("menu", menu);
		
		req.getRequestDispatcher("RestaurantOwner.jsp").forward(req, resp);
		
	}

}
