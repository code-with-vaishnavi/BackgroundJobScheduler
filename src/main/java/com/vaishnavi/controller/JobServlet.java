package com.vaishnavi.controller;

import com.vaishnavi.dao.JobDAO;
import com.vaishnavi.dao.JobHistoryDAO;
import com.vaishnavi.model.Job;
import com.vaishnavi.model.JobHistory;
import com.vaishnavi.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/JobServlet")
public class JobServlet extends HttpServlet {

    private JobDAO jobDAO;
    private JobHistoryDAO historyDAO;


    // ==================================================
    // INIT
    // ==================================================

    @Override
    public void init() {

        jobDAO = new JobDAO();
        historyDAO = new JobHistoryDAO();
    }


    // ==================================================
    // GET
    // ==================================================

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);


        // ==================================================
        // USER MUST BE LOGGED IN
        // ==================================================

        if (session == null
                || session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/jsp/login.jsp"
            );

            return;
        }


        User loggedUser =
                (User) session.getAttribute("user");

        String role =
                loggedUser.getRole();

        String action =
                request.getParameter("action");


        // ==================================================
        // VIEW JOBS
        // ==================================================

        if (action == null) {

            List<Job> jobList;


            // ADMIN → ALL JOBS
            if ("ADMIN".equalsIgnoreCase(role)) {

                jobList = jobDAO.getAllJobs();

            }

            // USER → ONLY THEIR JOBS
            else {

                jobList =
                        jobDAO.getJobsByUserId(
                                loggedUser.getUserId()
                        );
            }


            request.setAttribute(
                    "jobList",
                    jobList
            );


            request.getRequestDispatcher(
                    "/jsp/jobs.jsp"
            ).forward(request, response);
        }


        // ==================================================
        // EDIT JOB
        // ==================================================

        else if (action.equals("edit")) {

            int jobId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            Job job =
                    jobDAO.getJobById(jobId);


            if (job == null) {

                response.getWriter().println(
                        "Job not found."
                );

                return;
            }


            // USER CAN EDIT ONLY THEIR OWN JOB

            if (!"ADMIN".equalsIgnoreCase(role)
                    && job.getUserId()
                    != loggedUser.getUserId()) {

                response.getWriter().println(
                        "Access Denied: You can edit only your own jobs."
                );

                return;
            }


            request.setAttribute(
                    "job",
                    job
            );


            request.getRequestDispatcher(
                    "/jsp/editJob.jsp"
            ).forward(request, response);
        }


        // ==================================================
        // DELETE JOB
        // ==================================================

        else if (action.equals("delete")) {

            int jobId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            Job job =
                    jobDAO.getJobById(jobId);


            if (job == null) {

                response.getWriter().println(
                        "Job not found."
                );

                return;
            }


            // USER CAN DELETE ONLY THEIR OWN JOB

            if (!"ADMIN".equalsIgnoreCase(role)
                    && job.getUserId()
                    != loggedUser.getUserId()) {

                response.getWriter().println(
                        "Access Denied: You can delete only your own jobs."
                );

                return;
            }


            jobDAO.deleteJob(jobId);


            response.sendRedirect(
                    request.getContextPath()
                            + "/JobServlet"
            );
        }


        // ==================================================
        // RUN JOB
        // ==================================================

        else if (action.equals("run")) {

            int jobId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            // ==================================================
            // GET JOB
            // ==================================================

            Job job =
                    jobDAO.getJobById(jobId);


            if (job == null) {

                response.getWriter().println(
                        "Job not found."
                );

                return;
            }


            // ==================================================
            // USER CAN RUN ONLY THEIR OWN JOB
            // ADMIN CAN RUN ANY JOB
            // ==================================================

            if (!"ADMIN".equalsIgnoreCase(role)
                    && job.getUserId()
                    != loggedUser.getUserId()) {

                response.getWriter().println(
                        "Access Denied: You can run only your own jobs."
                );

                return;
            }


            // ==================================================
            // ONLY PENDING JOB CAN RUN
            // ==================================================

            if (!"Pending".equalsIgnoreCase(
                    job.getExecutionStatus())) {

                response.getWriter().println(
                        "Only Pending jobs can be executed."
                );

                return;
            }


            // ==================================================
            // CHANGE STATUS → RUNNING
            // ==================================================

            jobDAO.updateExecutionStatus(
                    jobId,
                    "Running"
            );


            // ==================================================
            // SIMULATE JOB EXECUTION
            // ==================================================

            try {

                Thread.sleep(2000);

            } catch (InterruptedException e) {

                Thread.currentThread().interrupt();


                // ==================================================
                // CHANGE STATUS → FAILED
                // ==================================================

                jobDAO.updateExecutionStatus(
                        jobId,
                        "Failed"
                );


                // ==================================================
                // SAVE FAILED HISTORY
                // ==================================================

                JobHistory history =
                        new JobHistory();

                history.setJobId(
                        job.getJobId()
                );

                history.setJobName(
                        job.getJobName()
                );

                history.setExecutionTime(
                        new Timestamp(
                                System.currentTimeMillis()
                        )
                );

                history.setStatus(
                        "Failed"
                );

                history.setResult(
                        "Job execution interrupted."
                );


                historyDAO.addHistory(history);


                response.sendRedirect(
                        request.getContextPath()
                                + "/JobServlet"
                );

                return;
            }


            // ==================================================
            // CHANGE STATUS → COMPLETED
            // ==================================================

            jobDAO.updateExecutionStatus(
                    jobId,
                    "Completed"
            );


            // ==================================================
            // SAVE SUCCESSFUL JOB HISTORY
            // ==================================================

            JobHistory history =
                    new JobHistory();


            history.setJobId(
                    job.getJobId()
            );


            history.setJobName(
                    job.getJobName()
            );


            history.setExecutionTime(
                    new Timestamp(
                            System.currentTimeMillis()
                    )
            );


            history.setStatus(
                    "Completed"
            );


            history.setResult(
                    "Success"
            );


            // INSERT HISTORY INTO DATABASE

            historyDAO.addHistory(history);


            // ==================================================
            // BACK TO JOB LIST
            // ==================================================

            response.sendRedirect(
                    request.getContextPath()
                            + "/JobServlet"
            );
        }
    }


    // ==================================================
    // POST
    // ==================================================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // ==================================================
        // USER MUST BE LOGGED IN
        // ==================================================

        if (session == null
                || session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/jsp/login.jsp"
            );

            return;
        }


        User loggedUser =
                (User) session.getAttribute("user");


        String role =
                loggedUser.getRole();


        String action =
                request.getParameter("action");


        // ==================================================
        // ADD JOB
        // ==================================================

        if (action == null) {

            Job job = new Job();


            job.setJobName(
                    request.getParameter(
                            "jobName"
                    )
            );


            job.setJobDescription(
                    request.getParameter(
                            "jobDescription"
                    )
            );


            job.setJobType(
                    request.getParameter(
                            "jobType"
                    )
            );


            job.setJobStatus(
                    request.getParameter(
                            "jobStatus"
                    )
            );


            job.setScheduleDate(
                    java.sql.Date.valueOf(
                            request.getParameter(
                                    "scheduleDate"
                            )
                    )
            );


            String time =
                    request.getParameter(
                            "scheduleTime"
                    );


            if (time.length() == 5) {

                time += ":00";
            }


            job.setScheduleTime(
                    java.sql.Time.valueOf(time)
            );


            job.setExecutionStatus(
                    request.getParameter(
                            "executionStatus"
                    )
            );


            // ==================================================
            // SAVE LOGGED-IN USER ID
            // ==================================================

            job.setUserId(
                    loggedUser.getUserId()
            );


            boolean status =
                    jobDAO.addJob(job);


            if (status) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/JobServlet"
                );

            } else {

                response.getWriter().println(
                        "Failed to add job."
                );
            }
        }


        // ==================================================
        // UPDATE JOB
        // ==================================================

        else if (action.equals("update")) {

            int jobId =
                    Integer.parseInt(
                            request.getParameter(
                                    "jobId"
                            )
                    );


            // ==================================================
            // GET EXISTING JOB
            // ==================================================

            Job existingJob =
                    jobDAO.getJobById(jobId);


            if (existingJob == null) {

                response.getWriter().println(
                        "Job not found."
                );

                return;
            }


            // ==================================================
            // USER CAN UPDATE ONLY OWN JOB
            // ADMIN CAN UPDATE ANY JOB
            // ==================================================

            if (!"ADMIN".equalsIgnoreCase(role)
                    && existingJob.getUserId()
                    != loggedUser.getUserId()) {

                response.getWriter().println(
                        "Access Denied: You can update only your own jobs."
                );

                return;
            }


            Job job = new Job();


            job.setJobId(jobId);


            job.setJobName(
                    request.getParameter(
                            "jobName"
                    )
            );


            job.setJobDescription(
                    request.getParameter(
                            "jobDescription"
                    )
            );


            job.setJobType(
                    request.getParameter(
                            "jobType"
                    )
            );


            job.setJobStatus(
                    request.getParameter(
                            "jobStatus"
                    )
            );


            job.setScheduleDate(
                    java.sql.Date.valueOf(
                            request.getParameter(
                                    "scheduleDate"
                            )
                    )
            );


            String time =
                    request.getParameter(
                            "scheduleTime"
                    );


            if (time.length() == 5) {

                time += ":00";
            }


            job.setScheduleTime(
                    java.sql.Time.valueOf(time)
            );


            job.setExecutionStatus(
                    request.getParameter(
                            "executionStatus"
                    )
            );


            // ==================================================
            // KEEP ORIGINAL OWNER
            // ==================================================

            job.setUserId(
                    existingJob.getUserId()
            );


            boolean status =
                    jobDAO.updateJob(job);


            if (status) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/JobServlet"
                );

            } else {

                response.getWriter().println(
                        "Failed to update job."
                );
            }
        }
    }
}