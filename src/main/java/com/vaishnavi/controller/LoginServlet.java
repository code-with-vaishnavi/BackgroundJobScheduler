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
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();

        User user = dao.loginUser(email, password);

        if (user != null) {

            // Create Session
            HttpSession session = request.getSession();

            // Store logged-in user
            session.setAttribute("user", user);

            // Redirect to Dashboard
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");

        } else {

            response.getWriter().println("<h2>Invalid Email or Password</h2>");

        }

    }
}