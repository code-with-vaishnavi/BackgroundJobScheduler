<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    List<User> userList = (List<User>) request.getAttribute("userList");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>User Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2>User Management</h2>

        <a href="<%= request.getContextPath() %>/jsp/addUser.jsp" class="btn btn-success">
            + Add User
        </a>

    </div>

    <table class="table table-bordered table-hover table-striped shadow">

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
            if (userList != null && !userList.isEmpty()) {

                for (User user : userList) {
        %>

        <tr>

            <td><%= user.getUserId() %></td>

            <td><%= user.getFullName() %></td>

            <td><%= user.getEmail() %></td>

            <td>

                <span class="badge bg-primary">
                    <%= user.getRole() %>
                </span>

            </td>

            <td>

                <a href="<%= request.getContextPath() %>/UserServlet?action=edit&id=<%= user.getUserId() %>"
                   class="btn btn-warning btn-sm">

                    Edit

                </a>

                <a href="<%= request.getContextPath() %>/UserServlet?action=delete&id=<%= user.getUserId() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this user?');">

                    Delete

                </a>

            </td>

        </tr>

        <%
                }

            } else {
        %>

        <tr>

            <td colspan="5" class="text-center">

                No Users Found

            </td>

        </tr>

        <%
            }
        %>

        </tbody>

    </table>

    <div class="mt-3">

        <a href="<%= request.getContextPath() %>/jsp/dashboard.jsp"
           class="btn btn-secondary">

            ← Back to Dashboard

        </a>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>