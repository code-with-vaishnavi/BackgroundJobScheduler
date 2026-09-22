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

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        UserDAO dao =
                new UserDAO();

        User user =
                dao.loginUser(
                        email,
                        password
                );


        if (user != null) {

            // ==========================================
            // CREATE SESSION
            // ==========================================

            HttpSession session =
                    request.getSession();


            // ==========================================
            // STORE LOGGED-IN USER
            // ==========================================

            session.setAttribute(
                    "user",
                    user
            );


            // ==========================================
            // ROLE-BASED REDIRECT
            // ==========================================

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

            response.getWriter().println(
                    "<h2>Invalid Email or Password</h2>"
            );
        }
    }
}