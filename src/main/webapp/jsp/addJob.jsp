<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Add Job - Background Job Scheduler</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body class="bg-light">


<div class="container mt-5">

    <div class="card shadow">

        <div class="card-body">

            <h2 class="text-center mb-4">
                Add New Job
            </h2>


            <form
                    action="<%= request.getContextPath() %>/JobServlet"
                    method="post">


                <!-- JOB NAME -->

                <div class="mb-3">

                    <label class="form-label">
                        Job Name
                    </label>

                    <input
                            type="text"
                            name="jobName"
                            class="form-control"
                            placeholder="Enter job name"
                            maxlength="100"
                            required>

                </div>


                <!-- JOB DESCRIPTION -->

                <div class="mb-3">

                    <label class="form-label">
                        Job Description
                    </label>

                    <textarea
                            name="jobDescription"
                            class="form-control"
                            rows="4"
                            placeholder="Enter job description"
                            maxlength="500"
                            required></textarea>

                </div>


                <!-- JOB TYPE -->

                <div class="mb-3">

                    <label class="form-label">
                        Job Type
                    </label>

                    <input
                            type="text"
                            name="jobType"
                            class="form-control"
                            placeholder="Example: Email, Report, Backup"
                            maxlength="50"
                            required>

                </div>


                <!-- JOB STATUS -->

                <div class="mb-3">

                    <label class="form-label">
                        Job Status
                    </label>

                    <select
                            name="jobStatus"
                            class="form-select"
                            required>

                        <option value="Active">
                            Active
                        </option>

                        <option value="Inactive">
                            Inactive
                        </option>

                        <option value="Completed">
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
                            name="scheduleDate"
                            class="form-control"
                            required>

                </div>


                <!-- SCHEDULE TIME -->

                <div class="mb-3">

                    <label class="form-label">
                        Schedule Time
                    </label>

                    <input
                            type="time"
                            name="scheduleTime"
                            class="form-control"
                            required>

                </div>


                <!-- EXECUTION STATUS -->

                <div class="mb-3">

                    <label class="form-label">
                        Execution Status
                    </label>

                    <select
                            name="executionStatus"
                            class="form-select"
                            required>

                        <option value="Pending">
                            Pending
                        </option>

                        <option value="Running">
                            Running
                        </option>

                        <option value="Completed">
                            Completed
                        </option>

                        <option value="Failed">
                            Failed
                        </option>

                    </select>

                </div>


                <!-- BUTTONS -->

                <div class="d-flex gap-2">

                    <button
                            type="submit"
                            class="btn btn-primary">

                        Save Job

                    </button>


                    <a
                            href="<%= request.getContextPath() %>/JobServlet"
                            class="btn btn-secondary">

                        View Jobs

                    </a>

                </div>

            </form>

        </div>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>