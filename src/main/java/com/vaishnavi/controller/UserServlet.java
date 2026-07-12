package com.vaishnavi.controller;

import com.vaishnavi.dao.UserDAO;
import com.vaishnavi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // ================= GET REQUEST =================
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Delete User
        if ("delete".equals(action)) {

            int userId = Integer.parseInt(request.getParameter("id"));

            userDAO.deleteUser(userId);

            response.sendRedirect("UserServlet");
            return;
        }

        // Edit User
        if ("edit".equals(action)) {

            int userId = Integer.parseInt(request.getParameter("id"));

            User user = userDAO.getUserById(userId);

            request.setAttribute("user", user);

            request.getRequestDispatcher("jsp/editUser.jsp")
                    .forward(request, response);

            return;
        }

        // Show User List
        List<User> userList = userDAO.getAllUsers();

        request.setAttribute("userList", userList);

        request.getRequestDispatcher("jsp/users.jsp")
                .forward(request, response);
    }

    // ================= POST REQUEST =================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ================= UPDATE USER =================

        if ("update".equals(action)) {

            int userId = Integer.parseInt(request.getParameter("userId"));

            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User user = new User();

            user.setUserId(userId);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean status = userDAO.updateUser(user);

            if (status) {

                response.sendRedirect("UserServlet");

            } else {

                response.getWriter().println("<h2>User Update Failed!</h2>");

            }

            return;
        }

        // ================= ADD USER =================

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean status = userDAO.registerUser(user);

        if (status) {

            response.sendRedirect("UserServlet");

        } else {

            response.getWriter().println("<h2>User Registration Failed!</h2>");

        }

    }

}