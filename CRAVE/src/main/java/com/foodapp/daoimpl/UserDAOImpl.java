package com.foodapp.daoimpl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.UserDAO;
import com.foodapp.dbutil.DBConnection;
import com.foodapp.model.PasswordEncryption;
import com.foodapp.model.User;

public class UserDAOImpl implements UserDAO {
	
	final static String INSERT_QUERY = "INSERT into `user` (`name` , `email`, `phoneNo`,`address`, `userName` , `password`,`role`) values (?,?,?,?,?,?,?)";
	final static String INSERT_R_QUERY = "INSERT into `user` (`name` , `email`, `phoneNo`,`address`, `userName` , `password`,`role`,`restaurantOwnerId`) values (?,?,?,?,?,?,?,?)";
	final static String SELECT_QUERY = "SELECT * from `user` WHERE `userId` = ?";
	final static String UPDATE_QUERY = "UPDATE `user` SET `name` = ? ,`email` = ? ,`phoneNo` = ? , `address` = ? ,`userName` = ?   WHERE`userId` = ?";
	final static String DELETE_QUERY = "DELETE from `user` WHERE `userId` = ?";
	final static String SELECTALL_QUERY = "SELECT * from `user`";
	final static String SELECTBYUSERANDPASS = "SELECT * from `user` WHERE `userName` = ? AND `password` = ?";
	final static String SELECTBYUSERANDPASSTOROLE ="SELECT * from `user` WHERE `userName` = ? AND `password` = ?";
	final static String USERNAMEVALID = "SELECT COUNT(*) FROM `user` WHERE userName = ?";
	final static String INSERT_QUERY_BY_SIGNUP = "INSERT into `user` (`name` , `email`, `phoneNo`,`address`, `userName` , `password`,`role`) values (?,?,?,?,?,?,?)";
	final static String GETRIDBYUSERANDPASS = "SELECT * from `user` WHERE `userName` = ? AND `password` = ?";
	final static String GETBYROLE = "SELECT * from `user` WHERE `role` = ?";
	

	static Connection con;

	public UserDAOImpl() {
		con = DBConnection.connect();
	}

