<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    if (!"USER".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
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

    <title>User Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<!-- Navbar -->

<nav class="navbar navbar-dark bg-primary shadow">

    <div class="container-fluid">

        <span class="navbar-brand">

            <i class="bi bi-person-circle"></i>

            Background Job Scheduler - User

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

    <!-- User Welcome -->

    <div class="alert alert-info">

        <h4>

            <i class="bi bi-person-fill"></i>

            User Dashboard

        </h4>

        <p class="mb-0">

            Welcome to your Background Job Scheduler account.

        </p>

    </div>


    <!-- User Features -->

    <div class="row g-4">


        <div class="col-md-4">

            <div class="card shadow h-100">

                <div class="card-body text-center">

                    <i class="bi bi-plus-circle-fill fs-1 text-primary"></i>

                    <h4 class="mt-3">

                        Create Job

                    </h4>

                    <p>

                        Create and schedule a new job.

                    </p>

                    <a href="<%=request.getContextPath()%>/jsp/addJob.jsp"
                       class="btn btn-primary">

                        Create Job

                    </a>

                </div>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card shadow h-100">

                <div class="card-body text-center">

                    <i class="bi bi-briefcase-fill fs-1 text-success"></i>

                    <h4 class="mt-3">

                        My Jobs

                    </h4>

                    <p>

                        View your scheduled jobs.

                    </p>

                    <a href="<%=request.getContextPath()%>/JobServlet"
                       class="btn btn-success">

                        My Jobs

                    </a>

                </div>

            </div>

        </div>


        <div class="col-md-4">

            <div class="card shadow h-100">

                <div class="card-body text-center">

                    <i class="bi bi-clock-history fs-1 text-info"></i>

                    <h4 class="mt-3">

                        Job History

                    </h4>

                    <p>

                        View your job execution history.

                    </p>

                    <a href="<%=request.getContextPath()%>/JobHistoryServlet"
                       class="btn btn-info text-white">

                        View History

                    </a>

                </div>

            </div>

        </div>

    </div>


    <!-- User Information -->

    <div class="card shadow mt-4">

        <div class="card-body">

            <h4>User Information</h4>

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

                <span class="badge bg-primary">

                    <%= user.getRole() %>

                </span>

            </p>

        </div>

    </div>

</div>

</body>

</html>