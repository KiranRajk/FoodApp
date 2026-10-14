<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<header class="auth-navbar">

    <div class="auth-navbar-inner">

        <a href="<%= request.getContextPath() %>/restaurant"
            class="auth-logo">

            <span class="auth-logo-icon">F</span>

            <span class="auth-logo-text">
                Food<span>App</span>
            </span>

        </a>

        <div class="auth-nav-right">

            <a href="<%= request.getContextPath() %>/restaurant"
                class="auth-nav-link">

                &#8592; Back to Restaurants

            </a>

        </div>

    </div>

</header>