package com.tap.controller;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.Dao.UserDAO;
import com.tap.DaoImpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        RequestDispatcher rd =
                req.getRequestDispatcher("login.jsp");

        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO userDao = new UserDaoImpl();

        User user = userDao.getUserByEmail(email);
        
       
        
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {

            HttpSession session = req.getSession();

            session.setAttribute("loggedInUser", user);

            resp.sendRedirect(
                    req.getContextPath() + "/restaurant"
            );

        } else {

            req.setAttribute(
                    "loginError",
                    "Invalid email or password"
            );

            RequestDispatcher rd =
                    req.getRequestDispatcher("login.jsp");

            rd.forward(req, resp);
        }
    }
}