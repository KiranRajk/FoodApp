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


@WebServlet("/signup")
public class SignupController extends HttpServlet {

    private UserDAO userDao;

    @Override
    public void init() throws ServletException {

        userDao = new UserDaoImpl();

    }

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        RequestDispatcher rd =
                req.getRequestDispatcher("signup.jsp");

        rd.forward(req, resp);

    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String confirmPassword = req.getParameter("confirmPassword");

        /*
         * Basic validation
         */
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || address == null || address.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {

            req.setAttribute(
                    "signupError",
                    "Please fill in all the required fields."
            );

            RequestDispatcher rd =
                    req.getRequestDispatcher("signup.jsp");

            rd.forward(req, resp);

            return;
        }

        /*
         * Check whether the email already exists
         */
        User existingUser =
                userDao.getUserByEmail(email.trim());

        if (existingUser != null) {

            req.setAttribute(
                    "signupError",
                    "An account with this email already exists."
            );

            RequestDispatcher rd =
                    req.getRequestDispatcher("signup.jsp");

            rd.forward(req, resp);

            return;
        }

        /*
         * Validate password confirmation
         */
        if (!password.equals(confirmPassword)) {

            req.setAttribute(
                    "signupError",
                    "Passwords do not match."
            );

            RequestDispatcher rd =
                    req.getRequestDispatcher("signup.jsp");

            rd.forward(req, resp);

            return;
        }

        /*
         * Create new User object
         */
        User user = new User();

        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPhone(phone.trim());
        
        String en_password = BCrypt.hashpw(password, BCrypt.gensalt());
        
        user.setPassword(en_password);
        
        user.setAddress(address.trim());
        user.setRole("customer");

        /*
         * Save user in database
         */
        userDao.addUser(user);

        /*
         * Registration successful
         */
        
        HttpSession session = req.getSession();

        session.setAttribute("loggedInUser", user);

        resp.sendRedirect(
                req.getContextPath() + "/restaurant"
        );
        
//        resp.sendRedirect(
//                req.getContextPath()
//                        + "/login?signup=success"
//        );
    }

}