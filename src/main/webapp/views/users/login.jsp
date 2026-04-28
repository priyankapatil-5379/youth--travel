<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:400,500,600,700" rel="stylesheet">
    <style>
        body {
            font-family: 'Dosis', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .login-container {
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            transition: transform 0.3s ease;
        }
        .login-container:hover {
            transform: translateY(-5px);
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h2 {
            font-weight: 700;
            color: #333;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .login-header p {
            color: #777;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #ff4b2b;
            box-shadow: 0 0 8px rgba(255, 75, 43, 0.2);
        }
        .btn-login {
            background: #f04c26;
            border: none;
            color: #fff;
            padding: 12px;
            border-radius: 10px;
            width: 100%;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
        }
        .btn-login:hover {
            opacity: 0.9;
            box-shadow: 0 5px 15px rgba(240, 76, 38, 0.4);
        }
        .footer-links {
            text-align: center;
            margin-top: 20px;
            color: #777;
        }
        .footer-links a {
            color: #f04c26;
            text-decoration: none;
            font-weight: 500;
        }
        .logo-box {
            text-align: center;
            margin-bottom: 20px;
        }
        .logo-box img {
            max-width: 150px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="logo-box">
        <a href="<c:url value='/'/>">
            <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel Logo">
        </a>
    </div>
    <div class="login-header">
        <h2>User Login</h2>
        <p>Welcome back, explorer!</p>
    </div>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <form action="<c:url value='/user/login'/>" method="post">
        <div class="form-group">
            <label for="email"><i class="fa fa-envelope"></i> Email Address</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>
        <div class="form-group">
            <label for="password"><i class="fa fa-lock"></i> Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-login">Login</button>
    </form>

    <div class="footer-links">
        <p><a href="<c:url value='/user/forgot-password'/>" style="color: #666; font-size: 14px;">Forgot Password?</a></p>
        <p>Don't have an account? <a href="<c:url value='/user/register'/>">Register Now</a></p>
        <p><a href="<c:url value='/'/>">Back to Home</a></p>
    </div>
</div>

</body>
</html>
