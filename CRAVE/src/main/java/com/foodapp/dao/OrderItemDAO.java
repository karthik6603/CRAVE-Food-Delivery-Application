package com.foodapp.dao;

import java.util.List;

import com.foodapp.model.OrderItem;

public interface OrderItemDAO {

	void addOrderItem(OrderItem orderItem);
	OrderItem getOrderItem(int orderItemId);
	void UpdateOrderItem(OrderItem orderItem);
	List<OrderItem> getAllOrderItemsByUserId(int userid);
	void deleteOrderItem(int orderItemId);
	void deleteOrderItemByMenuId(int menuId);
	List<OrderItem>getAll();
	List<OrderItem> getAllByOrderId(int orderId);
	
}
