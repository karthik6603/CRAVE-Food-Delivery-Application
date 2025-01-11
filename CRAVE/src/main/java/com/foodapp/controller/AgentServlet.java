package com.foodapp.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/AgentServlet")
public class AgentServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int orderId = Integer.parseInt(req.getParameter("orderId"));
		HttpSession session = req.getSession();
		session.setAttribute("orderId", orderId);
		resp.sendRedirect("CollectAllAgents");
		
	}

}
