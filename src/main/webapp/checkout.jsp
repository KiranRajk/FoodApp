<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodApp - Checkout</title>

    <!-- Shared CSS -->
    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/common.css">

    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/navbar.css">

    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/footer.css">

    <!-- Checkout CSS -->
    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/checkout.css">
</head>

<body>

    <!-- Shared Navbar -->
    <jsp:include page="/includes/navbar.jsp" />

    <main class="checkout-container">

        <a href="<%= request.getContextPath() %>/cart"
            class="back-link">
            &#8592; Back to Cart
        </a>

        <div class="checkout-heading">
            <span class="heading-label">ALMOST THERE!</span>
            <h1>Complete Your Order</h1>
            <p>
                Add your delivery details and choose how you'd like to pay.
            </p>
        </div>

        <%
            Cart cart = (Cart) request.getAttribute("cart");
            User user = (User) request.getAttribute("user");

            if (cart != null && !cart.isEmpty()) {
        %>

        <!-- Main Checkout Form -->
        <form action="<%= request.getContextPath() %>/checkout"
            method="post">

            <input type="hidden" name="action" value="confirm">

            <div class="checkout-layout">

                <!-- LEFT COLUMN -->
                <div class="checkout-left-column">

                    <!-- DELIVERY DETAILS -->
                    <section class="checkout-card details-card">

                        <div class="card-heading">
                            <div>
                                <h2>Delivery Details</h2>
                                <p>
                                    Where should we deliver your order?
                                </p>
                            </div>

                            <span class="section-icon">&#128205;</span>
                        </div>

                        <!-- CUSTOMER NAME -->
                        <div class="form-group">
                            <label for="customerName">
                                Customer Name
                            </label>

                            <input
                                type="text"
                                id="customerName"
                                value="<%= user != null && user.getName() != null ? user.getName() : "" %>"
                                readonly>
                        </div>

                        <!-- DELIVERY ADDRESS -->
                        <div class="form-group">

                            <label for="deliveryAddress">
                                Delivery Address
                                <span class="required-mark">*</span>
                            </label>

                            <textarea
                                id="deliveryAddress"
                                name="deliveryAddress"
                                rows="4"
                                maxlength="500"
                                placeholder="House number, street, area, landmark, city and PIN code"
                                required><%= user != null && user.getAddress() != null ? user.getAddress() : "" %></textarea>

                        </div>

                        <!-- CONTACT PHONE -->
                        <div class="form-group">

                            <label for="phone">
                                Contact Phone Number
                                <span class="required-mark">*</span>
                            </label>

                            <input
                                type="tel"
                                id="phone"
                                name="phone"
                                maxlength="15"
                                placeholder="Enter your contact number"
                                autocomplete="tel"
                                value="<%= user != null && user.getPhone() != null ? user.getPhone() : "" %>"
                                required>

                            <small>
                                The delivery partner may use this number
                                to contact you.
                            </small>

                        </div>

                    </section>

                    <!-- PAYMENT DETAILS -->
                    <section class="checkout-card payment-card">

                        <div class="card-heading">
                            <div>
                                <h2>Payment Method</h2>
                                <p>
                                    Choose your preferred payment method.
                                </p>
                            </div>

                            <span class="section-icon">&#128179;</span>
                        </div>

                        <!-- PAYMENT OPTIONS -->
                        <div class="payment-options">

                            <!-- CASH ON DELIVERY -->
                            <label class="payment-option">

                                <input
                                    type="radio"
                                    name="paymentMethod"
                                    value="COD"
                                    required
                                    checked>

                                <span class="payment-option-content">

                                    <span class="payment-icon">
                                        &#128181;
                                    </span>

                                    <span class="payment-text">
                                        <strong>Cash on Delivery</strong>
                                        <small>
                                            Pay when your order arrives.
                                        </small>
                                    </span>

                                </span>

                            </label>

                            <!-- UPI -->
                            <label class="payment-option">

                                <input
                                    type="radio"
                                    name="paymentMethod"
                                    value="UPI">

                                <span class="payment-option-content">

                                    <span class="payment-icon">
                                        &#128179;
                                    </span>

                                    <span class="payment-text">
                                        <strong>UPI</strong>
                                        <small>
                                            Enter your UPI ID below.
                                        </small>
                                    </span>

                                </span>

                            </label>

                            <!-- CARD -->
                            <label class="payment-option">

                                <input
                                    type="radio"
                                    name="paymentMethod"
                                    value="Card">

                                <span class="payment-option-content">

                                    <span class="payment-icon">
                                        &#128179;
                                    </span>

                                    <span class="payment-text">
                                        <strong>Credit / Debit Card</strong>
                                        <small>
                                            Enter your card details below.
                                        </small>
                                    </span>

                                </span>

                            </label>

                        </div>

                        <!-- UPI DETAILS -->
                        <div class="payment-detail-section upi-details">

                            <h3>UPI Details</h3>

                            <div class="form-group">

                                <label for="upiId">
                                    UPI ID
                                </label>

                                <input
                                    type="text"
                                    id="upiId"
                                    name="upiId"
                                    maxlength="100"
                                    placeholder="example@upi"
                                    autocomplete="off">

                                <small>
                                    Required only when UPI is selected.
                                </small>

                            </div>

                        </div>

                        <!-- CARD DETAILS -->
                        <div class="payment-detail-section card-details">

                            <h3>Card Details</h3>

                            <div class="form-group">

                                <label for="cardHolder">
                                    Name on Card
                                </label>

                                <input
                                    type="text"
                                    id="cardHolder"
                                    name="cardHolder"
                                    maxlength="100"
                                    placeholder="Enter the name on your card"
                                    autocomplete="off">

                            </div>

                            <div class="form-group">

                                <label for="cardNumber">
                                    Card Number
                                </label>

                                <input
                                    type="text"
                                    id="cardNumber"
                                    name="cardNumber"
                                    inputmode="numeric"
                                    maxlength="19"
                                    placeholder="Enter card number"
                                    autocomplete="off">

                            </div>

                            <div class="card-extra-fields">

                                <div class="form-group">

                                    <label for="expiryDate">
                                        Expiry Date
                                    </label>

                                    <input
                                        type="text"
                                        id="expiryDate"
                                        name="expiryDate"
                                        maxlength="7"
                                        placeholder="MM/YY"
                                        autocomplete="off">

                                </div>

                                <div class="form-group">

                                    <label for="cvv">
                                        CVV
                                    </label>

                                    <input
                                        type="password"
                                        id="cvv"
                                        name="cvv"
                                        inputmode="numeric"
                                        maxlength="4"
                                        placeholder="CVV"
                                        autocomplete="off">

                                </div>

                            </div>

                            <div class="payment-warning">

                                <span>&#9432;</span>

                                <p>
                                    Card payments are simulated for this
                                    project. Do not enter real card details.
                                    Card information will not be saved
                                    in the database.
                                </p>

                            </div>

                        </div>

                        <!-- PAYMENT INFORMATION -->
                        <div class="payment-info">

                            <span>&#9432;</span>

                            <p>
                                UPI and card payments are demonstration
                                options only. No real payment will be made.
                            </p>

                        </div>

                    </section>

                    <!-- ORDER ITEMS -->
                    <section class="checkout-card items-card">

                        <div class="card-heading">

                            <div>
                                <h2>Your Order</h2>
                                <p>
                                    Review the items in your cart.
                                </p>
                            </div>

                            <span class="item-count">
                                <%= cart.getTotalQuantity() %>
                                <%= cart.getTotalQuantity() == 1
                                    ? "item" : "items" %>
                            </span>

                        </div>

                        <!-- RESTAURANT INFORMATION -->
                        <div class="restaurant-info">

                            <div class="restaurant-icon">
                                &#127860;
                            </div>

                            <div class="restaurant-details">

                                <span>ORDERING FROM</span>

                                <strong>
                                    Restaurant #<%= cart.getRestaurantId() %>
                                </strong>

                            </div>

                        </div>

                        <!-- CART ITEMS -->
                        <div class="checkout-items">

                            <%
                                for (CartItem item : cart.getItems()) {
                            %>

                            <div class="checkout-item">

                                <div class="item-image-wrapper">

                                    <img
                                        src="<%= item.getMenu().getImagePath() %>"
                                        alt="<%= item.getMenu().getItemName() %>"
                                        class="item-image">

                                </div>

                                <div class="item-details">

                                    <h3>
                                        <%= item.getMenu().getItemName() %>
                                    </h3>

                                    <p class="item-unit-price">
                                        &#8377;<%= String.format(
                                            "%.2f",
                                            item.getMenu().getPrice()
                                        ) %>
                                        each
                                    </p>

                                    <span class="item-quantity">
                                        Quantity: <%= item.getQuantity() %>
                                    </span>

                                </div>

                                <div class="item-subtotal">
                                    &#8377;<%= String.format(
                                        "%.2f",
                                        item.getSubtotal()
                                    ) %>
                                </div>

                            </div>

                            <%
                                }
                            %>

                        </div>

                        <a href="<%= request.getContextPath() %>/cart"
                            class="edit-cart-link">
                            &#8592; Edit your cart
                        </a>

                    </section>

                </div>

                <!-- RIGHT COLUMN: ORDER SUMMARY -->
                <aside class="checkout-card summary-card">

                    <h2>Order Summary</h2>

                    <p class="summary-description">
                        Review your final payment breakdown.
                    </p>

                    <div class="summary-row">

                        <span>Total Items</span>

                        <span class="summary-value">
                            <%= cart.getTotalQuantity() %>
                        </span>

                    </div>

                    <div class="summary-row">

                        <span>Subtotal</span>

                        <span class="summary-value">
                            &#8377;<%= String.format(
                                "%.2f",
                                cart.getTotalAmount()
                            ) %>
                        </span>

                    </div>

                    <div class="summary-row">

                        <span>Delivery Fee</span>

                        <span class="delivery-free">
                            FREE
                        </span>

                    </div>

                    <div class="summary-divider"></div>

                    <div class="total-row">

                        <span>Total Amount</span>

                        <span class="total-value">
                            &#8377;<%= String.format(
                                "%.2f",
                                cart.getTotalAmount()
                            ) %>
                        </span>

                    </div>

                    <button type="submit" class="confirm-btn">
                        Place Order
                        <span>&#8594;</span>
                    </button>

                    <div class="checkout-note">

                        <span class="secure-icon">&#10003;</span>

                        <p>
                            Please verify your delivery details before
                            placing your order.
                        </p>

                    </div>

                </aside>

            </div>

        </form>

        <%
            } else {
        %>

        <!-- EMPTY CHECKOUT -->
        <section class="empty-checkout">

            <div class="empty-cart-icon">
                &#128722;
            </div>

            <h2>Your Cart is Empty</h2>

            <p>
                Looks like you haven't added anything to your cart yet.
                Explore our restaurants and find something delicious!
            </p>

            <a href="<%= request.getContextPath() %>/restaurant"
                class="browse-btn">

                Browse Restaurants
                <span>&#8594;</span>

            </a>

        </section>

        <%
            }
        %>

    </main>

    <!-- Shared Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- PAYMENT METHOD JAVASCRIPT -->
    <script>

        // Show the payment fields based on the selected payment method.
        function updatePaymentFields() {

            // Get the selected payment method.
            const selectedPayment = document.querySelector(
                'input[name="paymentMethod"]:checked'
            ).value;

            // Get the UPI and card sections.
            const upiSection = document.querySelector(".upi-details");
            const cardSection = document.querySelector(".card-details");

            // Show UPI details only when UPI is selected.
            upiSection.style.display =
                selectedPayment === "UPI" ? "block" : "none";

            // Show card details only when Card is selected.
            cardSection.style.display =
                selectedPayment === "Card" ? "block" : "none";

            // Make the UPI field mandatory only for UPI.
            document.getElementById("upiId").required =
                selectedPayment === "UPI";

            // Make card fields mandatory only for card payments.
            document.getElementById("cardHolder").required =
                selectedPayment === "Card";

            document.getElementById("cardNumber").required =
                selectedPayment === "Card";

            document.getElementById("expiryDate").required =
                selectedPayment === "Card";

            document.getElementById("cvv").required =
                selectedPayment === "Card";
        }

        // Update the fields whenever the payment option changes.
        document.querySelectorAll('input[name="paymentMethod"]')
            .forEach(function (radio) {
                radio.addEventListener("change", updatePaymentFields);
            });

        // Set the correct display when checkout first opens.
        updatePaymentFields();

    </script>

</body>
</html>