<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/UserDashboardServlet");
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

    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<!-- Navbar -->

<nav class="navbar navbar-dark bg-dark shadow">

    <div class="container-fluid">

        <span class="navbar-brand">

            <i class="bi bi-shield-lock-fill"></i>

            Background Job Scheduler - Admin

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


<!-- Dashboard -->

<div class="container mt-4">

    <div class="alert alert-primary">

        <h4>

            <i class="bi bi-person-badge-fill"></i>

            Admin Dashboard

        </h4>

        <p class="mb-0">

            You have full access to users, jobs and job history.

        </p>

    </div>


    <!-- Statistics -->

    <div class="row g-4">


        <!-- Total Users -->

        <div class="col-md-3">

            <div class="card bg-primary text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-people-fill fs-1"></i>

                    <h5>Total Users</h5>

                    <h2>

                        <%= request.getAttribute("totalUsers") %>

                    </h2>

                </div>

            </div>

        </div>


        <!-- Total Jobs -->

        <div class="col-md-3">

            <div class="card bg-success text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-briefcase-fill fs-1"></i>

                    <h5>Total Jobs</h5>

                    <h2>

                        <%= request.getAttribute("totalJobs") %>

                    </h2>

                </div>

            </div>

        </div>


        <!-- Completed Jobs -->

        <div class="col-md-3">

            <div class="card bg-warning shadow">

                <div class="card-body text-center">

                    <i class="bi bi-check-circle-fill fs-1"></i>

                    <h5>Completed Jobs</h5>

                    <h2>

                        <%= request.getAttribute("completedJobs") %>

                    </h2>

                </div>

            </div>

        </div>


        <!-- Failed Jobs -->

        <div class="col-md-3">

            <div class="card bg-danger text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-x-circle-fill fs-1"></i>

                    <h5>Failed Jobs</h5>

                    <h2>

                        <%= request.getAttribute("failedJobs") %>

                    </h2>

                </div>

            </div>

        </div>

    </div>


    <!-- Admin Features -->

    <div class="card shadow mt-4">

        <div class="card-body">

            <h4>

                <i class="bi bi-tools"></i>

                Admin Controls

            </h4>

            <hr>


            <a href="<%=request.getContextPath()%>/JobServlet"
               class="btn btn-success me-2">

                <i class="bi bi-briefcase-fill"></i>

                Manage All Jobs

            </a>


            <a href="<%=request.getContextPath()%>/JobHistoryServlet"
               class="btn btn-info text-white me-2">

                <i class="bi bi-clock-history"></i>

                Job History

            </a>


            <!-- User Management will be added next -->

            <button class="btn btn-secondary" disabled>

                <i class="bi bi-people-fill"></i>

                User Management - Coming Next

            </button>

        </div>

    </div>


    <!-- Admin Information -->

    <div class="card shadow mt-4">

        <div class="card-body">

            <h4>Administrator Information</h4>

            <hr>

            <p>

                <strong>Name:</strong>

                <%= user.getFullName() %>

            </p>

            <p>

                <strong>Email:</strong>

                <%= user.getEmail() %>

            </p>

            <p>

                <strong>Role:</strong>

                <span class="badge bg-danger">

                    <%= user.getRole() %>

                </span>

            </p>

        </div>

    </div>

</div>

</body>

</html>