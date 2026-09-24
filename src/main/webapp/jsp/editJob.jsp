<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.Job" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    // ==================================================
    // CHECK LOGIN SESSION
    // ==================================================

    User loggedUser =
            (User) session.getAttribute("user");

    if (loggedUser == null) {

        response.sendRedirect(
                request.getContextPath()
                        + "/jsp/login.jsp"
        );

        return;
    }


    // ==================================================
    // ROLE CHECK
    // ==================================================

    String role =
            loggedUser.getRole();

    if (!"USER".equalsIgnoreCase(role)
            && !"ADMIN".equalsIgnoreCase(role)) {

        response.sendRedirect(
                request.getContextPath()
                        + "/jsp/login.jsp"
        );

        return;
    }


    // ==================================================
    // PREVENT BROWSER CACHE
    // ==================================================

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


    // ==================================================
    // GET JOB
    // ==================================================

    Job job =
            (Job) request.getAttribute("job");

    if (job == null) {

        response.sendRedirect(
                request.getContextPath()
                        + "/JobServlet"
        );

        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit Job - Background Job Scheduler</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body class="bg-light">


<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-warning text-dark">

            <h3 class="mb-0">
                Edit Job
            </h3>

        </div>


        <div class="card-body">

            <form
                    action="<%= request.getContextPath() %>/JobServlet"
                    method="post">

                <!-- ACTION -->

                <input
                        type="hidden"
                        name="action"
                        value="update">


                <!-- JOB ID -->

                <input
                        type="hidden"
                        name="jobId"
                        value="<%= job.getJobId() %>">


                <!-- JOB NAME -->

                <div class="mb-3">

                    <label class="form-label">
                        Job Name
                    </label>

                    <input
                            type="text"
                            class="form-control"
                            name="jobName"
                            value="<%= job.getJobName() %>"
                            maxlength="100"
                            required>

                </div>


                <!-- DESCRIPTION -->

                <div class="mb-3">

                    <label class="form-label">
                        Description
                    </label>

                    <textarea
                            class="form-control"
                            name="jobDescription"
                            rows="4"
                            maxlength="500"
                            required><%= job.getJobDescription() %></textarea>

                </div>


                <!-- JOB TYPE -->

                <div class="mb-3">

                    <label class="form-label">
                        Job Type
                    </label>

                    <input
                            type="text"
                            class="form-control"
                            name="jobType"
                            value="<%= job.getJobType() %>"
                            maxlength="50"
                            required>

                </div>


                <!-- JOB STATUS -->

                <div class="mb-3">

                    <label class="form-label">
                        Job Status
                    </label>

                    <select
                            class="form-select"
                            name="jobStatus"
                            required>

                        <option
                                value="Active"
                            <%= "Active".equals(job.getJobStatus())
                                    ? "selected" : "" %>>

                            Active

                        </option>

                        <option
                                value="Inactive"
                            <%= "Inactive".equals(job.getJobStatus())
                                    ? "selected" : "" %>>

                            Inactive

                        </option>

                        <option
                                value="Completed"
                            <%= "Completed".equals(job.getJobStatus())
                                    ? "selected" : "" %>>

                            Completed

                        </option>

                    </select>

                </div>


                <!-- SCHEDULE DATE -->

                <div class="mb-3">

                    <label class="form-label">
                        Schedule Date
                    </label>

                    <input
                            type="date"
                            class="form-control"
                            name="scheduleDate"
                            value="<%= job.getScheduleDate() %>"
                            required>

                </div>


                <!-- SCHEDULE TIME -->

                <div class="mb-3">

                    <label class="form-label">
                        Schedule Time
                    </label>

                    <input
                            type="time"
                            class="form-control"
                            name="scheduleTime"
                            value="<%= job.getScheduleTime() %>"
                            required>

                </div>


                <!-- EXECUTION STATUS -->

                <div class="mb-3">

                    <label class="form-label">
                        Execution Status
                    </label>

                    <select
                            class="form-select"
                            name="executionStatus"
                            required>

                        <option
                                value="Pending"
                            <%= "Pending".equals(job.getExecutionStatus())
                                    ? "selected" : "" %>>

                            Pending

                        </option>

                        <option
                                value="Running"
                            <%= "Running".equals(job.getExecutionStatus())
                                    ? "selected" : "" %>>

                            Running

                        </option>

                        <option
                                value="Completed"
                            <%= "Completed".equals(job.getExecutionStatus())
                                    ? "selected" : "" %>>

                            Completed

                        </option>

                        <option
                                value="Failed"
                            <%= "Failed".equals(job.getExecutionStatus())
                                    ? "selected" : "" %>>

                            Failed

                        </option>

                    </select>

                </div>


                <!-- BUTTONS -->

                <button
                        type="submit"
                        class="btn btn-success">

                    <i class="bi bi-check-circle"></i>

                    Update Job

                </button>


                <a
                        href="<%= request.getContextPath() %>/JobServlet"
                        class="btn btn-secondary">

                    <i class="bi bi-arrow-left"></i>

                    Cancel

                </a>

            </form>

        </div>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>