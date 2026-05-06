<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-orange: #f04c26;
            --text-light: #f8fafc;
            --text-muted: #94a3b8;
            --card-bg: rgba(15, 23, 42, 0.85);
            --border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Outfit', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
            background-color: #002244;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('<c:url value="/views/assets/images/underwater-theme-bg.png"/>') top center/cover no-repeat;
            z-index: -2;
        }

        /* Sunlight Rays */
        .sun-rays-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
            overflow: hidden;
        }

        .ray {
            position: absolute;
            top: -10%;
            width: 80px;
            height: 120%;
            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.2), transparent);
            filter: blur(20px);
            transform: rotate(15deg);
            animation: moveRays 10s infinite linear alternate;
        }

        .ray-1 { left: 10%; animation-duration: 8s; }
        .ray-2 { left: 30%; animation-duration: 12s; }
        .ray-3 { left: 50%; animation-duration: 10s; }
        .ray-4 { left: 70%; animation-duration: 14s; }
        .ray-5 { left: 90%; animation-duration: 9s; }

        @keyframes moveRays {
            from { transform: rotate(12deg) translateX(-20px); opacity: 0.3; }
            to { transform: rotate(18deg) translateX(20px); opacity: 0.6; }
        }

        .login-card-container {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            display: flex;
            max-width: 1000px;
            width: 95%;
            margin: 40px auto;
            overflow: hidden;
            border: 1px solid var(--border);
			
        }

        .auth-side {
            flex: 1.1;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .info-side {
            flex: 1;
            background: rgba(255, 255, 255, 0.05);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .info-header {
            padding: 50px 40px 30px;
            text-align: center;
        }

        .info-header h2 {
            font-weight: 800;
            letter-spacing: 1px;
            color: var(--text-light);
            margin-bottom: 15px;
            text-transform: uppercase;
            font-size: 22px;
        }

        .info-header p {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.6;
            max-width: 320px;
            margin: 0 auto;
        }

        .info-image-container {
            position: relative;
            flex-grow: 1;
            min-height: 280px;
            overflow: hidden;
        }

        .info-image-container .slideshow {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
        }

        .info-image-container .slide {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background-size: cover;
            background-position: center;
            opacity: 0;
            transition: opacity 1.5s ease-in-out;
        }

        .info-image-container .slide.active {
            opacity: 1;
        }

        .info-image-container::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 120px;
            background: linear-gradient(to top, rgba(15, 23, 42, 0.9) 10%, transparent 100%);
            z-index: 2;
        }

        .features-row {
            display: flex;
            padding: 0 30px 50px;
            justify-content: space-between;
            text-align: center;
        }

        .feature-item {
            flex: 1;
            padding: 0 10px;
        }

        .feature-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 18px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
        }

        .icon-dest { color: #f43f5e; }
        .icon-people { color: #3b82f6; }
        .icon-growth { color: #10b981; }

        .feature-name { font-weight: 700; font-size: 13px; margin-bottom: 5px; color: var(--text-light); }
        .feature-desc { font-size: 10px; color: var(--text-muted); line-height: 1.4; }

        /* Form Styling */
        .login-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-title h1 {
            font-weight: 800;
            font-size: 28px;
            color: var(--text-light);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .login-title p {
            color: var(--text-muted);
            font-size: 14px;
        }

        .form-label {
            font-weight: 600;
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 10px;
            display: block;
        }

        .form-control-custom {
            width: 100%;
            padding: 14px 20px;
            border-radius: 14px;
            border: 1px solid var(--border);
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-light);
            font-weight: 500;
            margin-bottom: 22px;
            transition: 0.3s;
            outline: none;
        }

        .form-control-custom:focus {
            border-color: var(--primary-orange);
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 0 4px rgba(240, 76, 38, 0.15);
        }

        .btn-login-submit {
            width: 100%;
            background: var(--primary-orange);
            color: #fff;
            border: none;
            padding: 16px;
            border-radius: 16px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
            transition: 0.3s;
            font-size: 15px;
        }

        .btn-login-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(240, 75, 38, 0.4);
        }

        .auth-footer {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color: var(--text-muted);
        }

        .auth-footer p { margin-bottom: 8px; }
        .auth-footer a {
            color: var(--primary-orange);
            text-decoration: none;
            font-weight: 700;
        }

        @media (max-width: 991px) {
            .login-card-container { 
                flex-direction: column; 
                margin: 20px auto;
                border-radius: 20px;
                max-width: 500px;
            }
            .info-side { border-right: none; border-bottom: 1px solid var(--border); }
            .auth-side { padding: 40px 25px; }
            .info-image-container { min-height: 200px; }
            .feature-desc { display: none; }
        }
    </style>
</head>
<body>

    <!-- Sunlight Rays Effect -->
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
        <div class="ray ray-5"></div>
    </div>

    <div class="login-card-container">
        <!-- Left Side: Info Panel -->
        <div class="info-side">
            <div class="info-header">
                <h2>Adventure. Friendship. Growth.</h2>
                <p>Youth Travel is more than a journey—it's a chance to explore new places, make lifelong friends, and grow into your best self.</p>
            </div>
            <div class="info-image-container">
                <div class="slideshow">
                    <div class="slide active" style="background-image: url('<c:url value='/views/assets/images/gallery-bike.png'/>');"></div>
                    <div class="slide" style="background-image: url('<c:url value='/views/assets/images/gallery-trek.png'/>');"></div>
                    <div class="slide" style="background-image: url('<c:url value='/views/assets/images/gallery-camp-sunset.png'/>');"></div>
                    <div class="slide" style="background-image: url('<c:url value='/views/assets/images/gallery-tent-view.png'/>');"></div>
                </div>
            </div>
            <div class="features-row">
                <div class="feature-item">
                    <div class="feature-icon icon-dest"><i class="fa fa-map-marker"></i></div>
                    <div class="feature-name">Discover New Places</div>
                    <div class="feature-desc">Explore breathtaking destinations and hidden gems.</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon icon-people"><i class="fa fa-users"></i></div>
                    <div class="feature-name">Make New Friends</div>
                    <div class="feature-desc">Connect with like-minded travelers.</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon icon-growth"><i class="fa fa-line-chart"></i></div>
                    <div class="feature-name">Personal Growth</div>
                    <div class="feature-desc">Step out of your comfort zone and grow.</div>
                </div>
            </div>
        </div>

        <!-- Right Side: Login Form -->
        <div class="auth-side">
            <div class="login-title">
                <h1>User Login</h1>
                <p>Welcome back, explorer!</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" style="border-radius: 14px; font-size: 14px; margin-bottom: 20px; background: rgba(220, 38, 38, 0.2); border: 1px solid rgba(220, 38, 38, 0.3); color: #fca5a5; text-align: center;">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success" style="border-radius: 14px; font-size: 14px; margin-bottom: 20px; background: rgba(16, 185, 129, 0.2); border: 1px solid rgba(16, 185, 129, 0.3); color: #6ee7b7; text-align: center;">${message}</div>
            </c:if>

            <form action="<c:url value='/user/login'/>" method="post">
                <div>
                    <label class="form-label"><i class="fa fa-envelope" style="margin-right: 8px;"></i> Email Address</label>
                    <input type="email" name="email" class="form-control-custom" placeholder="ak421237@gmail.com" required>
                </div>
                <div>
                    <label class="form-label"><i class="fa fa-lock" style="margin-right: 8px;"></i> Password</label>
                    <input type="password" name="password" class="form-control-custom" placeholder="••••••" required>
                </div>
                
                <button type="submit" class="btn-login-submit">Login</button>
            </form>

            <div class="auth-footer">
                <p><a href="<c:url value='/user/forgot-password'/>" style="color: var(--text-muted); font-weight: 500;">Forgot Password?</a></p>
                <p>Don't have an account? <a href="<c:url value='/user/register'/>">Register Now</a></p>
                <p><a href="<c:url value='/'/>" style="color: var(--text-muted); font-size: 13px;">Back to Home</a></p>
            </div>
        </div>
    </div>

    <script>
        // Simple Slideshow Script
        (function() {
            const slides = document.querySelectorAll('.slide');
            let current = 0;
            
            function nextSlide() {
                slides[current].classList.remove('active');
                current = (current + 1) % slides.length;
                slides[current].classList.add('active');
            }
            
            setInterval(nextSlide, 4000);
        })();
    </script>
</body>
</html>
