<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.vaishnavi.model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");

    if (loggedUser == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>Add Job</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="text-center mb-4">
        Add New Job
    </h2>

    <form action="<%=request.getContextPath()%>/JobServlet"
          method="post">

        <div class="mb-3">

            <label class="form-label">
                Job Name
            </label>

            <input type="text"
                   name="jobName"
                   class="form-control"
                   required>

        </div>


        <div class="mb-3">

            <label class="form-label">
                Job Description
            </label>

            <textarea name="jobDescription"
                      class="form-control"
                      rows="4"
                      required></textarea>

        </div>


        <div class="mb-3">

            <label class="form-label">
                Job Type
            </label>

            <input type="text"
                   name="jobType"
                   class="form-control"
                   required>

        </div>


        <div class="mb-3">

            <label class="form-label">
                Job Status
            </label>

            <select name="jobStatus"
                    class="form-select">

                <option value="Active">
                    Active
                </option>

                <option value="Inactive">
                    Inactive
                </option>

                <option value="Completed">
                    Completed
                </option>

            </select>

        </div>


        <div class="mb-3">

            <label class="form-label">
                Schedule Date
            </label>

            <input type="date"
                   name="scheduleDate"
                   class="form-control"
                   required>

        </div>


        <div class="mb-3">

            <label class="form-label">
                Schedule Time
            </label>

            <input type="time"
                   name="scheduleTime"
                   class="form-control"
                   required>

        </div>


        <div class="mb-3">

            <label class="form-label">
                Execution Status
            </label>

            <select name="executionStatus"
                    class="form-select">

                <option value="Pending">
                    Pending
                </option>

                <option value="Running">
                    Running
                </option>

                <option value="Completed">
                    Completed
                </option>

                <option value="Failed">
                    Failed
                </option>

            </select>

        </div>


        <button type="submit"
                class="btn btn-primary">

            Save Job

        </button>


        <a href="<%=request.getContextPath()%>/JobServlet"
           class="btn btn-secondary">

            View Jobs

        </a>

    </form>

</div>

</body>

</html>