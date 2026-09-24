<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.vaishnavi.model.JobHistory" %>
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
    // ADMIN ONLY
    // ==================================================

    String userRole =
            loggedUser.getRole();

    if (!"ADMIN".equalsIgnoreCase(userRole)) {

        response.sendRedirect(
                request.getContextPath()
                        + "/UserDashboardServlet"
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
    // GET HISTORY LIST
    // ==================================================

    List<JobHistory> historyList =
            (List<JobHistory>) request.getAttribute(
                    "historyList"
            );
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Job History - Background Job Scheduler</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
            rel="stylesheet">

</head>

<body class="bg-light">


<div class="container mt-5">


    <!-- ==================================================
         HEADER
         ================================================== -->

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2>

            <i class="bi bi-clock-history"></i>

            Job Execution History

        </h2>


        <div>

            <a
                    href="<%= request.getContextPath() %>/AdminDashboardServlet"
                    class="btn btn-primary">

                <i class="bi bi-speedometer2"></i>

                Dashboard

            </a>


            <a
                    href="<%= request.getContextPath() %>/LogoutServlet"
                    class="btn btn-danger">

                <i class="bi bi-box-arrow-right"></i>

                Logout

            </a>

        </div>

    </div>


    <!-- ==================================================
         ADMIN INFORMATION
         ================================================== -->

    <div class="alert alert-dark">

        <i class="bi bi-shield-check"></i>

        Logged in as:

        <strong>
            <%= loggedUser.getFullName() %>
        </strong>

        <span class="badge bg-danger">
            ADMIN
        </span>

    </div>


    <!-- ==================================================
         HISTORY TABLE
         ================================================== -->

    <div class="card shadow">

        <div class="card-body">

            <div class="table-responsive">

                <table
                        class="table table-bordered table-striped table-hover mb-0">

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

                        if (historyList != null
                                && !historyList.isEmpty()) {

                            for (JobHistory history :
                                    historyList) {

                    %>

                    <tr>


                        <!-- HISTORY ID -->

                        <td>
                            <%= history.getHistoryId() %>
                        </td>


                        <!-- JOB ID -->

                        <td>
                            <%= history.getJobId() %>
                        </td>


                        <!-- JOB NAME -->

                        <td>
                            <%= history.getJobName() %>
                        </td>


                        <!-- EXECUTION TIME -->

                        <td>
                            <%= history.getExecutionTime() %>
                        </td>


                        <!-- STATUS -->

                        <td>

                            <% if ("Completed".equalsIgnoreCase(
                                    history.getStatus())) { %>

                                <span class="badge bg-success">

                                    <i class="bi bi-check-circle"></i>

                                    <%= history.getStatus() %>

                                </span>

                            <% } else if ("Failed".equalsIgnoreCase(
                                    history.getStatus())) { %>

                                <span class="badge bg-danger">

                                    <i class="bi bi-x-circle"></i>

                                    <%= history.getStatus() %>

                                </span>

                            <% } else { %>

                                <span class="badge bg-warning text-dark">

                                    <%= history.getStatus() %>

                                </span>

                            <% } %>

                        </td>


                        <!-- RESULT -->

                        <td>
                            <%= history.getResult() %>
                        </td>

                    </tr>


                    <%

                            }

                        } else {

                    %>


                    <tr>

                        <td
                                colspan="6"
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


    <!-- ==================================================
         BACK TO JOBS
         ================================================== -->

    <div class="mt-3">

        <a
                href="<%= request.getContextPath() %>/JobServlet"
                class="btn btn-secondary">

            <i class="bi bi-briefcase"></i>

            Back to Jobs

        </a>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>