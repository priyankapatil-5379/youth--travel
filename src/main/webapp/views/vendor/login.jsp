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
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-teal: #0F7C7C;
            --primary-teal-dark: #085a5a;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --bg-light: #ffffff;
            --input-bg: #f8fafc;
            --border: #e2e8f0;
            --teal-glow: rgba(15, 124, 124, 0.1);
        }

        body, html {
            font-family: 'Outfit', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
            background-color: var(--bg-light);
        }

        /* Full Screen Split Layout */
        .split-layout {
            display: flex;
            height: 100vh;
            width: 100%;
        }

        /* Left Side: Immersive Visuals */
        .image-section {
            flex: 1;
            position: relative;
            background: url('<c:url value="/views/assets/images/hero.png"/>') no-repeat center center;
            background-size: cover;
            display: flex;
            align-items: flex-end;
            padding: 60px;
        }

        .image-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(15, 124, 124, 0.4) 0%, rgba(0,0,0,0.2) 60%, transparent 100%);
            z-index: 1;
        }

        .image-content {
            position: relative;
            z-index: 10;
            color: #ffffff;
            max-width: 500px;
            animation: fadeInLeft 1s ease-out;
        }

        @keyframes fadeInLeft {
            from { opacity: 0; transform: translateX(-30px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .image-content h1 {
            font-family: 'Playfair Display', serif;
            font-size: 56px;
            font-weight: 900;
            line-height: 1.1;
            margin-bottom: 20px;
        }

        .image-content p {
            font-size: 18px;
            opacity: 0.9;
            line-height: 1.6;
        }

        /* Right Side: Form Section */
        .form-section {
            flex: 1;
            background: var(--bg-light);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px;
            overflow-y: auto;
        }

        .login-container {
            width: 100%;
            max-width: 440px;
            animation: fadeInRight 0.8s ease-out;
        }

        @keyframes fadeInRight {
            from { opacity: 0; transform: translateX(30px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-header img {
            height: 50px;
            margin-bottom: 30px;
        }

        .login-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            font-weight: 900;
            color: var(--text-dark);
            margin-bottom: 12px;
        }

        .login-header p {
            color: var(--text-muted);
            font-size: 16px;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 14px;
            margin-bottom: 10px;
            display: block;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 16px;
        }

        .form-control {
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            height: 58px;
            color: var(--text-dark);
            padding: 0 20px 0 52px;
            font-size: 15px;
            font-weight: 500;
            transition: 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary-teal);
            box-shadow: 0 4px 15px var(--teal-glow);
            outline: none;
            background: #fff;
        }

        .forgot-pass-link {
            text-align: right;
            margin-bottom: 30px;
        }

        .forgot-pass-link a {
            color: var(--primary-teal);
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
        }

        .forgot-pass-link a:hover {
            color: var(--primary-teal-dark);
            text-decoration: underline;
        }

        .btn-login {
            background: linear-gradient(135deg, var(--primary-teal), var(--primary-teal-dark));
            color: #fff;
            border: none;
            border-radius: 18px;
            height: 60px;
            width: 100%;
            font-weight: 800;
            font-size: 17px;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.4s;
            box-shadow: 0 10px 25px rgba(15, 124, 124, 0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(15, 124, 124, 0.4);
            color: #fff;
        }

        .login-footer {
            text-align: center;
            margin-top: 40px;
            color: var(--text-muted);
            font-size: 15px;
            font-weight: 500;
        }

        .login-footer a {
            color: var(--primary-teal);
            font-weight: 800;
            text-decoration: none;
            transition: 0.3s;
        }

        .login-footer a:hover {
            color: var(--primary-teal-dark);
        }

        .alert {
            border-radius: 16px;
            font-weight: 600;
            padding: 16px;
            margin-bottom: 24px;
            border: none;
        }

        .alert-danger { background: #fef2f2; color: #991b1b; }
        .alert-success { background: #f0fdf4; color: #166534; }

        @media (max-width: 991px) {
            body, html { overflow: auto; height: auto; }
            .split-layout { flex-direction: column; height: auto; }
            .image-section { height: 40vh; min-height: 350px; padding: 40px; }
            .form-section { padding: 60px 24px; }
            .image-content h1 { font-size: 38px; }
        }
    </style>
</head>
<body class="yt-vendor-login">
    <div class="split-layout">
        <!-- Left Side: Immersive Visuals -->
        <div class="image-section">
            <div class="image-overlay"></div>
            <div class="image-content">
                <h1>Scale Your<br>Adventure Business.</h1>
                <p>Partner with Youth Travel to reach thousands of explorers and grow your travel footprint globally.</p>
            </div>
        </div>

        <!-- Right Side: Form Section -->
        <div class="form-section">
            <div class="login-container">
                <div class="login-header">
                    <a href="<c:url value='/'/>">
                        <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel Logo">
                    </a>
                    <h2>Vendor Login</h2>
                    <p>Access your business dashboard and manage your services.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fa fa-exclamation-circle mr-2"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fa fa-check-circle mr-2"></i> ${message}
                    </div>
                </c:if>

                <form action="<c:url value='/vendor/login'/>" method="post">
                    <div class="form-group">
                        <label for="emailId">Business Email</label>
                        <div class="input-wrapper">
                            <i class="fa fa-envelope-o input-icon"></i>
                            <input type="email" id="emailId" name="emailId" class="form-control" placeholder="name@company.com" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Security Password</label>
                        <div class="input-wrapper">
                            <i class="fa fa-lock input-icon"></i>
                            <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>
                    </div>

                    <div class="forgot-pass-link">
                        <a href="<c:url value='/vendor/forgot-password'/>">Forgot Password?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-login">
                        Login to Dashboard <i class="fa fa-arrow-right"></i>
                    </button>
                </form>

                <div class="login-footer">
                    New partner? <a href="<c:url value='/vendor/register'/>" class="ms-2">Register your business</a>
                </div>
            </div>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>
