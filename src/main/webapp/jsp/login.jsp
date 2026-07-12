<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Login - Background Job Scheduler</title>

    <style>

        body{
            font-family: Arial, sans-serif;
            background:#f2f2f2;
        }

        .container{

            width:400px;
            margin:80px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0px 0px 10px gray;

        }

        h2{

            text-align:center;

        }

        input{

            width:100%;
            padding:10px;
            margin-top:10px;
            margin-bottom:20px;

        }

        button{

            width:100%;
            padding:12px;
            background:#007BFF;
            color:white;
            border:none;
            cursor:pointer;

        }

        button:hover{

            background:#0056b3;

        }

    </style>

</head>

<body>

<div class="container">

    <h2>User Login</h2>

    <form action="../LoginServlet" method="post">

        <label>Email</label>

        <input
                type="email"
                name="email"
                placeholder="Enter Email"
                required>

        <label>Password</label>

        <input
                type="password"
                name="password"
                placeholder="Enter Password"
                required>

        <button type="submit">

            Login

        </button>

    </form>

</div>

</body>
</html>