package com.tap.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.Dao.MenuDao;
import com.tap.Dao.OrderDao;
import com.tap.Dao.OrderItemDao;
import com.tap.Dao.RestaurantDao;

import com.tap.DaoImpl.MenuDaoImpl;
import com.tap.DaoImpl.OrderDaoImpl;
import com.tap.DaoImpl.OrderItemDaoImpl;
import com.tap.DaoImpl.RestaurantDaoImpl;

import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrdersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve the existing session.
        HttpSession session = req.getSession(false);

        // Check whether a session exists and the customer is logged in.
        if (session == null || session.getAttribute("loggedInUser") == null) {

            resp.sendRedirect(req.getContextPath() + "/login");

            return;
        }

        // Retrieve the logged-in customer.
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        int userId = loggedInUser.getId();

        // Create DAO objects.
        OrderDao orderDao = new OrderDaoImpl();
        OrderItemDao orderItemDao = new OrderItemDaoImpl();
        RestaurantDao restaurantDao = new RestaurantDaoImpl();
        MenuDao menuDao = new MenuDaoImpl();

        // Retrieve orders belonging to the logged-in customer only.
        List<Order> orders = orderDao.getOrdersByUserId(userId);

        // Store restaurant details for each order.
        Map<Integer, Restaurant> restaurantDetails = new HashMap<>();

        // Store the order items belonging to each order.
        Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();

        // Store menu details for each order item.
        Map<Integer, Menu> menuDetails = new HashMap<>();

        // Process every order.
        for (Order order : orders) {

            int orderId = order.getOrderId();
            int restaurantId = order.getRestaurantId();

            // Retrieve the restaurant associated with this order.
            Restaurant restaurant = restaurantDao.getRestaurant(restaurantId);

            if (restaurant != null) {
                restaurantDetails.put(orderId, restaurant);
            }

            // Retrieve the items belonging to this order.
            List<OrderItem> orderItems =
                    orderItemDao.getOrderItemsByOrderId(orderId);

            orderItemsMap.put(orderId, orderItems);

            // Retrieve menu details for each ordered item.
            for (OrderItem orderItem : orderItems) {

                int menuId = orderItem.getMenuId();

                // Avoid retrieving the same menu item repeatedly.
                if (!menuDetails.containsKey(menuId)) {

                    Menu menu = menuDao.getMenu(menuId);

                    if (menu != null) {
                        menuDetails.put(menuId, menu);
                    }
                }
            }
        }

        // Pass the information to orders.jsp.
        req.setAttribute("orders", orders);
        req.setAttribute("restaurantDetails", restaurantDetails);
        req.setAttribute("orderItemsMap", orderItemsMap);
        req.setAttribute("menuDetails", menuDetails);

        // Forward the request to the Orders page.
        RequestDispatcher rd = req.getRequestDispatcher("/orders.jsp");

        rd.forward(req, resp);
    }
}