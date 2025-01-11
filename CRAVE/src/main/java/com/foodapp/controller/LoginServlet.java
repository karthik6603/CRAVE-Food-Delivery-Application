package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.PasswordEncryption;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private UserDAO userdao;
	
	public void init() throws ServletException{
		userdao = new UserDAOImpl();
	}
	
	/* ENUM(`Customer`, `RestaurantAdmin`, `DeliveryAgent`, `SystemAdmin`) */
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String userName = req.getParameter("username");
		String password = req.getParameter("password");
		
		String encryptedPassword = PasswordEncryption.encrypt(password);
		
		boolean isValid = userdao.isValidUser(userName, encryptedPassword);
		String role = userdao.getUserRole(userName, encryptedPassword);
		User user = userdao.getUserByuserNameAndPassword(userName, encryptedPassword);
		
		HttpSession session = req.getSession();
		
		Integer attempts = (Integer) session.getAttribute("attempts");
		if(attempts == null) {
			attempts = 0;
		}
		if(isValid && role.equals("Customer")) {
			session.setAttribute("user", user);
			session.setAttribute("userName", userName);
			//
			User userdemo = (User)session.getAttribute("user");
			System.out.println(userdemo.getName() +" Customerisexecuting");
			resp.sendRedirect("Home.jsp");
		}
		else if(isValid && role.equals("RestaurantAdmin")) {
			RestaurantDAO restaurantdao = new RestaurantDAOImpl();
			int restaurantOwnerId = userdao.getRestaurantOwnerId(userName, encryptedPassword);
			int restaurantId = restaurantdao.getRestaurantId(restaurantOwnerId);
			
			session.setAttribute("user", user);
			session.setAttribute("userName", userName);
			session.setAttribute("restaurantId", restaurantId);
			
			System.out.println(userName +" RestaurantAdminisexecuting");
			resp.sendRedirect("RestaurantDashBoard");
		}
		else if(isValid && role.equals("DeliveryAgent")) {
			session.setAttribute("user", user);
			session.setAttribute("userName", userName);
			System.out.println(userName +" DeliveryAgentisexecuting");
			resp.sendRedirect("DeliveryAgent.jsp");
		}
		else if(isValid && role.equals("SystemAdmin")) {
			session.setAttribute("user", user);
			session.setAttribute("userName", userName);
			System.out.println(userName +" SystemAdminisexecuting");
			resp.sendRedirect("SystemAdminServlet");
		}
		else {
			attempts++;
			session.setAttribute("attempts", attempts);
			if(attempts >= 5) {
				resp.sendRedirect("Login.jsp?error=max_attempts");
			}else {
				resp.sendRedirect("Login.jsp?error=invalid_credentials");
			}
		}
		
	}

}
