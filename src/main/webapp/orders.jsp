<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.OrderItem" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.Menu" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Orders | FoodApp</title>

	<link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">

    <!-- Navbar CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/navbar.css">

    <!-- Footer CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/footer.css">
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/orders.css">
</head>

<body>

<%
    List<Order> orders =
        (List<Order>) request.getAttribute("orders");

    Map<Integer, Restaurant> restaurantDetails =
        (Map<Integer, Restaurant>) request.getAttribute("restaurantDetails");

    Map<Integer, List<OrderItem>> orderItemsMap =
        (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");

    Map<Integer, Menu> menuDetails =
        (Map<Integer, Menu>) request.getAttribute("menuDetails");
%>

<jsp:include page="/includes/navbar.jsp" />


<!-- ================= PAGE HEADER ================= -->

<header class="orders-hero">

    <div class="hero-content">

        <span class="hero-label">YOUR FOOD JOURNEY</span>

        <h1>My Orders</h1>

        <p>
            Every order tells a delicious story.
            Track your orders and revisit your favourites.
        </p>

    </div>

</header>


<!-- ================= ORDERS SECTION ================= -->

<main class="orders-container">

    <div class="section-heading">

        <div>
            <h2>Your Order History</h2>

            <p>
                View your previous orders and their details.
            </p>
        </div>

        

    </div>


    <%
        if (orders != null && !orders.isEmpty()) {
    %>

        <div class="orders-list">

        <%
            for (Order order : orders) {

                int orderId = order.getOrderId();

                Restaurant restaurant =
                    restaurantDetails.get(orderId);

                List<OrderItem> orderItems =
                    orderItemsMap.get(orderId);

                if (orderItems == null) {
                    orderItems = java.util.Collections.emptyList();
                }

                String status = order.getStatus();

                String statusClass = "status-default";

                if (status != null) {

                    if ("DELIVERED".equalsIgnoreCase(status)) {
                        statusClass = "status-delivered";
                    }
                    else if ("PLACED".equalsIgnoreCase(status)
                          || "CONFIRMED".equalsIgnoreCase(status)) {
                        statusClass = "status-placed";
                    }
                    else if ("PREPARING".equalsIgnoreCase(status)) {
                        statusClass = "status-preparing";
                    }
                    else if ("CANCELLED".equalsIgnoreCase(status)) {
                        statusClass = "status-cancelled";
                    }
                    else if ("OUT_FOR_DELIVERY".equalsIgnoreCase(status)
                          || "OUT FOR DELIVERY".equalsIgnoreCase(status)) {
                        statusClass = "status-delivery";
                    }
                }

                String formattedDate = "Date unavailable";

                if (order.getOrderDate() != null) {
                    formattedDate = new java.text.SimpleDateFormat(
                        "dd MMM yyyy, hh:mm a"
                    ).format(order.getOrderDate());
                }

                String restaurantName = "Restaurant unavailable";
                String restaurantImage = "";

                if (restaurant != null) {
                    restaurantName = restaurant.getName();

                    if (restaurant.getImagePath() != null) {
                        restaurantImage = restaurant.getImagePath();
                    }
                }

                String restaurantImageSrc = restaurantImage;

                if (restaurantImageSrc != null
                    && !restaurantImageSrc.trim().isEmpty()
                    && !restaurantImageSrc.startsWith("http://")
                    && !restaurantImageSrc.startsWith("https://")) {

                    restaurantImageSrc =
                        request.getContextPath() + "/" +
                        restaurantImageSrc.replaceFirst("^/+", "");
                }

                if (restaurantImageSrc == null
                    || restaurantImageSrc.trim().isEmpty()) {

                    restaurantImageSrc =
                        request.getContextPath() + "/images/restaurant-placeholder.png";
                }

                int itemCount = 0;

                for (OrderItem item : orderItems) {
                    itemCount += item.getQuantity();
                }
        %>


            <!-- ================= INDIVIDUAL ORDER CARD ================= -->

            <article class="order-card">

                <div class="order-card-header">

                    <div class="restaurant-info">

                        <div class="restaurant-image-wrapper">

                            <img
                                src="<%= restaurantImageSrc %>"
                                alt="<%= restaurantName %>"
                                class="restaurant-image"
                                onerror="this.onerror=null;this.src='<%= request.getContextPath() %>/images/restaurant-placeholder.png';">

                        </div>

                        <div class="restaurant-details">

                            <h3>
                                <%= restaurantName %>
                            </h3>

                            <p class="order-date">
                                <%= formattedDate %>
                            </p>

                            <p class="order-number">
                                Order #<%= orderId %>
                            </p>

                        </div>

                    </div>


                    <div class="order-summary">

                        <span class="status-badge <%= statusClass %>">
                            <%= status != null ? status.replace('_', ' ') : "STATUS UNAVAILABLE" %>
                        </span>

                        <div class="order-total">
                            ₹<%= String.format(java.util.Locale.US, "%.2f", order.getTotalAmount()) %>
                        </div>

                        <p class="item-count">
                            <%= itemCount %>
                            <%= itemCount == 1 ? "item" : "items" %>
                        </p>

                    </div>

                </div>


                <!-- ================= EXPAND/COLLAPSE BUTTON ================= -->

                <button
                    type="button"
                    class="order-toggle"
                    aria-expanded="false"
                    aria-label="View details for order <%= orderId %>"
                    onclick="toggleOrderDetails(this)">

                    <span>View Order Details</span>

                    <span class="toggle-icon">⌄</span>

                </button>


                <!-- ================= EXPANDABLE DETAILS ================= -->

                <div class="order-details">

                    <div class="details-divider"></div>

                    <h4 class="details-heading">
                        Ordered Items
                    </h4>


                    <%
                        if (!orderItems.isEmpty()) {

                            for (OrderItem orderItem : orderItems) {

                                Menu menu =
                                    menuDetails.get(orderItem.getMenuId());

                                String itemName = "Food item unavailable";
                                String itemImage = "";

                                if (menu != null) {

                                    itemName = menu.getItemName();

                                    if (menu.getImagePath() != null) {
                                        itemImage = menu.getImagePath();
                                    }
                                }

                                String itemImageSrc = itemImage;

                                if (itemImageSrc != null
                                    && !itemImageSrc.trim().isEmpty()
                                    && !itemImageSrc.startsWith("http://")
                                    && !itemImageSrc.startsWith("https://")) {

                                    itemImageSrc =
                                        request.getContextPath() + "/" +
                                        itemImageSrc.replaceFirst("^/+", "");
                                }

                                if (itemImageSrc == null
                                    || itemImageSrc.trim().isEmpty()) {

                                    itemImageSrc =
                                        request.getContextPath() + "/images/food-placeholder.png";
                                }
                    %>

                        <div class="order-item">

                            <div class="food-image-wrapper">

                                <img
                                    src="<%= itemImageSrc %>"
                                    alt="<%= itemName %>"
                                    class="food-image"
                                    onerror="this.onerror=null;this.src='<%= request.getContextPath() %>/images/food-placeholder.png';">

                            </div>

                            <div class="food-details">

                                <h5>
                                    <%= itemName %>
                                </h5>

                                <p>
                                    Quantity: <%= orderItem.getQuantity() %>
                                </p>

                            </div>

                            <div class="food-price">

                                ₹<%= String.format(
                                    java.util.Locale.US,
                                    "%.2f",
                                    orderItem.getItemTotal()
                                ) %>

                            </div>

                        </div>

                    <%
                            }
                        }
                        else {
                    %>

                        <div class="no-items">
                            No item details are available for this order.
                        </div>

                    <%
                        }
                    %>


                    <!-- ================= PAYMENT AND TOTAL ================= -->

                    <div class="order-payment-summary">

                        <div class="payment-info">

                            <span class="summary-label">
                                Payment Method
                            </span>

                            <strong>
                                <%= order.getPaymentMethod() != null
                                    ? order.getPaymentMethod()
                                    : "Not available" %>
                            </strong>

                        </div>


                        <div class="final-total">

                            <span>Total Amount</span>

                            <strong>
                                ₹<%= String.format(
                                    java.util.Locale.US,
                                    "%.2f",
                                    order.getTotalAmount()
                                ) %>
                            </strong>

                        </div>

                    </div>

                </div>

            </article>


        <%
            }
        %>

        </div>

    <%
        }
        else {
    %>


        <!-- ================= EMPTY ORDERS STATE ================= -->

        <section class="empty-orders">

            <div class="empty-icon">🛍️</div>

            <h2>No Orders Yet</h2>

            <p>
                Looks like you haven't ordered anything yet.
                Explore our restaurants and discover something delicious!
            </p>

            <a href="<%= request.getContextPath() %>/restaurant"
               class="browse-btn empty-browse-btn">
                Explore Restaurants
            </a>

        </section>


    <%
        }
    %>

</main>


<!-- ================= FOOTER ================= -->

<jsp:include page="/includes/footer.jsp" />


<!-- ================= JAVASCRIPT ================= -->

<script>

    function toggleOrderDetails(button) {

        const orderCard = button.closest(".order-card");

        const details = orderCard.querySelector(".order-details");

        const isExpanded =
            button.getAttribute("aria-expanded") === "true";

        button.setAttribute(
            "aria-expanded",
            String(!isExpanded)
        );

        details.classList.toggle("expanded", !isExpanded);

        const buttonText = button.querySelector("span:first-child");

        const toggleIcon = button.querySelector(".toggle-icon");

        if (!isExpanded) {

            buttonText.textContent = "Hide Order Details";

            toggleIcon.textContent = "⌃";

        }
        else {

            buttonText.textContent = "View Order Details";

            toggleIcon.textContent = "⌄";

        }
    }

</script>

</body>
</html>