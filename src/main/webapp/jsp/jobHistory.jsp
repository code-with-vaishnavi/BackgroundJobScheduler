<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.vaishnavi.model.JobHistory" %>

<!DOCTYPE html>
<html>

<head>

    <title>Job History</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<div class="container mt-5">

    <h2 class="text-center mb-4">
        Job Execution History
    </h2>

    <table class="table table-bordered table-striped table-hover">

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

            List<JobHistory> historyList =
                    (List<JobHistory>) request.getAttribute("historyList");

            if(historyList != null){

                for(JobHistory history : historyList){

        %>

        <tr>

            <td><%= history.getHistoryId() %></td>

            <td><%= history.getJobId() %></td>

            <td><%= history.getJobName() %></td>

            <td><%= history.getExecutionTime() %></td>

            <td>

                <span class="badge bg-success">

                    <%= history.getStatus() %>

                </span>

            </td>

            <td>

                <%= history.getResult() %>

            </td>

        </tr>

        <%

                }

            }

        %>

        </tbody>

    </table>

    <a href="<%=request.getContextPath()%>/DashboardServlet"
       class="btn btn-primary">

        Back to Dashboard

    </a>

</div>

</body>

</html>