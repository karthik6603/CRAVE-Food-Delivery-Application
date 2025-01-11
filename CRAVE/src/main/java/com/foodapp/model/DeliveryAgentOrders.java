package com.foodapp.model;

public class DeliveryAgentOrders {

	private  int orderId;
	private String name;
	private String address;
	private String status;
	private int agentId;
	
	public DeliveryAgentOrders() {
		// TODO Auto-generated constructor stub
	}
	public DeliveryAgentOrders(int orderId, String name, String address, String status, int agentId) {
		super();
		this.orderId = orderId;
		this.name = name;
		this.address = address;
		this.status = status;
		this.agentId = agentId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getAgentId() {
		return agentId;
	}
	public void setAgentId(int agentId) {
		this.agentId = agentId;
	}
	
}
