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
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Add User - Background Job Scheduler</title>

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

        <div class="card-header bg-success text-white">

            <h3 class="mb-0">

                <i class="bi bi-person-plus-fill"></i>

                Add New User

            </h3>

        </div>


        <div class="card-body">


            <!-- ==================================================
                 FORM
                 ================================================== -->

            <form
                    action="<%= request.getContextPath() %>/UserServlet"
                    method="post">


                <!-- FULL NAME -->

                <div class="mb-3">

                    <label class="form-label">

                        Full Name

                    </label>

                    <input
                            type="text"
                            name="fullName"
                            class="form-control"
                            placeholder="Enter full name"
                            maxlength="100"
                            required>

                </div>


                <!-- EMAIL -->

                <div class="mb-3">

                    <label class="form-label">

                        Email

                    </label>

                    <input
                            type="email"
                            name="email"
                            class="form-control"
                            placeholder="Enter email address"
                            autocomplete="email"
                            maxlength="150"
                            required>

                </div>


                <!-- PASSWORD -->

                <div class="mb-3">

                    <label class="form-label">

                        Password

                    </label>

                    <input
                            type="password"
                            name="password"
                            class="form-control"
                            placeholder="Enter password"
                            autocomplete="new-password"
                            minlength="6"
                            maxlength="100"
                            required>

                    <div class="form-text">

                        Password will be securely hashed before being stored.

                    </div>

                </div>


                <!-- ROLE -->

                <div class="mb-3">

                    <label class="form-label">

                        Role

                    </label>

                    <select
                            name="role"
                            class="form-select"
                            required>

                        <option value="USER">

                            USER

                        </option>

                        <option value="ADMIN">

                            ADMIN

                        </option>

                    </select>

                </div>


                <!-- BUTTONS -->

                <button
                        type="submit"
                        class="btn btn-success">

                    <i class="bi bi-person-plus"></i>

                    Save User

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