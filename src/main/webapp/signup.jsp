<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodApp - Create Account</title>

    <!-- Shared CSS -->
    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/common.css">
        
    <link rel="stylesheet"
    href="<%= request.getContextPath() %>/css/auth.css">

    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/navbar.css">

    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/footer.css">

    <!-- Signup CSS -->
    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/signup.css">
</head>

<body>

    <!-- Shared Navbar -->
    <jsp:include page="/includes/auth-navbar.jsp" />

    <main class="signup-container">

        <section class="signup-card">

            <div class="signup-icon">
                &#128722;
            </div>

            <span class="signup-label">JOIN FOODAPP</span>

            <h1>Create Your Account</h1>

            <p class="signup-description">
                Sign up and discover delicious food from your
                favourite restaurants.
            </p>

            <!-- Registration Form UI -->
            <form action="<%= request.getContextPath() %>/signup"
                method="post">

                <div class="form-group">
                    <label for="name">Full Name</label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter your full name"
                        autocomplete="name"
                        required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email"
                        autocomplete="email"
                        required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>

                    <input
                        type="tel"
                        id="phone"
                        name="phone"
                        placeholder="Enter your phone number"
                        autocomplete="tel"
                        required>
                </div>

                <div class="form-group">
                    <label for="address">Delivery Address</label>

                    <textarea
                        id="address"
                        name="address"
                        placeholder="Enter your delivery address"
                        autocomplete="street-address"
                        rows="3"
                        required></textarea>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Create a password"
                        autocomplete="new-password"
                        required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Re-enter your password"
                        autocomplete="new-password"
                        required>
                </div>

                <button type="submit" class="signup-btn">
                    Create Account
                    <span class="button-arrow">&#8594;</span>
                </button>

            </form>

            <div class="login-link">
                Already have an account?

                <a href="<%= request.getContextPath() %>/login">
                    Login
                </a>
            </div>

            <div class="signup-divider">
                <span>FOODAPP</span>
            </div>

            <p class="signup-note">
                Good food. Great moments. Delivered with love.
            </p>

        </section>

    </main>

    <!-- Shared Footer -->
    <jsp:include page="/includes/auth-footer.jsp" />

</body>
</html>