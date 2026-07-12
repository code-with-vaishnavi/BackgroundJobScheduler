<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Add User</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-success text-white">

            <h3>Add New User</h3>

        </div>

        <div class="card-body">

            <form action="<%= request.getContextPath() %>/UserServlet" method="post">

                <div class="mb-3">

                    <label class="form-label">Full Name</label>

                    <input type="text"
                           name="fullName"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">Email</label>

                    <input type="email"
                           name="email"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">Password</label>

                    <input type="password"
                           name="password"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">Role</label>

                    <select name="role"
                            class="form-select">

                        <option value="ADMIN">ADMIN</option>

                        <option value="USER">USER</option>

                    </select>

                </div>

                <button class="btn btn-success">

                    Save User

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