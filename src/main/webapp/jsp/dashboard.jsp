<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>
<%@ page import="com.vaishnavi.dao.UserDAO" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    int totalUsers = userDAO.getTotalUsers();

    // Prevent browser cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <title>Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>

<body class="bg-light">

<!-- Navbar -->

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

            <a href="../LogoutServlet"
               class="btn btn-danger btn-sm">

                Logout

            </a>

        </div>

    </div>

</nav>

<!-- Dashboard -->

<div class="container mt-4">

    <div class="row g-4">

        <!-- Total Users -->

        <div class="col-md-3">

            <div class="card bg-primary text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-people-fill fs-1"></i>

                    <h5 class="mt-2">

                        Total Users

                    </h5>

                    <h2>

                        <%= totalUsers %>

                    </h2>

                </div>

            </div>

        </div>

        <!-- Total Jobs -->

        <div class="col-md-3">

            <div class="card bg-success text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-briefcase-fill fs-1"></i>

                    <h5 class="mt-2">

                        Total Jobs

                    </h5>

                    <h2>0</h2>

                </div>

            </div>

        </div>

        <!-- Running Jobs -->

        <div class="col-md-3">

            <div class="card bg-warning shadow">

                <div class="card-body text-center">

                    <i class="bi bi-play-circle-fill fs-1"></i>

                    <h5 class="mt-2">

                        Running Jobs

                    </h5>

                    <h2>0</h2>

                </div>

            </div>

        </div>

        <!-- Failed Jobs -->

        <div class="col-md-3">

            <div class="card bg-danger text-white shadow">

                <div class="card-body text-center">

                    <i class="bi bi-x-circle-fill fs-1"></i>

                    <h5 class="mt-2">

                        Failed Jobs

                    </h5>

                    <h2>0</h2>

                </div>

            </div>

        </div>

    </div>

    <!-- Welcome Card -->

    <div class="card shadow mt-4">

        <div class="card-body">

            <h3>

                Welcome,

                <%= user.getFullName() %>

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

                Welcome to the

                <strong>Background Job Scheduler System</strong>.

            </p>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>