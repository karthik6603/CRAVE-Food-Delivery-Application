package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.OrderDAO;
import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.OrderDAOImpl;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.AgentOrders;
import com.foodapp.model.DeliveryAgentOrders;
import com.foodapp.model.Order;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/AssignAgentServlet")
public class AssignAgentServlet extends HttpServlet {
	
	 @Override
	    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        HttpSession ses = req.getSession();
	        
	        int otd = Integer.parseInt(req.getParameter("orderid"));
	        int ud = Integer.parseInt(req.getParameter("agentid"));
	        
	        AgentOrders agentOrders = (AgentOrders) ses.getAttribute("agentOrders");
	        
	        if (agentOrders == null) {
	            agentOrders = new AgentOrders();
	            ses.setAttribute("agentOrders", agentOrders);
	        }
	        
	        OrderDAO orderDaoImpl = new OrderDAOImpl();
	        Order order = orderDaoImpl.getOrder(otd);
	        
	        String status = order.getStatus();
	        int restId = order.getRestaurantId();
	        int userId = order.getUserId();
	        
	        UserDAO userDaoImpl = new UserDAOImpl();
	        User user = userDaoImpl.getUser(userId);
	        
	        String name = user.getName();
	        String address = user.getAddress();
	        
	        agentOrders.addOrder(new DeliveryAgentOrders(otd, name, address, status, ud));
	        System.out.println(agentOrders.getOrders());
	        resp.sendRedirect("SystemAdminServlet");
	    }

}
