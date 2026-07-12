<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit User</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-warning">

            <h3>Edit User</h3>

        </div>

        <div class="card-body">

            <form action="<%= request.getContextPath() %>/UserServlet" method="post">

                <input type="hidden"
                       name="action"
                       value="update">

                <input type="hidden"
                       name="userId"
                       value="<%= user.getUserId() %>">

                <div class="mb-3">

                    <label>Full Name</label>

                    <input type="text"
                           name="fullName"
                           class="form-control"
                           value="<%= user.getFullName() %>"
                           required>

                </div>

                <div class="mb-3">

                    <label>Email</label>

                    <input type="email"
                           name="email"
                           class="form-control"
                           value="<%= user.getEmail() %>"
                           required>

                </div>

                <div class="mb-3">

                    <label>Password</label>

                    <input type="text"
                           name="password"
                           class="form-control"
                           value="<%= user.getPassword() %>"
                           required>

                </div>

                <div class="mb-3">

                    <label>Role</label>

                    <select name="role"
                            class="form-select">

                        <option value="ADMIN"
                            <%= user.getRole().equals("ADMIN") ? "selected" : "" %>>
                            ADMIN
                        </option>

                        <option value="USER"
                            <%= user.getRole().equals("USER") ? "selected" : "" %>>
                            USER
                        </option>

                    </select>

                </div>

                <button class="btn btn-warning">

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