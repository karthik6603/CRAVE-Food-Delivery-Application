package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.foodapp.model.OrderStatus;

public class OrderStatusDAOImpl {

	String SELECT_QUERY = "SELECT status FROM orders WHERE orderId = ?";

	Connection connection = null;

	public OrderStatusDAOImpl() {

		String url = "jdbc:mysql://localhost:3306/foodapp";
		String username = "root";
		String password = "root";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url, username, password);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public String fetchOrderStatus(String orderId) {
		String status = null;
		try {
			PreparedStatement statement = connection.prepareStatement(SELECT_QUERY);

			statement.setString(1, orderId);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				status = resultSet.getString("status");
				
				OrderStatus orderStatus = new OrderStatus(orderId, status);
				
			}
		} catch (

		SQLException e) {
			e.printStackTrace();
		}

		return status;
	}

	
}
