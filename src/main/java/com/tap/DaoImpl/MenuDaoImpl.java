package com.tap.DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.Dao.MenuDao;
import com.tap.model.Menu;
import com.tap.util.DBConnection;

public class MenuDaoImpl implements MenuDao {

	private final static String INSERT_QUERY = "INSERT INTO menu "
			+ "(restaurantId, itemName, description, price, isAvailable, imagePath) "
			+ "VALUES (?, ?, ?, ?, ?, ?)";

	private final static String SELECT_QUERY = "SELECT * FROM menu WHERE menuId = ?";

	private final static String UPDATE_QUERY = "UPDATE menu SET restaurantId=?, itemName=?, description=?, "
			+ "price=?, isAvailable=?, imagePath=? WHERE menuId=?";

	private final static String DELETE_QUERY = "DELETE FROM menu WHERE menuId=?";

	private final static String SELECT_ALL_QUERY = "SELECT * FROM menu";

	private final static String SELECT_BY_RESTAURANT_ID_QUERY = "SELECT * FROM menu WHERE restaurantId=?";

	@Override
	public void addMenu(Menu menu) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setInt(1, menu.getRestaurantId());
			pstmt.setString(2, menu.getItemName());
			pstmt.setString(3, menu.getDescription());
			pstmt.setDouble(4, menu.getPrice());
			pstmt.setBoolean(5, menu.isAvailable());
			pstmt.setString(6, menu.getImagePath());

			int i = pstmt.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Menu getMenu(int menuId) {

		Menu menu = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, menuId);

			ResultSet resultset = pstmt.executeQuery();

			if (resultset.next()) {
				menu = extractMenuFromResultSet(resultset);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return menu;
	}

	private Menu extractMenuFromResultSet(ResultSet res) throws SQLException {

		int menuId = res.getInt(1);
		int restaurantId = res.getInt(2);
		String itemName = res.getString(3);
		String description = res.getString(4);
		double price = res.getDouble(5);
		boolean isAvailable = res.getBoolean(6);
		String imagePath = res.getString(7);

		Menu menu = new Menu(
				menuId,
				restaurantId,
				itemName,
				description,
				price,
				isAvailable,
				imagePath
		);

		return menu;
	}

	@Override
	public void updateMenu(Menu menu) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);

			pstmt.setInt(1, menu.getRestaurantId());
			pstmt.setString(2, menu.getItemName());
			pstmt.setString(3, menu.getDescription());
			pstmt.setDouble(4, menu.getPrice());
			pstmt.setBoolean(5, menu.isAvailable());
			pstmt.setString(6, menu.getImagePath());

			pstmt.setInt(7, menu.getMenuId());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteMenu(int menuId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_QUERY);

			pstmt.setInt(1, menuId);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Menu> getAllMenus() {

		ArrayList<Menu> allMenus = new ArrayList<Menu>();

		Connection connection = DBConnection.getConnection();

		try {
			Statement stmt = connection.createStatement();

			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);

			while (res.next()) {

				Menu menu = extractMenuFromResultSet(res);

				allMenus.add(menu);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return allMenus;
	}

	@Override
	public List<Menu> getMenuByRestaurantId(int restaurantId) {

		ArrayList<Menu> menus = new ArrayList<Menu>();

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_BY_RESTAURANT_ID_QUERY);

			pstmt.setInt(1, restaurantId);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {

				Menu menu = extractMenuFromResultSet(res);

				menus.add(menu);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return menus;
	}
}