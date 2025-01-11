package com.foodapp.dao;

import java.util.List;

import com.foodapp.model.Menu;

public interface MenuDAO {

	int addMenu(Menu menu);
	Menu getMenu(int menuId);
	void updateMenu(Menu menu);
	int deleteMenu(int menuId);
	List<Menu>getAll();
	List<Menu>getMenuByResto(int restauratId);
	
}
