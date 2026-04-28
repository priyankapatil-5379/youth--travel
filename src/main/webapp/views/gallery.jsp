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
    <title>Gallery - Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/owl-carousel/owl.carousel.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/owl-carousel/owl.theme.default.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/jquery.fancybox.min.css'/>">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Caveat:wght@600;700&family=Oswald:wght@700&family=Permanent+Marker&display=swap');

        body {
            background: #002244 url('<c:url value="/views/assets/images/underwater-theme-bg.png"/>') top center/cover no-repeat fixed;
            color: #fff;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.7);
            font-family: 'Dosis', sans-serif;
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
            background: rgba(0,0,0,0.2);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
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

        /* Gallery specific styles */
        .gallery {
            padding: 80px 0;
        }

        .banner-heading h2 {
            font-family: 'Permanent Marker', cursive;
            font-size: 56px;
            color: #e63946;
            margin-bottom: 15px;
        }

        .yt-gallery-grid {
            padding: 40px 0 10px;
        }

        .yt-gallery-card {
            margin-bottom: 30px;
        }

        .yt-gallery-thumb {
            display: block;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            transition: 0.3s;
        }

        .yt-gallery-thumb img {
            width: 100%;
            height: 240px;
            object-fit: cover;
            display: block;
            transition: transform 0.4s ease;
        }

        .yt-gallery-thumb:hover {
            transform: translateY(-8px);
            border-color: #e63946;
            box-shadow: 0 15px 35px rgba(230,57,70,0.2);
        }

        .yt-gallery-thumb:hover img {
            transform: scale(1.08);
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
                    <a href="<c:url value='/gallery'/>" class="active">Gallery</a>
                    <a href="<c:url value='/about'/>">About Us</a>
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

    <section class="gallery" style="background: transparent;">
        <div class="container">
            <div class="banner-heading text-center" style="margin-bottom: 50px;">
                <h2>Gallery</h2>
                <p class="font-18" style="color: #ddd;">Biking, trekking, camping, and road-trip moments — made for youth travel.</p>
            </div>

            <div class="yt-gallery-grid">
                <div class="row">
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-bike.png'/>" data-fancybox="yt-gallery" data-caption="Bike ride">
                            <img src="<c:url value='/views/assets/images/gallery-bike.png'/>" alt="Bike ride" />
                        </a>
                    </div>
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-dirt-bike.png'/>" data-fancybox="yt-gallery" data-caption="Dirt bike race">
                            <img src="<c:url value='/views/assets/images/gallery-dirt-bike.png'/>" alt="Dirt bike race" />
                        </a>
                    </div>
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-trek.png'/>" data-fancybox="yt-gallery" data-caption="Trekking trail">
                            <img src="<c:url value='/views/assets/images/gallery-trek.png'/>" alt="Trekking trail" />
                        </a>
                    </div>
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-camp-sunset.png'/>" data-fancybox="yt-gallery" data-caption="Sunset camping">
                            <img src="<c:url value='/views/assets/images/gallery-camp-sunset.png'/>" alt="Sunset camping" />
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-tent-gear.png'/>" data-fancybox="yt-gallery" data-caption="Camping gear">
                            <img src="<c:url value='/views/assets/images/gallery-tent-gear.png'/>" alt="Camping gear" />
                        </a>
                    </div>
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-tent-view.png'/>" data-fancybox="yt-gallery" data-caption="Tent view">
                            <img src="<c:url value='/views/assets/images/gallery-tent-view.png'/>" alt="Tent view" />
                        </a>
                    </div>
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-couple-tent.png'/>" data-fancybox="yt-gallery" data-caption="Camping together">
                            <img src="<c:url value='/views/assets/images/gallery-couple-tent.png'/>" alt="Camping together" />
                        </a>
                    </div>
                    <div class="col-sm-6 col-md-3 yt-gallery-card">
                        <a class="yt-gallery-thumb" href="<c:url value='/views/assets/images/gallery-van-camp.png'/>" data-fancybox="yt-gallery" data-caption="Van camping">
                            <img src="<c:url value='/views/assets/images/gallery-van-camp.png'/>" alt="Van camping" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="footer" style="background: rgba(0,0,0,0.2); padding: 80px 0; border-top: 1px solid rgba(255,255,255,0.1); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="footer-logo" style="margin-bottom: 20px;">
                        <img src="<c:url value='/views/assets/images/footer-logo.png'/>" alt="" style="height: 40px;"/>
                    </div>
                    <p style="color: #bbb; margin-bottom: 30px;">Not just places, but moments that stay with you forever. Explore the unexplored with Youth Travel.</p>
                    <div class="footer-address" style="color: #999;">
                        <p><i class="fa fa-map-marker" style="color: #e63946; margin-right: 10px;"></i> king Street, Huntavilla, Ontario Canada</p>
                        <p><i class="fa fa-phone" style="color: #e63946; margin-right: 10px;"></i> +(000)-865-5842</p>
                        <p><i class="fa fa-envelope" style="color: #e63946; margin-right: 10px;"></i> demo@gmail.com</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="news">
                        <p style="font-weight: 700; text-transform: uppercase; margin-bottom: 15px;">Newsletter Subscribe</p>
                    </div>
                    <div class="input-group-custom" style="margin-bottom: 30px;">
                        <input type="email" placeholder="Enter E-mail" style="flex: 1; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 12px; color: #fff; border-radius: 6px 0 0 6px;">
                        <button style="background: #e63946; border: none; padding: 0 25px; border-radius: 0 6px 6px 0; font-weight: 600;">Subscribe</button>
                    </div>
                    <div class="social-icons" style="display: flex; gap: 20px;">
                        <a href="#" style="color: #fff; font-size: 20px;"><i class="fa fa-facebook"></i></a>
                        <a href="#" style="color: #fff; font-size: 20px;"><i class="fa fa-twitter"></i></a>
                        <a href="#" style="color: #fff; font-size: 20px;"><i class="fa fa-linkedin"></i></a>
                        <a href="#" style="color: #fff; font-size: 20px;"><i class="fa fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/jquery.fancybox.min.js'/>"></script>
    <script type="text/javascript">
        $("[data-fancybox]").fancybox({});
    </script>
</body>

</html>
