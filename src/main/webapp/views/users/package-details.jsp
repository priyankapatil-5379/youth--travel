<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${trip.title} | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/dark.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Permanent+Marker&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #000a12;
            --accent-red: #e63946;
            --glass-card: rgba(255, 255, 255, 0.03);
            --glass-border: rgba(255, 255, 255, 0.08);
            --text-light: #f8fafc;
            --text-dim: #94a3b8;
        }

        body { font-family: 'Outfit', sans-serif; background-color: var(--bg-dark); color: var(--text-light); margin: 0; padding: 0; }
        .container-main { max-width: 1200px; margin: 40px auto; padding: 0 20px; display: grid; grid-template-columns: 1.8fr 1fr; gap: 30px; }
        .content-left { overflow: hidden; }

        .breadcrumb-nav { display: flex; align-items: center; gap: 10px; margin-bottom: 25px; font-size: 13px; font-weight: 600; color: var(--text-muted); }
        .breadcrumb-nav a { color: var(--text-muted); text-decoration: none; transition: 0.3s; }
        .breadcrumb-nav a:hover { color: #fff; }
        .breadcrumb-nav i { font-size: 10px; }

        .main-visual { position: relative; border-radius: 24px; overflow: hidden; margin-bottom: 30px; aspect-ratio: 16/7; background: #1e293b; box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
        .main-visual img { width: 100%; height: 100%; object-fit: cover; }
        .hero-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(2,6,23,0.8) 0%, transparent 60%); }
        .hero-info { position: absolute; bottom: 30px; left: 30px; }

        .tag-cloud { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 15px; }
        .tag-item { background: rgba(255,255,255,0.05); border: 1px solid var(--border); padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; color: var(--text-muted); }

        .masonry-gallery { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin-bottom: 50px; }
        .masonry-item { border-radius: 16px; overflow: hidden; height: 180px; position: relative; cursor: pointer; }
        .masonry-item img { width: 100%; height: 100%; object-fit: cover; transition: 0.5s; }
        .masonry-item:hover img { transform: scale(1.1); }
        .masonry-item.wide { grid-column: span 2; }
        .view-all-overlay { position: absolute; inset: 0; background: rgba(0,0,0,0.6); display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 16px; }

        .map-section { background: var(--card-bg); border-radius: 24px; padding: 30px; border: 1px solid var(--border); margin-top: 40px; }
        .map-placeholder { height: 300px; background: rgba(255,255,255,0.02); border-radius: 16px; display: flex; align-items: center; justify-content: center; border: 1px dashed var(--border); }

        .similar-section { margin-top: 60px; padding-top: 60px; border-top: 1px solid var(--border); }
        .similar-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-top: 30px; }
        .similar-card { background: var(--card-bg); border-radius: 20px; overflow: hidden; border: 1px solid var(--border); text-decoration: none; color: inherit; transition: 0.3s; }
        .similar-card:hover { transform: translateY(-10px); }
        .similar-img { height: 160px; width: 100%; object-fit: cover; }
        .similar-body { padding: 20px; }
        .similar-title { font-size: 16px; font-weight: 800; margin-bottom: 5px; }

        @media (max-width: 991px) { .container-main { grid-template-columns: 1fr; } .sidebar-card { position: static; } .trust-footer { gap: 20px; padding: 15px; } .footer-trust-item span { display: none; } .similar-grid { grid-template-columns: 1fr; } .masonry-gallery { grid-template-columns: repeat(2, 1fr); } }

        /* Right Sidebar */
        .sidebar-card { background: var(--card-bg); border-radius: 24px; padding: 30px; border: 1px solid var(--border); position: sticky; top: 40px; box-shadow: 0 10px 40px rgba(0,0,0,0.5); transition: 0.3s; }
        .sidebar-card:hover { border-color: var(--accent-red); box-shadow: 0 0 20px rgba(225, 29, 72, 0.2); }

        .price-header { display: flex; align-items: baseline; gap: 8px; margin-bottom: 25px; }
        .price-val { font-size: 32px; font-weight: 800; color: #fff; }
        .price-label { color: var(--text-muted); font-size: 14px; font-weight: 600; }

        .field-group { margin-bottom: 25px; }
        .field-label { display: block; font-size: 13px; font-weight: 700; color: var(--text-muted); margin-bottom: 10px; text-transform: uppercase; }
        .date-input-wrapper { position: relative; }
        .input-dark { background: rgba(0,0,0,0.2) !important; border: 1px solid var(--border) !important; border-radius: 12px !important; color: #fff !important; padding: 12px 40px 12px 15px !important; width: 100% !important; outline: none !important; font-weight: 600 !important; cursor: pointer; }
        .date-input-wrapper i { position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: var(--text-muted); pointer-events: none; }

        .counter-box { display: flex; align-items: center; justify-content: space-between; background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 12px; padding: 10px 20px; }
        .counter-btn { width: 32px; height: 32px; background: rgba(255,255,255,0.1); border: none; border-radius: 8px; color: #fff; font-size: 18px; font-weight: 800; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: 0.3s; }
        .counter-btn:hover { background: var(--accent-red); }

        .price-details { margin-top: 30px; padding-top: 25px; border-top: 1px dashed var(--border); }
        .price-row { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 14px; font-weight: 600; color: var(--text-muted); }
        .total-row { border-top: 1px solid var(--border); margin-top: 15px; padding-top: 15px; font-size: 18px; font-weight: 800; color: #fff; }

        .btn-book { width: 100%; background: var(--accent-red); color: #fff; border: none; padding: 18px; border-radius: 16px; font-weight: 800; font-size: 16px; margin-top: 30px; cursor: pointer; transition: 0.3s; text-transform: uppercase; }
        .btn-book:hover { transform: translateY(-3px); box-shadow: 0 10px 25px rgba(225, 29, 72, 0.4); }

        .side-widget { background: var(--card-bg); border-radius: 24px; padding: 25px; border: 1px solid var(--border); margin-top: 20px; }
        .widget-title { font-size: 16px; font-weight: 800; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; color: #fff; }
        .trust-item { display: flex; gap: 15px; margin-bottom: 15px; }
        .trust-icon { width: 32px; height: 32px; background: rgba(255,255,255,0.05); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 14px; color: var(--accent-red); flex-shrink: 0; }
        .trust-name { font-weight: 700; display: block; font-size: 13px; color: #fff; }
        .trust-desc { font-size: 11px; color: var(--text-muted); }

        .offer-box { background: rgba(0,0,0,0.2); border: 1px dashed var(--border); border-radius: 12px; padding: 15px; display: flex; justify-content: space-between; align-items: center; }
        .offer-code { font-weight: 800; color: #fff; font-size: 14px; }
        .btn-apply { color: var(--accent-red); font-size: 12px; font-weight: 800; text-decoration: none; }

        .contact-widget { background: linear-gradient(135deg, #1e293b 0%, #020617 100%); }
        .contact-row { display: flex; align-items: center; gap: 15px; margin-top: 15px; font-size: 18px; font-weight: 800; color: #fff; }

        .trust-footer { position: fixed; bottom: 0; left: 0; right: 0; background: rgba(15, 23, 42, 0.95); backdrop-filter: blur(10px); border-top: 1px solid var(--border); padding: 15px 40px; display: flex; justify-content: center; gap: 50px; z-index: 999; }
        .footer-trust-item { display: flex; align-items: center; gap: 10px; font-size: 12px; font-weight: 700; color: #fff; }
        .footer-trust-item i { color: #22c55e; font-size: 16px; }

        /* Skeleton Loading */
        .skeleton { background: linear-gradient(90deg, #1e293b 25%, #334155 50%, #1e293b 75%); background-size: 200% 100%; animation: shimmer 1.5s infinite; border-radius: 10px; }
        @keyframes shimmer { 0% { background-position: 200% 0; } 100% { background-position: -200% 0; } }

        @media (max-width: 991px) { .container-main { grid-template-columns: 1fr; } .sidebar-card { position: static; } .trust-footer { gap: 20px; padding: 15px; } .footer-trust-item span { display: none; } }
        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-light);
            margin: 0; padding: 0;
            overflow-x: hidden;
        }

        /* Underwater Background System */
        .ocean-bg { position: fixed; inset: 0; background: radial-gradient(circle at 50% 0%, #001f3f, #000a12); z-index: -2; }
        .sun-rays { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; pointer-events: none; opacity: 0.4; }
        .ray { position: absolute; top: -20%; width: 100px; height: 150%; background: linear-gradient(180deg, rgba(255,255,255,0.1) 0%, transparent 80%); filter: blur(40px); transform-origin: top center; animation: ray-swing 8s ease-in-out infinite alternate; }
        @keyframes ray-swing { 0% { transform: rotate(-5deg) scaleX(1); } 100% { transform: rotate(5deg) scaleX(0.8); } }

        /* MMT Style Sticky Nav with Glass Effect */
        .glass-nav {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border-bottom: 1px solid var(--glass-border);
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 0 60px;
            display: flex;
            gap: 40px;
        }
        .nav-link-mmt {
            padding: 20px 0;
            font-weight: 800;
            font-size: 13px;
            color: var(--text-dim);
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 2px;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            transition: 0.3s;
        }
        .nav-link-mmt.active, .nav-link-mmt:hover { color: #fff; border-bottom-color: var(--accent-red); }

        /* Hero Banner */
        .hero-banner { height: 60vh; background: url('${trip.imageUrl}') center center/cover no-repeat; position: relative; }
        .hero-overlay { position: absolute; inset: 0; background: linear-gradient(to top, var(--bg-deep) 0%, transparent 100%); }
        .hero-info { position: absolute; bottom: 60px; left: 60px; z-index: 10; max-width: 800px; }
        .hero-title { font-size: 4.5rem; font-weight: 900; letter-spacing: -3px; line-height: 0.9; margin-bottom: 15px; }

        .layout-container { max-width: 1400px; margin: 40px auto; padding: 0 60px; display: grid; grid-template-columns: 2fr 1fr; gap: 40px; }

        /* MMT Content Cards with Super Glass Styling */
        .glass-card { 
            background: var(--glass-card); 
            backdrop-filter: blur(30px); 
            border: 1px solid var(--glass-border); 
            border-radius: 24px; 
            padding: 40px; 
            margin-bottom: 30px; 
            transition: 0.3s;
        }
        .section-title { font-size: 20px; font-weight: 900; margin-bottom: 25px; color: var(--accent-red); text-transform: uppercase; letter-spacing: 2px; }

        /* Dynamic Chips */
        .chip { background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border); border-radius: 100px; padding: 6px 16px; font-size: 12px; font-weight: 700; display: inline-flex; align-items: center; gap: 8px; margin-right: 10px; margin-bottom: 10px; color: var(--text-light); }
        .chip i { color: var(--accent-red); }

        /* Itinerary Timeline */
        .day-box { position: relative; padding-left: 50px; border-left: 1px solid var(--glass-border); margin-left: 15px; margin-bottom: 40px; }
        .day-indicator { position: absolute; left: -16px; top: 0; background: var(--accent-red); color: #fff; width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 12px; box-shadow: 0 0 15px var(--accent-red); }

        /* Booking Instrument - Diamond Polish */
        .sticky-booking { position: sticky; top: 110px; }
        .booking-panel { 
            background: rgba(230, 57, 70, 0.05); 
            backdrop-filter: blur(50px); 
            border: 1px solid rgba(230, 57, 70, 0.3); 
            border-radius: 40px; 
            padding: 45px; 
            box-shadow: 0 40px 100px rgba(0,0,0,0.7), inset 0 0 20px rgba(230, 57, 70, 0.1);
            position: relative;
            overflow: hidden;
        }
        .booking-panel::before {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: conic-gradient(from 180deg at 50% 50%, transparent 0deg, rgba(230, 57, 70, 0.1) 180deg, transparent 360deg);
            animation: rotate-glow 10s linear infinite;
            z-index: -1;
        }
        @keyframes rotate-glow { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

        .price-hero-luxe { margin-bottom: 40px; }
        .price-big { font-size: 4rem; font-weight: 900; line-height: 1; color: #fff; text-shadow: 0 0 30px var(--accent-glow); }
        .price-label { font-size: 11px; font-weight: 800; letter-spacing: 2px; color: var(--accent-red); margin-bottom: 8px; text-transform: uppercase; }

        .luxe-input {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--glass-border);
            border-radius: 18px;
            padding: 18px 20px;
            color: #fff;
            font-weight: 700;
            font-size: 14px;
            width: 100%;
            transition: 0.4s;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='white' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 20px center;
        }
        .luxe-input:focus { outline: none; border-color: var(--accent-red); box-shadow: 0 0 15px var(--accent-glow); background: rgba(255,255,255,0.06); }

        .btn-royal-glow {
            width: 100%;
            background: linear-gradient(135deg, #e63946 0%, #c1121f 100%);
            color: #fff;
            border: none;
            padding: 25px;
            border-radius: 22px;
            font-weight: 900;
            font-size: 18px;
            text-transform: uppercase;
            letter-spacing: 3px;
            box-shadow: 0 15px 40px rgba(230, 57, 70, 0.4);
            transition: 0.5s;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            animation: pulse-btn 2s infinite;
        }
        @keyframes pulse-btn {
            0% { box-shadow: 0 15px 40px rgba(230, 57, 70, 0.4); }
            50% { box-shadow: 0 15px 60px rgba(230, 57, 70, 0.6); }
            100% { box-shadow: 0 15px 40px rgba(230, 57, 70, 0.4); }
        }
        .btn-royal-glow:hover { transform: translateY(-5px) scale(1.02); filter: brightness(1.1); }

        /* Hotel Card */
        .mmt-hotel-card { display: grid; grid-template-columns: 220px 1fr; gap: 25px; background: rgba(255,255,255,0.02); border-radius: 20px; padding: 25px; border: 1px solid var(--glass-border); }
        .hotel-img-luxe { width: 100%; height: 160px; object-fit: cover; border-radius: 15px; }

        @svg-filter: url(#water-rough);
    </style>
</head>
<body>

    <div class="ocean-bg"></div>
    <div class="sun-rays">
        <div class="ray" style="left: 10%; animation-delay: 0s;"></div>
        <div class="ray" style="left: 35%; animation-delay: 2s;"></div>
        <div class="ray" style="left: 65%; animation-delay: 1s;"></div>
        <div class="ray" style="left: 85%; animation-delay: 3s;"></div>
    </div>

    <div class="container-main">
        <div class="content-left">
            <div class="breadcrumb-nav">
                <a href="/user/dashboard">Home</a>
                <i class="fa fa-chevron-right"></i>
                <a href="#" id="breadCategory">Packages</a>
                <i class="fa fa-chevron-right"></i>
                <span style="color: #fff;" id="breadTitle">Trip Details</span>
            </div>

            <div id="skeletons">
                <div class="skeleton" style="width: 100%; height: 400px; border-radius: 20px; margin-bottom: 30px;"></div>
                <div class="skeleton" style="width: 80%; height: 40px; margin-bottom: 20px;"></div>
            </div>

            <div id="realContent" style="display: none;">
                <div class="main-visual">
                    <img id="mainImg" src="" alt="Trip Visual">
                    <div class="hero-overlay"></div>
                    <div class="play-btn"><i class="fa fa-play"></i></div>
                    <div class="type-tag" id="tripCategory">GROUP</div>
                </div>

                <h1 class="trip-title" id="tripTitle">Loading...</h1>
                <div class="trip-meta" id="tripMeta"></div>
                
                <div class="section-title">Overview</div>
                <div class="desc-text" id="tripDesc"></div>

                <div class="section-title">Activities</div>
                <div class="tag-cloud" id="activityTags"></div>

                <div style="margin-top: 40px;">
                    <div class="section-title">Inclusions</div>
                    <div class="inclusions-grid" id="inclusionsGrid"></div>
                </div>

                <div class="section-title">Itinerary</div>
                <div class="itinerary-list" id="itineraryList"></div>

                <div class="section-title">Gallery</div>
                <div class="masonry-gallery" id="masonryGallery"></div>

                <div class="map-section">
                    <div class="section-title"><i class="fa fa-map-marker"></i> Location on Map</div>
                    <div class="map-placeholder">
                        <i class="fa fa-map-o" style="font-size: 40px; margin-bottom: 10px; color: var(--border);"></i>
                        <div style="font-weight: 700; color: var(--text-muted);">Map view coming soon</div>
                    </div>
                </div>
            </div>
        </div>


        <div class="content-right">
            <div class="sidebar-card">
                <div class="price-header">
                    <span class="price-val" id="priceDisplay">₹0</span>
                    <span class="price-label">/ person</span>
                </div>

                <div class="field-group">
                    <label class="field-label">Select Date</label>
                    <div class="date-input-wrapper">
                        <input type="text" id="datePicker" class="input-dark" placeholder="Select Date" readonly>
                        <i class="fa fa-calendar"></i>
                    </div>
                </div>

                <div class="field-group">
                    <label class="field-label">Travelers</label>
                    <div class="counter-box">
                        <button class="counter-btn" onclick="changeTravelers(-1)">-</button>
                        <div style="text-align: center;">
                            <span id="travelerCount" style="font-weight: 800; font-size: 18px;">1</span>
                            <div style="font-size: 11px; font-weight: 600; color: var(--text-muted);" id="travelerLabel">1 Adult</div>
                        </div>
                        <button class="counter-btn" onclick="changeTravelers(1)">+</button>
                    </div>
                </div>

                <div class="price-details">
                    <div class="price-row">
                        <span id="priceBreakupLabel">₹0 x 1 Adult</span>
                        <span id="basicCost">₹0</span>
                    </div>
                    <div class="price-row">
                        <span>Discount (0%)</span>
                        <span style="color: #22c55e;">- ₹0</span>
                    </div>
                    <div class="total-row">
                        <span>Total Amount</span>
                        <span id="finalTotal">₹0</span>
                    </div>
                </div>

                <button class="btn-book" onclick="proceedToBooking()">BOOK NOW</button>
                <div style="display: flex; align-items: center; justify-content: center; gap: 8px; font-size: 12px; font-weight: 600; color: #22c55e; margin-top: 20px;">
                    <i class="fa fa-shield"></i> 100% Secure & Safe Payments
                </div>
            </div>

            <div class="side-widget">
                <div class="widget-title"><i class="fa fa-question-circle"></i> Why Book With Us?</div>
                <div class="trust-item">
                    <div class="trust-icon"><i class="fa fa-tags"></i></div>
                    <div class="trust-info">
                        <span class="trust-name">Best Price Guarantee</span>
                        <span class="trust-desc">Get the best price always</span>
                    </div>
                </div>
                <div class="trust-item">
                    <div class="trust-icon"><i class="fa fa-bolt"></i></div>
                    <div class="trust-info">
                        <span class="trust-name">Easy Booking</span>
                        <span class="trust-desc">Hassle-free booking process</span>
                    </div>
                </div>
            </div>

            <div class="side-widget">
                <div class="widget-title"><i class="fa fa-gift"></i> Available Offers</div>
                <div class="offer-box">
                    <div>
                        <div class="offer-code">HOLIDAY10</div>
                        <div style="font-size: 11px; color: var(--text-muted);">Get 10% off</div>
                    </div>
                    <a href="#" class="btn-apply">Apply</a>
                </div>
    <!-- Rough Edge Filter -->
    <svg width="0" height="0" style="position:absolute;z-index:-1;"><filter id="water-rough"><feTurbulence type="fractalNoise" baseFrequency="0.02" numOctaves="3" result="noise" /><feDisplacementMap in="SourceGraphic" in2="noise" scale="5" xChannelSelector="R" yChannelSelector="G" /></filter></svg>

    <div class="hero-banner">
        <div class="hero-overlay"></div>
        <div class="hero-info">
            <div class="hero-title">${trip.title}</div>
            <div class="d-flex gap-4 align-items-center">
                <span class="badge bg-danger rounded-pill px-4 py-2 fw-black text-uppercase small">${not empty trip.difficulty ? trip.difficulty : 'Expert Led'}</span>
                <span class="fw-bold fs-5"><i class="fa fa-map-marker text-danger me-2"></i> ${trip.destination}</span>
                <span class="fw-bold fs-5"><i class="fa fa-clock-o text-danger me-2"></i> ${trip.days}D / ${trip.nights}N</span>
            </div>
        </div>
    </div>

    </div>

    <div class="container-main similar-section">
        <div style="width: 100%;">
            <h2 class="section-title">Similar Destinations</h2>
            <div class="similar-grid" id="similarGrid"></div>
        </div>
    </div>

    <div class="trust-footer">
        <div class="footer-trust-item"><i class="fa fa-check-circle"></i> <span>Free Cancellation</span></div>
        <div class="footer-trust-item"><i class="fa fa-calendar-check-o"></i> <span>Flexible Booking</span></div>
        <div class="footer-trust-item"><i class="fa fa-lock"></i> <span>Secure Payment</span></div>
    </div>

    <div id="toast" style="position: fixed; bottom: 20px; right: 20px; background: #fff; color: #000; padding: 15px 25px; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); transform: translateY(100px); transition: 0.3s; z-index: 10000; font-weight: 700;"></div>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        const packageId = document.getElementById('packageIdValue').value;
        let tripData = null;
        let travelers = 1;
        let picker = null;

        async function fetchTripDetails() {
            try {
                const response = await fetch('/api/packages/' + packageId);
                if (!response.ok) throw new Error("Failed to load");
                tripData = await response.json();
                renderUI();
            } catch (err) {
                console.error(err);
                document.getElementById('skeletons').innerHTML = '<div style="text-align:center; padding: 50px;"><h2>Failed to load package.</h2><p>Please try again later.</p></div>';
            }
        }

        function renderUI() {
            if (!tripData || !tripData.trip) return;
            const { trip, schedules } = tripData;
            
            document.getElementById('skeletons').style.display = 'none';
            document.getElementById('realContent').style.display = 'block';

            document.getElementById('tripTitle').innerText = trip.title || "Trip Package";
            document.getElementById('breadTitle').innerText = trip.title;
            document.getElementById('breadCategory').innerText = trip.category || "Packages";
            document.getElementById('tripCategory').innerText = trip.category || "GROUP";
            document.getElementById('priceDisplay').innerText = "₹" + (trip.price || 0).toLocaleString('en-IN');
            
            document.getElementById('tripMeta').innerHTML = `
                <span><i class="fa fa-map-marker"></i> ` + (trip.destination || 'N/A') + `</span>
                <span><i class="fa fa-calendar"></i> ` + (trip.days || 0) + ` Days / ` + (trip.nights || 0) + ` Nights</span>
                <span><i class="fa fa-bolt"></i> ` + (trip.difficulty || 'Easy') + `</span>
            `;

            document.getElementById('tripDesc').innerText = trip.description || "No description available.";

            // Activities
            const activities = ["Sightseeing", "Adventure", "Photography", "Camping", "Trekking"];
            document.getElementById('activityTags').innerHTML = activities.map(a => `<span class="tag-item">` + a + `</span>`).join('');

            // Inclusions
            const incs = [
                {icon: 'hotel', label: 'Hotel Stay'},
                {icon: 'cutlery', label: 'Meals'},
                {icon: 'bus', label: 'Transport'},
                {icon: 'user-secret', label: 'Guide'},
                {icon: 'fire', label: 'Bonfire'},
                {icon: 'camera', label: 'Sightseeing'}
            ];
            document.getElementById('inclusionsGrid').innerHTML = incs.map(i => `
                <div class="inclusion-item"><div class="inclusion-icon"><i class="fa fa-`+i.icon+`"></i></div><div class="inclusion-label">`+i.label+`</div></div>
            `).join('');

            const media = trip.mediaUrls ? trip.mediaUrls.split(',') : [];
            const mainImg = media.length > 0 ? media[0] : "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=1200";
            document.getElementById('mainImg').src = mainImg;

            // Masonry Gallery
            const galleryMedia = media.length > 0 ? media : [mainImg, mainImg, mainImg, mainImg, mainImg];
            const mGallery = document.getElementById('masonryGallery');
            if (mGallery) {
                mGallery.innerHTML = galleryMedia.slice(0, 5).map((url, i) => `
                    <div class="masonry-item ` + (i === 0 ? 'wide' : '') + `">
                        <img src="` + url + `" alt="Gallery">
                        ` + (i === 4 ? '<div class="view-all-overlay">+' + (media.length > 5 ? media.length - 5 : 12) + ' Photos</div>' : '') + `
    <div class="glass-nav">
        <div class="nav-link-mmt active" onclick="scrollToId('overview')">Overview</div>
        <div class="nav-link-mmt" onclick="scrollToId('itinerary')">Itinerary</div>
        <div class="nav-link-mmt" onclick="scrollToId('stay')">Hotels</div>
        <div class="nav-link-mmt" onclick="scrollToId('policies')">Policies</div>
    </div>

    <div class="layout-container">
        <div class="main-content">
            
            <div id="overview" class="glass-card">
                <h3 class="section-title">The Experience</h3>
                <p class="text-white-50 lh-lg fs-6">${trip.description}</p>
                <div class="mt-5">
                    <h6 class="fw-bold small text-uppercase mb-3 opacity-50">What's Included</h6>
                    <div class="d-flex flex-wrap">
                        <c:set var="incs" value="${fn:split(trip.inclusions, ',')}" />
                        <c:forEach var="inc" items="${incs}">
                            <div class="chip"><i class="fa fa-check-circle"></i> ${fn:trim(inc)}</div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            // Similar Destinations (Mock)
            const sGrid = document.getElementById('similarGrid');
            if (sGrid) {
                const similar = [
                    {title: 'Spiti Valley Adventure', price: 12000, img: 'https://images.unsplash.com/photo-1544085311-12102736596e?w=400'},
                    {title: 'Ladakh Bike Trip', price: 15000, img: 'https://images.unsplash.com/photo-1581791538302-03537b9c97bf?w=400'},
                    {title: 'Kasol Riverside Stay', price: 5000, img: 'https://images.unsplash.com/photo-1510614002443-42e97036a5a2?w=400'}
                ];
                sGrid.innerHTML = similar.map(s => `
                    <a href="#" class="similar-card">
                        <img src="` + s.img + `" class="similar-img">
                        <div class="similar-body">
                            <div class="similar-title">` + s.title + `</div>
                            <div style="font-weight: 800; color: var(--accent-red);">₹` + s.price + `</div>
                        </div>
                    </a>
                `).join('');
            }

            if (trip.itinerary) {

                try {
                    const plan = JSON.parse(trip.itinerary);
                    if (Array.isArray(plan)) {
                        document.getElementById('itineraryList').innerHTML = plan.map(day => `
                            <div class="itinerary-day">
                                <div class="day-dot"></div>
                                <div class="day-title">Day ` + day.day + `</div>
                                <div class="day-subtitle">` + day.title + `</div>
                                <div class="day-content">` + day.description + `</div>
                            </div>
                        `).join('');
                    }
                } catch(e) { console.error(e); }
            }

            const availableDates = Array.isArray(schedules) ? schedules.map(s => s.startDate) : [];
            picker = flatpickr("#datePicker", {
                enable: availableDates,
                dateFormat: "d M Y",
                disableMobile: true,
                theme: "dark",
                onChange: updatePricing
            });
            <div id="itinerary" class="glass-card">
                <h3 class="section-title">Detailed Journey</h3>
                <c:forEach var="i" begin="1" end="${trip.days}">
                    <div class="day-box">
                        <div class="day-indicator">${i}</div>
                        <h4 class="fw-bold text-white mb-2 text-capitalize">${trip.destination} Discovery</h4>
                        <div class="mb-3">
                            <span class="chip"><i class="fa fa-car"></i> Private Transfer</span>
                            <span class="chip"><i class="fa fa-hotel"></i> Check-in</span>
                        </div>
                        <p class="small text-white-50">Exploring the deep soul of ${trip.destination}. This day is curated for immersive local experiences and cinematic sights.</p>
                    </div>
                </c:forEach>
            </div>

            <div id="stay" class="glass-card">
                <h3 class="section-title">Luxury Accommodation</h3>
                <div class="mmt-hotel-card">
                    <c:set var="galArr" value="${fn:split(trip.mediaUrls, ',')}" />
                    <img src="${not empty galArr[1] ? galArr[1] : trip.imageUrl}" class="hotel-img-luxe">
                    <div>
                        <div class="fs-4 fw-black text-white mb-1">Premium ${trip.stayCategory} Experience</div>
                        <div class="text-warning small mb-3"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i> (Verified)</div>
                        <div class="d-flex flex-wrap">
                            <c:set var="amens" value="${fn:split(trip.stayAmenities, ',')}" />
                            <c:forEach var="amen" items="${amens}">
                                <div class="chip">${fn:trim(amen)}</div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <div id="policies" class="glass-card">
                <h3 class="section-title">Policies & Essential Info</h3>
                <div class="row g-4">
                    <div class="col-md-12">
                        <h6 class="fw-bold small text-danger text-uppercase mb-2">Cancellation Policy</h6>
                        <p class="small text-white-50">${not empty trip.cancellationPolicy ? trip.cancellationPolicy : 'Flexible cancellation policy applies.'}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="sidebar-area">
            <div class="sticky-booking">
                <div class="booking-panel">
                    <div class="price-hero-luxe text-center">
                        <div class="price-label">Exclusive Explorer Rate</div>
                        <div class="price-big">₹${trip.price}</div>
                        <div class="small opacity-50 fw-bold mt-1">per adventurer • all inclusive</div>
                    </div>

                    <form action="<c:url value='/user/booking/submit'/>" method="POST" id="luxeBookingForm">
                        <input type="hidden" name="tripId" value="${trip.id}">
                        <input type="hidden" name="tripType" value="Package">

                        <div class="mb-4">
                            <label class="small fw-black text-white-50 text-uppercase mb-3 letter-spacing-1">1. Choose Your Departure</label>
                            <select name="selectedDate" class="luxe-input" required>
                                <c:forEach var="s" items="${schedules}">
                                    <option value="${s.startDate}">${s.startDate} (${s.availableSeats} Spots Left)</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-4">
                            <label class="small fw-black text-white-50 text-uppercase mb-3 letter-spacing-1">2. Traveling Explorers</label>
                            <select name="travelers" class="luxe-input" onchange="updateLuxePrice()" id="paxSelect">
                                <c:forEach var="p" begin="1" end="10"><option value="${p}">${p} Adults</option></c:forEach>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="small fw-black text-white-50 text-uppercase mb-3 letter-spacing-1">3. Special Requirements</label>
                            <textarea name="guestDetails" class="luxe-input" style="height: 80px; resize: none;" placeholder="e.g. Dietary needs, wheelchair access..."></textarea>
                        </div>

                        <div class="py-4 border-top border-secondary mt-4">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-white-50 fw-bold">Package Base x <span id="paxDisplay">1</span></span>
                                <span id="baseTotal" class="fw-bold">₹${trip.price}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-white-50 fw-bold">Taxes & Expert Fees</span>
                                <span class="text-success fw-bold">INCLUDED</span>
                            </div>
                            <div class="d-flex justify-content-between fs-4 fw-black text-white pt-4 border-top border-secondary">
                                <span style="letter-spacing: -1px;">TOTAL JOURNEY</span>
                                <span id="finalTotal" class="text-danger">₹${trip.price}</span>
                            </div>
                        </div>

                        <button type="submit" class="btn-royal-glow" ${trip.soldOut ? 'disabled' : ''}>
                            ${trip.soldOut ? 'FULLY BOOKED' : 'SECURE MY JOURNEY'}
                        </button>
                    </form>
                </div>

                <div class="mt-4 glass-card p-4 d-flex align-items-center gap-3">
                    <img src="https://ui-avatars.com/api/?name=${fn:replace(trip.vendor.businessName, ' ', '+')}&background=e63946&color=fff" class="rounded-circle" style="width: 45px; height: 45px; border: 2px solid var(--accent-red);">
                    <div>
                        <div class="small fw-bold">Verified Support by ${trip.vendor.businessName}</div>
                        <div class="small text-white-50">Trusted Luxury Expert</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const basePrice = ${trip.price};
        function updateLuxePrice() {
            const pax = document.getElementById('paxSelect').value;
            const total = basePrice * pax;
            document.getElementById('paxDisplay').innerText = pax;
            document.getElementById('baseTotal').innerText = '₹' + total.toLocaleString('en-IN');
            document.getElementById('finalTotal').innerText = '₹' + total.toLocaleString('en-IN');
        }

        function setMainImage(url, el) {
            document.getElementById('mainImg').src = url;
            document.querySelectorAll('.thumb-item').forEach(i => i.classList.remove('active'));
            el.classList.add('active');
        }

        function changeTravelers(delta) {
            travelers = Math.max(1, Math.min(10, travelers + delta));
            document.getElementById('travelerCount').innerText = travelers;
            document.getElementById('travelerLabel').innerText = travelers + (travelers === 1 ? " Adult" : " Adults");
            updatePricing();
        }

        function updatePricing() {
            if (!tripData || !tripData.trip) return;
            const price = tripData.trip.price || 0;
            const total = price * travelers;
            document.getElementById('priceBreakupLabel').innerText = "₹" + price.toLocaleString('en-IN') + " x " + travelers + " Adult" + (travelers > 1 ? "s" : "");
            document.getElementById('basicCost').innerText = "₹" + total.toLocaleString('en-IN');
            document.getElementById('finalTotal').innerText = "₹" + total.toLocaleString('en-IN');
        }

        function proceedToBooking() {
            const date = document.getElementById('datePicker').value;
            if (!date) {
                showToast("Please select a travel date.");
                return;
            }
            window.location.href = `/user/booking/review?tripId=` + packageId + `&selectedDate=` + encodeURIComponent(date) + `&travelers=` + travelers;
        }

        function showToast(msg) {
            const t = document.getElementById('toast');
            t.innerText = msg;
            t.style.transform = "translateY(0)";
            setTimeout(() => t.style.transform = "translateY(100px)", 3000);
        }

        window.onload = fetchTripDetails;
        function scrollToId(id) {
            document.getElementById(id).scrollIntoView({ behavior: 'smooth', block: 'start' });
            document.querySelectorAll('.nav-link-mmt').forEach(el => el.classList.remove('active'));
            event.target.classList.add('active');
        }
    </script>
</body>
</html>