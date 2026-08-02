package com.vaishnavi.controller;

import com.vaishnavi.dao.JobHistoryDAO;
import com.vaishnavi.model.JobHistory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<JobHistory> historyList = historyDAO.getAllHistory();

        request.setAttribute("historyList", historyList);

        request.getRequestDispatcher("/jsp/jobHistory.jsp")
                .forward(request, response);

    }
}