package com.tap.DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.UserDAO;
import com.tap.model.User;
import com.tap.util.DBConnection;

public class UserDaoImpl implements UserDAO{
	
	private final static String INSERT_USER =
	        "INSERT INTO user(name, email, password, phone, address, role, createdDate, lastLoginDate) VALUES(?,?,?,?,?,?,?,?)";

	private final static String GET_USER =
	        "SELECT * FROM user WHERE id = ?";

	private final static String GET_USER_BY_EMAIL =
	        "SELECT * FROM user WHERE email = ?";

	private final static String UPDATE_USER =
	        "UPDATE user SET name=?, email=?, password=?, phone=?, address=?, role=?, lastLoginDate=? WHERE id=?";

	private final static String DELETE_USER =
	        "DELETE FROM user WHERE id=?";

	private final static String GET_ALL_USERS =
	        "SELECT * FROM user";

	@Override
	public void addUser(User user){
		
		Connection connection = DBConnection.getConnection();	
		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_USER);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getPhone());
			pstmt.setString(5, user.getAddress());
			pstmt.setString(6, user.getRole());
			pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			pstmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
			
			int i = pstmt.executeUpdate();
			System.out.println(i);
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public User getUser(int userId) {

	    User user = null;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(GET_USER)) {

	        statement.setInt(1, userId);

	        try (ResultSet resultSet = statement.executeQuery()) {

	            if (resultSet.next()) {

	                user = new User();

	                user.setId(resultSet.getInt("id"));
	                user.setName(resultSet.getString("name"));
	                user.setEmail(resultSet.getString("email"));
	                user.setPassword(resultSet.getString("password"));
	                user.setPhone(resultSet.getString("phone"));
	                user.setAddress(resultSet.getString("address"));
	                user.setRole(resultSet.getString("role"));
	                user.setCreatedDate(resultSet.getTimestamp("createdDate"));
	                user.setLastLoginDate(resultSet.getTimestamp("lastLoginDate"));
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return user;
	}
	
	@Override
	public User getUserByEmail(String userEmail) {

	    User user = null;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(GET_USER_BY_EMAIL)) {

	        statement.setString(1, userEmail);

	        try (ResultSet resultSet = statement.executeQuery()) {

	            if (resultSet.next()) {

	                user = new User();

	                user.setId(resultSet.getInt("id"));
	                user.setName(resultSet.getString("name"));
	                user.setEmail(resultSet.getString("email"));
	                user.setPassword(resultSet.getString("password"));
	                user.setPhone(resultSet.getString("phone"));
	                user.setAddress(resultSet.getString("address"));
	                user.setRole(resultSet.getString("role"));
	                user.setCreatedDate(resultSet.getTimestamp("createdDate"));
	                user.setLastLoginDate(resultSet.getTimestamp("lastLoginDate"));
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return user;
	}

	@Override
	public void updateUser(User user) {
		
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_USER);
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getPhone());
			pstmt.setString(5, user.getAddress());
			pstmt.setString(6, user.getRole());
			pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			
			pstmt.setInt(8, user.getId());
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void deleteUser(int userId) {
		Connection connection = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_USER);
			pstmt.setInt(1, userId);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<User> getAllUsers() {

	    ArrayList<User> allUser = new ArrayList<User>();

	    try (Connection connection = DBConnection.getConnection();
	         Statement statement = connection.createStatement();
	         ResultSet resultSet = statement.executeQuery(GET_ALL_USERS)) {

	        while (resultSet.next()) {

	            User user = new User();

	            user.setId(resultSet.getInt("id"));
	            user.setName(resultSet.getString("name"));
	            user.setEmail(resultSet.getString("email"));
	            user.setPassword(resultSet.getString("password"));
	            user.setPhone(resultSet.getString("phone"));
	            user.setAddress(resultSet.getString("address"));
	            user.setRole(resultSet.getString("role"));
	            user.setCreatedDate(resultSet.getTimestamp("createdDate"));
	            user.setLastLoginDate(resultSet.getTimestamp("lastLoginDate"));

	            allUser.add(user);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return allUser;
	}

}
