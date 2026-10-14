<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodApp - Login</title>

    <!-- Shared CSS -->
    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/common.css">
     
    <link rel="stylesheet"
    	href="<%= request.getContextPath() %>/css/auth.css">

    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/navbar.css">

    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/footer.css">

    <!-- Login CSS -->
    <link rel="stylesheet"
        href="<%= request.getContextPath() %>/css/login.css">
</head>

<body>

    <!-- Shared Navbar -->
    <jsp:include page="/includes/auth-navbar.jsp" />

    <main class="login-container">

        <section class="login-card">

            <div class="login-icon">
                &#128722;
            </div>

            <span class="welcome-label">WELCOME BACK</span>

            <h1>Sign in to FoodApp</h1>

            <p class="login-description">
                Your favourite meals are just a few clicks away.
            </p>

            <!-- Login Error Message -->
            <%
                if (request.getAttribute("loginError") != null) {
            %>

                <div class="error-message" role="alert">
                    <span class="error-icon">&#9888;</span>

                    <span>
                        <%= request.getAttribute("loginError") %>
                    </span>
                </div>

            <%
                }
            %>

            <!-- Existing Login Form -->
            <form
                action="<%= request.getContextPath() %>/login"
                method="post">

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

                    <label for="password">Password</label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required>

                </div>

                <button type="submit" class="login-btn">
                    Login
                    <span class="button-arrow">&#8594;</span>
                </button>

            </form>

            <div class="register-link">
                Don't have an account?

                <a href="<%= request.getContextPath() %>/signup">
                    Register
                </a>
            </div>

            <div class="login-divider">
                <span>FOODAPP</span>
            </div>

            <p class="login-note">
                Good food. Great moments. Delivered with love.
            </p>

        </section>

    </main>

    <!-- Shared Footer -->
    <jsp:include page="/includes/auth-footer.jsp" />

</body>
</html>