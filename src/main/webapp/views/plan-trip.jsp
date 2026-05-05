<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Plan My Trip</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
</head>

<body class="yt-dark">
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

    <div class="fish-container">
        <div class="fish fish-1 fish-orange"><div class="fish-body"></div></div>
        <div class="fish fish-2 fish-cyan"><div class="fish-body"></div></div>
        <div class="fish fish-3 fish-golden"><div class="fish-body"></div></div>
        <div class="diver diver-1">
            <div class="diver-body"></div>
            <div class="bubble-stream"><span></span><span></span><span></span></div>
        </div>
        <div class="diver diver-2">
            <div class="diver-body"></div>
            <div class="bubble-stream"><span></span><span></span><span></span></div>
        </div>
    </div>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Caveat:wght@600;700&family=Oswald:wght@700&family=Permanent+Marker&display=swap');

        body {
            background-color: #002244;
            color: #fff;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.7);
            font-family: 'Dosis', sans-serif;
            overflow-x: hidden;
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
            top: 0; left: 0; width: 100%; height: 100%;
            z-index: -1; pointer-events: none; overflow: hidden;
        }
        .ray {
            position: absolute; top: -10%; width: 80px; height: 150%;
            background: linear-gradient(180deg, rgba(255, 230, 120, 0.25) 0%, rgba(255, 220, 80, 0.12) 40%, rgba(255, 255, 255, 0) 100%);
            filter: blur(18px); transform-origin: top center; border-radius: 50%;
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

        /* === FISH & SEA LIFE === */
        .fish-container { position: fixed; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; z-index: -1; }
        .fish { position: absolute; width: 140px; height: 100px; opacity: 0.9; filter: drop-shadow(0 12px 25px rgba(0,0,0,0.4)); }
        .fish-body { width: 100%; height: 100%; background-size: contain; background-repeat: no-repeat; background-position: center; animation: fishWiggle 2.5s ease-in-out infinite; }
        .fish-orange .fish-body { background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 120 80'><defs><clipPath id='b'><path d='M15,45 C15,20 85,20 85,45 C85,70 15,70 15,45'/></clipPath></defs><path d='M90,40 L115,20 Q120,40 115,60 L90,40' fill='%23ff7700' stroke='%23331100' stroke-width='2'/><path d='M40,20 Q60,0 90,30' fill='%23ff7700' stroke='%23331100' stroke-width='2'/><path d='M45,60 Q65,80 90,50' fill='%23ff7700' stroke='%23331100' stroke-width='2'/><path d='M15,45 C15,20 85,20 85,45 C85,70 15,70 15,45' fill='%23ff9922' stroke='%23331100' stroke-width='2'/><g clip-path='url(%23b)'><path d='M35,10 Q45,45 35,80 M55,10 Q65,45 55,80 M75,10 Q85,45 75,80' fill='none' stroke='white' stroke-width='9' opacity='0.8'/></g><circle cx='32' cy='40' r='9' fill='white' stroke='%23331100' stroke-width='1.5'/><circle cx='34' cy='40' r='5' fill='black'/><circle cx='32' cy='38' r='2' fill='white'/><circle cx='38' cy='52' r='2.5' fill='%23ff77aa' opacity='0.6'/><path d='M15,45 Q10,45 10,48 Q10,51 15,50' fill='none' stroke='%23331100' stroke-width='2'/></svg>"); }
        .fish-cyan .fish-body { background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 120 80'><defs><clipPath id='b'><path d='M15,45 C15,20 85,20 85,45 C85,70 15,70 15,45'/></clipPath></defs><path d='M90,40 L115,20 Q120,40 115,60 L90,40' fill='%230077be' stroke='%23003366' stroke-width='2'/><path d='M40,20 Q60,0 90,30' fill='%230077be' stroke='%23003366' stroke-width='2'/><path d='M45,60 Q65,80 90,50' fill='%230077be' stroke='%23003366' stroke-width='2'/><path d='M15,45 C15,20 85,20 85,45 C85,70 15,70 15,45' fill='%2300aaff' stroke='%23003366' stroke-width='2'/><g clip-path='url(%23b)'><path d='M35,10 Q45,45 35,80 M55,10 Q65,45 55,80 M75,10 Q85,45 75,80' fill='none' stroke='%23ffdd00' stroke-width='9' opacity='0.8'/></g><circle cx='32' cy='40' r='9' fill='white' stroke='%23003366' stroke-width='1.5'/><circle cx='34' cy='40' r='5' fill='black'/><circle cx='32' cy='38' r='2' fill='white'/><circle cx='38' cy='52' r='2.5' fill='%23ff77aa' opacity='0.6'/><path d='M15,45 Q10,45 10,48 Q10,51 15,50' fill='none' stroke='%23003366' stroke-width='2'/></svg>"); }
        .fish-golden .fish-body { background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 120 80'><defs><clipPath id='b'><path d='M15,45 C15,20 85,20 85,45 C85,70 15,70 15,45'/></clipPath></defs><path d='M90,40 L115,20 Q120,40 115,60 L90,40' fill='%238800cc' stroke='%23330066' stroke-width='2'/><path d='M40,20 Q60,0 90,30' fill='%238800cc' stroke='%23330066' stroke-width='2'/><path d='M45,60 Q65,80 90,50' fill='%238800cc' stroke='%23330066' stroke-width='2'/><path d='M15,45 C15,20 85,20 85,45 C85,70 15,70 15,45' fill='%23aa33ff' stroke='%23330066' stroke-width='2'/><g clip-path='url(%23b)'><path d='M35,10 Q45,45 35,80 M55,10 Q65,45 55,80 M75,10 Q85,45 75,80' fill='none' stroke='%23ff66cc' stroke-width='9' opacity='0.8'/></g><circle cx='32' cy='40' r='9' fill='white' stroke='%23330066' stroke-width='1.5'/><circle cx='34' cy='40' r='5' fill='black'/><circle cx='32' cy='38' r='2' fill='white'/><circle cx='38' cy='52' r='2.5' fill='%23ff99cc' opacity='0.6'/><path d='M15,45 Q10,45 10,48 Q10,51 15,50' fill='none' stroke='%23330066' stroke-width='2'/></svg>"); }
        .fish-1 { top: 15%; animation: swim-right 28s linear infinite; }
        .fish-2 { top: 45%; animation: swim-left 34s linear infinite; }
        .fish-3 { top: 75%; animation: swim-right 22s linear infinite; }

        .diver { position: absolute; width: 200px; height: 100px; opacity: 0.8; filter: drop-shadow(0 10px 15px rgba(0,0,0,0.5)); z-index: -1; }
        .diver-body { width: 100%; height: 100%; background-size: contain; background-repeat: no-repeat; background-position: center; background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 240 120'><defs><linearGradient id='g1' x1='0%25' y1='0%25' x2='0%25' y2='100%25'><stop offset='0%25' stop-color='%232563eb'/><stop offset='100%25' stop-color='%231e3a8a'/></linearGradient><linearGradient id='g2' x1='0%25' y1='0%25' x2='0%25' y2='100%25'><stop offset='0%25' stop-color='%23ffffff'/><stop offset='100%25' stop-color='%23d1d5db'/></linearGradient></defs><path d='M100,20 L160,40 Q165,45 160,50 L100,30 Z' fill='url(%23g2)' stroke='%234b5563' stroke-width='1'/><path d='M115,25 L117,45 M140,33 L142,53' stroke='%23374151' stroke-width='2' opacity='0.3'/><path d='M30,55 Q60,35 120,45 L170,55 L165,85 L140,75 L80,80 Q40,80 30,55 Z' fill='url(%23g1)' stroke='%231e1b4b' stroke-width='1.5'/><path d='M40,55 Q70,50 110,55' fill='none' stroke='%233b82f6' stroke-width='3' opacity='0.4'/><path d='M170,55 L210,40 L215,60 Z' fill='%231e40af' stroke='%231e3a8a' stroke-width='1'/><path d='M165,85 L205,100 L210,80 Z' fill='%231e40af' stroke='%231e3a8a' stroke-width='1'/><circle cx='38' cy='52' r='14' fill='%230f172a'/><path d='M25,48 Q50,48 50,56 Q50,64 25,64 Z' fill='%23334155'/><rect x='28' y='50' width='18' height='10' rx='3' fill='%23bae6fd' opacity='0.8'/><path d='M110,25 Q80,25 50,55' fill='none' stroke='%23111' stroke-width='2'/></svg>"); animation: diverWiggle 5s ease-in-out infinite; }
        .diver-1 { left: -200px; top: 30%; animation: swim-right 45s linear infinite; }
        .diver-2 { right: -200px; top: 60%; animation: swim-left 55s linear infinite; }

        .bubble-stream { position: absolute; top: 40%; left: 20%; }
        .bubble-stream span { position: absolute; width: 8px; height: 8px; background: rgba(255, 255, 255, 0.4); border: 1px solid rgba(255, 255, 255, 0.6); border-radius: 50%; animation: risingBubbles 3s infinite ease-out; }
        .bubble-stream span:nth-child(2) { animation-delay: 1s; left: 5px; width: 6px; height: 6px; }
        .bubble-stream span:nth-child(3) { animation-delay: 2s; left: -5px; width: 10px; height: 10px; }

        @keyframes fishWiggle { 0%, 100% { transform: rotate(-3deg); } 50% { transform: rotate(3deg); } }
        @keyframes diverWiggle { 0%, 100% { transform: translateY(0) rotate(-2deg); } 50% { transform: translateY(-10px) rotate(2deg); } }
        @keyframes swim-right { 0% { left: -150px; transform: scaleX(-1); } 100% { left: 110%; transform: scaleX(-1); } }
        @keyframes swim-left { 0% { right: -150px; transform: scaleX(1); } 100% { right: 110%; transform: scaleX(1); } }
        @keyframes risingBubbles { 0% { transform: translateY(0) scale(1); opacity: 0; } 50% { opacity: 0.8; } 100% { transform: translateY(-100px) scale(1.5); opacity: 0; } }

        /* Navigation & Content Styles */
        .yt-new-nav {
            position: relative;
            z-index: 1000;
            padding: 20px 0;
        }

        .nav-flex {
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
        }

        .nav-flex .logo { flex: 1; }
        .nav-flex .logo img { height: 40px; }
        .nav-links {
            display: flex;
            gap: 35px;
            align-items: center;
            justify-content: center;
            flex: 2;
        }
        .nav-links a {
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
        }
        .nav-links a:hover, .nav-links a.active { color: #e63946; }
        .nav-right {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 10px;
            flex: 1;
        }
        .nav-right .login-btn {
            background: #e63946;
            color: #fff;
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
            display: inline-block;
        }
        .nav-right .login-btn:hover { background: #c1121f; }
        .nav-mobile-toggle {
            display: none;
            color: #fff;
            font-size: 28px;
            cursor: pointer;
            z-index: 2000;
            transition: 0.3s;
        }

        /* Planner Content Styles */
        .yt-plan-container {
            position: relative;
            z-index: 10;
            padding: 60px 0 100px;
        }

        .yt-plan-hero-inner h1 {
            font-family: 'Chelsea Market', cursive;
            font-size: 56px;
            font-weight: 800;
            margin-bottom: 15px;
            color: #fff;
            text-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
            text-align: center;
        }
        .yt-plan-hero-inner p {
            color: rgba(255,255,255,0.9);
            font-size: 20px;
            font-weight: 600;
            max-width: 600px;
            margin: 0 auto 50px;
            text-align: center;
        }

        .yt-plan-card {
            background: linear-gradient(145deg, rgba(30,30,35,0.7) 0%, rgba(15,15,18,0.9) 100%);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            margin-bottom: 60px;
        }

        .yt-plan-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
            align-items: end;
        }
        .yt-plan-field span {
            display: block;
            margin-bottom: 10px;
            font-size: 14px;
            font-weight: 700;
            color: #e63946;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .yt-plan-field input, .yt-plan-field select {
            width: 100%;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 12px;
            padding: 12px 15px;
            color: #fff;
            font-weight: 600;
            transition: 0.3s;
        }
        .yt-plan-field input:focus, .yt-plan-field select:focus {
            border-color: #e63946;
            background: rgba(255,255,255,0.1);
            outline: none;
        }
        .yt-plan-field select option {
            background: #1a1a20;
            color: #fff;
            padding: 10px;
        }

        .yt-btn {
            padding: 14px 28px;
            border-radius: 12px;
            font-weight: 700;
            transition: 0.3s;
            text-align: center;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .yt-btn-primary { background: #e63946; color: #fff; box-shadow: 0 4px 15px rgba(230,57,70,0.4); }
        .yt-btn-primary:hover { background: #c1121f; transform: translateY(-2px); box-shadow: 0 6px 20px rgba(230,57,70,0.6); }

        .yt-plan-status {
            text-align: center;
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 40px;
            color: #fff;
            text-shadow: 0 2px 10px rgba(0,0,0,0.5);
        }

        .yt-plan-result-card {
            background: linear-gradient(145deg, rgba(30,30,35,0.7) 0%, rgba(15,15,18,0.9) 100%);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 20px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            transition: 0.4s;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
        }
        .yt-plan-result-card:hover {
            transform: translateY(-10px);
            border-color: rgba(230, 57, 70, 0.8);
            box-shadow: 0 20px 45px rgba(230, 57, 70, 0.2);
        }
        .yt-plan-result-img {
            height: 200px;
            min-height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        .yt-plan-result-img::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, transparent 60%, rgba(0,0,0,0.8) 100%);
        }
        .yt-plan-result-body { 
            padding: 25px; 
            flex: 1; 
            display: flex; 
            flex-direction: column; 
        }
        .yt-plan-result-top { display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px; gap: 10px; }
        .yt-plan-result-top strong { 
            font-size: 20px; 
            font-weight: 800; 
            color: #fff; 
            line-height: 1.2;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .yt-plan-pill { background: rgba(230, 57, 70, 0.2); color: #fff; border: 1px solid rgba(230,57,70,0.5); padding: 4px 10px; border-radius: 20px; font-weight: 800; font-size: 13px; white-space: nowrap; }
        .yt-plan-result-meta { display: flex; flex-wrap: wrap; gap: 15px; color: rgba(255,255,255,0.6); font-size: 13px; margin-bottom: 15px; }
        .yt-plan-result-meta i { color: #e63946; margin-right: 5px; }
        .yt-plan-result-body p { 
            color: rgba(255,255,255,0.8); 
            font-size: 14px; 
            line-height: 1.5; 
            font-weight: 500;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .yt-plan-result-actions { margin-top: auto; }

        /* Results Grid Upgrade */
        .yt-plan-results {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }
        /* Override bootstrap row behavior for our custom grid */
        .yt-plan-results::before, .yt-plan-results::after { display: none; }
        
        /* Remove bootstrap padding from columns if used inside grid */
        .yt-plan-results > div[class*="col-"] {
            width: 100% !important;
            padding: 0 !important;
            margin: 0 !important;
        }

        @media (max-width: 991px) {
            .nav-mobile-toggle { display: flex !important; }
            .yt-plan-grid { grid-template-columns: 1fr; }
            .yt-plan-hero-inner h1 { font-size: 42px; }
            .yt-plan-results { grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; }
        }
        @media (max-width: 576px) {
            .yt-plan-results { grid-template-columns: 1fr; }
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
                        <a href="<c:url value='/'/>">Home</a>
                        <a href="<c:url value='/gallery'/>">Gallery</a>
                        <a href="<c:url value='/about'/>">About Us</a>
                        <a href="<c:url value='/contact'/>">Contact Us</a>
                    </div>
                    <div class="nav-right">
                        <div class="nav-mobile-toggle" onclick="document.querySelector('.nav-links').classList.toggle('active')">
                            <i class="fa fa-bars"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container yt-plan-container">
            <div class="yt-plan-hero-inner">
                <h1>PLAN YOUR ESCAPE</h1>
                <p>Ready to collect stories? Enter your budget and vibe, we'll handle the rest.</p>
            </div>

            <div class="yt-plan-card">
                <form id="ytPlanForm" class="yt-plan-form" autocomplete="off">
                    <div class="yt-plan-grid">
                        <label class="yt-plan-field">
                            <span>BUDGET (₹)</span>
                            <input id="ytBudget" type="number" min="0" step="100" placeholder="Eg: 3000" required>
                        </label>
                        <label class="yt-plan-field">
                            <span>DURATION</span>
                            <select id="ytDays">
                                <option value="1">1 day</option>
                                <option value="2" selected>2 days</option>
                                <option value="3">3 days</option>
                                <option value="4">4 days</option>
                            </select>
                        </label>
                        <label class="yt-plan-field">
                            <span>VIBE</span>
                            <select id="ytType">
                                <option value="any" selected>Any Adventure</option>
                                <option value="rides">Bike Rides</option>
                                <option value="trekking">Trekking</option>
                                <option value="camping">Camping</option>
                                <option value="dayouts">Day Outs</option>
                            </select>
                        </label>
                        <div class="yt-plan-actions">
                            <button class="yt-btn yt-btn-primary" type="submit">SEARCH ADVENTURES <i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </form>
            </div>

            <div id="ytPlanStatus" class="yt-plan-status" aria-live="polite"></div>
            <div id="ytPlanResults" class="yt-plan-results" aria-label="Suggested trips"></div>
        </div>
    </section>

<section class="footer" style="position: relative; z-index: 20; background: rgba(8, 12, 20, 0.9); backdrop-filter: blur(10px);">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-6">
                    <div class="footer-content">
                        <div class="footer-logo">
                            <img src="<c:url value='/views/assets/images/footer-logo.png'/>" alt="" />
                        </div>
                        <div class="footer-text">
                            <p>Connecting the youth with extraordinary experiences. Explore India like never before with curated trips, safe stays, and like-minded travelers.</p>
                        </div>
                        <div class="footer-address">
                            <ul>
                                <li><i class="fa fa-map-marker" aria-hidden="true"></i> Youth Travel, MG Road, Bengaluru, Karnataka, India</li>
                                <li><i class="fa fa-phone" aria-hidden="true"></i> +91 98765 43210</li>
                                <li><i class="fa fa-envelope" aria-hidden="true"></i> support@youthtravel.in</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="footer-content">
                        <div class="news">
                            <p>Stay Updated</p>
                        </div>
                        <div class="subscribe">
                            <form id="newsletterForm" onsubmit="subscribeNewsletter(event)">
                                <div class="input-group">
                                    <input type="email" id="newsletterEmail" class="form-control" size="50" placeholder="Enter E-mail" required>
                                    <div class="input-group-btn">
                                        <button type="submit" id="subscribeBtn" class="btn btn-danger">Subscribe</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="social-icons">
                            <ul>
                                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i> FACEBOOK</a></li>
                                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i> TWITTER</a></li>
                                <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i> LINKEDIN</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
<script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
<script>
    function subscribeNewsletter(e) {
        e.preventDefault();
        const email = document.getElementById('newsletterEmail').value;
        const btn = document.getElementById('subscribeBtn');
        const formData = new FormData();
        formData.append("name", "Newsletter Subscriber");
        formData.append("email", email);
        formData.append("message", "Subscribed to newsletter.");
        fetch('/enquiry/submit', { method: 'POST', body: formData })
        .then(res => {
            if(res.ok) {
                const originalText = btn.innerHTML;
                btn.innerHTML = "Subscribed";
                btn.style.background = "#4caf50";
                btn.disabled = true;
                document.getElementById('newsletterEmail').value = "";
                setTimeout(() => {
                    btn.innerHTML = originalText;
                    btn.style.background = "";
                    btn.disabled = false;
                }, 3000);
            }
        });
    }

    (function() {
        const form = document.getElementById('ytPlanForm');
        const budgetEl = document.getElementById('ytBudget');
        const daysEl = document.getElementById('ytDays');
        const typeEl = document.getElementById('ytType');
        const statusEl = document.getElementById('ytPlanStatus');
        const resultsEl = document.getElementById('ytPlanResults');

        function escapeHtml(str) {
            return String(str)
                .replaceAll("&", "&amp;")
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll('"', "&quot;")
                .replaceAll("'", "&#039;");
        }

        function setStatus(text) {
            statusEl.textContent = text || "";
        }
        function renderResults(items) {
            resultsEl.innerHTML = "";
            if (!items || !items.length) {
                resultsEl.innerHTML = '<div class="col-sm-12 text-center py-5"><div class="yt-plan-empty" style="color: rgba(255,255,255,0.4); font-size: 18px; border: 1px dashed rgba(255,255,255,0.2); padding: 30px; border-radius: 20px;">No adventures found matching your pocket. Try a different vibe!</div></div>';
                return;
            }

            resultsEl.innerHTML = items.map((it) => {
                const img = it && it.image ? String(it.image) : "https://images.unsplash.com/photo-1501555088652-021faa106b9b?auto=format&fit=crop&w=800&q=80";
                const name = escapeHtml(it && it.name ? it.name : "");
                const place = escapeHtml(it && it.place ? it.place : "");
                const days = escapeHtml(it && it.days != null ? it.days : "");
                const price = it && it.price != null ? it.price : "??";
                const tag = escapeHtml(it && it.tag ? it.tag : "");
                const tripId = it && it.id ? it.id : "";
                const detailUrl = "<c:url value='/user/package-details/'/>" + tripId;

                return ''
                    + '  <article class="yt-plan-result-card">'
                    + '    <div class="yt-plan-result-img" style="background-image:url(\'' + img + '\')"></div>'
                    + '    <div class="yt-plan-result-body">'
                    + '      <div class="yt-plan-result-top">'
                    + '        <strong>' + name + '</strong>'
                    + '        <span class="yt-plan-pill">₹' + price + '</span>'
                    + '      </div>'
                    + '      <div class="yt-plan-result-meta">'
                    + '        <span><i class="fa fa-map-marker"></i> ' + place + '</span>'
                    + '        <span><i class="fa fa-calendar"></i> ' + days + ' day(s)</span>'
                    + '      </div>'
                    + '      <p>' + tag + '</p>'
                    + '      <div class="yt-plan-result-actions mt-3">'
                    + '        <a class="yt-btn yt-btn-primary d-block" href="' + detailUrl + '">VIEW DETAILS <i class="fa fa-arrow-right"></i></a>'
                    + '      </div>'
                    + '    </div>'
                    + '  </article>';
            }).join('');
        }

        async function fetchPlan() {
            const budget = Number(budgetEl.value || 0);
            const days = Number(daysEl.value || 0);
            const type = String(typeEl.value || "any");

            setStatus("Analyzing the best escapes for you...");

            try {
                const res = await fetch("/api/plan-trip", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ budget, days, type })
                });

                if (!res.ok) throw new Error("HTTP " + res.status);
                const data = await res.json();

                setStatus(data.count ? ("We found " + data.count + " epic adventures for you!") : "No adventures found for this budget.");
                renderResults(data.results || []);
            } catch (e) {
                setStatus("Something went wrong. Dive in again later!");
            }
        }

        form.addEventListener("submit", async (e) => {
            e.preventDefault();
            resultsEl.innerHTML = "";
            await fetchPlan();
        });

        budgetEl.value = 20000;
        window.setTimeout(() => {
            form.dispatchEvent(new Event("submit"));
        }, 150);
    })();
</script>
</body>
</html>


