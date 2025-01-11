package com.foodapp.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/DeliveryAgent")
public class DeliveryAgent extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		UserDAO userdao = new UserDAOImpl();
		
		userdao.addUser(new User(
					req.getParameter("name"),
					req.getParameter("email"),
					req.getParameter("phone"),
					req.getParameter("username"),
					req.getParameter("password"),
					req.getParameter("address"),
					"DeliveryAgent",
					LocalDateTime.now()
				));
		resp.sendRedirect("DeliveryAgent.jsp");
	}

}
