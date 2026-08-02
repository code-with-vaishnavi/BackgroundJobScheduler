<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.vaishnavi.model.Job" %>

<%
    List<Job> jobList = (List<Job>) request.getAttribute("jobList");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Job Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="text-center mb-4">
        Job Management
    </h2>

    <div class="mb-3">

        <a href="<%=request.getContextPath()%>/jsp/addJob.jsp"
           class="btn btn-primary">
            + Add Job
        </a>

        <a href="<%=request.getContextPath()%>/JobHistoryServlet"
           class="btn btn-info text-white">
            Job History
        </a>

        <a href="<%=request.getContextPath()%>/DashboardServlet"
           class="btn btn-secondary">
            Dashboard
        </a>

    </div>

    <table class="table table-bordered table-hover table-striped">

        <thead class="table-dark">

        <tr>

            <th>ID</th>
            <th>Job Name</th>
            <th>Description</th>
            <th>Type</th>
            <th>Status</th>
            <th>Schedule Date</th>
            <th>Schedule Time</th>
            <th>Execution</th>
            <th>Action</th>

        </tr>

        </thead>

        <tbody>

        <%

            if(jobList != null){

                for(Job job : jobList){

        %>

        <tr>

            <td><%= job.getJobId() %></td>

            <td><%= job.getJobName() %></td>

            <td><%= job.getJobDescription() %></td>

            <td><%= job.getJobType() %></td>

            <td><%= job.getJobStatus() %></td>

            <td><%= job.getScheduleDate() %></td>

            <td><%= job.getScheduleTime() %></td>

            <td>

                <% if("Completed".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <span class="badge bg-success">
                        Completed
                    </span>

                <% } else if("Pending".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <span class="badge bg-warning text-dark">
                        Pending
                    </span>

                <% } else if("Failed".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <span class="badge bg-danger">
                        Failed
                    </span>

                <% } else { %>

                    <span class="badge bg-secondary">
                        <%= job.getExecutionStatus() %>
                    </span>

                <% } %>

            </td>

            <td>

                <% if("Pending".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <a href="<%=request.getContextPath()%>/JobServlet?action=run&id=<%=job.getJobId()%>"
                       class="btn btn-success btn-sm">
                        Run
                    </a>

                <% } %>

                <a href="<%=request.getContextPath()%>/JobServlet?action=edit&id=<%=job.getJobId()%>"
                   class="btn btn-warning btn-sm">
                    Edit
                </a>

                <a href="<%=request.getContextPath()%>/JobServlet?action=delete&id=<%=job.getJobId()%>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Delete this job?');">
                    Delete
                </a>

            </td>

        </tr>

        <%

                }

            } else {

        %>

        <tr>

            <td colspan="9" class="text-center">
                No Jobs Available
            </td>

        </tr>

        <%

            }

        %>

        </tbody>

    </table>

</div>

</body>

</html>