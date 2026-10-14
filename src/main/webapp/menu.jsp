<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodApp - Menu</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/navbar.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/footer.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/menu.css">
</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <%@ include file="includes/navbar.jsp" %>


    <!-- ================= HERO SECTION ================= -->

    <section class="menu-hero">

        <div class="menu-hero-content">

            <span class="menu-hero-badge">
                MADE WITH LOVE, SERVED WITH FLAVOUR
            </span>

            <h1>
                Discover Your<br>
                <span>Next Favourite Meal</span>
            </h1>

            <p>
                Fresh flavours, delicious dishes, and something special
                for every craving.
            </p>

        </div>

        <div class="menu-hero-decoration menu-decoration-one"></div>
        <div class="menu-hero-decoration menu-decoration-two"></div>

    </section>


    <!-- ================= MENU SECTION ================= -->

    <main class="menu-main">

        <section class="menu-section">

            <div class="menu-section-header">

                <div class="menu-heading">

                    <span class="section-eyebrow">
                        SOMETHING DELICIOUS AWAITS
                    </span>

                    <h2>Explore Our Menu</h2>

                    <p>
                        Choose from our delicious selection of dishes.
                    </p>

                </div>

                <div class="menu-item-count">

                    <span class="count-number">
                        <%
                            List<Menu> menuList =
                                (List<Menu>) request.getAttribute("menuList");

                            if (menuList != null) {
                                out.print(menuList.size());
                            } else {
                                out.print(0);
                            }
                        %>
                    </span>

                    <span class="count-label">
                        Menu Items
                    </span>

                </div>

            </div>


            <%
                Cart cart = (Cart) session.getAttribute("cart");

                if (menuList != null && !menuList.isEmpty()) {
            %>

                <!-- ================= MENU GRID ================= -->

                <div class="menu-grid">

                    <%
                        for (Menu menu : menuList) {

                            int cartQuantity = 0;

                            if (cart != null && !cart.isEmpty()) {

                                for (CartItem cartItem : cart.getItems()) {

                                    if (cartItem.getMenu().getMenuId()
                                            == menu.getMenuId()) {

                                        cartQuantity = cartItem.getQuantity();
                                        break;
                                    }
                                }
                            }
                    %>

                        <!-- ================= MENU CARD ================= -->

                        <article class="menu-card">

                            <!-- FOOD IMAGE -->

                            <div class="menu-image-container">

                                <img
                                    class="menu-image"
                                    src="<%= menu.getImagePath() %>"
                                    alt="<%= menu.getItemName() %>"
                                    loading="lazy">

                                <div class="menu-image-overlay"></div>

                                <div class="availability-badge
                                    <%= menu.isAvailable()
                                        ? "badge-available"
                                        : "badge-unavailable" %>">

                                    <span class="availability-dot"></span>

                                    <%= menu.isAvailable()
                                        ? "Available"
                                        : "Unavailable" %>

                                </div>

                            </div>


                            <!-- MENU DETAILS -->

                            <div class="menu-content">

                                <div class="menu-title-row">

                                    <h3 class="menu-name">
                                        <%= menu.getItemName() %>
                                    </h3>

                                    <span class="menu-price">
                                        &#8377;<%= String.format("%.2f",
                                            menu.getPrice()) %>
                                    </span>

                                </div>


                                <p class="menu-description">
                                    <%= menu.getDescription() %>
                                </p>


                                <div class="menu-card-divider"></div>


                                <!-- CARD BOTTOM -->

                                <div class="menu-bottom">

                                    <%
                                        if (menu.isAvailable()) {
                                    %>

                                        <div class="availability-text available">

                                            <span class="availability-indicator"></span>

                                            <span>Available now</span>

                                        </div>


                                        <%
                                            if (cartQuantity == 0) {
                                        %>

                                            <!-- ADD TO CART -->

                                            <form
                                                class="add-cart-form"
                                                action="<%= request.getContextPath() %>/cart"
                                                method="post">

                                                <input
                                                    type="hidden"
                                                    name="action"
                                                    value="add">

                                                <input
                                                    type="hidden"
                                                    name="menuId"
                                                    value="<%= menu.getMenuId() %>">

                                                <button
                                                    type="submit"
                                                    class="add-cart-btn">

                                                    <span>+ Add</span>

                                                </button>

                                            </form>

                                        <%
                                            } else {
                                        %>

                                            <!-- QUANTITY CONTROLS -->

                                            <div class="quantity-container">

                                                <!-- MINUS -->

                                                <form
                                                    class="quantity-form"
                                                    action="<%= request.getContextPath() %>/cart"
                                                    method="post">

                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="update">

                                                    <input
                                                        type="hidden"
                                                        name="menuId"
                                                        value="<%= menu.getMenuId() %>">

                                                    <input
                                                        type="hidden"
                                                        name="source"
                                                        value="menu">

                                                    <input
                                                        type="hidden"
                                                        name="restaurantId"
                                                        value="<%= menu.getRestaurantId() %>">

                                                    <input
                                                        type="hidden"
                                                        name="quantity"
                                                        value="<%= cartQuantity - 1 %>">

                                                    <button
                                                        type="submit"
                                                        class="quantity-btn"
                                                        aria-label="Decrease quantity">

                                                        &minus;

                                                    </button>

                                                </form>


                                                <!-- CURRENT QUANTITY -->

                                                <span class="quantity-value">
                                                    <%= cartQuantity %>
                                                </span>


                                                <!-- PLUS -->

                                                <form
                                                    class="quantity-form"
                                                    action="<%= request.getContextPath() %>/cart"
                                                    method="post">

                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="update">

                                                    <input
                                                        type="hidden"
                                                        name="menuId"
                                                        value="<%= menu.getMenuId() %>">

                                                    <input
                                                        type="hidden"
                                                        name="source"
                                                        value="menu">

                                                    <input
                                                        type="hidden"
                                                        name="restaurantId"
                                                        value="<%= menu.getRestaurantId() %>">

                                                    <input
                                                        type="hidden"
                                                        name="quantity"
                                                        value="<%= cartQuantity + 1 %>">

                                                    <button
                                                        type="submit"
                                                        class="quantity-btn"
                                                        aria-label="Increase quantity">

                                                        +

                                                    </button>

                                                </form>

                                            </div>

                                        <%
                                            }
                                        %>

                                    <%
                                        } else {
                                    %>

                                        <div class="availability-text unavailable">

                                            <span class="availability-indicator"></span>

                                            <span>Currently unavailable</span>

                                        </div>

                                        <button
                                            type="button"
                                            class="add-cart-btn disabled-btn"
                                            disabled>

                                            Unavailable

                                        </button>

                                    <%
                                        }
                                    %>

                                </div>

                            </div>

                        </article>

                    <%
                        }
                    %>

                </div>

            <%
                } else {
            %>

                <!-- ================= EMPTY MENU ================= -->

                <div class="empty-menu">

                    <div class="empty-menu-icon">

                        <svg xmlns="http://www.w3.org/2000/svg"
                             width="42"
                             height="42"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="1.6"
                             stroke-linecap="round"
                             stroke-linejoin="round">

                            <path d="M3 2v7a4 4 0 0 0 4 4h1"></path>

                            <path d="M7 2v20"></path>

                            <path d="M11 2v7a4 4 0 0 1-4 4"></path>

                            <path d="M18 2v20"></path>

                            <path d="M18 2c3 2 3 6 0 8"></path>

                        </svg>

                    </div>

                    <h3>No Menu Items Available</h3>

                    <p>
                        This restaurant currently has no menu items.
                        Please check again later.
                    </p>

                </div>

            <%
                }
            %>

        </section>

    </main>


    <!-- ================= FOOTER ================= -->

    <%@ include file="includes/footer.jsp" %>

</body>

</html>