package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.OrderHistoryDAO;
import com.foodapp.dbutil.DBConnection;
import com.foodapp.model.OrderHistory;

public class OrderHistoryDAOImpl implements OrderHistoryDAO {
	
	String INSERT_QUERY = "INSERT into `orderhistory` (`orderId`,`userId`) values (?,?)";
	String UPDATE_QUERY = "UPDATE `orderhistory` SET `userId` = ? , `orderId` = ? WHERE `orderHistoryID` = ?";
	String SELECT_QUERY = "SELECT * from `orderhistory` WHERE `orderHistroyId` = ?";
	String DELETE_QUERY = "DELETE from `orderhistory` WHERE `orderHistoryID` = ?";
	String SELECTALL_QUERY = "SELECT * from `orderhistory`";

	Connection con = null;

	public OrderHistoryDAOImpl() {

		con = DBConnection.connect();
	}

	@Override
	public void addOrderHistoryItem(OrderHistory orderHistory) {

		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(INSERT_QUERY);

			prepareStatement.setInt(1, orderHistory.getOrderId());
			prepareStatement.setInt(2, orderHistory.getUserId());
			System.out.println(orderHistory.getUserId());
			System.out.println(orderHistory.getOrderId());
			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateOrderHistroyItem(OrderHistory orderHistory) {

		PreparedStatement prepareStatement = null;

		try {
			prepareStatement = con.prepareStatement(UPDATE_QUERY);

			prepareStatement.setInt(1, orderHistory.getUserId());
			prepareStatement.setInt(2, orderHistory.getOrderId());

			prepareStatement.setInt(3, orderHistory.getOrderHistoryId());

			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public OrderHistory getOrderHistroyItem(int orderHistoryId) {

		PreparedStatement prepareStatement = null;

		ResultSet res = null;
		OrderHistory orderHistory = null;
		try {
			prepareStatement = con.prepareStatement(SELECT_QUERY);

			prepareStatement.setInt(1, orderHistoryId);
			res = prepareStatement.executeQuery();

			if (res.next()) {
				int userId = res.getInt("userId");
				int orderId = res.getInt("orderId");

				orderHistory = new OrderHistory(orderHistoryId, userId, orderId);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderHistory;
	}

	@Override
	public void deleteOrderHistroyItem(int orderHistoryId) {

		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(DELETE_QUERY);
			prepareStatement.setInt(1, orderHistoryId);
			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderHistory> getAll() {

		Statement statement = null;

		ResultSet res = null;

		ArrayList<OrderHistory> OrderHistoryList = new ArrayList<OrderHistory>();
		try {
			statement = con.createStatement();
			res = statement.executeQuery(SELECTALL_QUERY);

			while (res.next()) {

				int orderHistoryId = res.getInt("orderHistoryId");
				int userId = res.getInt("userId");
				int orderId = res.getInt("orderId");

				OrderHistory orderHistory = new OrderHistory(orderHistoryId, userId, orderId);

				OrderHistoryList.add(orderHistory);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return OrderHistoryList;

	}


}
