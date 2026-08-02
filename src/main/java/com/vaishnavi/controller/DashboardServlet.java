package com.vaishnavi.controller;

import com.vaishnavi.dao.JobDAO;
import com.vaishnavi.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    private UserDAO userDAO;
    private JobDAO jobDAO;

    @Override
    public void init() {

        userDAO = new UserDAO();
        jobDAO = new JobDAO();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("totalUsers",
                userDAO.getTotalUsers());

        request.setAttribute("totalJobs",
                jobDAO.getTotalJobs());

        request.setAttribute("pendingJobs",
                jobDAO.getPendingJobs());

        request.setAttribute("completedJobs",
                jobDAO.getCompletedJobs());

        request.setAttribute("failedJobs",
                jobDAO.getFailedJobs());

        request.getRequestDispatcher("/jsp/dashboard.jsp")
                .forward(request, response);

    }

}