package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/CollectAllAgents")
public class CollectAllAgents extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		UserDAO userdao = new UserDAOImpl();
		List<User> DeliveryAgents = userdao.getAllUserByRole("DeliveryAgent");
		HttpSession session = req.getSession();
		session.setAttribute("DeliveryAgents", DeliveryAgents);
		resp.sendRedirect("AllDeliveryAgents.jsp");
		
	}

}
