package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/UpdateUserProfile")
public class UpdateUserProfile extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		UserDAO udao = new UserDAOImpl();
		User user = new User(
					Integer.parseInt(req.getParameter("userId")),
					req.getParameter("name").trim(),
					req.getParameter("email").trim(),
					req.getParameter("phoneNo").trim(),
					req.getParameter("address").trim(),
					req.getParameter("userName").trim()
				);
		udao.updateUser(user);
		
		req.setAttribute("user", user);
		
		req.getRequestDispatcher("EditUserDetails.jsp").forward(req, resp);
		
	}

}
