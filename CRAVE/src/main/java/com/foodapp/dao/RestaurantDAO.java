package com.foodapp.dao;

import java.util.ArrayList;
import java.util.List;

import com.foodapp.model.Restaurant;

public interface RestaurantDAO {

	void addRestaurant(Restaurant restaurant);
	Restaurant getRestaurant(int restaurantId);
	void updateRestaurant(Restaurant restaurant);
	void deleteRestaurant(int restaurantId);
	List<Restaurant>getAll();
	int getRestaurantId(int restaurantOwnerId);
	
}
