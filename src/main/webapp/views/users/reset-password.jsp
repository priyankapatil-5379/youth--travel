<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Youth Travel</title>
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
        .footer-links {
            text-align: center;
            margin-top: 20px;
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
        <h2>Create New Password</h2>
        <p>Please enter your new password below</p>
    </div>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="<c:url value='/user/reset-password'/>" method="post">
        <div class="form-group">
            <label for="newPassword"><i class="fa fa-lock"></i> New Password</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Enter new password" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword"><i class="fa fa-lock"></i> Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm new password" required>
        </div>
        <button type="submit" class="btn btn-login">Reset Password</button>
    </form>
</div>
</body>
</html>
