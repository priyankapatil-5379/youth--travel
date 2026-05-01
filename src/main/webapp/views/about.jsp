<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>About Us - Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Caveat:wght@600;700&family=Oswald:wght@700&family=Permanent+Marker&display=swap');

        body {
            background: #002244 url('<c:url value="/views/assets/images/underwater-theme-bg.png"/>') top center/cover no-repeat fixed;
            color: #fff;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.7);
            font-family: 'Dosis', sans-serif;
            overflow-x: hidden;
        }

        /* === SUNLIGHT RAYS === */
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
            height: 150%;
            background: linear-gradient(
                180deg,
                rgba(255, 230, 120, 0.25) 0%,
                rgba(255, 220, 80, 0.12) 40%,
                rgba(255, 255, 255, 0) 100%
            );
            filter: blur(18px);
            transform-origin: top center;
            border-radius: 50%;
            animation: ray-swing 6s ease-in-out infinite alternate;
        }

        .ray-1 { left: 5%;  width: 60px;  animation-duration: 7s;  animation-delay: 0s;   opacity: 0.7; }
        .ray-2 { left: 18%; width: 100px; animation-duration: 9s;  animation-delay: 1s;   opacity: 0.5; }
        .ray-3 { left: 33%; width: 70px;  animation-duration: 6s;  animation-delay: 2s;   opacity: 0.8; }
        .ray-4 { left: 52%; width: 90px;  animation-duration: 8s;  animation-delay: 0.5s; opacity: 0.6; }
        .ray-5 { left: 68%; width: 65px;  animation-duration: 7.5s;animation-delay: 1.5s; opacity: 0.75;}
        .ray-6 { left: 82%; width: 110px; animation-duration: 10s; animation-delay: 3s;   opacity: 0.5; }

        @keyframes ray-swing {
            0%   { transform: rotate(-6deg) scaleX(0.9);  opacity: 0.2; }
            30%  { opacity: 0.9; }
            60%  { transform: rotate(4deg)  scaleX(1.1);  opacity: 0.7; }
            100% { transform: rotate(8deg)  scaleX(0.85); opacity: 0.25; }
        }

        .yt-new-nav {
            position: relative;
            z-index: 1000;
            padding: 20px 0;
            background: rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        .nav-flex {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .nav-flex .logo img {
            height: 40px;
        }

        .nav-links {
            display: flex;
            gap: 35px;
            align-items: center;
        }

        .nav-links a {
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
        }

        .nav-links a:hover, .nav-links a.active {
            color: #e63946;
        }

        .nav-right .login-btn {
            background: #e63946;
            color: #fff;
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
        }

        .nav-right .login-btn:hover {
            background: #c1121f;
        }

        .nav-mobile-toggle {
            display: none;
            color: #fff;
            font-size: 28px;
            cursor: pointer;
            z-index: 2000;
            transition: 0.3s;
        }

        /* Visibility Utilities */
        @media (min-width: 992px) {
            .d-lg-none { display: none !important; }
            .d-lg-inline-block { display: inline-block !important; }
        }
        @media (max-width: 991px) {
            .d-none { display: none !important; }
        }

        @media (max-width: 991px) {
            .nav-mobile-toggle { 
                display: flex !important; 
                position: fixed !important;
                top: 20px;
                right: 20px;
                z-index: 99999 !important; 
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                width: 50px;
                height: 50px;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                border: 1px solid rgba(255, 255, 255, 0.2);
                box-shadow: 0 8px 32px rgba(0,0,0,0.3);
                color: #fff;
                cursor: pointer;
                transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .nav-mobile-toggle:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: scale(1.05);
            }
            .nav-links {
                display: flex !important;
                position: fixed !important;
                top: 0;
                right: -100%;
                width: 100%;
                height: 100vh;
                background: rgba(8, 12, 20, 1);
                backdrop-filter: blur(35px);
                -webkit-backdrop-filter: blur(35px);
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px;
                z-index: 999999 !important; 
                transition: 0.6s cubic-bezier(0.77, 0, 0.175, 1);
                gap: 20px;
                visibility: hidden;
            }
            .nav-links.active {
                right: 0;
                visibility: visible;
            }
            .nav-links a {
                padding: 15px 30px;
                width: 80%;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                font-size: 24px;
                font-weight: 700;
                letter-spacing: 3px;
                text-transform: uppercase;
                color: rgba(255, 255, 255, 0.9);
                opacity: 0;
                transform: translateY(30px);
                transition: 0.5s cubic-bezier(0.4, 0, 0.2, 1);
                text-decoration: none;
            }
            .nav-links a:last-of-type { border-bottom: none; }
            .nav-links.active a {
                opacity: 1;
                transform: translateY(0);
            }
            /* Stagger delays for links */
            .nav-links.active a:nth-child(1) { transition-delay: 0.2s; }
            .nav-links.active a:nth-child(2) { transition-delay: 0.3s; }
            .nav-links.active a:nth-child(3) { transition-delay: 0.4s; }
            .nav-links.active a:nth-child(4) { transition-delay: 0.5s; }
            .nav-links.active a:nth-child(5) { transition-delay: 0.6s; }
            .nav-links.active .mobile-btn-wrap { opacity: 1; transform: translateY(0); transition-delay: 0.7s; }

            .nav-links .mobile-btn-wrap {
                margin-top: 30px;
                display: flex !important;
                flex-direction: column;
                align-items: center;
                gap: 15px;
                width: 100%;
                opacity: 0;
                transform: translateY(30px);
                transition: 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .nav-links a:hover, .nav-links a.active {
                color: #e63946;
                transform: scale(1.05);
            }
            .mobile-btn-wrap .login-btn {
                width: 220px;
                text-align: center;
            }
            .nav-right .login-btn { display: none; }
            .yt-about-hero { z-index: 1 !important; }
        }

        /* PREMIUM HERO SECTION */
        .yt-about-hero {
            padding: 120px 0 80px;
            position: relative;
        }

        .hero-title {
            font-family: 'Permanent Marker', cursive;
            font-size: clamp(38px, 6.5vw, 72px);
            line-height: 1.1;
            text-transform: uppercase;
            margin-bottom: 30px;
            letter-spacing: 2px;
            transform: skewX(-5deg);
            color: #fff;
            text-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
        }

        .text-red {
            color: #e63946;
        }

        .underline-brush {
            position: relative;
            display: inline-block;
        }

        .underline-brush::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -10px;
            width: 100%;
            height: 20px;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 200 20" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg"><path d="M 5,15 Q 50,0 100,10 T 195,15 Q 150,20 100,15 T 5,15 Z" fill="%23e63946"/></svg>') no-repeat center;
            background-size: 100% 100%;
            z-index: -1;
        }

        .hero-subtitle {
            font-size: 22px;
            color: #ddd;
            max-width: 700px;
            line-height: 1.6;
            margin-bottom: 40px;
        }

        /* PREMIUM CARDS (Same as index.jsp hero cards) */
        .yt-about-card {
            background: linear-gradient(145deg, rgba(30,30,35,0.7) 0%, rgba(15,15,18,0.9) 100%);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 16px;
            padding: 35px 25px;
            text-align: center;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            transition: all 0.4s ease;
            height: 100%;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
            margin-bottom: 30px;
        }

        .yt-about-card:hover {
            border-color: rgba(230,57,70,0.8);
            box-shadow: 0 15px 35px rgba(230,57,70,0.2);
            transform: translateY(-8px);
        }

        .yt-about-card i {
            font-size: 42px;
            color: #e63946;
            margin-bottom: 25px;
            display: block;
        }

        .yt-about-card h4 {
            font-family: 'Oswald', sans-serif;
            font-size: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
            color: #fff;
        }

        .yt-about-card p {
            font-size: 14px;
            color: #aaa;
            line-height: 1.6;
        }

        /* SPECIAL ROUGH-EDGE CARD */
        .hero-special-card {
            color: #222;
            padding: 40px;
            position: relative;
            z-index: 1;
            margin-top: 30px;
        }

        .hero-special-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: #fdf5e6;
            z-index: -1;
            filter: url(#rough-edge);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .hero-special-card h4 {
            font-family: 'Caveat', cursive;
            font-size: 38px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .hero-special-card p {
            font-size: 15px;
            color: #444;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .btn-red {
            background: linear-gradient(135deg, #e63946 0%, #c1121f 100%);
            color: #fff;
            padding: 14px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(230,57,70,0.4);
            transition: all 0.3s ease;
        }
        
        .btn-red:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(230,57,70,0.6);
            color: #fff;
        }

        .yt-section-title h3 {
            font-family: 'Permanent Marker', cursive;
            font-size: 36px;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 50px;
        }

        @media (max-width: 768px) {
            .yt-about-hero { padding: 60px 0 40px; }
            .hero-subtitle { font-size: 16px; }
            .yt-about-card { padding: 25px 20px; }
            .yt-about-card i { font-size: 32px; margin-bottom: 15px; }
            .hero-special-card { padding: 25px; margin-top: 40px; }
            .hero-special-card h4 { font-size: 32px; }
            .yt-section-title h3 { font-size: 28px; margin-bottom: 30px; }
        }

        @media (max-width: 576px) {
            .input-group-custom { flex-direction: column; background: transparent !important; border: none !important; gap: 10px; }
            .input-group-custom input { border: 1px solid rgba(255,255,255,0.2) !important; border-radius: 8px !important; width: 100%; }
            .input-group-custom button { padding: 15px !important; border-radius: 8px !important; width: 100%; }
            .social-icons { justify-content: center; margin-top: 20px; }
        }

        /* Prevent infinite horizontal stretch on ultra-wide screens */
        @media (min-width: 2000px) {
            .yt-new-nav .container, .yt-about-page .container, .footer .container {
                max-width: 1600px;
            }
            .yt-about-page {
                max-width: 1920px;
                margin-left: auto;
                margin-right: auto;
            }
        }
    </style>
</head>

<body>
    <svg width="0" height="0" style="position:absolute;z-index:-1;">
        <filter id="rough-edge">
            <feTurbulence type="fractalNoise" baseFrequency="0.05" numOctaves="3" result="noise" />
            <feDisplacementMap in="SourceGraphic" in2="noise" scale="8" xChannelSelector="R" yChannelSelector="G" />
        </filter>
    </svg>

    <!-- Sunlight Rays -->
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
        <div class="ray ray-5"></div>
        <div class="ray ray-6"></div>
    </div>

    <!-- Underwater Animation (Global Fish and Divers) -->
    <div class="fish-container">
        <!-- 1. Clownfish -->
        <div class="fish fish-1 fish-orange">
            <div class="fish-body"></div>
        </div>
        
        <!-- 2. Blue Tang -->
        <div class="fish fish-2 fish-cyan">
            <div class="fish-body"></div>
        </div>
        
        <!-- 3. Yellow Tang -->
        <div class="fish fish-3 fish-golden">
            <div class="fish-body"></div>
        </div>

        <!-- Scuba Divers -->
        <div class="diver diver-1">
            <div class="diver-body"></div>
            <div class="bubble-stream"><span></span><span></span><span></span></div>
        </div>
        <div class="diver diver-2">
            <div class="diver-body"></div>
            <div class="bubble-stream"><span></span><span></span><span></span></div>
        </div>
    </div>

    <div class="yt-new-nav">
        <div class="container">
            <div class="nav-flex">
                <div class="logo">
                    <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" /></a>
                </div>
                <div class="nav-links">
                    <a href="<c:url value='/'/>">Home</a>
                    <a href="<c:url value='/gallery'/>">Gallery</a>
                    <a href="<c:url value='/about'/>" class="active">About Us</a>
                    <a href="<c:url value='/contact'/>">Contact Us</a>
                </div>
                <div class="nav-right" style="display: flex; align-items: center; gap: 15px;">
                    <a href="<c:url value='/user/login'/>" class="login-btn">Login / Sign Up</a>
                    <div class="nav-mobile-toggle" onclick="document.querySelector('.nav-links').classList.toggle('active')">
                        <i class="fa fa-bars"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <main class="yt-about-page">
        <section class="yt-about-hero" style="background: transparent;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1 class="hero-title">BEYOND <span class="text-red">TRAVEL.</span><br><span class="underline-brush">COLLECTING <span class="text-red">LIFE.</span></span></h1>
                        <p class="hero-subtitle">
                            Youth Travel isn't just a booking platform. It's a community of dreamers, riders, and explorers who believe that life happens outside the comfort zone.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <section class="yt-about-showcase" style="padding-bottom: 80px; background: transparent;">
            <div class="container">
                <div class="yt-section-title text-center">
                    <h3>OUR CORE <span class="text-red">CULTURE</span></h3>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <article class="yt-about-card">
                            <i class="fa fa-motorcycle"></i>
                            <h4>Raw Adventures</h4>
                            <p>We don't do luxury resorts. We do mountain passes, dirt tracks, and hidden campfires that the typical tourist never sees.</p>
                        </article>
                    </div>
                    <div class="col-md-4">
                        <article class="yt-about-card">
                            <i class="fa fa-shield"></i>
                            <h4>Safety First</h4>
                            <p>Adventure doesn't mean recklessness. Our plans include vetted routes, emergency coordination, and a community that has your back.</p>
                        </article>
                    </div>
                    <div class="col-md-4">
                        <article class="yt-about-card">
                            <i class="fa fa-users"></i>
                            <h4>Youth Community</h4>
                            <p>Built by youth, for youth. We understand your budget, your energy, and your need for stories that actually matter.</p>
                        </article>
                    </div>
                </div>
            </div>
        </section>

        <section class="yt-about-story" style="padding: 100px 0; background: rgba(0,0,0,0.15); backdrop-filter: blur(3px); -webkit-backdrop-filter: blur(3px); border-top: 1px solid rgba(255,255,255,0.05); border-bottom: 1px solid rgba(255,255,255,0.05);">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-7">
                        <h2 style="font-family: 'Oswald', sans-serif; font-size: 42px; text-transform: uppercase; margin-bottom: 30px;">Why we <span class="text-red">exist</span></h2>
                        <p style="font-size: 18px; line-height: 1.8; color: #eee; margin-bottom: 25px;">
                            We started Youth Travel because we were tired of "tour packages" that felt like school field trips. We wanted the freedom of the road with the security of a plan.
                        </p>
                        <p style="font-size: 18px; line-height: 1.8; color: #eee;">
                            Whether you're planning with college mates or your office gang, we bridge the gap between "we should go" and "we are here." No hidden costs, no boring guides — just raw India.
                        </p>
                    </div>
                    <div class="col-md-5">
                        <div class="hero-special-card">
                            <h4>Built for Indian Weekends</h4>
                            <p>Real travel time, real local knowledge, and support that speaks your language — ensuring your trip is legendary from start to finish.</p>
                            <a class="btn-red" href="<c:url value='/contact'/>" style="width: 100%; justify-content: center;">Join the Movement <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <section class="footer" style="background: rgba(0,0,0,0.2); padding: 80px 0; border-top: 1px solid rgba(255,255,255,0.1); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="footer-logo" style="margin-bottom: 25px;">
                        <img src="<c:url value='/views/assets/images/footer-logo.png'/>" alt="" style="height: 45px;"/>
                    </div>
                    <p style="color: #fff; margin-bottom: 30px; font-size: 16px; line-height: 1.8;">Not just places, but moments that stay with you forever. Explore the unexplored with Youth Travel.</p>
                    <div class="footer-address" style="color: #fff;">
                        <p style="margin-bottom: 12px;"><i class="fa fa-map-marker" style="color: #e63946; margin-right: 12px; width: 20px;"></i> Youth Travel, MG Road, Bengaluru, Karnataka, India</p>
                        <p style="margin-bottom: 12px;"><i class="fa fa-phone" style="color: #e63946; margin-right: 12px; width: 20px;"></i> +91 98765 43210</p>
                        <p style="margin-bottom: 12px;"><i class="fa fa-envelope" style="color: #e63946; margin-right: 12px; width: 20px;"></i> support@youthtravel.in</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="news">
                        <p style="font-weight: 700; text-transform: uppercase; margin-bottom: 20px; letter-spacing: 1px; color: #fff;">Join the Inner Circle</p>
                    </div>
                    <form id="newsFormAbout" onsubmit="subscribeNewsAbout(event)">
                        <div class="input-group-custom" style="margin-bottom: 35px; display: flex; background: rgba(255,255,255,0.05); border-radius: 8px; border: 1px solid rgba(255,255,255,0.1); overflow: hidden;">
                            <input type="email" id="emailAbout" placeholder="Your Email Address" style="flex: 1; background: transparent; border: none; padding: 15px; color: #fff; outline: none;" required>
                            <button type="submit" id="btnAbout" style="background: #e63946; border: none; padding: 0 30px; color: #fff; font-weight: 600; cursor: pointer;">SUBSCRIBE</button>
                        </div>
                    </form>
                    <script>
                        function subscribeNewsAbout(e) {
                            e.preventDefault();
                            const email = document.getElementById('emailAbout').value;
                            const btn = document.getElementById('btnAbout');
                            const formData = new FormData();
                            formData.append("name", "Newsletter Subscriber");
                            formData.append("email", email);
                            formData.append("message", "Subscribed to newsletter.");
                            fetch('/enquiry/submit', { method: 'POST', body: formData })
                            .then(res => {
                                if(res.ok) {
                                    const originalText = btn.innerHTML;
                                    const originalBg = btn.style.background;
                                    btn.innerHTML = "SUBSCRIBED";
                                    btn.style.background = "#4caf50";
                                    btn.disabled = true;
                                    document.getElementById('emailAbout').value = "";
                                    setTimeout(() => {
                                        btn.innerHTML = originalText;
                                        btn.style.background = originalBg;
                                        btn.disabled = false;
                                    }, 3000);
                                }
                            });
                        }
                    </script>
                    <div class="social-icons" style="display: flex; gap: 25px;">
                        <a href="#" style="color: #fff; font-size: 24px; transition: 0.3s;" onmouseover="this.style.color='#e63946'" onmouseout="this.style.color='#fff'"><i class="fa fa-instagram"></i></a>
                        <a href="#" style="color: #fff; font-size: 24px; transition: 0.3s;" onmouseover="this.style.color='#e63946'" onmouseout="this.style.color='#fff'"><i class="fa fa-youtube-play"></i></a>
                        <a href="#" style="color: #fff; font-size: 24px; transition: 0.3s;" onmouseover="this.style.color='#e63946'" onmouseout="this.style.color='#fff'"><i class="fa fa-facebook"></i></a>
                        <a href="#" style="color: #fff; font-size: 24px; transition: 0.3s;" onmouseover="this.style.color='#e63946'" onmouseout="this.style.color='#fff'"><i class="fa fa-twitter"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>

</html>