	@Override
	public void addUser(User user) {

		PreparedStatement prepareStatement = null;

		try {
			prepareStatement = con.prepareStatement(INSERT_QUERY);
			prepareStatement.setString(1, user.getName());
			prepareStatement.setString(2, user.getEmail());
			prepareStatement.setString(3, user.getPhoneNo());
			prepareStatement.setString(4, user.getAddress());
			prepareStatement.setString(5, user.getUserName());
			String encryptedPassword = PasswordEncryption.encrypt(user.getPassword());
			prepareStatement.setString(6, encryptedPassword);
			prepareStatement.setString(7, user.getRole());

			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	@Override
	public void addRUser(User user) {
		
		PreparedStatement prepareStatement = null;
		
		try {
			prepareStatement = con.prepareStatement(INSERT_R_QUERY);
			prepareStatement.setString(1, user.getName());
			prepareStatement.setString(2, user.getEmail());
			prepareStatement.setString(3, user.getPhoneNo());
			prepareStatement.setString(4, user.getAddress());
			prepareStatement.setString(5, user.getUserName());
			String encryptedPassword = PasswordEncryption.encrypt(user.getPassword());
			prepareStatement.setString(6, encryptedPassword);
			prepareStatement.setString(7, user.getRole());
			LocalDateTime lastlogin = user.getLastlogin();
			
			prepareStatement.setInt(8, user.getRestaurantOwnerId());
			
			prepareStatement.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public User getUser(int userId) {

		PreparedStatement prepareStatement = null;
		ResultSet res = null;
		User user = null;
		try {
			prepareStatement = con.prepareStatement(SELECT_QUERY);

			prepareStatement.setInt(1, userId);
			res = prepareStatement.executeQuery();

			if (res.next()) {
				String name = res.getString("name");
				String email = res.getString("email");
				String phoneNo = res.getString("phoneNo");
				String address = res.getString("address");
				String userName = res.getString("userName");
				String password = res.getString("password");
				String role = res.getString("role");

				user = new User(userId, name, email, phoneNo, address, userName, password, role);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public void updateUser(User user) {

		PreparedStatement prepareStatement = null;

		try {
			prepareStatement = con.prepareStatement(UPDATE_QUERY);

			prepareStatement.setString(1, user.getName());
			prepareStatement.setString(2, user.getEmail());
			prepareStatement.setString(3, user.getPhoneNo());
			prepareStatement.setString(4, user.getAddress());
			prepareStatement.setString(5, user.getUserName());

			prepareStatement.setInt(6, user.getUserId());

			prepareStatement.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	@Override
	public void deleteUser(int userId) {

		PreparedStatement prepareStatement = null;
		try {
			prepareStatement = con.prepareStatement(DELETE_QUERY);
			prepareStatement.setInt(1, userId);
			prepareStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<User> getAllUser() {

		Statement statement = null;

		ResultSet res = null;

		ArrayList<User> userList = new ArrayList<User>();
		try {
			statement = con.createStatement();
			res = statement.executeQuery(SELECTALL_QUERY);

			while (res.next()) {
				int userId = res.getInt("userId");
				String name = res.getString("name");
				String email = res.getString("email");
				String phoneNo = res.getString("phoneNo");
				String address = res.getString("address");
				String userName = res.getString("userName");
				String password = res.getString("password");
				String role = res.getString("role");
				
				User user = new User(userId, name, email, phoneNo, address, userName, password, role
					);
				userList.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}

	@Override
	public boolean isValidUser(String userName, String encryptedPassword) {

		PreparedStatement prepareStatement = null;

		ResultSet res = null;
		boolean isValid = false;
		try {
			prepareStatement = con.prepareStatement(SELECTBYUSERANDPASS);

			prepareStatement.setString(1, userName);
			//String decryptedPassword = PasswordEncryption.decryption(encryptedPassword);
	        prepareStatement.setString(2, encryptedPassword);

			res = prepareStatement.executeQuery();

			if (res.next()) {
				isValid = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isValid;
	}

	public boolean isUserExists(String userName) {

		boolean exists = false;
		PreparedStatement prepareStatement = null;
		ResultSet res = null;

		try {
			prepareStatement = con.prepareStatement(USERNAMEVALID);
			prepareStatement.setString(1, userName);

			res = prepareStatement.executeQuery();

			if (res.next()) {
				int c = res.getInt(1);
				exists = c > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return exists;
	}

	@Override
	public void addUserSignUp(User user) {

		try {
			PreparedStatement prepareStatement = con.prepareStatement(INSERT_QUERY_BY_SIGNUP);
			prepareStatement.setString(1, user.getUserName());
			prepareStatement.setString(2, user.getEmail());
			prepareStatement.setString(3, user.getPhoneNo());
			prepareStatement.setString(4, user.getAddress());
			prepareStatement.setString(5, user.getUserName());
			prepareStatement.setString(6, user.getPassword());
			prepareStatement.setString(7, user.getRole());

			String encrptedPassword = encryption(user.getPassword());

			prepareStatement.setString(6, encrptedPassword);

			prepareStatement.executeQuery();

		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

	 @Override
	    public User getUserByuserNameAndPassword(String userName, String password) {
	        User user=new User();
	        try (PreparedStatement prepareStatement = con.prepareStatement(SELECTBYUSERANDPASS)) {
	            prepareStatement.setString(1, userName);
	            prepareStatement.setString(2, password);
	            try (ResultSet res = prepareStatement.executeQuery()) {
	                if (res.next()) {
	                    user.setUserId(res.getInt("userId"));
	                    user.setName(res.getString("name"));
	                    user.setEmail(res.getString("email"));
	                    user.setPhoneNo(res.getString("phoneNo"));
	                    user.setAddress(res.getString("address"));
	                    user.setUserName(userName);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return user;
	    }

	public static String encryption(String s) {
		String t = "";
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			c = (char) (c + 1);
			t = t + c;
		}
		return t;
	}

	public static String decryption(String s) {
		String t = "";
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			c = (char) (c - 1);
			t = t + c;
		}
		return t;
	}

	@Override
	public String getUserRole(String userName, String Password) {

			ResultSet res = null;
			User user = null;
			String role;
			try {
				PreparedStatement prepareStatement = con.prepareStatement(SELECTBYUSERANDPASSTOROLE);

				prepareStatement.setString(1, userName);

				String encryotedPassword = encryption(Password);

				prepareStatement.setString(2, Password);

				res = prepareStatement.executeQuery();

				if (res.next()) {

					role=res.getString("role");
					return role;
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

			return "Invalid User";
		}
	@Override
	public int getRestaurantOwnerId(String userName, String encryptedPassword) {
		ResultSet res = null;
		int roId = 0;
		String role;
		try {
			PreparedStatement prepareStatement = con.prepareStatement(GETRIDBYUSERANDPASS);
			prepareStatement.setString(1, userName);
			prepareStatement.setString(2, encryptedPassword);
			res = prepareStatement.executeQuery();
			if (res.next()) {

				roId=res.getInt("restaurantOwnerId");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return roId;
	}
	@Override
	public List<User> getAllUserByRole(String role) {

		Statement statement = null;

		ResultSet res = null;

		ArrayList<User> userList = new ArrayList<User>();
		try {
			PreparedStatement prepareStatement = con.prepareStatement(GETBYROLE);
			prepareStatement.setString(1, role);
			res = prepareStatement.executeQuery();

			while (res.next()) {
				int userId = res.getInt("userId");
				String name = res.getString("name");
				String email = res.getString("email");
				String phoneNo = res.getString("phoneNo");
				String address = res.getString("address");
				String userName = res.getString("userName");
				String password = res.getString("password");

				User user = new User(userId, name, email, phoneNo, address, userName, password);
				userList.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}
	
}
