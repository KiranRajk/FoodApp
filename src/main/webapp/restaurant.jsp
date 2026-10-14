<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodApp - Restaurants</title>

    <!-- Common CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">

    <!-- Navbar CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/navbar.css">

    <!-- Footer CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/footer.css">

    <!-- Restaurant Page CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/restaurant.css">
</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <%@ include file="includes/navbar.jsp" %>


    <!-- ================= HERO SECTION ================= -->

    <section class="restaurant-hero">

        <div class="restaurant-hero-content">

            <span class="hero-badge">
                GOOD FOOD, GOOD MOOD
            </span>

            <h1>
                Delicious food,<br>
                <span>delivered to you.</span>
            </h1>

            <p class="hero-description">
                Discover amazing restaurants, explore your favourite
                cuisines, and find something delicious for every craving.
            </p>

            <div class="hero-highlights">

                <span>
                    <span class="highlight-dot"></span>
                    Explore Restaurants
                </span>

                <span>
                    <span class="highlight-dot"></span>
                    Discover Cuisines
                </span>

                <span>
                    <span class="highlight-dot"></span>
                    Order Your Favourites
                </span>

            </div>

        </div>

        <div class="hero-decoration hero-decoration-one"></div>

        <div class="hero-decoration hero-decoration-two"></div>

    </section>


    <!-- ================= RESTAURANT SECTION ================= -->

    <main class="restaurant-main">

        <section class="restaurant-section">

            <div class="restaurant-section-header">

                <div>

                    <span class="section-eyebrow">
                        YOUR NEXT FAVOURITE MEAL
                    </span>

                    <h2>Explore Restaurants</h2>

                    <p>
                        Discover delicious food from our partner restaurants.
                    </p>

                </div>

                <div class="restaurant-count">

                    <span class="count-number">
                        <%
                            List<Restaurant> restaurants =
                                (List<Restaurant>) request.getAttribute("restaurants");

                            if (restaurants != null) {
                                out.print(restaurants.size());
                            } else {
                                out.print(0);
                            }
                        %>
                    </span>

                    <span class="count-label">
                        Restaurants
                    </span>

                </div>

            </div>


            <!-- ================= RESTAURANT CARDS ================= -->

            <div class="restaurant-grid">

                <%
                    if (restaurants != null && !restaurants.isEmpty()) {

                        for (Restaurant restaurant : restaurants) {
                %>

                    <article class="restaurant-card">

                        <!-- Restaurant Image -->

                        <div class="restaurant-image-container">

                            <img
                                class="restaurant-image"
                                src="<%= restaurant.getImagePath() %>"
                                alt="<%= restaurant.getName() %>"
                                loading="lazy">

                            <div class="restaurant-image-overlay"></div>

                            <!-- Restaurant Rating -->

                            <div class="restaurant-rating">

                                <span class="rating-star">
                                    &#9733;
                                </span>

                                <span>
                                    <%= String.format("%.1f", restaurant.getRating()) %>
                                </span>

                            </div>

                            <!-- Restaurant Availability -->

                            <div class="restaurant-status
                                <%= restaurant.isActive() ? "status-open" : "status-closed" %>">

                                <span class="status-dot"></span>

                                <%= restaurant.isActive() ? "Open" : "Closed" %>

                            </div>

                        </div>


                        <!-- Restaurant Details -->

                        <div class="restaurant-info">

                            <h3 class="restaurant-name">
                                <%= restaurant.getName() %>
                            </h3>

                            <p class="restaurant-cuisine">
                                <%= restaurant.getCuisineType() %>
                            </p>


                            <!-- Delivery Time -->

                            <div class="restaurant-details">

                                <div class="detail-item">

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

                                        <path d="M12 6v6l4 2"></path>

                                    </svg>

                                    <span>
                                        <%= restaurant.getDeliveryTime() %> mins
                                    </span>

                                </div>


                                <div class="detail-divider"></div>


                                <!-- Restaurant Address -->

                                <div class="detail-item restaurant-address">

                                    <svg xmlns="http://www.w3.org/2000/svg"
                                         width="17"
                                         height="17"
                                         viewBox="0 0 24 24"
                                         fill="none"
                                         stroke="currentColor"
                                         stroke-width="1.8"
                                         stroke-linecap="round"
                                         stroke-linejoin="round">

                                        <path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z"></path>

                                        <circle cx="12" cy="10" r="2.5"></circle>

                                    </svg>

                                    <span title="<%= restaurant.getAddress() %>">
                                        <%= restaurant.getAddress() %>
                                    </span>

                                </div>

                            </div>


                            <!-- View Menu -->

                            <a
                                href="<%= request.getContextPath() %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
                                class="view-menu-btn">

                                <span>Explore Menu</span>

                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="18"
                                     height="18"
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

                        </div>

                    </article>

                <%
                        }

                    } else {
                %>

                    <!-- No Restaurants Available -->

                    <div class="empty-restaurants">

                        <div class="empty-icon">

                            <svg xmlns="http://www.w3.org/2000/svg"
                                 width="36"
                                 height="36"
                                 viewBox="0 0 24 24"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="1.5"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <path d="M3 2v7a4 4 0 0 0 4 4h1"></path>

                                <path d="M7 2v20"></path>

                                <path d="M11 2v7a4 4 0 0 1-4 4"></path>

                                <path d="M18 2v20"></path>

                                <path d="M18 2c3 2 3 6 0 8"></path>

                            </svg>

                        </div>

                        <h3>No Restaurants Available</h3>

                        <p>
                            There are currently no restaurants to display.
                            Please check again later.
                        </p>

                    </div>

                <%
                    }
                %>

            </div>

        </section>

    </main>


    <!-- ================= FOOTER ================= -->

    <%@ include file="includes/footer.jsp" %>

</body>

</html>