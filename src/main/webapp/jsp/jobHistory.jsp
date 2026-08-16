<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.vaishnavi.model.JobHistory" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");

    if (loggedUser == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    String userRole = loggedUser.getRole();

    List<JobHistory> historyList =
            (List<JobHistory>) request.getAttribute("historyList");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Job History</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2>
            <i class="bi bi-clock-history"></i>
            Job Execution History
        </h2>

        <!-- Role Based Dashboard -->

        <% if ("ADMIN".equalsIgnoreCase(userRole)) { %>

            <a href="<%=request.getContextPath()%>/AdminDashboardServlet"
               class="btn btn-primary">

                <i class="bi bi-speedometer2"></i>
                Dashboard

            </a>

        <% } else { %>

            <a href="<%=request.getContextPath()%>/UserDashboardServlet"
               class="btn btn-primary">

                <i class="bi bi-speedometer2"></i>
                Dashboard

            </a>

        <% } %>

    </div>


    <!-- History Table -->

    <div class="card shadow">

        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-bordered table-striped table-hover mb-0">

                    <thead class="table-dark">

                    <tr>

                        <th>History ID</th>
                        <th>Job ID</th>
                        <th>Job Name</th>
                        <th>Execution Time</th>
                        <th>Status</th>
                        <th>Result</th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                        if (historyList != null && !historyList.isEmpty()) {

                            for (JobHistory history : historyList) {
                    %>

                    <tr>

                        <td>
                            <%= history.getHistoryId() %>
                        </td>

                        <td>
                            <%= history.getJobId() %>
                        </td>

                        <td>
                            <%= history.getJobName() %>
                        </td>

                        <td>
                            <%= history.getExecutionTime() %>
                        </td>

                        <td>

                            <% if ("Completed".equalsIgnoreCase(history.getStatus())) { %>

                                <span class="badge bg-success">
                                    <%= history.getStatus() %>
                                </span>

                            <% } else if ("Failed".equalsIgnoreCase(history.getStatus())) { %>

                                <span class="badge bg-danger">
                                    <%= history.getStatus() %>
                                </span>

                            <% } else { %>

                                <span class="badge bg-warning text-dark">
                                    <%= history.getStatus() %>
                                </span>

                            <% } %>

                        </td>

                        <td>
                            <%= history.getResult() %>
                        </td>

                    </tr>

                    <%
                            }

                        } else {
                    %>

                    <tr>

                        <td colspan="6"
                            class="text-center text-muted">

                            No Job History Available

                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

        </div>

    </div>


    <!-- Back to Jobs -->

    <div class="mt-3">

        <a href="<%=request.getContextPath()%>/JobServlet"
           class="btn btn-secondary">

            <i class="bi bi-briefcase"></i>
            Back to Jobs

        </a>

    </div>

</div>

</body>

</html>