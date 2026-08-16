<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.vaishnavi.model.Job" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    List<Job> jobList = (List<Job>) request.getAttribute("jobList");

    User loggedUser = (User) session.getAttribute("user");

    String userRole = "";

    if (loggedUser != null) {
        userRole = loggedUser.getRole();
    }

    boolean isAdmin = "ADMIN".equalsIgnoreCase(userRole);
    boolean isUser = "USER".equalsIgnoreCase(userRole);
%>

<!DOCTYPE html>
<html>

<head>

    <title>Job Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <!-- ================= HEADER ================= -->

    <h2 class="text-center mb-4">

        <% if (isAdmin) { %>

            Admin Job Management

        <% } else { %>

            My Jobs

        <% } %>

    </h2>


    <!-- ================= NAVIGATION ================= -->

    <div class="mb-3">

        <!-- ADD JOB -->

        <a href="<%=request.getContextPath()%>/jsp/addJob.jsp"
           class="btn btn-primary">

            + Add Job

        </a>


        <!-- JOB HISTORY -->

        <a href="<%=request.getContextPath()%>/JobHistoryServlet"
           class="btn btn-info text-white">

            Job History

        </a>


        <!-- DASHBOARD -->

        <% if (isAdmin) { %>

            <a href="<%=request.getContextPath()%>/AdminDashboardServlet"
               class="btn btn-dark">

                Admin Dashboard

            </a>

        <% } else { %>

            <a href="<%=request.getContextPath()%>/UserDashboardServlet"
               class="btn btn-secondary">

                My Dashboard

            </a>

        <% } %>

    </div>


    <!-- ================= JOB TABLE ================= -->

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

            if (jobList != null && !jobList.isEmpty()) {

                for (Job job : jobList) {

        %>

        <tr>

            <!-- JOB ID -->

            <td>
                <%= job.getJobId() %>
            </td>


            <!-- JOB NAME -->

            <td>
                <%= job.getJobName() %>
            </td>


            <!-- DESCRIPTION -->

            <td>
                <%= job.getJobDescription() %>
            </td>


            <!-- TYPE -->

            <td>
                <%= job.getJobType() %>
            </td>


            <!-- JOB STATUS -->

            <td>
                <%= job.getJobStatus() %>
            </td>


            <!-- SCHEDULE DATE -->

            <td>
                <%= job.getScheduleDate() %>
            </td>


            <!-- SCHEDULE TIME -->

            <td>
                <%= job.getScheduleTime() %>
            </td>


            <!-- EXECUTION STATUS -->

            <td>

                <% if ("Completed".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <span class="badge bg-success">
                        Completed
                    </span>

                <% } else if ("Pending".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <span class="badge bg-warning text-dark">
                        Pending
                    </span>

                <% } else if ("Running".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <span class="badge bg-primary">
                        Running
                    </span>

                <% } else if ("Failed".equalsIgnoreCase(job.getExecutionStatus())) { %>

                    <span class="badge bg-danger">
                        Failed
                    </span>

                <% } else { %>

                    <span class="badge bg-secondary">
                        <%= job.getExecutionStatus() %>
                    </span>

                <% } %>

            </td>


            <!-- ================= ACTION ================= -->

            <td>


                <!-- ========================================= -->
                <!-- ADMIN ACTIONS                             -->
                <!-- ========================================= -->

                <% if (isAdmin) { %>


                    <!-- RUN -->

                    <% if ("Pending".equalsIgnoreCase(job.getExecutionStatus())) { %>

                        <a href="<%=request.getContextPath()%>/JobServlet?action=run&id=<%=job.getJobId()%>"
                           class="btn btn-success btn-sm">

                            Run

                        </a>

                    <% } %>


                    <!-- EDIT -->

                    <a href="<%=request.getContextPath()%>/JobServlet?action=edit&id=<%=job.getJobId()%>"
                       class="btn btn-warning btn-sm">

                        Edit

                    </a>


                    <!-- DELETE -->

                    <a href="<%=request.getContextPath()%>/JobServlet?action=delete&id=<%=job.getJobId()%>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete this job?');">

                        Delete

                    </a>


                <% } %>


                <!-- ========================================= -->
                <!-- USER ACTIONS                              -->
                <!-- ========================================= -->

                <% if (isUser) { %>


                    <!-- USER CAN RUN OWN JOB -->

                    <% if ("Pending".equalsIgnoreCase(job.getExecutionStatus())) { %>

                        <a href="<%=request.getContextPath()%>/JobServlet?action=run&id=<%=job.getJobId()%>"
                           class="btn btn-success btn-sm">

                            Run

                        </a>

                    <% } %>


                    <!-- USER CAN EDIT OWN JOB -->

                    <a href="<%=request.getContextPath()%>/JobServlet?action=edit&id=<%=job.getJobId()%>"
                       class="btn btn-warning btn-sm">

                        Edit

                    </a>


                    <!-- USER CAN DELETE OWN JOB -->

                    <a href="<%=request.getContextPath()%>/JobServlet?action=delete&id=<%=job.getJobId()%>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete this job?');">

                        Delete

                    </a>


                <% } %>


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


    <!-- ================= USER INFORMATION ================= -->

    <% if (isUser && loggedUser != null) { %>

        <div class="alert alert-info mt-4">

            Logged in as:

            <strong>
                <%= loggedUser.getFullName() %>
            </strong>

            <span class="badge bg-primary">
                USER
            </span>

        </div>

    <% } %>


    <!-- ================= ADMIN INFORMATION ================= -->

    <% if (isAdmin && loggedUser != null) { %>

        <div class="alert alert-dark mt-4">

            Logged in as:

            <strong>
                <%= loggedUser.getFullName() %>
            </strong>

            <span class="badge bg-danger">
                ADMIN
            </span>

        </div>

    <% } %>


</div>

</body>

</html>