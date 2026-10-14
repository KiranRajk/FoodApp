<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Cart - FoodApp</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/navbar.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/footer.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/cart.css">
</head>

<body>

    <!-- ================= NAVBAR ================= -->
    <%@ include file="includes/navbar.jsp" %>


    <!-- ================= CART PAGE HEADER ================= -->
    <section class="cart-hero">

        <div class="cart-hero-content">

            <span class="cart-eyebrow">
                YOUR FAVOURITES, ALL IN ONE PLACE
            </span>

            <h1>Your Shopping Cart</h1>

            <p>
                Review your delicious picks before placing your order.
            </p>

        </div>

    </section>


    <!-- ================= MAIN CART CONTENT ================= -->
    <main class="cart-main">

        <%
            Cart cart = (Cart) session.getAttribute("cart");
        %>

        <div class="cart-page-container">

            <% if (cart != null && !cart.isEmpty()) { %>

                <!-- CART SECTION HEADER -->
                <div class="cart-section-header">

                    <div>

                        <h2>Your Items</h2>

                        <p>
                            You have
                            <strong><%= cart.getTotalQuantity() %></strong>
                            item(s) in your cart.
                        </p>

                    </div>

                    <!-- CART HEADER ACTIONS -->
                    <div class="cart-header-actions">

                        <!-- CLEAR CART BUTTON -->
                        <form action="<%= request.getContextPath() %>/cart"
                              method="post"
                              class="clear-cart-form">

                            <input type="hidden"
                                   name="action"
                                   value="clear">

                            <button type="submit"
                                    class="clear-cart-btn">

                                <span aria-hidden="true">&#128465;</span>
                                Clear Cart

                            </button>

                        </form>

                        <!-- EXISTING CONTINUE SHOPPING LINK -->
                        <a href="<%= request.getContextPath() %>/restaurant"
                           class="continue-shopping">

                            <span>&larr;</span>
                            Continue Shopping

                        </a>

                    </div>

                </div>


                <!-- CART LAYOUT -->
                <div class="cart-layout">

                    <!-- CART ITEMS -->
                    <section class="cart-items-card">

                        <%
                            for (CartItem item : cart.getItems()) {
                        %>

                            <article class="cart-item">

                                <!-- FOOD IMAGE -->
                                <div class="cart-item-image-container">

                                    <img
                                        class="cart-item-image"
                                        src="<%= item.getMenu().getImagePath() %>"
                                        alt="<%= item.getMenu().getItemName() %>">

                                </div>


                                <!-- ITEM INFORMATION -->
                                <div class="cart-item-details">

                                    <h3 class="cart-item-name">
                                        <%= item.getMenu().getItemName() %>
                                    </h3>

                                    <p class="cart-item-unit-price">

                                        Unit price:

                                        <strong>
                                            &#8377;<%= String.format(
                                                "%.2f",
                                                item.getMenu().getPrice()) %>
                                        </strong>

                                    </p>

                                    <p class="cart-item-quantity-label">
                                        Adjust quantity below
                                    </p>


                                    <!-- QUANTITY CONTROLS -->
                                    <div class="cart-quantity-container">

                                        <!-- DECREASE QUANTITY -->
                                        <form
                                            class="cart-quantity-form"
                                            action="<%= request.getContextPath() %>/cart"
                                            method="post">

                                            <input
                                                type="hidden"
                                                name="action"
                                                value="update">

                                            <input
                                                type="hidden"
                                                name="menuId"
                                                value="<%= item.getMenu().getMenuId() %>">

                                            <input
                                                type="hidden"
                                                name="quantity"
                                                value="<%= item.getQuantity() - 1 %>">

                                            <input
                                                type="hidden"
                                                name="source"
                                                value="cart">

                                            <button
                                                type="submit"
                                                class="cart-quantity-btn"
                                                aria-label="Decrease quantity">

                                                &minus;

                                            </button>

                                        </form>


                                        <!-- CURRENT QUANTITY -->
                                        <span class="cart-quantity-value">
                                            <%= item.getQuantity() %>
                                        </span>


                                        <!-- INCREASE QUANTITY -->
                                        <form
                                            class="cart-quantity-form"
                                            action="<%= request.getContextPath() %>/cart"
                                            method="post">

                                            <input
                                                type="hidden"
                                                name="action"
                                                value="update">

                                            <input
                                                type="hidden"
                                                name="menuId"
                                                value="<%= item.getMenu().getMenuId() %>">

                                            <input
                                                type="hidden"
                                                name="quantity"
                                                value="<%= item.getQuantity() + 1 %>">

                                            <input
                                                type="hidden"
                                                name="source"
                                                value="cart">

                                            <button
                                                type="submit"
                                                class="cart-quantity-btn"
                                                aria-label="Increase quantity">

                                                +

                                            </button>

                                        </form>

                                    </div>

                                </div>


                                <!-- ITEM SUBTOTAL -->
                                <div class="cart-item-subtotal">

                                    <span class="subtotal-label">
                                        Subtotal
                                    </span>

                                    <span class="subtotal-price">

                                        &#8377;<%= String.format(
                                            "%.2f",
                                            item.getSubtotal()) %>

                                    </span>

                                </div>

                            </article>

                        <%
                            }
                        %>

                    </section>


                    <!-- ORDER SUMMARY -->
                    <aside class="cart-summary-card">

                        <div class="summary-heading">

                            <div class="summary-icon">

                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="24"
                                     height="24"
                                     viewBox="0 0 24 24"
                                     fill="none"
                                     stroke="currentColor"
                                     stroke-width="1.8"
                                     stroke-linecap="round"
                                     stroke-linejoin="round">

                                    <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"></path>

                                    <path d="M3 6h18"></path>

                                    <path d="M16 10a4 4 0 0 1-8 0"></path>

                                </svg>

                            </div>

                            <h2>Order Summary</h2>

                        </div>


                        <div class="summary-detail-row">

                            <span>Items</span>

                            <span>
                                <%= cart.getTotalQuantity() %>
                            </span>

                        </div>


                        <div class="summary-detail-row">

                            <span>Subtotal</span>

                            <span>
                                &#8377;<%= String.format(
                                    "%.2f",
                                    cart.getTotalAmount()) %>
                            </span>

                        </div>


                        <div class="summary-detail-row delivery-row">

                            <span>Delivery Fee</span>

                            <span class="free-delivery">
                                Free
                            </span>

                        </div>


                        <div class="summary-divider"></div>


                        <div class="summary-total-row">

                            <span>Total Amount</span>

                            <span>
                                &#8377;<%= String.format(
                                    "%.2f",
                                    cart.getTotalAmount()) %>
                            </span>

                        </div>


                        <a href="<%= request.getContextPath() %>/checkout"
                           class="checkout-btn">

                            <span>Proceed to Checkout</span>

                            <svg xmlns="http://www.w3.org/2000/svg"
                                 width="19"
                                 height="19"
                                 viewBox="0 0 24 24"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <path d="M5 12h14"></path>

                                <path d="m12 5 7 7-7 7"></path>

                            </svg>

                        </a>


                        <div class="summary-note">

                            <svg xmlns="http://www.w3.org/2000/svg"
                                 width="17"
                                 height="17"
                                 viewBox="0 0 24 24"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="1.8"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <circle cx="12" cy="12" r="10"></circle>

                                <path d="M12 16v-4"></path>

                                <path d="M12 8h.01"></path>

                            </svg>

                            <span>
                                Review your items before confirming your order.
                            </span>

                        </div>

                    </aside>

                </div>

            <% } else { %>


                <!-- ================= EMPTY CART ================= -->
                <section class="empty-cart-card">

                    <div class="empty-cart-illustration">

                        <svg xmlns="http://www.w3.org/2000/svg"
                             width="68"
                             height="68"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="1.4"
                             stroke-linecap="round"
                             stroke-linejoin="round">

                            <circle cx="9" cy="21" r="1"></circle>

                            <circle cx="20" cy="21" r="1"></circle>

                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>

                            <path d="M12 9v4"></path>

                            <path d="M10 11h4"></path>

                        </svg>

                    </div>

                    <span class="empty-cart-eyebrow">
                        YOUR CART IS WAITING
                    </span>

                    <h2>Your cart is empty</h2>

                    <p>
                        Looks like you haven't added anything delicious yet.
                        Explore our restaurants and find something you love.
                    </p>

                    <a href="<%= request.getContextPath() %>/restaurant"
                       class="browse-restaurants-btn">

                        Browse Restaurants

                        <span>&rarr;</span>

                    </a>

                </section>

            <% } %>

        </div>

    </main>


    <!-- ================= FOOTER ================= -->
    <%@ include file="includes/footer.jsp" %>

</body>

</html>