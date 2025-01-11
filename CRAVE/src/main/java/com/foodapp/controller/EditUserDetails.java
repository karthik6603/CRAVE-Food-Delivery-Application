package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class EditUserDetails
 */
//@WebServlet("/EditUserDetails")
public class EditUserDetails extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		
		 String isthismenu = req.getParameter("isthismenu");
		 if(session.getAttribute("restaurantId")!=null)
		 {
		 int  restaurantId = (int) session.getAttribute("restaurantId");
		 session.setAttribute("restaurantId", restaurantId);
		 }
		session.setAttribute("isthismenu", isthismenu);
		
		String isthiscart= req.getParameter("isthiscart");
		session.setAttribute("isthiscart", isthiscart);
		
		String isthischeckout= req.getParameter("isthischeckout");
		session.setAttribute("isthischeckout", isthischeckout);
		
		
		String isthisconfirm= req.getParameter("isthisconfirm");
		session.setAttribute("isthisconfirm", isthisconfirm);
		
		
		String isthishistory= req.getParameter("isthishistory");
		session.setAttribute("isthishistory", isthishistory);
		
		String isthisviewcart= req.getParameter("isthisviewcart");
		session.setAttribute("isthisviewcart", isthisviewcart);
		
	
		
		
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("EditUserDetails.jsp");
		requestDispatcher.forward(req, resp);
		
		
		
		
	}
		
		
		

}
