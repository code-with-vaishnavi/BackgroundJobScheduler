package com.vaishnavi.controller;

import com.vaishnavi.dao.JobDAO;
import com.vaishnavi.dao.UserDAO;

import com.vaishnavi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/UserDashboardServlet")
public class UserDashboardServlet extends HttpServlet {

    private UserDAO userDAO;
    private JobDAO jobDAO;

    @Override
    public void init() {

        userDAO = new UserDAO();
        jobDAO = new JobDAO();

    }

    @Override
    protected void doGet(
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
         * Check active session
         */
        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/jsp/login.jsp"
            );

            return;
        }

        /*
         * Get logged-in user
         */
        User loggedUser =
                (User) session.getAttribute("user");

        /*
         * Only USER accounts should access
         * the User Dashboard.
         */
        if (!"USER".equalsIgnoreCase(
                loggedUser.getRole())) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/AdminDashboardServlet"
            );

            return;
        }

        /*
         * Load dashboard statistics
         */
        request.setAttribute(
                "totalUsers",
                userDAO.getTotalUsers()
        );

        request.setAttribute(
                "totalJobs",
                jobDAO.getTotalJobs()
        );

        request.setAttribute(
                "pendingJobs",
                jobDAO.getPendingJobs()
        );

        request.setAttribute(
                "completedJobs",
                jobDAO.getCompletedJobs()
        );

        request.setAttribute(
                "failedJobs",
                jobDAO.getFailedJobs()
        );

        /*
         * Open User Dashboard
         */
        request.getRequestDispatcher(
                "/jsp/userDashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}