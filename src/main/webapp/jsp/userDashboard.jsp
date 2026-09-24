<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    // ==================================================
    // CHECK LOGIN SESSION
    // ==================================================

    User user =
            (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect(
                request.getContextPath()
                        + "/jsp/login.jsp"
        );

        return;
    }


    // ==================================================
    // USER ONLY
    // ==================================================

    if (!"USER".equalsIgnoreCase(
            user.getRole()
    )) {

        response.sendRedirect(
                request.getContextPath()
                        + "/AdminDashboardServlet"
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
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>User Dashboard - Background Job Scheduler</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
            rel="stylesheet">

</head>

<body class="bg-light">


<!-- ==================================================
     NAVBAR
     ================================================== -->

<nav class="navbar navbar-dark bg-primary shadow">

    <div class="container-fluid">

        <span class="navbar-brand">

            <i class="bi bi-person-circle"></i>

            Background Job Scheduler - User

        </span>


        <div class="text-white">

            Welcome,

            <b>
                <%= user.getFullName() %>
            </b>

            |

            <a
                    href="<%= request.getContextPath() %>/LogoutServlet"
                    class="btn btn-danger btn-sm">

                <i class="bi bi-box-arrow-right"></i>

                Logout

            </a>

        </div>

    </div>

</nav>


<!-- ==================================================
     MAIN CONTAINER
     ================================================== -->

<div class="container mt-4">


    <!-- ==================================================
         USER WELCOME
         ================================================== -->

    <div class="alert alert-info">

        <h4>

            <i class="bi bi-person-fill"></i>

            User Dashboard

        </h4>

        <p class="mb-0">

            Welcome to your Background Job Scheduler account.

        </p>

    </div>


    <!-- ==================================================
         USER FEATURES
         ================================================== -->

    <div class="row g-4">


        <!-- CREATE JOB -->

        <div class="col-md-6">

            <div class="card shadow h-100">

                <div class="card-body text-center">

                    <i
                            class="bi bi-plus-circle-fill fs-1 text-primary">
                    </i>

                    <h4 class="mt-3">

                        Create Job

                    </h4>

                    <p>

                        Create and schedule a new job.

                    </p>

                    <a
                            href="<%= request.getContextPath() %>/jsp/addJob.jsp"
                            class="btn btn-primary">

                        <i class="bi bi-plus-circle"></i>

                        Create Job

                    </a>

                </div>

            </div>

        </div>


        <!-- MY JOBS -->

        <div class="col-md-6">

            <div class="card shadow h-100">

                <div class="card-body text-center">

                    <i
                            class="bi bi-briefcase-fill fs-1 text-success">
                    </i>

                    <h4 class="mt-3">

                        My Jobs

                    </h4>

                    <p>

                        View and manage your scheduled jobs.

                    </p>

                    <a
                            href="<%= request.getContextPath() %>/JobServlet"
                            class="btn btn-success">

                        <i class="bi bi-briefcase"></i>

                        My Jobs

                    </a>

                </div>

            </div>

        </div>

    </div>


    <!-- ==================================================
         USER INFORMATION
         ================================================== -->

    <div class="card shadow mt-4">

        <div class="card-body">

            <h4>

                <i class="bi bi-person-vcard"></i>

                User Information

            </h4>

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


<!-- ==================================================
     BOOTSTRAP JS
     ================================================== -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>