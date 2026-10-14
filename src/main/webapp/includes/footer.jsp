<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<footer class="footer">

    <!-- Main Footer Content -->
    <div class="footer-container">

        <!-- Brand Section -->
        <div class="footer-brand">

            <a href="<%= request.getContextPath() %>/restaurant"
               class="footer-logo">

                <span class="footer-logo-icon">F</span>

                <span>
                    Food<span class="footer-logo-highlight">App</span>
                </span>

            </a>

            <p class="footer-description">
                Discover delicious food from your favourite restaurants
                and enjoy a convenient food ordering experience.
            </p>

        </div>


        <!-- Quick Links -->
        <div class="footer-section">

            <h3 class="footer-heading">Quick Links</h3>

            <ul class="footer-links">

                <li>
                    <a href="<%= request.getContextPath() %>/restaurant">
                        Restaurants
                    </a>
                </li>

                <li>
                    <a href="<%= request.getContextPath() %>/cart">
                        My Cart
                    </a>
                </li>

                <li>
                    <a href="<%= request.getContextPath() %>/orders">
                        My Orders
                    </a>
                </li>

            </ul>

        </div>


        <!-- Account Links -->
        <div class="footer-section">

            <h3 class="footer-heading">My Account</h3>

            <ul class="footer-links">

                <% if (session.getAttribute("loggedInUser") == null) { %>

                    <li>
                        <a href="<%= request.getContextPath() %>/login">
                            Login
                        </a>
                    </li>

                    <li>
                        <a href="<%= request.getContextPath() %>/signup">
                            Create Account
                        </a>
                    </li>

                <% } else { %>

                    <li>
                        <a href="<%= request.getContextPath() %>/profile">
                            My Profile
                        </a>
                    </li>

                    <li>
                        <a href="<%= request.getContextPath() %>/orders">
                            Order History
                        </a>
                    </li>

                <% } %>

            </ul>

        </div>


        <!-- Contact Section -->
        <div class="footer-section">

            <h3 class="footer-heading">Contact</h3>

            <p class="footer-contact-text">
                Have questions or feedback?
            </p>

            <a href="mailto:support@foodapp.example"
               class="footer-contact-link">
                Contact Support
            </a>

        </div>

    </div>


    <!-- Footer Bottom -->
    <div class="footer-bottom">

        <p class="footer-copyright">
            &copy; <%= java.time.Year.now().getValue() %> FoodApp.
            All rights reserved.
        </p>

        <p class="footer-tagline">
            Made with <span class="footer-heart">&hearts;</span>
            for food lovers.
        </p>

    </div>

</footer>