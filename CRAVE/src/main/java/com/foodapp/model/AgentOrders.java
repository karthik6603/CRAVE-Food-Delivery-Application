package com.foodapp.model;

import java.util.HashMap;
import java.util.Map;

public class AgentOrders {

	private Map<Integer, DeliveryAgentOrders> orders;
	
	public AgentOrders() {
		this.orders = new HashMap<>();
	}
	
	public void addOrder(DeliveryAgentOrders newOrder) {
		if(newOrder != null) {
			int orderId = newOrder.getOrderId();
			orders.put(orderId, newOrder);
		}
		else {
			System.out.println("order cannot be null");
		}
	}
	
	public Map<Integer, DeliveryAgentOrders> getOrders(){
		return new HashMap<Integer, DeliveryAgentOrders>(orders);
	}
	
	public void clear() {
		orders.clear();
	}
	
}
