package com.tap.DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.OrderDao;
import com.tap.model.Order;
import com.tap.util.DBConnection;

public class OrderDaoImpl implements OrderDao {

	private final static String INSERT_ORDER = "INSERT INTO `orders` "
			+ "(userId, restaurantId, orderDate, totalAmount, status, paymentMethod) "
			+ "VALUES (?, ?, ?, ?, ?, ?)";

	private final static String GET_ORDER = "SELECT * FROM `orders` WHERE orderId = ?";

	private final static String UPDATE_ORDER = "UPDATE `orders` SET userId=?, restaurantId=?, "
			+ "orderDate=?, totalAmount=?, status=?, paymentMethod=? WHERE orderId=?";

	private final static String DELETE_ORDER = "DELETE FROM `orders` WHERE orderId=?";

	private final static String GET_ALL_ORDERS = "SELECT * FROM `orders`";

	private final static String GET_ORDERS_BY_USER_ID = "SELECT * FROM `orders` WHERE userId=?";

//	@Override
//	public int addOrder(Order order) {
//
//		Connection connection = DBConnection.getConnection();
//
//		try {
//			PreparedStatement pstmt = connection.prepareStatement(INSERT_ORDER);
//
//			pstmt.setInt(1, order.getUserId());
//			pstmt.setInt(2, order.getRestaurantId());
//			pstmt.setTimestamp(3, order.getOrderDate());
//			pstmt.setDouble(4, order.getTotalAmount());
//			pstmt.setString(5, order.getStatus());
//			pstmt.setString(6, order.getPaymentMethod());
//
//			pstmt.executeUpdate();
//		
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
	
	
	@Override
	public int addOrder(Order order) {

	    int generatedOrderId = -1;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement pstmt = connection.prepareStatement(
	                 INSERT_ORDER,
	                 Statement.RETURN_GENERATED_KEYS)) {

	        pstmt.setInt(1, order.getUserId());
	        pstmt.setInt(2, order.getRestaurantId());
	        pstmt.setTimestamp(3, order.getOrderDate());
	        pstmt.setDouble(4, order.getTotalAmount());
	        pstmt.setString(5, order.getStatus());
	        pstmt.setString(6, order.getPaymentMethod());

	        pstmt.executeUpdate();

	        try (ResultSet resultSet = pstmt.getGeneratedKeys()) {

	            if (resultSet.next()) {

	                generatedOrderId = resultSet.getInt(1);

	                order.setOrderId(generatedOrderId);
	            }
	        }

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return generatedOrderId;
	}

	@Override
	public Order getOrder(int orderId) {

		Order order = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ORDER);

			pstmt.setInt(1, orderId);

			ResultSet resultset = pstmt.executeQuery();

			if (resultset.next()) {
				order = extractOrderFromResultSet(resultset);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return order;
	}

	private Order extractOrderFromResultSet(ResultSet res) throws SQLException {

		int orderId = res.getInt(1);
		int userId = res.getInt(2);
		int restaurantId = res.getInt(3);
		java.sql.Timestamp orderDate = res.getTimestamp(4);
		double totalAmount = res.getDouble(5);
		String status = res.getString(6);
		String paymentMethod = res.getString(7);

		Order order = new Order(
				orderId,
				userId,
				restaurantId,
				orderDate,
				totalAmount,
				status,
				paymentMethod
		);

		return order;
	}

	@Override
	public void updateOrder(Order order) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER);

			pstmt.setInt(1, order.getUserId());
			pstmt.setInt(2, order.getRestaurantId());
			pstmt.setTimestamp(3, order.getOrderDate());
			pstmt.setDouble(4, order.getTotalAmount());
			pstmt.setString(5, order.getStatus());
			pstmt.setString(6, order.getPaymentMethod());

			pstmt.setInt(7, order.getOrderId());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrder(int orderId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_ORDER);

			pstmt.setInt(1, orderId);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Order> getAllOrders() {

		ArrayList<Order> allOrders = new ArrayList<Order>();

		Connection connection = DBConnection.getConnection();

		try {
			Statement stmt = connection.createStatement();

			ResultSet res = stmt.executeQuery(GET_ALL_ORDERS);

			while (res.next()) {

				Order order = extractOrderFromResultSet(res);

				allOrders.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return allOrders;
	}

	@Override
	public List<Order> getOrdersByUserId(int userId) {

		ArrayList<Order> orders = new ArrayList<Order>();

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(GET_ORDERS_BY_USER_ID);

			pstmt.setInt(1, userId);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {

				Order order = extractOrderFromResultSet(res);

				orders.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orders;
	}
}