<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Youth Travel | Start Your Adventure</title>
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
            color: var(--text-dark);
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
            height: 100%;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .slideshow {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
        }

        .slide {
            position: absolute;
            inset: 0;
            background-size: cover;
            background-position: center;
            opacity: 0;
            transition: opacity 1.5s cubic-bezier(0.4, 0, 0.2, 1);
            transform: scale(1.1);
        }

        .slide.active {
            opacity: 1;
            transform: scale(1);
        }

        .image-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to right, rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.2));
            z-index: 1;
        }

        .brand-floating {
            position: absolute;
            top: 40px;
            left: 40px;
            z-index: 10;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand-logo {
            width: 45px;
            height: 45px;
            object-fit: contain;
            filter: brightness(0) invert(1);
        }

        .brand-name {
            font-weight: 800;
            font-size: 20px;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #ffffff;
        }

        .image-content {
            position: relative;
            z-index: 10;
            padding: 60px;
            max-width: 600px;
            color: #ffffff;
        }

        .display-title {
            font-family: 'Playfair Display', serif;
            font-size: 64px;
            font-weight: 900;
            line-height: 1.1;
            margin-bottom: 24px;
        }

        .display-sub {
            font-size: 18px;
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
        }

        /* Right Side: Form Section (Teal Theme) */
        .form-section {
            flex: 1;
            background: var(--bg-light);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px;
            position: relative;
        }

        .form-container {
            width: 100%;
            max-width: 460px;
            animation: fadeInRight 0.8s ease-out;
        }

        @keyframes fadeInRight {
            from { opacity: 0; transform: translateX(20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            font-weight: 900;
            color: var(--text-dark);
            margin-bottom: 12px;
        }

        .form-header p {
            color: var(--text-muted);
            font-size: 16px;
        }

        /* Form Controls */
        .input-group-custom {
            margin-bottom: 24px;
        }

        .form-label {
            font-weight: 700;
            font-size: 13px;
            color: var(--text-dark);
            margin-bottom: 8px;
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

        .form-control-custom {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 16px 20px 16px 50px;
            color: var(--text-dark);
            font-size: 15px;
            font-weight: 500;
            transition: 0.3s;
            outline: none;
        }

        .form-control-custom:focus {
            background: #ffffff;
            border-color: var(--primary-teal);
            box-shadow: 0 4px 12px var(--teal-glow);
        }

        /* Button Gradient (Teal) */
        .btn-register-luxe {
            width: 100%;
            background: linear-gradient(to right, var(--primary-teal), var(--primary-teal-dark));
            color: #fff;
            border: none;
            padding: 18px;
            border-radius: 14px;
            font-weight: 800;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 10px;
            transition: 0.4s;
            cursor: pointer;
            box-shadow: 0 10px 25px rgba(15, 124, 124, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-register-luxe:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(15, 124, 124, 0.45);
        }

        .login-footer {
            text-align: center;
            margin-top: 32px;
            font-size: 15px;
            color: var(--text-muted);
        }

        .login-footer a {
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 700;
            margin-left: 5px;
            transition: 0.3s;
        }
        .login-footer a:hover { color: var(--primary-teal-dark); text-decoration: underline; }

        /* Alerts */
        .alert-luxe {
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 24px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .alert-error { background: #f0fdfa; color: #0d9488; border: 1px solid #99f6e4; }
        .alert-success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }

        @media (max-width: 991px) {
            body, html { overflow: auto; height: auto; }
            .split-layout { flex-direction: column; height: auto; }
            .image-section { height: 40vh; min-height: 350px; }
            .form-section { padding: 40px 24px; }
            .display-title { font-size: 40px; }
            .image-content { padding: 40px; }
        }
    </style>
</head>
<body>

    <div class="split-layout">
        <!-- Left Side: Immersive Visuals (Preserved) -->
        <div class="image-section">
            <div class="brand-floating">
                <img src="<c:url value='/views/assets/images/logo.png'/>" class="brand-logo" alt="Logo">
                <span class="brand-name">Youth Travel</span>
            </div>
            
            <div class="slideshow">
                <div class="slide active" style="background-image: url('<c:url value='/views/assets/images/gallery-bike.png'/>');"></div>
                <div class="slide" style="background-image: url('<c:url value='/views/assets/images/gallery-trek.png'/>');"></div>
                <div class="slide" style="background-image: url('<c:url value='/views/assets/images/gallery-camp-sunset.png'/>');"></div>
                <div class="slide" style="background-image: url('<c:url value='/views/assets/images/gallery-tent-view.png'/>');"></div>
            </div>
            <div class="image-overlay"></div>
            
            <div class="image-content">
                <h1 class="display-title">Explore.<br>Learn. Grow.</h1>
                <p class="display-sub">Join a global community of young explorers. Start your journey into the wild and discover the extraordinary today.</p>
            </div>
        </div>

        <!-- Right Side: Form Section (Teal Theme) -->
        <div class="form-section">
            <div class="form-container">
                <div class="form-header">
                    <h2>Join the Adventure</h2>
                    <p>Enter your details to start your journey.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert-luxe alert-error"><i class="fa fa-exclamation-circle"></i><span>${error}</span></div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert-luxe alert-success"><i class="fa fa-check-circle"></i><span>${message}</span></div>
                </c:if>

                <form action="<c:url value='/user/register'/>" method="post">
                    <div class="input-group-custom">
                        <label class="form-label">Full Name</label>
                        <div class="input-wrapper">
                            <i class="fa fa-user input-icon"></i>
                            <input type="text" name="fullName" class="form-control-custom" placeholder="John Doe" required>
                        </div>
                    </div>
                    
                    <div class="input-group-custom">
                        <label class="form-label">Email Address</label>
                        <div class="input-wrapper">
                            <i class="fa fa-envelope input-icon"></i>
                            <input type="email" name="email" class="form-control-custom" placeholder="adventure@travel.com" required>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="input-group-custom">
                                <label class="form-label">Phone</label>
                                <div class="input-wrapper">
                                    <i class="fa fa-phone input-icon"></i>
                                    <input type="text" name="phoneNumber" class="form-control-custom" placeholder="+91..." required>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group-custom">
                                <label class="form-label">City</label>
                                <div class="input-wrapper">
                                    <i class="fa fa-map-marker input-icon"></i>
                                    <input type="text" name="city" class="form-control-custom" placeholder="Bengaluru">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="input-group-custom">
                        <label class="form-label">Password</label>
                        <div class="input-wrapper">
                            <i class="fa fa-lock input-icon"></i>
                            <input type="password" name="password" class="form-control-custom" placeholder="••••••••" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-register-luxe">
                        Create Account <i class="fa fa-arrow-right"></i>
                    </button>
                </form>

                <div class="login-footer">
                    Already part of the tribe? <a href="<c:url value='/user/login'/>">Login Here</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        (function() {
            const slides = document.querySelectorAll('.slide');
            let current = 0;
            function nextSlide() {
                slides[current].classList.remove('active');
                current = (current + 1) % slides.length;
                slides[current].classList.add('active');
            }
            setInterval(nextSlide, 5000);
        })();
    </script>
</body>
</html>