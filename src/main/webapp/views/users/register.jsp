<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>User Registration | Youth Travel</title>
            <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
            <link href="https://fonts.googleapis.com/css?family=Dosis:400,500,600,700" rel="stylesheet">
            <style>
                body {
                    font-family: 'Dosis', sans-serif;
                    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0;
                    padding: 20px;
                }

                .register-container {
                    background: #fff;
                    padding: 40px;
                    border-radius: 20px;
                    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                    width: 100%;
                    max-width: 500px;
                }

                .register-header {
                    text-align: center;
                    margin-bottom: 30px;
                }

                .register-header h2 {
                    font-weight: 700;
                    color: #333;
                    text-transform: uppercase;
                    letter-spacing: 2px;
                }

                .form-group {
                    margin-bottom: 15px;
                }

                .form-control {
                    border-radius: 10px;
                    padding: 10px 15px;
                    border: 1px solid #ddd;
                }

                .btn-register {
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

                .btn-register:hover {
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
            </style>
        </head>

        <body>

            <div class="register-container">
                <div class="register-header">
                    <h2>Join Youth Travel</h2>
                    <p>Start your adventure today!</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <form action="<c:url value='/user/register'/>" method="post">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" placeholder="John Doe"
                            required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="john@example.com"
                            required>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber">Phone Number</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                            placeholder="+91 9876543210" required>
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" class="form-control" placeholder="e.g. Bengaluru">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" class="form-control"
                            placeholder="Create a password" required>
                    </div>
                    <button type="submit" class="btn btn-register">Create Account</button>
                </form>

                <div class="footer-links">
                    <p>Already have an account? <a href="<c:url value='/user/login'/>">Login Here</a></p>
                </div>
            </div>

        </body>

        </html>