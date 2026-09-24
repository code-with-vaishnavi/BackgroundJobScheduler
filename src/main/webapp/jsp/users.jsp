<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
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

    if (!"ADMIN".equalsIgnoreCase(
            loggedUser.getRole()
    )) {

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
    // GET USER LIST
    // ==================================================

    List<User> userList =
            (List<User>) request.getAttribute(
                    "userList"
            );
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>User Management - Background Job Scheduler</title>

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

        <div>

            <h2>

                <i class="bi bi-people-fill"></i>

                User Management

            </h2>

            <p class="text-muted mb-0">

                Manage registered users and their roles.

            </p>

        </div>


        <div>

            <a
                    href="<%= request.getContextPath() %>/jsp/addUser.jsp"
                    class="btn btn-success">

                <i class="bi bi-person-plus-fill"></i>

                Add User

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
         USER TABLE
         ================================================== -->

    <div class="card shadow">

        <div class="card-body">

            <div class="table-responsive">

                <table
                        class="table table-bordered table-hover table-striped mb-0">

                    <thead class="table-dark">

                    <tr>

                        <th>ID</th>

                        <th>Full Name</th>

                        <th>Email</th>

                        <th>Role</th>

                        <th width="220">Action</th>

                    </tr>

                    </thead>


                    <tbody>

                    <%

                        if (userList != null
                                && !userList.isEmpty()) {

                            for (User user : userList) {

                    %>

                    <tr>


                        <!-- USER ID -->

                        <td>
                            <%= user.getUserId() %>
                        </td>


                        <!-- FULL NAME -->

                        <td>
                            <%= user.getFullName() %>
                        </td>


                        <!-- EMAIL -->

                        <td>
                            <%= user.getEmail() %>
                        </td>


                        <!-- ROLE -->

                        <td>

                            <% if ("ADMIN".equalsIgnoreCase(
                                    user.getRole())) { %>

                                <span class="badge bg-danger">

                                    <i class="bi bi-shield-fill"></i>

                                    ADMIN

                                </span>

                            <% } else { %>

                                <span class="badge bg-primary">

                                    <i class="bi bi-person-fill"></i>

                                    USER

                                </span>

                            <% } %>

                        </td>


                        <!-- ACTIONS -->

                        <td>

                            <a
                                    href="<%= request.getContextPath() %>/UserServlet?action=edit&id=<%= user.getUserId() %>"
                                    class="btn btn-warning btn-sm">

                                <i class="bi bi-pencil-square"></i>

                                Edit

                            </a>


                            <a
                                    href="<%= request.getContextPath() %>/UserServlet?action=delete&id=<%= user.getUserId() %>"
                                    class="btn btn-danger btn-sm"
                                    onclick="return confirm('Are you sure you want to delete this user?');">

                                <i class="bi bi-trash"></i>

                                Delete

                            </a>

                        </td>

                    </tr>


                    <%

                            }

                        } else {

                    %>


                    <tr>

                        <td
                                colspan="5"
                                class="text-center text-muted">

                            <i class="bi bi-person-x"></i>

                            No Users Found

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
         BACK TO ADMIN DASHBOARD
         ================================================== -->

    <div class="mt-3">

        <a
                href="<%= request.getContextPath() %>/AdminDashboardServlet"
                class="btn btn-secondary">

            <i class="bi bi-arrow-left"></i>

            Back to Dashboard

        </a>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>