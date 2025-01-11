package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.dao.MenuDAO;
import com.foodapp.dao.RestaurantDAO;
import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Menu;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RestaurantOwnerServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
        
        // Check if restaurantId is null
        if (restaurantId == null) {
            resp.sendRedirect("login.jsp"); // Redirect to login if session is invalid
            return;
        }

        RestaurantDAO restaurantdao = new RestaurantDAOImpl();
        Restaurant restaurant = restaurantdao.getRestaurant(restaurantId);
        
        // Check if restaurant exists
        if (restaurant == null) {
            resp.sendRedirect("error.jsp"); // Redirect to error page if restaurant is not found
            return;
        }

        MenuDAO menu = new MenuDAOImpl();
        List<Menu> menuList = menu.getMenuByResto(restaurantId);
        
        req.setAttribute("menuList", menuList);
        req.setAttribute("restaurant", restaurant);
        
        req.getRequestDispatcher("RestaurantOwner.jsp").forward(req, resp);
    }
}
