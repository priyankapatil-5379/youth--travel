<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vendor Login | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        body.yt-vendor-login {
            background: #0b0f18 url('<c:url value="/views/assets/images/hero.png"/>') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        body.yt-vendor-login::before {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(9, 11, 18, 0.9) 0%, rgba(9, 11, 18, 0.4) 100%);
            z-index: 1;
        }
        .login-container {
            position: relative;
            z-index: 2;
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header img {
            height: 45px;
            margin-bottom: 20px;
        }
        .login-header h2 {
            color: #fff;
            font-weight: 800;
            font-size: 24px;
            letter-spacing: 1px;
            margin: 0;
        }
        .login-header p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            margin-top: 8px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            color: rgba(255, 255, 255, 0.8);
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
            display: block;
        }
        .form-control {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            height: 48px;
            color: #fff;
            padding: 0 16px;
            transition: all 0.2s;
        }
        .form-control:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: #f04c26;
            box-shadow: 0 0 0 4px rgba(240, 76, 38, 0.15);
            outline: none;
        }
        .btn-login {
            background: #f04c26;
            border: none;
            border-radius: 12px;
            height: 48px;
            width: 100%;
            color: #fff;
            font-weight: 700;
            font-size: 16px;
            margin-top: 10px;
            transition: all 0.2s;
        }
        .btn-login:hover {
            background: #d93d1a;
            transform: translateY(-1px);
            box-shadow: 0 10px 20px rgba(240, 76, 38, 0.3);
        }
        .login-footer {
            text-align: center;
            margin-top: 25px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
        }
        .login-footer a {
            color: #f04c26;
            font-weight: 700;
            text-decoration: none;
        }
        .login-footer a:hover {
            text-decoration: underline;
        }
        .alert {
            border-radius: 12px;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body class="yt-vendor-login">
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel Logo">
                </a>
                <h2>VENDOR LOGIN</h2>
                <p>Manage your trips and bookings</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fa fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fa fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <form action="<c:url value='/vendor/login'/>" method="post">
                <div class="form-group">
                    <label for="emailId">Email Address</label>
                    <input type="email" id="emailId" name="emailId" class="form-control" placeholder="name@company.com" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
                <div style="text-align: right; margin-bottom: 20px;">
                    <a href="<c:url value='/vendor/forgot-password'/>" style="color: rgba(255,255,255,0.5); font-size: 13px; font-weight: 600;">Forgot password?</a>
                </div>
                <button type="submit" class="btn btn-login">Login to Dashboard</button>
            </form>

            <div class="login-footer">
                Don't have a partner account? <br>
                <a href="<c:url value='/vendor/register'/>">Register your business</a>
            </div>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>
