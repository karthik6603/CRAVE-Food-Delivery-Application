package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.OrderItemDAO;
import com.foodapp.dbutil.DBConnection;
import com.foodapp.model.OrderItem;

public class OrderItemDAOImpl implements OrderItemDAO {
	
	private static Connection con = null;

	// SQL Queries
	static final String INSERT_QUERY = "INSERT INTO `orderitem`( `userId`,`restaurantId`, `menuId`, `name`, `quantity`, `price`,`totalAmount`,`orderId`)VALUES(?,?,?,?,?,?,?,?)";
	static final String SELECT_QUERY = "SELECT * FROM `orderitem` WHERE `orderItemId`=?";
	static final String SELECT_BY_ORDERID_QUERY = "SELECT * FROM `orderitem` WHERE `orderId`=?";
	static final String SELECT_ALL_QUERY = "SELECT * FROM `orderitem`";
	static final String UPDATE_QUERY = "UPDATE `orderitem` set `userId`=?,`restaurantId`=?, `menuId`=?, `itemName`=?, `quantity`=?, `price`=?, `totalAmount`=? WHERE `orderItemId`=?";
	static final String DELETE_QUERY = "DELETE FROM `orderitem` WHERE `orderItemId`=?";
	static final String DELETE_MENU_QUERY = "DELETE FROM `orderitem` WHERE `menuId`=?";
	static final String SELECT_ALL_QUERY_BY_USERID = "SELECT * FROM `orderitem` Where `userId`=?";

	public OrderItemDAOImpl() {
		
		con = DBConnection.connect();
	}

	@Override
	public void addOrderItem(OrderItem orderItem) {
		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(INSERT_QUERY);

			prepareStatement.setInt(1, orderItem.getUserId());
			prepareStatement.setInt(2, orderItem.getRestaurantId());
			prepareStatement.setInt(3, orderItem.getMenuId());
			prepareStatement.setString(4, orderItem.getItemName());
			prepareStatement.setInt(5, orderItem.getQuantity());
			prepareStatement.setDouble(6, orderItem.getPrice());
			prepareStatement.setDouble(7, orderItem.getTotalAmount());
			prepareStatement.setInt(8, orderItem.getOrderId());
			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (prepareStatement != null)
				try {
					prepareStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

	}

	@Override
	public OrderItem getOrderItem(int orderItemId) {
		PreparedStatement prepareStatement = null;
		ResultSet res = null;
		OrderItem orderItem = null;

		try {
			prepareStatement = con.prepareStatement(SELECT_QUERY);
			prepareStatement.setInt(1, orderItemId);

			res = prepareStatement.executeQuery();

			if (res.next()) {
				int userId = res.getInt("userId");
				int restaurantId = res.getInt("restaurantId");
				int menuId = res.getInt("menuId");
				String itemName = res.getString("name");
				int quantity = res.getInt("quantity");
				double price = res.getDouble("price");
				double totalAmount = res.getDouble("totalAmount");
				orderItem = new OrderItem(userId, restaurantId, menuId, itemName, quantity, price,
						totalAmount);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (prepareStatement != null)
				try {
					prepareStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		return orderItem;
	}

	@Override
	public List<OrderItem> getAllByOrderId(int orderId) {
		 PreparedStatement prepareStatement = null;
		ResultSet res = null;
		OrderItem orderItem = null;
		ArrayList<OrderItem> OrderItemsList = new ArrayList<OrderItem>();
		
		try {
			prepareStatement = con.prepareStatement(SELECT_BY_ORDERID_QUERY);
			prepareStatement.setInt(1, orderId);
			
			res = prepareStatement.executeQuery();
			while (res.next()) {
				int orderItemId = res.getInt("orderItemId");
				int userId = res.getInt("userId");
				int restaurantId = res.getInt("restaurantId");
				int menuId = res.getInt("menuId");
				String itemName = res.getString("name");
				int quantity = res.getInt("quantity");
				double price = res.getDouble("price");
				double totalAmount = res.getDouble("totalAmount");
				
				orderItem = new OrderItem(orderItemId, userId, restaurantId, menuId, itemName, quantity, price,
						totalAmount);
				OrderItemsList.add(orderItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return OrderItemsList;
	}
	@Override
	public List<OrderItem> getAll() {
		Statement createStatement = null;
		ResultSet res = null;
		OrderItem orderItem = null;
		ArrayList<OrderItem> OrderItemsList = new ArrayList<OrderItem>();

		try {
			createStatement = con.createStatement();

			res = createStatement.executeQuery(SELECT_ALL_QUERY);
			while (res.next()) {
				int orderItemId = res.getInt("orderItemId");
				int userId = res.getInt("userId");
				int restaurantId = res.getInt("restaurantId");
				int menuId = res.getInt("menuId");
				String itemName = res.getString("itemName");
				int quantity = res.getInt("quantity");
				double price = res.getDouble("price");
				double totalAmount = res.getDouble("totalAmount");

				orderItem = new OrderItem(orderItemId, userId, restaurantId, menuId, itemName, quantity, price,
						totalAmount);
				OrderItemsList.add(orderItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (createStatement != null)
				try {
					createStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return OrderItemsList;
	}

	@Override
	public void UpdateOrderItem(OrderItem orderItem) {
		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(UPDATE_QUERY);

			prepareStatement.setInt(1, orderItem.getUserId());
			prepareStatement.setInt(2, orderItem.getRestaurantId());
			prepareStatement.setInt(3, orderItem.getMenuId());
			prepareStatement.setString(4, orderItem.getItemName());
 
			prepareStatement.setInt(5, orderItem.getQuantity());
			prepareStatement.setDouble(6, orderItem.getPrice());
			prepareStatement.setDouble(7, orderItem.getTotalAmount());

			prepareStatement.setInt(8, orderItem.getOrderItemId());

			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (prepareStatement != null)
				try {
					prepareStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

	}

	@Override
	public void deleteOrderItem(int orderItemId) {
		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(DELETE_QUERY);
			prepareStatement.setInt(1, orderItemId);

			prepareStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (prepareStatement != null)
				try {
					prepareStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

	}
	@Override
	public void deleteOrderItemByMenuId(int menuId) {
		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(DELETE_QUERY);
			prepareStatement.setInt(1, menuId);
			
			prepareStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (prepareStatement != null)
				try {
					prepareStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
	}

	@Override
	public List<OrderItem> getAllOrderItemsByUserId(int userid) {
		PreparedStatement prepareStatement = null;
		ResultSet res = null;
		OrderItem orderItem = null;
		ArrayList<OrderItem> OrderItemsList = new ArrayList<OrderItem>();

		try {
			prepareStatement = con.prepareStatement(SELECT_ALL_QUERY_BY_USERID);
			prepareStatement.setInt(1, userid);

			res = prepareStatement.executeQuery();

			while (res.next()) {
				int orderItemId = res.getInt("orderItemId");
				int userId = res.getInt("userId");
				int restaurantId = res.getInt("restaurantId");
				int menuId = res.getInt("menuId");
				String itemName = res.getString("itemName");
				int quantity = res.getInt("quantity");
				double price = res.getDouble("price");
				double totalAmount = res.getDouble("totalAmount");

				orderItem = new OrderItem(orderItemId, userId, restaurantId, menuId, itemName, quantity, price,
						totalAmount);
				OrderItemsList.add(orderItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (prepareStatement != null)
				try {
					prepareStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		return OrderItemsList;
	}

}
