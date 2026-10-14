package com.tap.model;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

	private Map<Integer, CartItem> items;
	private int restaurantId;

	public Cart() {
		items = new LinkedHashMap<>();
		restaurantId = 0;
	}

	// Add item to cart
	public boolean addItem(Menu menu) {

		// First item decides which restaurant this cart belongs to
		if (items.isEmpty()) {
			restaurantId = menu.getRestaurantId();
		}

		// Do not allow items from another restaurant
		if (restaurantId != menu.getRestaurantId()) {
			return false;
		}

		int menuId = menu.getMenuId();

		// If item already exists, increase quantity
		if (items.containsKey(menuId)) {

			CartItem existingItem = items.get(menuId);

			existingItem.setQuantity(
					existingItem.getQuantity() + 1
			);

		} else {

			CartItem cartItem = new CartItem(menu, 1);

			items.put(menuId, cartItem);
		}

		return true;
	}

	// Update quantity
	public void updateQuantity(int menuId, int quantity) {

		if (items.containsKey(menuId)) {

			if (quantity <= 0) {
				removeItem(menuId);
			} else {

				CartItem cartItem = items.get(menuId);

				cartItem.setQuantity(quantity);
			}
		}
	}

	// Remove one menu item completely
	public void removeItem(int menuId) {

		items.remove(menuId);

		// If cart becomes empty, reset restaurant
		if (items.isEmpty()) {
			restaurantId = 0;
		}
	}

	// Get all cart items
	public Collection<CartItem> getItems() {
		return items.values();
	}

	// Calculate complete cart total
	public double getTotalAmount() {

		double total = 0;

		for (CartItem item : items.values()) {
			total += item.getSubtotal();
		}

		return total;
	}

	// Total quantity of items in cart
	public int getTotalQuantity() {

		int totalQuantity = 0;

		for (CartItem item : items.values()) {
			totalQuantity += item.getQuantity();
		}

		return totalQuantity;
	}

	// Restaurant to which this cart belongs
	public int getRestaurantId() {
		return restaurantId;
	}

	// Check whether cart is empty
	public boolean isEmpty() {
		return items.isEmpty();
	}

	// Remove everything from cart
	public void clear() {

		items.clear();
		restaurantId = 0;
	}
}