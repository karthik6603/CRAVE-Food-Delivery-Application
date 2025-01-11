package com.foodapp.dao;

import java.util.List;

import com.foodapp.model.OrderHistory;

public interface OrderHistoryDAO {

	void addOrderHistoryItem(OrderHistory orderHistory);
	OrderHistory getOrderHistroyItem(int orderHistoryId);
	void updateOrderHistroyItem(OrderHistory orderHistory);
	void deleteOrderHistroyItem(int orderHistoryId);
	List<OrderHistory>getAll();
	
}
