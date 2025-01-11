package com.foodapp.dao;

import java.util.List;

import com.foodapp.model.Order;

public interface OrderDAO {

	void addOrder(Order order);
	Order getOrder(int orderId);
	void updateOrder(Order order);
	void deleteOrder(int orderId);
	List<Order>getAll();
	int getOrder(Order order);
	List<Order> getOrderbyuid(int userid);
	List<Order> getOrderbyStatus(String initialStatus);
	
}
