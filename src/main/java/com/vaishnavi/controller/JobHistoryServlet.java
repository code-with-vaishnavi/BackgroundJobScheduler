package com.vaishnavi.controller;

import com.vaishnavi.dao.JobHistoryDAO;
import com.vaishnavi.model.JobHistory;
import com.vaishnavi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/JobHistoryServlet")
public class JobHistoryServlet extends HttpServlet {

    private JobHistoryDAO historyDAO;

    @Override
    public void init() {
        historyDAO = new JobHistoryDAO();
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
         * Get user role
         */
        String role =
                loggedUser.getRole();

        /*
         * Currently Job History is available
         * only to ADMIN users.
         */
        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/UserDashboardServlet"
            );

            return;
        }

        /*
         * Get all job execution history
         */
        List<JobHistory> historyList =
                historyDAO.getAllHistory();

        request.setAttribute(
                "historyList",
                historyList
        );

        /*
         * Open Job History JSP
         */
        request.getRequestDispatcher(
                "/jsp/jobHistory.jsp"
        ).forward(
                request,
                response
        );
    }
}