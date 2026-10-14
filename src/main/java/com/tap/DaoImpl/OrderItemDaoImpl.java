package com.tap.DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.OrderItemDao;
import com.tap.model.OrderItem;
import com.tap.util.DBConnection;

public class OrderItemDaoImpl implements OrderItemDao {

	private final static String INSERT_QUERY = "INSERT INTO orderitem "
			+ "(orderId, menuId, quantity, itemTotal) "
			+ "VALUES (?, ?, ?, ?)";

	private final static String SELECT_QUERY = "SELECT * FROM orderitem WHERE orderItemId = ?";

	private final static String UPDATE_QUERY = "UPDATE orderitem SET orderId=?, menuId=?, "
			+ "quantity=?, itemTotal=? WHERE orderItemId=?";

	private final static String DELETE_QUERY = "DELETE FROM orderitem WHERE orderItemId=?";

	private final static String SELECT_ALL_QUERY = "SELECT * FROM orderitem";

	private final static String SELECT_BY_ORDER_ID_QUERY = "SELECT * FROM orderitem WHERE orderId=?";

	@Override
	public void addOrderItem(OrderItem orderItem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setInt(1, orderItem.getOrderId());
			pstmt.setInt(2, orderItem.getMenuId());
			pstmt.setInt(3, orderItem.getQuantity());
			pstmt.setDouble(4, orderItem.getItemTotal());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public OrderItem getOrderItem(int orderItemId) {

		OrderItem orderItem = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, orderItemId);

			ResultSet resultset = pstmt.executeQuery();

			if (resultset.next()) {
				orderItem = extractOrderItemFromResultSet(resultset);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderItem;
	}

	private OrderItem extractOrderItemFromResultSet(ResultSet res) throws SQLException {

		int orderItemId = res.getInt(1);
		int orderId = res.getInt(2);
		int menuId = res.getInt(3);
		int quantity = res.getInt(4);
		double itemTotal = res.getDouble(5);

		OrderItem orderItem = new OrderItem(
				orderItemId,
				orderId,
				menuId,
				quantity,
				itemTotal
		);

		return orderItem;
	}

	@Override
	public void updateOrderItem(OrderItem orderItem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);

			pstmt.setInt(1, orderItem.getOrderId());
			pstmt.setInt(2, orderItem.getMenuId());
			pstmt.setInt(3, orderItem.getQuantity());
			pstmt.setDouble(4, orderItem.getItemTotal());

			pstmt.setInt(5, orderItem.getOrderItemId());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrderItem(int orderItemId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_QUERY);

			pstmt.setInt(1, orderItemId);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderItem> getAllOrderItems() {

		ArrayList<OrderItem> allOrderItems = new ArrayList<OrderItem>();

		Connection connection = DBConnection.getConnection();

		try {
			Statement stmt = connection.createStatement();

			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);

			while (res.next()) {

				OrderItem orderItem = extractOrderItemFromResultSet(res);

				allOrderItems.add(orderItem);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return allOrderItems;
	}

	@Override
	public List<OrderItem> getOrderItemsByOrderId(int orderId) {

		ArrayList<OrderItem> orderItems = new ArrayList<OrderItem>();

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_BY_ORDER_ID_QUERY);

			pstmt.setInt(1, orderId);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {

				OrderItem orderItem = extractOrderItemFromResultSet(res);

				orderItems.add(orderItem);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderItems;
	}

	
}