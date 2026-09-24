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

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

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
        User loggedInUser =
                (User) session.getAttribute("user");

        /*
         * ADMIN only
         */
        if (!"ADMIN".equalsIgnoreCase(
                loggedInUser.getRole())) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/UserDashboardServlet"
            );

            return;
        }

        /*
         * Dashboard statistics
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
         * Open Admin Dashboard
         */
        request.getRequestDispatcher(
                "/jsp/adminDashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}