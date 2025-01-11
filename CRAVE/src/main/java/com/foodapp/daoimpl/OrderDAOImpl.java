package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.OrderDAO;
import com.foodapp.dbutil.DBConnection;
import com.foodapp.model.Order;

public class OrderDAOImpl implements OrderDAO {
	
	static final String INSERT_QUERY = "INSERT into `order` (`restaurantid` , `userId`, `totalAmount`,`modeOfPayment`, `status`) values (?,?,?,?,?)";
	static final String DELETE_QUERY = "DELETE from `order` WHERE `orderId` = ?";
	static final String SELECT_QUERY = "SELECT * from `order` WHERE `orderId` = ?";
	static final String UPDATE_QUERY = "UPDATE `order` SET `restaurantId` = ? ,`userId` = ? , `totalAmount` = ? ,`modeOfPayment` = ? , `status` = ? WHERE`orderId` = ?";
	static final String SELECTALL_QUERY = "SELECT * from `order`";
	static final String SELECTALL_QUERY_BY_STATUS = "SELECT * FROM `order` WHERE `status` = ? ORDER BY `orderId` DESC";

	static final String SELECT_BYUID_QUERY = "SELECT * from `order` WHERE `userId`=?";
	static final String SELECT_ORDERID_QUERY = "SELECT * from `order` WHERE `restaurantId` = ? and `userId` = ? and `totalAmount`=? and `modeOfPayment` = ? and `status` = ?";
/*orderId, restaurantId, userId, totalAmount, modeOfPayment, status, orderDate,ENUM('Confirmed', 'Dispatched', 'Delivered')*/
	static Connection con = null;

	public OrderDAOImpl() {

		con = DBConnection.connect();

	}

	@Override
	public void addOrder(Order order) {

		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(INSERT_QUERY);

			prepareStatement.setInt(1, order.getRestaurantId());
			prepareStatement.setInt(2, order.getUserId());
			prepareStatement.setDouble(3, order.getTotalAmount());
			prepareStatement.setString(4, order.getModeOfPayment());
			prepareStatement.setString(5, "Confirmed");

			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteOrder(int orderId) {

		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(DELETE_QUERY);
			prepareStatement.setInt(1, orderId);
			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Order> getAll() {

		Statement statement = null;

		ResultSet res = null;

		ArrayList<Order> orderList = new ArrayList<Order>();
		try {
			statement = con.createStatement();
			res = statement.executeQuery(SELECTALL_QUERY);

			while (res.next()) {

				int orderId = res.getInt("orderId");
				int restaurantId = res.getInt("restaurantId");
				int userId = res.getInt("userId");
				float totalAmount = res.getFloat("totalAmount");
				String modeOfPayment = res.getString("modeOfPayment");
				String status = res.getString("status");

				Order order = new Order(orderId, restaurantId, userId, totalAmount, modeOfPayment, status);

				orderList.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderList;

	}

	@Override
	public Order getOrder(int orderId) {

		PreparedStatement prepareStatement = null;
		ResultSet res = null;
		Order order = null;
		try {
			prepareStatement = con.prepareStatement(SELECT_QUERY);

			prepareStatement.setInt(1, orderId);
			res = prepareStatement.executeQuery();

			if (res.next()) {

				int restaurantId = res.getInt("restaurantId");
				int userId = res.getInt("userId");
				float totalAmount = res.getFloat("totalAmount");
				String modeOfPayment = res.getString("modeOfPayment");
				String status = res.getString("status");

				order = new Order(userId, restaurantId, userId, totalAmount, modeOfPayment, status);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return order;
	}

	@Override
	public void updateOrder(Order order) {

		PreparedStatement prepareStatement = null;

		try {
			prepareStatement = con.prepareStatement(UPDATE_QUERY);

			prepareStatement.setInt(1, order.getRestaurantId());
			prepareStatement.setInt(2, order.getUserId());
			prepareStatement.setDouble(3, order.getTotalAmount());
			prepareStatement.setString(4, order.getModeOfPayment());
			prepareStatement.setString(5, order.getStatus());

			prepareStatement.setInt(6, order.getOrderId());

			prepareStatement.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	private int getLastOrderIdFromDatabase() throws SQLException {
		int lastOrderId = 0;
		String query = "SELECT MAX(orderid) FROM `order`"; 

		try (PreparedStatement statement = con.prepareStatement(query);
				ResultSet resultSet = statement.executeQuery()) {
			if (resultSet.next()) {
				lastOrderId = resultSet.getInt(1);
			}
		}

		return lastOrderId;
	}
	@Override
	public int getOrder(Order order) {
		ResultSet result=null;
		int orderId=0;
		try {
			PreparedStatement statement = con.prepareStatement(SELECT_ORDERID_QUERY);
			statement.setInt(1, order.getRestaurantId());
			statement.setInt(2, order. getUserId());
			statement.setDouble(3, order.getTotalAmount());
			statement.setString(4, order.getModeOfPayment());
			statement.setString(5, order. getStatus());
			result=statement.executeQuery();
			if(result.next())
			{
				  orderId = result.getInt("orderId");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return orderId;
	}

	@Override
	public List<Order> getOrderbyuid(int userid) {

		PreparedStatement statement = null;

		ResultSet res = null;

		ArrayList<Order> orderList = new ArrayList<Order>();
		try {
			statement = con.prepareStatement(SELECT_BYUID_QUERY);
			statement.setInt(1, userid);
			res = statement.executeQuery();

			while (res.next()) {

				int orderId = res.getInt("orderId");
				int restaurantId = res.getInt("restaurantId");
				int userId = res.getInt("userId");
				float totalAmount = res.getFloat("totalAmount");
				String modeOfPayment = res.getString("modeOfPayment");
				String status = res.getString("status");

				Order order = new Order(orderId, restaurantId, userId, totalAmount, modeOfPayment, status);

				orderList.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderList;

	}
	@Override
	public List<Order> getOrderbyStatus(String initialStatus) {
		
		PreparedStatement statement = null;
		
		ResultSet res = null;
		
		ArrayList<Order> orderList = new ArrayList<Order>();
		try {
			statement = con.prepareStatement(SELECTALL_QUERY_BY_STATUS);
			statement.setString(1, initialStatus);
			res = statement.executeQuery();
			
			while (res.next()) {
				
				int orderId = res.getInt("orderId");
				int restaurantId = res.getInt("restaurantId");
				int userId = res.getInt("userId");
				float totalAmount = res.getFloat("totalAmount");
				String modeOfPayment = res.getString("modeOfPayment");
				String status = res.getString("status");
				
				Order order = new Order(orderId, restaurantId, userId, totalAmount, modeOfPayment, status);
				
				orderList.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return orderList;
		
	}

}
