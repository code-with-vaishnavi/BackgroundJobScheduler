<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    // GET USER
    // ==================================================

    User user =
            (User) request.getAttribute("user");

    if (user == null) {

        response.sendRedirect(
                request.getContextPath()
                        + "/UserServlet"
        );

        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit User - Background Job Scheduler</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
            rel="stylesheet">

</head>

<body class="bg-light">


<div class="container mt-5">

    <div class="card shadow">


        <!-- ==================================================
             HEADER
             ================================================== -->

        <div class="card-header bg-warning text-dark">

            <h3 class="mb-0">

                <i class="bi bi-person-gear"></i>

                Edit User

            </h3>

        </div>


        <div class="card-body">


            <!-- ==================================================
                 FORM
                 ================================================== -->

            <form
                    action="<%= request.getContextPath() %>/UserServlet"
                    method="post">

                <!-- ACTION -->

                <input
                        type="hidden"
                        name="action"
                        value="update">


                <!-- USER ID -->

                <input
                        type="hidden"
                        name="userId"
                        value="<%= user.getUserId() %>">


                <!-- ==================================================
                     FULL NAME
                     ================================================== -->

                <div class="mb-3">

                    <label class="form-label">

                        Full Name

                    </label>

                    <input
                            type="text"
                            name="fullName"
                            class="form-control"
                            value="<%= user.getFullName() %>"
                            maxlength="100"
                            required>

                </div>


                <!-- ==================================================
                     EMAIL
                     ================================================== -->

                <div class="mb-3">

                    <label class="form-label">

                        Email

                    </label>

                    <input
                            type="email"
                            name="email"
                            class="form-control"
                            value="<%= user.getEmail() %>"
                            autocomplete="email"
                            maxlength="150"
                            required>

                </div>


                <!-- ==================================================
                     NEW PASSWORD
                     ================================================== -->

                <div class="mb-3">

                    <label class="form-label">

                        New Password

                    </label>

                    <input
                            type="password"
                            name="password"
                            class="form-control"
                            placeholder="Leave blank to keep current password"
                            autocomplete="new-password"
                            minlength="6"
                            maxlength="100">

                    <div class="form-text">

                        Leave this field blank if you do not want
                        to change the current password.

                    </div>

                </div>


                <!-- ==================================================
                     ROLE
                     ================================================== -->

                <div class="mb-3">

                    <label class="form-label">

                        Role

                    </label>

                    <select
                            name="role"
                            class="form-select"
                            required>

                        <option
                                value="ADMIN"
                            <%= "ADMIN".equalsIgnoreCase(
                                    user.getRole())
                                    ? "selected"
                                    : "" %>>

                            ADMIN

                        </option>

                        <option
                                value="USER"
                            <%= "USER".equalsIgnoreCase(
                                    user.getRole())
                                    ? "selected"
                                    : "" %>>

                            USER

                        </option>

                    </select>

                </div>


                <!-- ==================================================
                     BUTTONS
                     ================================================== -->

                <button
                        type="submit"
                        class="btn btn-warning">

                    <i class="bi bi-check-circle"></i>

                    Update User

                </button>


                <a
                        href="<%= request.getContextPath() %>/UserServlet"
                        class="btn btn-secondary">

                    <i class="bi bi-arrow-left"></i>

                    Cancel

                </a>

            </form>

        </div>

    </div>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>