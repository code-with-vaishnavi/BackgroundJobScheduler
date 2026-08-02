<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <title>Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>

<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">

    <div class="container-fluid">

        <span class="navbar-brand">
            <i class="bi bi-cpu-fill"></i>
            Background Job Scheduler
        </span>

        <div class="text-white">

            Welcome,

            <b><%= user.getFullName() %></b>

            |

            <a href="<%=request.getContextPath()%>/LogoutServlet"
               class="btn btn-danger btn-sm">
                Logout
            </a>

        </div>

    </div>

</nav>

<div class="container mt-4">

    <!-- Navigation Buttons -->

    <div class="mb-4 text-center">

        <a href="<%=request.getContextPath()%>/JobServlet"
           class="btn btn-primary me-2">
            <i class="bi bi-briefcase-fill"></i>
            Manage Jobs
        </a>

        <a href="<%=request.getContextPath()%>/JobHistoryServlet"
           class="btn btn-success me-2">
            <i class="bi bi-clock-history"></i>
            Job History
        </a>

    </div>

    <div class="row g-4">

        <!-- Total Users -->

        <div class="col-md-3">

            <div class="card bg-primary text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-people-fill fs-1"></i>

                    <h5 class="mt-2">Total Users</h5>

                    <h2><%= request.getAttribute("totalUsers") %></h2>

                </div>

            </div>

        </div>

        <!-- Total Jobs -->

        <div class="col-md-3">

            <div class="card bg-success text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-briefcase-fill fs-1"></i>

                    <h5 class="mt-2">Total Jobs</h5>

                    <h2><%= request.getAttribute("totalJobs") %></h2>

                </div>

            </div>

        </div>

        <!-- Completed Jobs -->

        <div class="col-md-3">

            <div class="card bg-warning shadow">

                <div class="card-body text-center">

                    <i class="bi bi-check-circle-fill fs-1"></i>

                    <h5 class="mt-2">Completed Jobs</h5>

                    <h2><%= request.getAttribute("completedJobs") %></h2>

                </div>

            </div>

        </div>

        <!-- Failed Jobs -->

        <div class="col-md-3">

            <div class="card bg-danger text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-x-circle-fill fs-1"></i>

                    <h5 class="mt-2">Failed Jobs</h5>

                    <h2><%= request.getAttribute("failedJobs") %></h2>

                </div>

            </div>

        </div>

    </div>

    <!-- Welcome Card -->

    <div class="card shadow mt-4">

        <div class="card-body">

            <h3>
                Welcome, <%= user.getFullName() %>
            </h3>

            <hr>

            <p>
                <strong>Email :</strong>
                <%= user.getEmail() %>
            </p>

            <p>
                <strong>Role :</strong>
                <%= user.getRole() %>
            </p>

            <p>
                Welcome to the <strong>Background Job Scheduler System</strong>.
            </p>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>