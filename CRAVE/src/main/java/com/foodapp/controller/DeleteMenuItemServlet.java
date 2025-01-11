package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.MenuDAO;
import com.foodapp.dao.OrderItemDAO;
import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.daoimpl.OrderItemDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/DeleteMenuItemServlet")
public class DeleteMenuItemServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int menuid=Integer.parseInt(req.getParameter("id"));
		OrderItemDAO o = new OrderItemDAOImpl();
		o.deleteOrderItemByMenuId(menuid);
		MenuDAO m = new MenuDAOImpl();
		int status=m.deleteMenu(menuid);
		if(status==1)
		{
			RequestDispatcher rd = req.getRequestDispatcher("RestaurantDashBoard");
			rd.forward(req, resp);
		}
	}

}
