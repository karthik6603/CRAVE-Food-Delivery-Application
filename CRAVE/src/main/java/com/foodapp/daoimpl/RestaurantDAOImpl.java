package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.dbutil.DBConnection;
import com.foodapp.model.Restaurant;

public class RestaurantDAOImpl implements RestaurantDAO {
	
	final static String INSERT_QUERY = "INSERT into `restaurant` (`name` , `imagePath`, `rating`,`eta`, `cuisineType` , `address`,`isActive` , `restaurantOwnerId`) values (?,?,?,?,?,?,?,?)";
	final static String DELETE_QUERY = "DELETE from `restaurant` WHERE `restaurantId` = ?";
	final static String SELECT_ALL_QUERY = "SELECT * from `restaurant`";
	final static String SELECT_QUERY = "SELECT * from `restaurant` WHERE `restaurantId` = ?";
	final static String UPDATE_QUERY = "UPDATE `restaurant` SET `name` = ? ,`cuisineType` = ? , `address` = ?, `isActive` = ?  WHERE`restaurantId` = ?";
	final static String SELECT_RID__QUERY = "SELECT * from `restaurant` WHERE `restaurantOwnerId` = ?";

	static Connection con = null;

	public RestaurantDAOImpl() {
		
		con = DBConnection.connect();
	}

	@Override
	public void addRestaurant(Restaurant restaurant) {

		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(INSERT_QUERY);
			
			prepareStatement.setString(1, restaurant.getName());
			prepareStatement.setString(2, restaurant.getImagePath());
			prepareStatement.setFloat(3, restaurant.getRating());
			prepareStatement.setString(4, restaurant.getEta());
			prepareStatement.setString(5, restaurant.getCuisineType());
			prepareStatement.setString(6, restaurant.getAddress());
			prepareStatement.setString(7, restaurant.getIsActive());
			prepareStatement.setInt(8, restaurant.getRestaurantOwnerId());

			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteRestaurant(int restaurantId) {

		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(DELETE_QUERY);
			prepareStatement.setInt(1, restaurantId);
			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public List<Restaurant> getAll() {

		Statement statement = null;

		ResultSet res = null;

		ArrayList<Restaurant> restaurantList = new ArrayList<Restaurant>();
		try {
			statement = con.createStatement();
			res = statement.executeQuery(SELECT_ALL_QUERY);

			while (res.next()) {
				int restauantId = res.getInt("restaurantId");
				String name = res.getString("name");
				String imagePath = res.getString("imagePath");
				float rating = res.getFloat("rating");
				String eta = res.getString("eta");
				String address = res.getString("address");
				String cuisineType = res.getString("cuisineType");
				String isActive = res.getString("isActive");
				int restaurantOwnerId = res.getInt("restaurantOwnerId");

				Restaurant restaurant = new Restaurant(restauantId, name, imagePath, rating, eta, cuisineType, address, isActive, restaurantOwnerId);

				restaurantList.add(restaurant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return restaurantList;
	}

	@Override
	public Restaurant getRestaurant(int restaurantId) {

		PreparedStatement prepareStatement = null;
		ResultSet res = null;
		Restaurant restaurant = null;

		try {
			prepareStatement = con.prepareStatement(SELECT_QUERY);

			prepareStatement.setInt(1, restaurantId);
			res = prepareStatement.executeQuery();

			if (res.next()) {
				String name = res.getString("name");
				String imagePath = res.getString("imagePath");
				float rating = res.getInt("rating");
				String eta = res.getString("eta");
				String address = res.getString("address");
				String CuisineType = res.getString("cuisineType");
				String isActive = res.getString("isActive");
				int restauantOwnerId = res.getInt("restaurantOwnerId");

				restaurant = new Restaurant(restaurantId, name, imagePath, rating, eta, CuisineType, address, isActive,
						restauantOwnerId);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return restaurant;

	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {

		PreparedStatement prepareStatement = null;

		try {
			prepareStatement = con.prepareStatement(UPDATE_QUERY);

			prepareStatement.setString(1, restaurant.getName());
			prepareStatement.setString(2, restaurant.getCuisineType());
			prepareStatement.setString(3, restaurant.getAddress());
			prepareStatement.setString(4, restaurant.getIsActive());

			prepareStatement.setInt(5, restaurant.getRestaurantId());

			prepareStatement.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}
	}
	@Override
	public int getRestaurantId(int restaurantOwnerId) {
		PreparedStatement prepareStatement = null;
		ResultSet res = null;
		Restaurant restaurant = null;
		int restauantId=0;
		try {
			prepareStatement = con.prepareStatement(SELECT_RID__QUERY);

			prepareStatement.setInt(1, restaurantOwnerId);
			res = prepareStatement.executeQuery();

			if (res.next()) {
				restauantId = res.getInt("restaurantId");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return restauantId;
	}


}
