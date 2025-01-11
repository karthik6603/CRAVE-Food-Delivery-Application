package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.dao.OrderItemDAO;
import com.foodapp.daoimpl.OrderItemDAOImpl;
import com.foodapp.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ViewOrderDetails
 */
//@WebServlet("/ViewOrderDetails")
public class ViewOrderDetails extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int orderid=Integer.parseInt(req.getParameter("orderId"));
		OrderItemDAO orderitemdaoimpl=new OrderItemDAOImpl();
		List<OrderItem> itemslist = orderitemdaoimpl.getAllByOrderId(orderid);
		req.getSession().setAttribute("itemslist", itemslist);
		resp.sendRedirect("AllOrderItems.jsp");
	}

}
