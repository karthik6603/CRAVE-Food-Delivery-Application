package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/EditDeliveryAgentServlet")
public class EditDeliveryAgentServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		UserDAO userdao = new UserDAOImpl();
		
		userdao.updateUser(new User(
					Integer.parseInt(req.getParameter("userId")),
					req.getParameter("name"),
					req.getParameter("email"),
					req.getParameter("phone"),
					req.getParameter("address")
				));
		
		resp.sendRedirect("DeliveryAgent.jsp");

		
	}

}
