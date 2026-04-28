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
            font-size: 26px;
            cursor: pointer;
            padding: 5px;
        }

        @media (max-width: 991px) {
            .nav-mobile-toggle { display: block; }
            .nav-links {
                display: none;
                position: absolute;
                top: 70px;
                left: 0;
                right: 0;
                background: #111111;
                flex-direction: column;
                padding: 15px 0;
                border-radius: 8px;
                z-index: 1050;
                border: 1px solid rgba(255,255,255,0.1);
                box-shadow: 0 20px 40px rgba(0,0,0,0.8);
                gap: 0;
            }
            .nav-links.active {
                display: flex;
            }
            .nav-links a {
                padding: 12px 25px;
                width: 100%;
                text-align: left;
                border-bottom: 1px solid rgba(255,255,255,0.05);
            }
        }

        /* PREMIUM HERO SECTION */
        .yt-about-hero {
            padding: 120px 0 80px;
            position: relative;
        }

        .hero-title {
            font-family: 'Permanent Marker', cursive;
            font-size: 72px;
            line-height: 1.1;
            text-transform: uppercase;
            margin-bottom: 30px;
            letter-spacing: 2px;
            transform: skewX(-5deg);
            color: #fff;
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
            .hero-title { font-size: 48px; }
            .hero-subtitle { font-size: 18px; }
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
                    <p style="color: #bbb; font-size: 16px; margin-bottom: 35px; max-width: 450px;">Collect moments, not things. Youth Travel is your gateway to the most authentic adventures across India.</p>
                    <div class="footer-address" style="color: #999; font-size: 15px;">
                        <p><i class="fa fa-map-marker" style="color: #e63946; margin-right: 15px;"></i> king Street, Huntavilla, Ontario Canada</p>
                        <p><i class="fa fa-phone" style="color: #e63946; margin-right: 15px;"></i> +(000)-865-5842</p>
                        <p><i class="fa fa-envelope" style="color: #e63946; margin-right: 15px;"></i> contact@youthtravel.in</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="news">
                        <p style="font-weight: 700; text-transform: uppercase; margin-bottom: 20px; letter-spacing: 1px;">Join the Inner Circle</p>
                    </div>
                    <div class="input-group-custom" style="margin-bottom: 35px; display: flex; background: rgba(255,255,255,0.05); border-radius: 8px; border: 1px solid rgba(255,255,255,0.1); overflow: hidden;">
                        <input type="email" placeholder="Your Email Address" style="flex: 1; background: transparent; border: none; padding: 15px; color: #fff; outline: none;">
                        <button style="background: #e63946; border: none; padding: 0 30px; color: #fff; font-weight: 600; cursor: pointer;">SUBSCRIBE</button>
                    </div>
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

