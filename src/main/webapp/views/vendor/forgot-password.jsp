<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Forgot Password | Youth Travel</title>
            <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
            <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
            <style>
                body.yt-vendor-login {
                    background: #0b0f18;
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .login-card {
                    background: rgba(255, 255, 255, 0.05);
                    backdrop-filter: blur(20px);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 20px;
                    padding: 40px;
                    width: 100%;
                    max-width: 420px;
                }

                .login-header h2 {
                    color: #fff;
                    font-weight: 800;
                    text-align: center;
                    margin-bottom: 30px;
                }

                .form-control {
                    background: rgba(255, 255, 255, 0.08);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 12px;
                    height: 48px;
                    color: #fff;
                }

                .btn-login {
                    background: #f04c26;
                    border: none;
                    border-radius: 12px;
                    height: 48px;
                    width: 100%;
                    color: #fff;
                    font-weight: 700;
                    margin-top: 20px;
                }
            </style>
        </head>

        <body class="yt-vendor-login">
            <div class="login-card">
                <div class="login-header">
                    <h2>FORGOT PASSWORD</h2>
                    <p style="color: rgba(255,255,255,0.5); text-align: center;">Enter your email to receive recovery
                        instructions.</p>
                </div>
                <form>
                    <div class="form-group">
                        <input type="email" class="form-control" placeholder="Email Address" required>
                    </div>
                    <button type="submit" class="btn btn-login">Send Reset Link</button>
                </form>
                <div style="text-align: center; margin-top: 20px;">
                    <a href="<c:url value='/vendor/login'/>" style="color: #f04c26; font-weight: 700;">Back to Login</a>
                </div>
            </div>
        </body>

        </html>