package com.vaishnavi.controller;

import com.vaishnavi.dao.JobDAO;
import com.vaishnavi.model.Job;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/JobServlet")
public class JobServlet extends HttpServlet {

    private JobDAO jobDAO;

    @Override
    public void init() {
        jobDAO = new JobDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {

            List<Job> jobList = jobDAO.getAllJobs();

            request.setAttribute("jobList", jobList);

            request.getRequestDispatcher("/jsp/jobs.jsp").forward(request, response);

        } else if (action.equals("edit")) {

            int jobId = Integer.parseInt(request.getParameter("id"));

            Job job = jobDAO.getJobById(jobId);

            request.setAttribute("job", job);

            request.getRequestDispatcher("/jsp/editJob.jsp").forward(request, response);

        } else if (action.equals("delete")) {

            int jobId = Integer.parseInt(request.getParameter("id"));

            jobDAO.deleteJob(jobId);

            response.sendRedirect(request.getContextPath() + "/JobServlet");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ================= ADD JOB =================
        if (action == null) {

            Job job = new Job();

            job.setJobName(request.getParameter("jobName"));
            job.setJobDescription(request.getParameter("jobDescription"));
            job.setJobType(request.getParameter("jobType"));
            job.setJobStatus(request.getParameter("jobStatus"));
            job.setScheduleDate(java.sql.Date.valueOf(request.getParameter("scheduleDate")));
            job.setScheduleTime(java.sql.Time.valueOf(request.getParameter("scheduleTime") + ":00"));
            job.setExecutionStatus(request.getParameter("executionStatus"));

            boolean status = jobDAO.addJob(job);

            if (status) {
                response.sendRedirect(request.getContextPath() + "/JobServlet");
            } else {
                response.getWriter().println("Failed to add job.");
            }

        }

        // ================= UPDATE JOB =================
        else if (action.equals("update")) {

            Job job = new Job();

            job.setJobId(Integer.parseInt(request.getParameter("jobId")));
            job.setJobName(request.getParameter("jobName"));
            job.setJobDescription(request.getParameter("jobDescription"));
            job.setJobType(request.getParameter("jobType"));
            job.setJobStatus(request.getParameter("jobStatus"));

            // NEW FIELDS
            job.setScheduleDate(
                    java.sql.Date.valueOf(request.getParameter("scheduleDate"))
            );

            String time = request.getParameter("scheduleTime");

            if (time.length() == 5) {   // HH:mm
                time += ":00";
            }

            job.setScheduleTime(java.sql.Time.valueOf(time));

            job.setExecutionStatus(
                    request.getParameter("executionStatus")
            );

            boolean status = jobDAO.updateJob(job);

            if (status) {

                response.sendRedirect(request.getContextPath() + "/JobServlet");

            } else {

                response.getWriter().println("Failed to update job.");

            }

        }

    }
}