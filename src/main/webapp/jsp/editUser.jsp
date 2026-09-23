<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect(
                request.getContextPath() + "/UserServlet"
        );
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit User</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-warning">

            <h3>Edit User</h3>

        </div>

        <div class="card-body">

            <form action="<%= request.getContextPath() %>/UserServlet"
                  method="post">

                <input type="hidden"
                       name="action"
                       value="update">

                <input type="hidden"
                       name="userId"
                       value="<%= user.getUserId() %>">


                <!-- Full Name -->

                <div class="mb-3">

                    <label class="form-label">
                        Full Name
                    </label>

                    <input type="text"
                           name="fullName"
                           class="form-control"
                           value="<%= user.getFullName() %>"
                           required>

                </div>


                <!-- Email -->

                <div class="mb-3">

                    <label class="form-label">
                        Email
                    </label>

                    <input type="email"
                           name="email"
                           class="form-control"
                           value="<%= user.getEmail() %>"
                           required>

                </div>


                <!-- New Password -->

                <div class="mb-3">

                    <label class="form-label">
                        New Password
                    </label>

                    <input type="password"
                           name="password"
                           class="form-control"
                           placeholder="Leave blank to keep current password">

                    <small class="text-muted">
                        Leave this field blank if you do not want to change the password.
                    </small>

                </div>


                <!-- Role -->

                <div class="mb-3">

                    <label class="form-label">
                        Role
                    </label>

                    <select name="role"
                            class="form-select">

                        <option value="ADMIN"
                            <%= "ADMIN".equalsIgnoreCase(user.getRole())
                                    ? "selected"
                                    : "" %>>

                            ADMIN

                        </option>

                        <option value="USER"
                            <%= "USER".equalsIgnoreCase(user.getRole())
                                    ? "selected"
                                    : "" %>>

                            USER

                        </option>

                    </select>

                </div>


                <!-- Buttons -->

                <button type="submit"
                        class="btn btn-warning">

                    Update User

                </button>

                <a href="<%= request.getContextPath() %>/UserServlet"
                   class="btn btn-secondary">

                    Cancel

                </a>

            </form>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>