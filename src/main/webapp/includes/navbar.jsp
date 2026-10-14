<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User"%>

<nav class="navbar">
	<div class="navbar-container">

		<!-- FoodApp Logo -->
		<a href="<%=request.getContextPath()%>/restaurant" class="navbar-logo">
			<span class="logo-icon">F</span> <span>Food<span
				class="logo-highlight">App</span></span>
		</a>

		<!-- Navigation Links -->
		<div class="navbar-links">

			<a href="<%=request.getContextPath()%>/restaurant"
				class="navbar-link"> Restaurants </a> <a
				href="<%=request.getContextPath()%>/cart"
				class="navbar-link cart-link"> Cart </a> <a
				href="<%=request.getContextPath()%>/orders" class="navbar-link">
				Orders </a>

			<%
			User loggedInUser = (User) session.getAttribute("loggedInUser");

			if (loggedInUser == null) {
			%>

			<a href="<%=request.getContextPath()%>/login" class="navbar-login">
				Login </a>

			<%
			} else {
			%>

			<!-- Profile Button -->
			<a href="<%=request.getContextPath()%>/profile"
				class="navbar-profile" title="<%=loggedInUser.getName()%>"
				aria-label="My Profile"> <svg xmlns="http://www.w3.org/2000/svg"
					width="22" height="22" viewBox="0 0 24 24" fill="none"
					stroke="currentColor" stroke-width="2" stroke-linecap="round"
					stroke-linejoin="round">

            <circle cx="12" cy="8" r="4"></circle>
            <path d="M5 21v-2a7 7 0 0 1 14 0v2"></path>

        </svg>

			</a>

			<!-- Logout Button -->
			<form action="<%=request.getContextPath()%>/logout" method="get"
				class="navbar-logout-form">

				<button type="submit" class="navbar-logout" title="Logout"
					aria-label="Logout">

					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
						viewBox="0 0 24 24" fill="none" stroke="currentColor"
						stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
						aria-hidden="true">

            <path d="M10 17l5-5-5-5"></path>
            <path d="M15 12H3"></path>
            <path d="M12 3h6a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-6"></path>

        </svg>

				</button>

			</form>

			<%
			}
			%>

		</div>

	</div>
</nav>