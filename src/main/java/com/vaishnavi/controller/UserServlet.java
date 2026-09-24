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
import java.util.List;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // ==================================================
    // ADMIN ACCESS CHECK
    // ==================================================

    private boolean isAdmin(HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return false;
        }

        User loggedInUser =
                (User) session.getAttribute("user");

        if (loggedInUser == null) {
            return false;
        }

        return "ADMIN".equalsIgnoreCase(
                loggedInUser.getRole()
        );
    }

    // ==================================================
    // NO-CACHE HEADERS
    // ==================================================

    private void setNoCacheHeaders(
            HttpServletResponse response) {

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
    }

    // ==================================================
    // ROLE VALIDATION
    // ==================================================

    private boolean isValidRole(String role) {

        return "ADMIN".equalsIgnoreCase(role)
                || "USER".equalsIgnoreCase(role);
    }

    // ==================================================
    // GET REQUEST
    // ==================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        setNoCacheHeaders(response);

        // ==================================================
        // ADMIN ONLY
        // ==================================================

        if (!isAdmin(request)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/jsp/login.jsp"
            );

            return;
        }

        String action =
                request.getParameter("action");

        // ==================================================
        // DELETE USER
        // ==================================================

        if ("delete".equals(action)) {

            String id =
                    request.getParameter("id");

            if (id != null) {

                try {

                    int userId =
                            Integer.parseInt(id);

                    userDAO.deleteUser(userId);

                } catch (NumberFormatException e) {

                    e.printStackTrace();
                }
            }

            response.sendRedirect(
                    request.getContextPath()
                            + "/UserServlet"
            );

            return;
        }

        // ==================================================
        // EDIT USER
        // ==================================================

        if ("edit".equals(action)) {

            String id =
                    request.getParameter("id");

            if (id != null) {

                try {

                    int userId =
                            Integer.parseInt(id);

                    User user =
                            userDAO.getUserById(userId);

                    if (user == null) {

                        response.sendRedirect(
                                request.getContextPath()
                                        + "/UserServlet"
                        );

                        return;
                    }

                    request.setAttribute(
                            "user",
                            user
                    );

                    request.getRequestDispatcher(
                            "/jsp/editUser.jsp"
                    ).forward(
                            request,
                            response
                    );

                } catch (NumberFormatException e) {

                    e.printStackTrace();

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/UserServlet"
                    );
                }

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/UserServlet"
                );
            }

            return;
        }

        // ==================================================
        // SHOW USER LIST
        // ==================================================

        List<User> userList =
                userDAO.getAllUsers();

        request.setAttribute(
                "userList",
                userList
        );

        request.getRequestDispatcher(
                "/jsp/users.jsp"
        ).forward(
                request,
                response
        );
    }

    // ==================================================
    // POST REQUEST
    // ==================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        setNoCacheHeaders(response);

        // ==================================================
        // ADMIN ONLY
        // ==================================================

        if (!isAdmin(request)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/jsp/login.jsp"
            );

            return;
        }

        String action =
                request.getParameter("action");

        // ==================================================
        // UPDATE USER
        // ==================================================

        if ("update".equals(action)) {

            String userIdParameter =
                    request.getParameter("userId");

            if (userIdParameter == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/UserServlet"
                );

                return;
            }

            try {

                int userId =
                        Integer.parseInt(
                                userIdParameter
                        );

                String fullName =
                        request.getParameter(
                                "fullName"
                        );

                String email =
                        request.getParameter(
                                "email"
                        );

                String password =
                        request.getParameter(
                                "password"
                        );

                String role =
                        request.getParameter(
                                "role"
                        );

                // ==================================================
                // VALIDATE ROLE
                // ==================================================

                if (!isValidRole(role)) {

                    response.getWriter().println(
                            "<h2>Invalid User Role!</h2>"
                    );

                    return;
                }

                User user =
                        new User();

                user.setUserId(userId);
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPassword(password);
                user.setRole(role);

                boolean status =
                        userDAO.updateUser(user);

                if (status) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/UserServlet"
                    );

                } else {

                    response.getWriter().println(
                            "<h2>User Update Failed!</h2>"
                    );
                }

            } catch (NumberFormatException e) {

                e.printStackTrace();

                response.sendRedirect(
                        request.getContextPath()
                                + "/UserServlet"
                );
            }

            return;
        }

        // ==================================================
        // ADD USER
        // ==================================================

        String fullName =
                request.getParameter(
                        "fullName"
                );

        String email =
                request.getParameter(
                        "email"
                );

        String password =
                request.getParameter(
                        "password"
                );

        String role =
                request.getParameter(
                        "role"
                );

        // ==================================================
        // VALIDATE ROLE
        // ==================================================

        if (!isValidRole(role)) {

            response.getWriter().println(
                    "<h2>Invalid User Role!</h2>"
            );

            return;
        }

        User user =
                new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean status =
                userDAO.registerUser(user);

        if (status) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/UserServlet"
            );

        } else {

            response.getWriter().println(
                    "<h2>User Registration Failed!</h2>"
            );
        }
    }
}