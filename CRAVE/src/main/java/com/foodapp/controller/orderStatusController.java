package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.daoimpl.OrderStatusDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class orderStatusController
 */
//@WebServlet("/orderStatusController")
public class orderStatusController extends HttpServlet {
	public void getOrderStatus(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String orderId = request.getParameter("orderId");

		OrderStatusDAOImpl orderStatusDaoImpl = new OrderStatusDAOImpl();
		String status = orderStatusDaoImpl.fetchOrderStatus(orderId);

		request.setAttribute("status", status);

		RequestDispatcher rd = request.getRequestDispatcher("trackOrderStatus.jsp");
		rd.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		orderStatusController orderStatusController = new orderStatusController();
		orderStatusController.getOrderStatus(request, response);
	}


}
