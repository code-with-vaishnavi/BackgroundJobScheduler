package com.vaishnavi.controller;

import com.vaishnavi.dao.UserDAO;
import com.vaishnavi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Prevent browser caching
         */
        response.setHeader(
                "Cache-Control",
                "no-cache, no-store, must-revalidate"
        );

        response.setHeader(
                "Pragma",
                "no-cache"
        );

        response.setDateHeader(
                "Expires",
                0
        );

        /*
         * Get login credentials
         */
        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        /*
         * Basic validation
         */
        if (email == null
                || email.trim().isEmpty()
                || password == null
                || password.isEmpty()) {

            response.getWriter().println(
                    "<h2>Email and Password are required.</h2>"
            );

            return;
        }

        /*
         * Authenticate user
         */
        UserDAO dao =
                new UserDAO();

        User user =
                dao.loginUser(
                        email.trim(),
                        password
                );

        /*
         * Login successful
         */
        if (user != null) {

            /*
             * Invalidate any existing session
             * before creating a new authenticated session.
             */
            HttpSession oldSession =
                    request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            /*
             * Create fresh authenticated session
             */
            HttpSession session =
                    request.getSession(true);

            /*
             * Store logged-in user
             */
            session.setAttribute(
                    "user",
                    user
            );

            /*
             * Role-based redirect
             */
            if ("ADMIN".equalsIgnoreCase(
                    user.getRole()
            )) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/AdminDashboardServlet"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/UserDashboardServlet"
                );
            }

        } else {

            /*
             * Invalid credentials
             */
            response.getWriter().println(
                    "<h2>Invalid Email or Password</h2>"
            );
        }
    }
}