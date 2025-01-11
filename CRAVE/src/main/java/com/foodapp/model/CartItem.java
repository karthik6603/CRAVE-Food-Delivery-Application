package com.foodapp.model;

public class CartItem {

	private int itemId;
	private int restautantId;
	private String name;
	private int quantity;
	private double price;
	
	public CartItem() {
		
	}

	public CartItem(int itemId, int restautantId, String name, int quantity, double price) {
		super();
		this.itemId = itemId;
		this.restautantId = restautantId;
		this.name = name;
		this.quantity = quantity;
		this.price = price;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public int getRestautantId() {
		return restautantId;
	}

	public void setRestautantId(int restautantId) {
		this.restautantId = restautantId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "CartItem [itemId=" + itemId + ", restautantId=" + restautantId + ", name=" + name + ", quantity="
				+ quantity + ", price=" + price + "]";
	}
	
}
