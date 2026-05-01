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
    <title>Homepage</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/owl-carousel/owl.carousel.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/owl-carousel/owl.theme.default.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/jquery.fancybox.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/YouTubePopUp.css'/>">
    <style>
        .yt-gallery-grid {
            padding: 10px 0 0;
        }

        .yt-gallery-card {
            margin-bottom: 24px;
        }

        .yt-gallery-thumb {
            display: block;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 10px 22px rgba(0, 0, 0, 0.15);
            background: #fff;
        }

        .yt-gallery-thumb img {
            width: 100%;
            height: 210px;
            object-fit: cover;
            display: block;
            transition: transform 0.25s ease;
        }

        .yt-gallery-thumb:hover img {
            transform: scale(1.03);
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
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Caveat:wght@600;700&family=Oswald:wght@700&family=Permanent+Marker&display=swap');

        body {
            background-color: #002244;
            color: #fff;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.7);
        }

        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('<c:url value="/views/assets/images/underwater-theme-bg.png"/>') top center/cover no-repeat;
            z-index: -2;
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

        .yt-new-hero {
            position: relative;
            width: 100%;
            min-height: 100vh;
            /* We remove the specific hero background image so the global underwater one shows through,
               or use a translucent overlay */
            background: transparent;
            font-family: 'Dosis', sans-serif;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .yt-new-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, rgba(0,20,40,0.2) 0%, rgba(0,30,60,0.4) 100%);
            z-index: 1;
        }

        .yt-new-nav {
            position: relative;
            z-index: 1000;
            padding: 20px 0;
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

        .hero-main-container {
            position: relative;
            z-index: 10;
            flex-grow: 1;
            display: flex;
            align-items: center;
            padding-top: 50px;
            padding-bottom: 40px;
        }

        .hero-text-content {
            max-width: 800px;
            margin-bottom: 20px;
        }

        .hero-title {
            font-family: 'Permanent Marker', cursive;
            font-size: 78px;
            line-height: 1.1;
            text-transform: uppercase;
            margin: 0 0 25px 0;
            letter-spacing: 2px;
            text-shadow: 2px 4px 10px rgba(0,0,0,0.5);
            transform: skewX(-5deg);
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
            bottom: -15px;
            width: 100%;
            height: 25px;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 200 20" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg"><path d="M 5,15 Q 50,0 100,10 T 195,15 Q 150,20 100,15 T 5,15 Z" fill="%23e63946"/></svg>') no-repeat center;
            background-size: 100% 100%;
            z-index: -1;
            opacity: 0.9;
        }

        .hero-subtitle {
            font-size: 20px;
            color: #e0e0e0;
            margin-bottom: 45px;
            line-height: 1.6;
        }

        .hero-action-btns {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .btn-red {
            background: linear-gradient(135deg, #e63946 0%, #c1121f 100%);
            color: #fff;
            padding: 14px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            border: none;
            display: flex;
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

        .btn-outline {
            background: rgba(15,15,18,0.5);
            color: #fff;
            padding: 14px 24px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            border: 1px solid rgba(255,255,255,0.1);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .btn-outline:hover {
            background: rgba(255,255,255,0.1);
            border-color: rgba(255,255,255,0.3);
            transform: translateY(-2px);
            color: #fff;
        }

        .hero-play-btn {
            position: absolute;
            right: 15%;
            top: 55%;
            transform: translateY(-50%);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .play-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            border: 2px solid #e63946;
            background: rgba(0,0,0,0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #fff;
            cursor: pointer;
            transition: 0.3s;
        }

        .play-circle:hover {
            background: #e63946;
        }

        .play-text {
            font-weight: 600;
            font-size: 16px;
            line-height: 1.2;
        }

        .hero-social {
            position: absolute;
            right: 30px;
            top: 45%;
            transform: translateY(-50%);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }

        .hero-social a {
            color: #fff;
            font-size: 18px;
            opacity: 0.7;
            transition: 0.3s;
        }

        .hero-social a:hover {
            opacity: 1;
            color: #e63946;
        }

        .vertical-text {
            writing-mode: vertical-rl;
            transform: rotate(180deg);
            margin-top: 20px;
            font-size: 12px;
            letter-spacing: 2px;
            opacity: 0.7;
        }

        .hero-bottom-area {
            position: relative;
            z-index: 10;
            padding-bottom: 25px;
        }

        .hero-cards-wrapper {
            display: flex;
            gap: 20px;
            margin-bottom: 35px;
            align-items: stretch;
        }

        .hero-cards-grid {
            display: flex;
            gap: 15px;
            flex: 1;
            align-items: center;
        }

        .card-nav {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: 0.3s;
        }
        
        .card-nav:hover {
            background: rgba(255,255,255,0.1);
        }

        .hero-card {
            background: linear-gradient(145deg, rgba(30,30,35,0.7) 0%, rgba(15,15,18,0.9) 100%);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 16px;
            padding: 30px 15px;
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            transition: all 0.4s ease;
            cursor: pointer;
            height: 100%;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
        }

        .hero-card:hover {
            border-color: rgba(230,57,70,0.8);
            box-shadow: 0 15px 35px rgba(230,57,70,0.2);
            transform: translateY(-8px);
        }

        .hero-card i {
            font-size: 32px;
            margin-bottom: 18px;
            color: #fff;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .hero-card:hover i {
            color: #e63946;
            transform: scale(1.1);
        }

        .hero-card h4 {
            font-size: 15px;
            font-weight: 700;
            margin: 0 0 12px 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #fff;
        }

        .hero-card p {
            font-size: 13px;
            color: #aaa;
            margin: 0;
            line-height: 1.5;
        }

        .hero-special-card {
            color: #222;
            padding: 25px 30px;
            width: 320px;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            z-index: 1;
        }

        .hero-special-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: #fdf5e6;
            z-index: -1;
            filter: url(#rough-edge);
            box-shadow: inset 0 0 20px rgba(0,0,0,0.05);
        }

        .hero-special-card h4 {
            font-family: 'Caveat', cursive;
            font-size: 32px;
            margin: 0 0 15px 0;
            font-weight: 700;
        }

        .avatars {
            display: flex;
            margin-bottom: 15px;
        }

        .avatars img, .avatar-add {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            border: 2px solid #fdf5e6;
            margin-left: -12px;
            object-fit: cover;
        }

        .avatars img:first-child { margin-left: 0; }

        .avatar-add {
            background: #e63946;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            font-weight: bold;
        }

        .hero-special-card p {
            font-size: 13px;
            color: #555;
            margin-bottom: 15px;
        }

        .btn-red-sm {
            background: #e63946;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            transition: 0.3s;
        }
        
        .btn-red-sm:hover {
            background: #c1121f;
        }

        .hero-stats-wrapper {
            position: relative;
            width: 100vw;
            margin-left: calc(-50vw + 50%);
            z-index: 1;
            padding-top: 15px;
            margin-top: 20px;
        }

        .hero-stats-wrapper::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(20,20,22,0.95);
            z-index: -1;
            filter: url(#rough-edge);
            box-shadow: 0 -5px 15px rgba(0,0,0,0.3);
        }

        .hero-stats-footer {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 80px;
            padding: 25px 0 20px 0;
            max-width: 1140px;
            margin: 0 auto;
        }

        .stats-box {
            display: flex;
            gap: 40px;
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .stat-item i {
            font-size: 24px;
            opacity: 0.8;
            color: #fff;
        }

        .stat-item div {
            display: flex;
            flex-direction: column;
        }

        .stat-item strong {
            font-size: 20px;
            color: #e63946;
            font-weight: 700;
        }

        .stat-item span {
            font-size: 11px;
            color: #aaa;
            letter-spacing: 1px;
        }

        .quote-box {
            text-align: center;
            max-width: 320px;
        }

        .quote-box p {
            font-size: 14px;
            font-style: italic;
            color: #ddd;
            margin: 0 0 5px 0;
        }

        .quote-box span {
            font-size: 12px;
            color: #888;
        }

        .newsletter-box {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .newsletter-box p {
            font-size: 14px;
            margin: 0;
            color: #eee;
        }

        .input-group-custom {
            display: flex;
            background: rgba(255,255,255,0.1);
            border-radius: 6px;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.15);
        }

        .input-group-custom input {
            background: transparent;
            border: none;
            padding: 10px 15px;
            color: #fff;
            outline: none;
            font-size: 13px;
            width: 200px;
        }

        .input-group-custom input::placeholder {
            color: #999;
        }

        .input-group-custom button {
            background: #e63946;
            border: none;
            color: #fff;
            padding: 0 18px;
            cursor: pointer;
            transition: 0.3s;
        }
        
        .input-group-custom button:hover {
            background: #c1121f;
        }



        .nav-mobile-toggle {
            display: none;
            color: #fff;
            font-size: 26px;
            cursor: pointer;
            padding: 5px;
        }

        @media (max-width: 1200px) {
            .hero-play-btn { right: 5%; }
            .hero-special-card { width: 250px; }
            .stats-box { gap: 20px; }
        }

        @media (max-width: 991px) {
            .nav-mobile-toggle { display: block; }
            .hero-title { font-size: 50px; }
            .hero-cards-wrapper { flex-direction: column; gap: 20px; }
            .card-nav { display: none; }
            .hero-cards-grid { 
                flex-wrap: nowrap; 
                overflow-x: auto; 
                -webkit-overflow-scrolling: touch;
                padding-bottom: 15px;
                scroll-snap-type: x mandatory;
            }
            .hero-card { 
                min-width: 220px; 
                scroll-snap-align: start;
                flex: 0 0 auto;
            }
            .hero-special-card { width: 100%; }
            .hero-stats-footer { flex-direction: column; gap: 30px; text-align: center; }
            .hero-play-btn, .hero-social { display: none; }
            .stats-box { flex-wrap: wrap; justify-content: center; gap: 20px; }
            
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
                font-size: 18px;
            }
            .nav-links a:last-child {
                border-bottom: none;
            }
            .nav-links a:hover {
                background: rgba(255,255,255,0.05);
                padding-left: 30px;
            }
        }

        @media (max-width: 576px) {
            .hero-title { font-size: 36px; }
            .hero-subtitle { font-size: 16px; margin-bottom: 30px; }
            .hero-action-btns { flex-direction: column; width: 100%; }
            .hero-action-btns a { width: 100%; justify-content: center; }
            .nav-right .login-btn { padding: 8px 16px; font-size: 14px; }
            .stats-box { flex-direction: row; flex-wrap: wrap; justify-content: space-between; }
            .stat-item { flex-direction: column; text-align: center; gap: 5px; width: 45%; margin-bottom: 15px; }
            .stat-item i { font-size: 24px; }
            .input-group-custom { flex-direction: column; background: transparent; border: none; gap: 10px; }
            .input-group-custom input { border: 1px solid rgba(255,255,255,0.2); border-radius: 6px; width: 100%; }
            .input-group-custom button { padding: 12px; border-radius: 6px; width: 100%; }
        }
    </style>

    <section class="yt-new-hero">
        <div class="yt-new-nav">
            <div class="container">
                <div class="nav-flex">
                    <div class="logo">
                        <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" /></a>
                    </div>
                    <div class="nav-links">
                        <a href="<c:url value='/'/>" class="active">Home</a>
                        <a href="#choose-adventure">Explore <i class="fa fa-caret-down"></i></a>
                        <a href="<c:url value='/gallery'/>">Gallery</a>
                        <a href="<c:url value='/about'/>">About Us</a>
                        <a href="<c:url value='/contact'/>">Contact Us</a>
                    </div>
                    <div class="nav-right" style="display: flex; align-items: center; gap: 10px;">
                        <a href="<c:url value='/user/login'/>" class="login-btn">Login / Sign Up</a>
                        <a href="<c:url value='/vendor/login'/>" class="login-btn" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.2); font-size: 14px; padding: 10px 18px;">Vendor Portal</a>
                        <div class="nav-mobile-toggle" onclick="document.querySelector('.nav-links').classList.toggle('active')">
                            <i class="fa fa-bars"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container hero-main-container">
            <div class="hero-text-content">
                <h1 class="hero-title">LIVE YOUNG.<br>CHASE MORE.<br><span class="underline-brush">COLLECT <span class="text-red">STORIES.</span></span></h1>
                <p class="hero-subtitle">Not just places, but moments that<br>stay with you forever.</p>
                
                <div class="hero-action-btns">
                    <a href="#choose-adventure" class="btn-red">Explore Now <i class="fa fa-arrow-right"></i></a>
                    <a href="<c:url value='/plan-trip'/>" class="btn-outline"><i class="fa fa-users"></i> Plan My Trip</a>
                    <a href="<c:url value='/user/register'/>" class="btn-outline"><i class="fa fa-user-plus"></i> Join Community</a>
                </div>
            </div>

            <!-- ===== VERTICAL HERO SLIDESHOW ===== -->
            <style>
                /* Outer wrap — absolute positioned in hero */
                .hero-vss-wrap {
                    position: absolute;
                    right: 85px;
                    top: 50%;
                    transform: translateY(-50%);
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 14px;
                    z-index: 20;
                }

                /* Red pill button above the frame */
                .yt-story-pill {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    background: linear-gradient(135deg, #e63946 0%, #c1121f 100%);
                    color: #fff;
                    font-size: 13px;
                    font-weight: 700;
                    padding: 9px 22px;
                    border-radius: 50px;
                    text-decoration: none;
                    white-space: nowrap;
                    box-shadow: 0 4px 18px rgba(230,57,70,0.5);
                    transition: transform 0.3s, box-shadow 0.3s;
                }
                .yt-story-pill:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 28px rgba(230,57,70,0.7);
                    color: #fff;
                }
                .yt-story-pill-icon {
                    width: 24px; height: 24px;
                    border-radius: 50%;
                    background: rgba(255,255,255,0.22);
                    display: flex; align-items: center; justify-content: center;
                    font-size: 9px;
                }

                /* Torn-paper rough-edge FRAME — same style as Plan with Friends card */
                .yt-vss-frame {
                    position: relative;
                    padding: 12px;
                    z-index: 1;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                }
                .yt-vss-frame::before {
                    content: '';
                    position: absolute;
                    top: 0; left: 0; right: 0; bottom: 0;
                    background: #fdf5e6;
                    z-index: -1;
                    filter: url(#rough-edge);
                    box-shadow: 0 20px 55px rgba(0,0,0,0.55), inset 0 0 18px rgba(0,0,0,0.06);
                }

                /* Inner slideshow box — photos clip inside here */
                .yt-vss-box {
                    width: 220px;
                    height: 300px;
                    border-radius: 10px;
                    overflow: hidden;
                    position: relative;
                    background: #111;
                }
                .yt-vss-track {
                    display: flex;
                    flex-direction: column;
                    transition: transform 0.65s cubic-bezier(0.77,0,0.175,1);
                    will-change: transform;
                }
                .yt-vss-slide {
                    width: 220px;
                    height: 300px;
                    min-height: 300px;
                    overflow: hidden;
                    flex-shrink: 0;
                    position: relative;
                }
                .yt-vss-slide img {
                    width: 100%; height: 100%;
                    object-fit: cover; display: block;
                    transition: transform 8s ease;
                }
                .yt-vss-slide.vss-active img { transform: scale(1.06); }
                .yt-vss-slide::after {
                    content: ''; position: absolute; inset: 0;
                    background: linear-gradient(to bottom, transparent 55%, rgba(0,10,30,0.5) 100%);
                    pointer-events: none;
                }

                /* Dots sit below the box inside the cream frame */
                .yt-vss-dots {
                    display: flex; gap: 7px;
                    margin-top: 9px;
                    z-index: 10;
                }
                .yt-vss-dot {
                    width: 7px; height: 7px; border-radius: 50%;
                    background: rgba(0,0,0,0.25);
                    border: none; padding: 0; cursor: pointer;
                    transition: background 0.3s, transform 0.3s;
                }
                .yt-vss-dot.vss-dot-active { background: #e63946; transform: scale(1.4); }

                @media (max-width: 1280px) { .hero-vss-wrap { right: 50px; } }
                @media (max-width: 1100px) { .hero-vss-wrap { right: 20px; } }
                @media (max-width: 991px)  { .hero-vss-wrap { display: none; } }
            </style>

            <div class="hero-vss-wrap">
                <!-- Red pill button above the frame -->
                <a href="#" class="yt-story-pill">
                    <span class="yt-story-pill-icon"><i class="fa fa-play"></i></span>
                    Watch Our Story
                </a>
                <!-- Torn-paper frame wrapping the slideshow -->
                <div class="yt-vss-frame">
                    <div class="yt-vss-box">
                        <div class="yt-vss-track" id="ytVssTrack">
                            <div class="yt-vss-slide vss-active">
                                <img src="<c:url value='/views/assets/images/new-gallery-1.jpg'/>" alt="Story 1">
                            </div>
                            <div class="yt-vss-slide">
                                <img src="<c:url value='/views/assets/images/new-gallery-2.jpg'/>" alt="Story 2">
                            </div>
                            <div class="yt-vss-slide">
                                <img src="<c:url value='/views/assets/images/new-gallery-3.jpg'/>" alt="Story 3">
                            </div>
                            <div class="yt-vss-slide">
                                <img src="<c:url value='/views/assets/images/new-gallery-4.jpg'/>" alt="Story 4">
                            </div>
                            <div class="yt-vss-slide">
                                <img src="<c:url value='/views/assets/images/new-gallery-5.jpg'/>" alt="Story 5">
                            </div>
                        </div>
                    </div>
                    <!-- Dots inside the cream frame below the photos -->
                    <div class="yt-vss-dots" id="ytVssDots"></div>
                </div>
            </div>

            <script>
            (function(){
                var DELAY = 3500, SLIDE_H = 300;
                var track = document.getElementById('ytVssTrack');
                var dotsWrap = document.getElementById('ytVssDots');
                if(!track || !dotsWrap) return;
                var slides = track.querySelectorAll('.yt-vss-slide');
                var total = slides.length, cur = 0, timer;
                for(var i=0;i<total;i++){
                    var d=document.createElement('button');
                    d.className='yt-vss-dot'+(i===0?' vss-dot-active':'');
                    d.setAttribute('data-i',i);
                    d.addEventListener('click', function(){ go(parseInt(this.getAttribute('data-i'))); });
                    dotsWrap.appendChild(d);
                }
                function dots(){ return dotsWrap.querySelectorAll('.yt-vss-dot'); }
                function go(idx){
                    idx=((idx%total)+total)%total;
                    slides[cur].classList.remove('vss-active');
                    dots()[cur].classList.remove('vss-dot-active');
                    cur=idx;
                    track.style.transform='translateY(-'+(cur*SLIDE_H)+'px)';
                    slides[cur].classList.add('vss-active');
                    dots()[cur].classList.add('vss-dot-active');
                    clearInterval(timer);
                    timer=setInterval(function(){ go(cur+1); }, DELAY);
                }
                timer=setInterval(function(){ go(cur+1); }, DELAY);
                var box=track.closest('.yt-vss-box');
                if(box){
                    box.addEventListener('mouseenter',function(){ clearInterval(timer); });
                    box.addEventListener('mouseleave',function(){ timer=setInterval(function(){ go(cur+1); },DELAY); });
                }
            })();
            </script>
            <!-- ===== END VERTICAL HERO SLIDESHOW ===== -->

            <div class="hero-social">
                <a href="#"><i class="fa fa-instagram"></i></a>
                <a href="#"><i class="fa fa-youtube-play"></i></a>
                <a href="#">
                    <!-- TikTok SVG icon since FontAwesome 4 doesn't have it -->
                    <svg viewBox="0 0 448 512" width="16" fill="currentColor" style="display:block;"><path d="M448 209.91a210.06 210.06 0 0 1 -122.77-39.25V349.38A162.55 162.55 0 1 1 185 188.31V278.2a74.62 74.62 0 1 0 52.23 71.18V0l88 0a121.18 121.18 0 0 0 1.86 22.17h0A122.18 122.18 0 0 0 381 102.39a121.43 121.43 0 0 0 67 20.14Z"/></svg>
                </a>
                <div class="vertical-text">Follow Us</div>
            </div>
        </div>

        <div class="hero-bottom-area">
            <div class="container">
                <div class="hero-cards-wrapper">
                    <div class="card-nav left"><i class="fa fa-arrow-left"></i></div>
                    <div class="hero-cards-grid">
                        <div class="hero-card">
                            <i class="fa fa-area-chart"></i>
                            <h4>TREK & HIKE</h4>
                            <p>Conquer trails,<br>feel alive.</p>
                        </div>
                        <div class="hero-card">
                            <i class="fa fa-tree"></i>
                            <h4>BEACH ESCAPES</h4>
                            <p>Sun, sand and<br>good vibes.</p>
                        </div>
                        <div class="hero-card">
                            <i class="fa fa-bus"></i>
                            <h4>ROAD TRIPS</h4>
                            <p>Endless roads,<br>limitless fun.</p>
                        </div>
                        <div class="hero-card">
                            <i class="fa fa-university"></i>
                            <h4>CULTURE</h4>
                            <p>Explore traditions,<br>embrace stories.</p>
                        </div>
                        <div class="hero-card">
                            <i class="fa fa-fire"></i>
                            <h4>WILD CAMPING</h4>
                            <p>Sleep under stars,<br>wake to dreams.</p>
                        </div>
                    </div>
                    <div class="card-nav right"><i class="fa fa-arrow-right"></i></div>
                    
                    <div class="hero-special-card">
                        <h4 style="font-family: 'Permanent Marker', cursive; font-size: 36px; line-height: 1.2; margin-bottom: 15px; color: #1a1a1a; transform: rotate(-2deg);">Adventure Awaits!</h4>
                        <p style="font-size: 16px; color: #444; line-height: 1.6; font-weight: 500;">Ready to escape the ordinary? Dive into the extraordinary with our curated youth experiences.</p>
                        <div style="margin-top: 20px; padding-top: 15px; border-top: 2px dashed rgba(0,0,0,0.1);">
                            <span style="font-family: 'Caveat', cursive; font-size: 28px; color: #e63946; font-weight: 700;">#ChaseTheHorizon</span>
                        </div>
                    </div>
                </div>

                </div>
                
                <div class="hero-stats-wrapper">
                    <div class="container">
                        <div class="hero-stats-footer">
                            <div class="stats-box">
                                <div class="stat-item">
                                    <i class="fa fa-map-marker"></i>
                                    <div>
                                        <strong>250+</strong>
                                        <span>DESTINATIONS</span>
                                    </div>
                                </div>
                                <div class="stat-item">
                                    <i class="fa fa-users"></i>
                                    <div>
                                        <strong>10K+</strong>
                                        <span>HAPPY TRAVELERS</span>
                                    </div>
                                </div>
                                <div class="stat-item">
                                    <i class="fa fa-star"></i>
                                    <div>
                                        <strong>4.9<span style="color:#e63946">*</span></strong>
                                        <span>GOOGLE RATING</span>
                                    </div>
                                </div>
                                <div class="stat-item">
                                    <i class="fa fa-headphones"></i>
                                    <div>
                                        <strong>24/7</strong>
                                        <span>TRAVEL SUPPORT</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="quote-box">
                                <p>"We travel not to escape life,<br>but for life not to escape us."</p>
                                <span>- Unknown</span>
                            </div>
                            

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section id="choose-adventure" class="yt-home-section yt-choose">
        <div class="container">
            <div class="yt-section-title">
                <span class="yt-line"></span>
                <h3>CHOOSE YOUR ADVENTURE</h3>
                <span class="yt-line"></span>
            </div>
            <div class="row yt-adventure-row">
                <div class="col-sm-6 col-md-3">
                    <div class="yt-adventure-card" style="background-image:url('<c:url value="/views/assets/images/gallery-bike.png"/>');">
                        <div class="yt-adventure-overlay"></div>
                        <div class="yt-adventure-content">
                            <div class="yt-adventure-icon"><i class="fa fa-motorcycle"></i></div>
                            <h4>GROUP RIDES</h4>
                            <p>KTM, Bullet & more. Join epic road trips.</p>
                            <a href="#featured-trips">View Trips <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="yt-adventure-card" style="background-image:url('<c:url value="/views/assets/images/gallery-trek.png"/>');">
                        <div class="yt-adventure-overlay"></div>
                        <div class="yt-adventure-content">
                            <div class="yt-adventure-icon"><i class="fa fa-map-signs"></i></div>
                            <h4>TREKKING</h4>
                            <p>Mountains are calling. Answer the adventure.</p>
                            <a href="#featured-trips">View Trips <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="yt-adventure-card" style="background-image:url('<c:url value="/views/assets/images/gallery-camp-sunset.png"/>');">
                        <div class="yt-adventure-overlay"></div>
                        <div class="yt-adventure-content">
                            <div class="yt-adventure-icon"><i class="fa fa-fire"></i></div>
                            <h4>CAMPING</h4>
                            <p>Sleep under the stars. Stories around the fire.</p>
                            <a href="#featured-trips">View Trips <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="yt-adventure-card" style="background-image:url('<c:url value="/views/assets/images/gallery-tent-view.png"/>');">
                        <div class="yt-adventure-overlay"></div>
                        <div class="yt-adventure-content">
                            <div class="yt-adventure-icon"><i class="fa fa-sun-o"></i></div>
                            <h4>DAY OUTS</h4>
                            <p>Short escapes. Big memories.</p>
                            <a href="#featured-trips">View Trips <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="home-gallery-strip" class="yt-home-section yt-home-gallery">
        <div class="container">
            <div class="yt-section-title yt-section-title-sm">
                <span class="yt-line"></span>
                <h3>GALLERY</h3>
                <span class="yt-line"></span>
            </div>
            <div class="row yt-mini-gallery">
                <c:choose>
                    <c:when test="${not empty galleryImages}">
                        <c:forEach var="img" items="${galleryImages}">
                            <div class="col-xs-6 col-sm-3 col-md-3">
                                <a class="yt-mini-thumb" href="<c:url value='${img.imageUrl}'/>" data-fancybox="home-strip" data-caption="${img.caption}">
                                    <img src="<c:url value='${img.imageUrl}'/>" alt="${img.caption}">
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Fallback static images if none uploaded -->
                        <div class="col-xs-6 col-sm-3 col-md-3">
                            <a class="yt-mini-thumb" href="<c:url value='/views/assets/images/new-gallery-1.jpg'/>" data-fancybox="home-strip" data-caption="Youth Adventure 1">
                                <img src="<c:url value='/views/assets/images/new-gallery-1.jpg'/>" alt="Youth Adventure 1">
                            </a>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-3">
                            <a class="yt-mini-thumb" href="<c:url value='/views/assets/images/new-gallery-2.jpg'/>" data-fancybox="home-strip" data-caption="Youth Adventure 2">
                                <img src="<c:url value='/views/assets/images/new-gallery-2.jpg'/>" alt="Youth Adventure 2">
                            </a>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-3">
                            <a class="yt-mini-thumb" href="<c:url value='/views/assets/images/new-gallery-3.jpg'/>" data-fancybox="home-strip" data-caption="Youth Adventure 3">
                                <img src="<c:url value='/views/assets/images/new-gallery-3.jpg'/>" alt="Youth Adventure 3">
                            </a>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-3">
                            <a class="yt-mini-thumb" href="<c:url value='/views/assets/images/new-gallery-4.jpg'/>" data-fancybox="home-strip" data-caption="Youth Adventure 4">
                                <img src="<c:url value='/views/assets/images/new-gallery-4.jpg'/>" alt="Youth Adventure 4">
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <section id="featured-trips" class="yt-home-section yt-featured">
        <div class="container">
            <div class="yt-section-title yt-section-title-sm">
                <span class="yt-line"></span>
                <h3>FEATURED TRIPS</h3>
                <span class="yt-line"></span>
            </div>

            <div class="row">
                <div class="col-sm-6 col-md-3" style="margin-bottom:18px;">
                    <div class="yt-trip-card">
                        <div class="yt-trip-price">₹2999</div>
                        <img src="https://images.unsplash.com/photo-1598209279122-8541213a0387?w=600&auto=format&fit=crop&q=60" alt="Ride" />
                        <div class="yt-trip-body">
                            <h4>KTM Bengaluru Ride</h4>
                            <p>2 Days / 1 Night<br>Bengaluru → Nandi Hills</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3" style="margin-bottom:18px;">
                    <div class="yt-trip-card">
                        <div class="yt-trip-price">₹4499</div>
                        <img src="https://images.unsplash.com/photo-1551632811-561732d1e306?w=600&auto=format&fit=crop&q=60" alt="Trek" />
                        <div class="yt-trip-body">
                            <h4>Kudremukh Trek</h4>
                            <p>3 Days / 2 Nights<br>Karnataka</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3" style="margin-bottom:18px;">
                    <div class="yt-trip-card">
                        <div class="yt-trip-price">₹1999</div>
                        <img src="https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=600&auto=format&fit=crop&q=60" alt="Camping" />
                        <div class="yt-trip-body">
                            <h4>Camping at Saklespur</h4>
                            <p>1 Day / 1 Night<br>Adventure & Campfire</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3" style="margin-bottom:18px;">
                    <div class="yt-trip-card">
                        <div class="yt-trip-price">₹999</div>
                        <img src="https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=600&auto=format&fit=crop&q=60" alt="Day out" />
                        <div class="yt-trip-body">
                            <h4>Coorg Day Out</h4>
                            <p>Day Trip<br>Waterfalls & Fun</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row yt-feature-icons">
                <div class="col-sm-3 col-xs-6">
                    <div class="yt-icon-card">
                        <i class="fa fa-inr"></i>
                        <div>
                            <strong>BEST PRICES</strong>
                            <span>Affordable adventures</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3 col-xs-6">
                    <div class="yt-icon-card">
                        <i class="fa fa-shield"></i>
                        <div>
                            <strong>TRUST & SAFETY</strong>
                            <span>Your safety, our priority</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3 col-xs-6">
                    <div class="yt-icon-card">
                        <i class="fa fa-users"></i>
                        <div>
                            <strong>EXPERT ORGANIZERS</strong>
                            <span>Trips by experienced travelers</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3 col-xs-6">
                    <div class="yt-icon-card">
                        <i class="fa fa-heart"></i>
                        <div>
                            <strong>MADE FOR YOUTH</strong>
                            <span>By youth, for youth</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="yt-home-section yt-why-better">
        <div class="container">
            <div class="yt-section-title yt-section-title-sm">
                <span class="yt-line"></span>
                <h3>WHY YOUTH TRAVEL IS BETTER</h3>
                <span class="yt-line"></span>
            </div>

            <div class="row yt-why-grid">
                <div class="col-sm-6 col-md-4">
                    <div class="yt-why-card">
                        <div class="yt-why-icon"><i class="fa fa-check-circle"></i></div>
                        <h4>Real prices. No surprises.</h4>
                        <p>Clear inclusions, transparent budgets, and youth-friendly packages—so you don’t get last-minute shocks.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="yt-why-card">
                        <div class="yt-why-icon"><i class="fa fa-shield"></i></div>
                        <h4>Verified partners</h4>
                        <p>We promote trusted vendors and good listings. Safer stays, cleaner camps, and better trip coordination.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="yt-why-card">
                        <div class="yt-why-icon"><i class="fa fa-bolt"></i></div>
                        <h4>Fast planning</h4>
                        <p>Ready itineraries + checklists + trip ideas. Plan a weekend in minutes, not days.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="yt-why-card">
                        <div class="yt-why-icon"><i class="fa fa-users"></i></div>
                        <h4>Made for groups</h4>
                        <p>Friends trip? College trip? We help with group stays, ride plans, and simple coordination.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="yt-why-card">
                        <div class="yt-why-icon"><i class="fa fa-map-marker"></i></div>
                        <h4>Local, Indian travel focus</h4>
                        <p>Routes, timings, and tips built for Indian conditions—weather, weekends, and real travel time.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="yt-why-card">
                        <div class="yt-why-icon"><i class="fa fa-heart"></i></div>
                        <h4>Community vibe</h4>
                        <p>By youth, for youth. Share moments, find ideas, and keep exploring.</p>
                    </div>
                </div>
            </div>

            <div class="yt-why-cta">
                <a class="yt-btn yt-btn-primary" href="#choose-adventure">Explore Experiences</a>
                <a class="yt-btn yt-btn-outline" href="<c:url value='/contact'/>">Talk to Us</a>
            </div>
        </div>
    </section>

    <section class="yt-home-section yt-more-photos">
        <div class="container">
            <div class="yt-section-title yt-section-title-sm">
                <span class="yt-line"></span>
                <h3>MORE MOMENTS</h3>
                <span class="yt-line"></span>
            </div>
            <p class="yt-muted">More photos to make the homepage feel complete and premium.</p>

            <div class="row yt-photo-grid">
                <c:choose>
                    <c:when test="${not empty momentImages}">
                        <c:forEach var="img" items="${momentImages}">
                            <div class="col-xs-6 col-sm-4 col-md-3">
                                <a class="yt-mini-thumb" href="<c:url value='${img.imageUrl}'/>" data-fancybox="more-moments" data-caption="${img.caption}">
                                    <img src="<c:url value='${img.imageUrl}'/>" alt="${img.caption}">
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Fallback static images -->
                        <div class="col-xs-6 col-sm-4 col-md-3">
                            <a class="yt-mini-thumb" href="<c:url value='/views/assets/images/more-waterpark.png'/>" data-fancybox="more-moments" data-caption="Waterpark fun">
                                <img src="<c:url value='/views/assets/images/more-waterpark.png'/>" alt="Waterpark fun">
                            </a>
                        </div>
                        <div class="col-xs-6 col-sm-4 col-md-3">
                            <a class="yt-mini-thumb" href="<c:url value='/views/assets/images/more-scuba.png'/>" data-fancybox="more-moments" data-caption="Scuba diving">
                                <img src="<c:url value='/views/assets/images/more-scuba.png'/>" alt="Scuba diving">
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            </div>
        </div>
    </section>

    <section id="explorer-reviews" class="yt-testimonials">
        <div class="container">
            <h2 class="yt-testimonials-heading">Why Explorers Love Youth Travel</h2>
            <p class="yt-testimonials-lead">Hear from real adventurers who have travelled with us — from serene treks and camping nights to bold group rides across India.</p>
            <div class="row yt-testimonials-row">
                <div class="col-md-4 col-sm-6">
                    <article class="yt-review-card">
                        <header class="yt-review-card-head">
                            <div class="yt-review-avatar yt-review-avatar-a" aria-hidden="true">R</div>
                            <div class="yt-review-meta">
                                <strong class="yt-review-name">Rajesh Kumar</strong>
                                <span class="yt-review-place">Bengaluru, Karnataka</span>
                            </div>
                            <div class="yt-review-rating">
                                <i class="fa fa-star" aria-hidden="true"></i>
                                <span>5.0</span>
                            </div>
                        </header>
                        <p class="yt-review-text">I booked a weekend ride to Nandi Hills through Youth Travel, and the entire process was smooth from enquiry to the day of travel. The itinerary was practical, pricing was transparent, and the organiser was punctual and professional. <em>Truly value-for-money for youngsters who want to explore without any fuss.</em> I have already recommended it to my office friends.</p>
                    </article>
                </div>
                <div class="col-md-4 col-sm-6">
                    <article class="yt-review-card">
                        <header class="yt-review-card-head">
                            <div class="yt-review-avatar yt-review-avatar-b" aria-hidden="true">P</div>
                            <div class="yt-review-meta">
                                <strong class="yt-review-name">Priya Sharma</strong>
                                <span class="yt-review-place">New Delhi</span>
                            </div>
                            <div class="yt-review-rating">
                                <i class="fa fa-star" aria-hidden="true"></i>
                                <span>5.0</span>
                            </div>
                        </header>
                        <p class="yt-review-text">We were a group of six planning a short trek, and Youth Travel helped us shortlist a safe route with clear inclusions. Communication on WhatsApp was prompt, and there were no hidden charges — which matters a lot when you are budgeting as students. <em>The experience felt organised yet relaxed,</em> exactly how a holiday should be. Full marks from our side.</p>
                    </article>
                </div>
                <div class="col-md-4 col-sm-6">
                    <article class="yt-review-card">
                        <header class="yt-review-card-head">
                            <div class="yt-review-avatar yt-review-avatar-c" aria-hidden="true">A</div>
                            <div class="yt-review-meta">
                                <strong class="yt-review-name">Amit Patel</strong>
                                <span class="yt-review-place">Ahmedabad, Gujarat</span>
                            </div>
                            <div class="yt-review-rating">
                                <i class="fa fa-star" aria-hidden="true"></i>
                                <span>5.0</span>
                            </div>
                        </header>
                        <p class="yt-review-text">Excellent initiative for youth who love road trips and outdoor plans but do not want to chase ten different vendors. The website is easy to use, trip details are properly listed, and the support team answers queries politely. <em>Our camping outing was memorable — good coordination and a very positive vibe throughout.</em> Keep up the good work.</p>
                    </article>
                </div>
            </div>
        </div>
    </section>

    <!-- Floating WhatsApp + Chatbot (Home) -->
    <div class="yt-float-stack" aria-label="Quick contact buttons">
        <a class="yt-float-btn yt-float-btn-whatsapp"
           href="https://wa.me/919876543210?text=Hi%20Youth%20Travel%2C%20I%20want%20to%20plan%20a%20trip."
           target="_blank"
           rel="noopener"
           aria-label="Chat on WhatsApp">
            <i class="fa fa-whatsapp" aria-hidden="true"></i>
        </a>

        <button id="ytChatOpen" class="yt-float-btn yt-float-btn-chat" type="button" aria-label="Open chat assistant">
            <img class="yt-chatbot-icon" src="<c:url value='/views/assets/images/yt-chatbot-icon.png'/>" alt="Chatbot">
            <span class="yt-chatbot-hand" aria-hidden="true">
                <svg viewBox="0 0 64 64" width="18" height="18" role="presentation" aria-hidden="true" focusable="false">
                    <defs>
                        <linearGradient id="ytRoboHand" x1="0" x2="1" y1="0" y2="1">
                            <stop offset="0" stop-color="#9af0ff"/>
                            <stop offset="0.55" stop-color="#55c8ff"/>
                            <stop offset="1" stop-color="#3b82f6"/>
                        </linearGradient>
                    </defs>
                    <!-- robotic palm -->
                    <path d="M22 28c0-3 2.4-5.5 5.5-5.5h9C40.6 22.5 43 25 43 28v15c0 6-4.9 11-11 11h-1c-6.1 0-11-5-11-11V28z"
                          fill="rgba(255,255,255,0.12)" stroke="url(#ytRoboHand)" stroke-width="3" stroke-linejoin="round"/>
                    <!-- fingers -->
                    <path d="M24 26V16c0-2 1.6-3.6 3.6-3.6S31.2 14 31.2 16v10"
                          fill="none" stroke="url(#ytRoboHand)" stroke-width="3" stroke-linecap="round"/>
                    <path d="M32 26V14.5c0-2 1.6-3.6 3.6-3.6S39.2 12.5 39.2 14.5V26"
                          fill="none" stroke="url(#ytRoboHand)" stroke-width="3" stroke-linecap="round"/>
                    <path d="M40 27v-8.5c0-2 1.6-3.6 3.6-3.6S47.2 16.5 47.2 18.5V33"
                          fill="none" stroke="url(#ytRoboHand)" stroke-width="3" stroke-linecap="round"/>
                    <!-- thumb -->
                    <path d="M22 32l-4.2-2.4c-1.8-1-4.1-.4-5.2 1.4-1.1 1.9-.4 4.3 1.5 5.3l7.9 4.6"
                          fill="none" stroke="url(#ytRoboHand)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    <!-- small glow dot -->
                    <circle cx="33" cy="39" r="2" fill="#9af0ff" opacity="0.9"/>
                </svg>
            </span>
        </button>
    </div>

    <aside id="ytChatWidget" class="yt-chat-widget" aria-label="Youth Travel chat assistant">
        <div class="yt-chat-head">
            <div class="yt-chat-title">
                <div class="yt-chat-badge" aria-hidden="true"><i class="fa fa-bolt"></i></div>
                <div>
                    <strong>Youth Travel AI</strong>
                    <span>Ask about rides, treks, budgets</span>
                </div>
            </div>
            <button id="ytChatClose" class="yt-chat-close" type="button" aria-label="Close chat">
                <i class="fa fa-times" aria-hidden="true"></i>
            </button>
        </div>
        <div id="ytChatMessages" class="yt-chat-messages" role="log" aria-live="polite"></div>
        <div class="yt-chat-foot">
            <form id="ytChatForm" class="yt-chat-form" autocomplete="off">
                <input id="ytChatInput" class="yt-chat-input" type="text" placeholder="Type your message..." />
                <button class="yt-chat-send" type="submit" aria-label="Send message">
                    <i class="fa fa-paper-plane" aria-hidden="true"></i>
                </button>
            </form>
        </div>
    </aside>

    <section class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="footer-content">
                            <div class="footer-logo">
                                <img src="<c:url value='/views/assets/images/footer-logo.png'/>" alt="" />
                            </div>
                            <div class="footer-text">
                                <p>
                                    Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur
                                </p>
                            </div>
                            <div class="footer-address">
                                <ul>
                                    <li><i class="fa fa-map-marker" aria-hidden="true"></i> Youth Travel, MG Road, Bengaluru, Karnataka, India
                                    </li>

                                    <li>
                                        <i class="fa fa-phone" aria-hidden="true"></i> +91 98765 43210

                                    </li>
                                    <li>
                                        <i class="fa fa-envelope" aria-hidden="true"></i> support@youthtravel.in

                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="footer-content">
                            <div class="news">
                                <p>
                                    Newsletter Subscribe
                                </p>
                            </div>
                            <div class="subscribe">
                                <form>
                                    <div class="input-group">
                                        <input type="email" class="form-control" size="50" placeholder="Enter E-mail" required>
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-danger">Subscribe</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="social-icons">
                                <ul>
                                    <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i>

                                       FACEBOOK</a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i>

                                       TWITTER</a></li>
                                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i>

                                   LINKEDIN</a></li>
                                </ul>
                            </div>
                            <div class="yt-footer-stores" aria-label="Download our app">
                                <a class="yt-store-btn" href="#" aria-label="Get it on Google Play">
                                    <i class="fa fa-android" aria-hidden="true"></i>
                                    <span>
                                        <small>Get it on</small>
                                        <strong>Google Play</strong>
                                    </span>
                                </a>
                                <a class="yt-store-btn" href="#" aria-label="Download on the App Store">
                                    <i class="fa fa-apple" aria-hidden="true"></i>
                                    <span>
                                        <small>Download on</small>
                                        <strong>App Store</strong>
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/owl-carousel/owl.carousel.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/owl-carousel/highlight.js'/>"></script>
    <script src="<c:url value='/views/assets/js/owl-carousel/app.js'/>"></script>
    <script src="<c:url value='/views/assets/js/jquery.fancybox.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/YouTubePopUp.jquery.js'/>"></script>
    <script src="<c:url value='/views/assets/js/yt-chatbot.js'/>"></script>
    <script>
        $(document).ready(function() {
            var owl = $('.owl-carousel');
            var hero = $('.header.yt-home-header');

            function setHeroBgBySlideIndex(slideIndex) {
                var slides = owl.find('.owl-item:not(.cloned) .item');
                if (!slides.length) return;

                var normalized = slideIndex % slides.length;
                if (normalized < 0) normalized += slides.length;

                var bg = $(slides[normalized]).attr('data-bg');
                if (!bg) return;

                hero.css('background-image', 'url(' + bg + ')');

                // Preload next image for smoother transitions.
                var nextIdx = (normalized + 1) % slides.length;
                var nextBg = $(slides[nextIdx]).attr('data-bg');
                if (nextBg) {
                    var img = new Image();
                    img.src = nextBg;
                }
            }

            owl.on('initialized.owl.carousel', function() {
                setHeroBgBySlideIndex(0);
            });

            owl.on('changed.owl.carousel', function(e) {
                if (!e || !e.item) return;

                // Owl adds cloned items for looping; normalize to real slide index.
                var carousel = owl.data('owl.carousel');
                var realCount = e.item.count || 0;
                if (!realCount) return;

                var cloneCount = (carousel && carousel._clones) ? carousel._clones.length : 0;
                var idx = e.item.index - Math.floor(cloneCount / 2);
                idx = idx % realCount;
                if (idx < 0) idx += realCount;

                setHeroBgBySlideIndex(idx);
            });

            owl.owlCarousel({
                margin: 10,
                nav: false,
                loop: true,
                autoplay: true,
                autoplayTimeout: 3000,
                responsive: {
                    0: {
                        items: 1
                    },
                    600: {
                        items: 1
                    },
                    1000: {
                        items: 1
                    }
                }
            })
        })
    </script>
    <script type="text/javascript">
        $("[data-fancybox]").fancybox({});
    </script>
    <script>
        jQuery(function() {
            jQuery("a#video").YouTubePopUp();
        })
    </script>
</body>

</html>