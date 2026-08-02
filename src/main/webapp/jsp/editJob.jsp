<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.Job" %>

<%
    Job job = (Job) request.getAttribute("job");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Edit Job</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-warning text-dark">

            <h3>Edit Job</h3>

        </div>

        <div class="card-body">

            <form action="<%=request.getContextPath()%>/JobServlet" method="post">

                <input type="hidden" name="action" value="update">

                <input type="hidden" name="jobId" value="<%=job.getJobId()%>">

                <div class="mb-3">

                    <label class="form-label">Job Name</label>

                    <input type="text"
                           class="form-control"
                           name="jobName"
                           value="<%=job.getJobName()%>"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">Description</label>

                    <textarea class="form-control"
                              name="jobDescription"
                              rows="3"
                              required><%=job.getJobDescription()%></textarea>

                </div>

                <div class="mb-3">

                    <label class="form-label">Job Type</label>

                    <input type="text"
                           class="form-control"
                           name="jobType"
                           value="<%=job.getJobType()%>"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">Job Status</label>

                    <select class="form-select" name="jobStatus">

                        <option value="Active"
                            <%= "Active".equals(job.getJobStatus()) ? "selected" : "" %>>
                            Active
                        </option>

                        <option value="Inactive"
                            <%= "Inactive".equals(job.getJobStatus()) ? "selected" : "" %>>
                            Inactive
                        </option>

                    </select>

                </div>

                <!-- NEW -->

                <div class="mb-3">

                    <label class="form-label">Schedule Date</label>

                    <input type="date"
                           class="form-control"
                           name="scheduleDate"
                           value="<%=job.getScheduleDate()%>"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">Schedule Time</label>

                    <input type="time"
                           class="form-control"
                           name="scheduleTime"
                           value="<%=job.getScheduleTime()%>"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">Execution Status</label>

                    <select class="form-select"
                            name="executionStatus">

                        <option value="Pending"
                            <%= "Pending".equals(job.getExecutionStatus()) ? "selected" : "" %>>
                            Pending
                        </option>

                        <option value="Running"
                            <%= "Running".equals(job.getExecutionStatus()) ? "selected" : "" %>>
                            Running
                        </option>

                        <option value="Completed"
                            <%= "Completed".equals(job.getExecutionStatus()) ? "selected" : "" %>>
                            Completed
                        </option>

                        <option value="Failed"
                            <%= "Failed".equals(job.getExecutionStatus()) ? "selected" : "" %>>
                            Failed
                        </option>

                    </select>

                </div>

                <button class="btn btn-success">
                    Update Job
                </button>

                <a href="<%=request.getContextPath()%>/JobServlet"
                   class="btn btn-secondary">
                    Cancel
                </a>

            </form>

        </div>

    </div>

</div>

</body>

</html>