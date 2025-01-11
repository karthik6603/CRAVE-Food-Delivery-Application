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

//@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	
	private UserDAO userdao;
	
	public void init() throws ServletException{
		userdao = new UserDAOImpl();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address");
		String userName = req.getParameter("username");
		String password = req.getParameter("password");
		String role = "Customer";
		
		//Debug
		System.out.println(name+"\n"
				+ email+"\n"
				+ phone+"\n"
				+ address+"\n"
				+ userName+"\n"
				+ password);
		//

		userdao.addRUser(new User(name, email, phone, address, userName, password, role, LocalDateTime.now()));
		
		resp.sendRedirect("Login.jsp");
		

	}

}
