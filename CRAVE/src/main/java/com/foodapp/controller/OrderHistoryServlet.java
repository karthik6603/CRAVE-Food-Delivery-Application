package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.dao.OrderDAO;
import com.foodapp.daoimpl.OrderDAOImpl;
import com.foodapp.model.Order;
import com.foodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println(user);
		int userId = user.getUserId();
		OrderDAO orderDaoImpl = new OrderDAOImpl();
		List<Order> allOrderItems = orderDaoImpl.getOrderbyuid(userId);
		session.setAttribute("allOrderItems", allOrderItems);

		RequestDispatcher requestDispatcher = req.getRequestDispatcher("OrderHistory.jsp");
		requestDispatcher.forward(req, resp);
	}

}
