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
    <title>Contact Us - Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/owl-carousel/owl.carousel.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/owl-carousel/owl.theme.default.min.css'/>">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Caveat:wght@600;700&family=Oswald:wght@700&family=Permanent+Marker&display=swap');

        body {
            background-color: #002244;
            color: #fff;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.7);
            font-family: 'Dosis', sans-serif;
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

        /* Contact Page Styles */
        .contact-form {
            padding: 80px 0;
        }

        .contact-heading h1 {
            font-family: 'Permanent Marker', cursive;
            font-size: 56px;
            color: #e63946;
            margin-bottom: 15px;
        }

        .contact-heading h3 {
            font-size: 18px;
            color: #ddd;
            margin-bottom: 50px;
        }

        #contact {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 40px;
            max-width: 600px;
            margin: 0 auto;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        #contact h3 {
            font-family: 'Oswald', sans-serif;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 30px;
            text-align: center;
        }

        #contact fieldset {
            border: none;
            margin-bottom: 20px;
        }

        #contact input, #contact textarea {
            width: 100%;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            padding: 15px;
            border-radius: 10px;
            color: #fff;
            outline: none;
            transition: 0.3s;
        }

        #contact input:focus, #contact textarea:focus {
            border-color: #e63946;
            background: rgba(255,255,255,0.1);
        }

        #contact button {
            width: 100%;
            background: linear-gradient(135deg, #e63946 0%, #c1121f 100%);
            border: none;
            padding: 16px;
            border-radius: 10px;
            color: #fff;
            font-weight: 700;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(230,57,70,0.3);
            transition: 0.3s;
        }

        #contact button:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px rgba(230,57,70,0.4);
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
                    <a href="<c:url value='/contact'/>" class="active">Contact Us</a>
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

    <section class="contact-form" style="background: transparent;">
        <div class="container">
            <div class="contact-heading text-center">
                <h1>Contact Us</h1>
                <h3>You can send your feedback or report any issues by submitting the form.</h3>
            </div>
            <form id="contact" onsubmit="submitContactForm(event)">
                <h3 style="color: #fff; margin-bottom: 20px;">Leave your query here</h3>
                <fieldset>
                    <input name="name" placeholder="Your name" type="text" required autofocus>
                </fieldset>
                <fieldset>
                    <input name="email" placeholder="Your Email Address" type="email" required>
                </fieldset>
                <fieldset>
                    <input name="phone" placeholder="Your Phone Number (optional)" type="tel">
                </fieldset>
                <fieldset>
                    <textarea name="message" placeholder="Type your message here...." required style="height: 150px;"></textarea>
                </fieldset>
                <fieldset>
                    <button name="submit" type="submit" id="contact-submit">Submit Message</button>
                </fieldset>
            </form>
        </div>
    </section>

    <script>
        function submitContactForm(e) {
            e.preventDefault();
            const form = document.getElementById('contact');
            const formData = new FormData(form);
            
            fetch('/enquiry/submit', {
                method: 'POST',
                body: formData
            }).then(res => {
                if(res.ok) {
                    alert('Message sent successfully! We will contact you soon.');
                    form.reset();
                } else {
                    alert('Something went wrong. Please try again.');
                }
            }).catch(err => {
                alert('Connection error. Please try again.');
            });
        }
    </script>

    <section class="footer" style="background: rgba(0,0,0,0.2); padding: 80px 0; border-top: 1px solid rgba(255,255,255,0.1); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="footer-logo" style="margin-bottom: 20px;">
                        <img src="<c:url value='/views/assets/images/footer-logo.png'/>" alt="" style="height: 40px;"/>
                    </div>
                    <p style="color: #fff; margin-bottom: 30px;">Not just places, but moments that stay with you forever. Explore the unexplored with Youth Travel.</p>
                    <div class="footer-address" style="color: #fff;">
                        <p><i class="fa fa-map-marker" style="color: #e63946; margin-right: 10px;"></i> Youth Travel, MG Road, Bengaluru, Karnataka, India</p>
                        <p><i class="fa fa-phone" style="color: #e63946; margin-right: 10px;"></i> +91 98765 43210</p>
                        <p><i class="fa fa-envelope" style="color: #e63946; margin-right: 10px;"></i> support@youthtravel.in</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="news">
                        <p style="font-weight: 700; text-transform: uppercase; margin-bottom: 15px; color: #fff;">Newsletter Subscribe</p>
                    </div>
                    <form id="newsFormContact" onsubmit="subscribeNewsContact(event)">
                        <div class="input-group-custom" style="margin-bottom: 30px; display: flex; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 6px; overflow: hidden;">
                            <input type="email" id="emailContact" placeholder="Enter E-mail" style="flex: 1; background: transparent; border: none; padding: 12px; color: #fff; outline: none;" required>
                            <button type="submit" id="btnContact" style="background: #e63946; border: none; padding: 0 25px; color: #fff; font-weight: 600; cursor: pointer;">Subscribe</button>
                        </div>
                    </form>
                    <script>
                        function subscribeNewsContact(e) {
                            e.preventDefault();
                            const email = document.getElementById('emailContact').value;
                            const btn = document.getElementById('btnContact');
                            const formData = new FormData();
                            formData.append("name", "Newsletter Subscriber");
                            formData.append("email", email);
                            formData.append("message", "Subscribed to newsletter.");
                            fetch('/enquiry/submit', { method: 'POST', body: formData })
                            .then(res => {
                                if(res.ok) {
                                    const originalText = btn.innerHTML;
                                    const originalBg = btn.style.background;
                                    btn.innerHTML = "Subscribed";
                                    btn.style.background = "#4caf50";
                                    btn.disabled = true;
                                    document.getElementById('emailContact').value = "";
                                    setTimeout(() => {
                                        btn.innerHTML = originalText;
                                        btn.style.background = originalBg;
                                        btn.disabled = false;
                                    }, 3000);
                                }
                            });
                        }
                    </script>
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
</body>

</html>
