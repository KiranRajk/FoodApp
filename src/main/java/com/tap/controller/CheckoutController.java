package com.tap.controller;

import com.tap.Dao.OrderDao;
import com.tap.Dao.OrderItemDao;
import com.tap.DaoImpl.OrderDaoImpl;
import com.tap.DaoImpl.OrderItemDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		Cart cart = (Cart) session.getAttribute("cart");

		if (cart == null || cart.isEmpty()) {

			resp.sendRedirect(req.getContextPath() + "/cart");

			return;
		}

		// Retrieve the logged-in user from the session.
		User user = (User) session.getAttribute("loggedInUser");

		// Redirect to login if the user is not logged in.
		if (user == null) {

			resp.sendRedirect(req.getContextPath() + "/login");

			return;
		}

		// Pass the cart and user details to checkout.jsp.
		req.setAttribute("cart", cart);
		req.setAttribute("user", user);

		RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");

		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		// Get logged-in user
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		// Get cart
		Cart cart = (Cart) session.getAttribute("cart");

		// Validate user
		if (loggedInUser == null) {

			resp.sendRedirect(req.getContextPath() + "/login");

			return;
		}

		// Validate cart
		if (cart == null || cart.isEmpty()) {

			resp.sendRedirect(req.getContextPath() + "/cart");

			return;
		}

		// Get payment mode from checkout.jsp
		String paymentMode = req.getParameter("paymentMethod");

		// Validate payment mode
		if (paymentMode == null || paymentMode.trim().isEmpty()) {

			resp.sendRedirect(req.getContextPath() + "/checkout");

			return;
		}

		/*
		 * User address is already available inside loggedInUser.getAddress().
		 *
		 * We are not storing the address in the orders table because there is no
		 * address column in that table.
		 */

		// Create Order DAO
		OrderDao orderDao = new OrderDaoImpl();

		// Create Order object
		Order order = new Order(0, loggedInUser.getId(), cart.getRestaurantId(),
				new java.sql.Timestamp(System.currentTimeMillis()), cart.getTotalAmount(), "PLACED", paymentMode);

		// Insert Order and get generated orderId
		int orderId = orderDao.addOrder(order);

		// Check whether Order was successfully created
		if (orderId <= 0) {

			req.setAttribute("checkoutError", "Unable to place the order. Please try again.");

			req.setAttribute("cart", cart);
			req.setAttribute("user", loggedInUser);

			RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");

			rd.forward(req, resp);

			return;
		}

		// Create Order Item DAO
		OrderItemDao orderItemDao = new OrderItemDaoImpl();

		// Insert every CartItem into OrderItem table
		for (CartItem cartItem : cart.getItems()) {

			OrderItem orderItem = new OrderItem(0, orderId, cartItem.getMenu().getMenuId(), cartItem.getQuantity(),
					cartItem.getSubtotal());

			orderItemDao.addOrderItem(orderItem);
		}

		// Clear cart after successful order
		cart.clear();

		session.setAttribute("cart", cart);

		// Store orderId for next page
		session.setAttribute("lastOrderId", orderId);

		// Redirect after successful order
		resp.sendRedirect(req.getContextPath() + "/order-success");
	}
}