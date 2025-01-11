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

//@WebServlet("/AgentSignUpServlet")
public class AgentSignUpServlet extends HttpServlet {
	
	private UserDAO userDAOImpl;

	public void init() throws ServletException {
		userDAOImpl = new UserDAOImpl();

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String role = "DeliveryAgent";

		if (name.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty() || role.isEmpty()) {
			resp.sendRedirect("AgentSignUp.jsp?error=missingField");
			return;
		}

		//String userName = generateUserName(username);

		User user = new User();

		user.setName(name);
		user.setEmail(email);
		user.setPhoneNo(phone);
		user.setUserName(username);
		user.setPassword(password);
		user.setAddress(address);
		user.setRole(role);
		user.setLastlogin(LocalDateTime.now());
		userDAOImpl.addUser(user);

		resp.sendRedirect("Login.jsp");
	}

	


}
