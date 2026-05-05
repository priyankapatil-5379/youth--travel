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
            --glass-card: rgba(255, 255, 255, 0.04);
            --glass-border: rgba(255, 255, 255, 0.12);
            --text-light: #f8fafc;
            --text-dim: #94a3b8;
            --accent-glow: rgba(230, 57, 70, 0.5);
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
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(30px);
            -webkit-backdrop-filter: blur(30px);
            border-bottom: 1px solid var(--glass-border);
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 0 80px;
            display: flex;
            gap: 50px;
        }
        .nav-link-mmt {
            padding: 25px 0;
            font-weight: 900;
            font-size: 14px;
            color: var(--text-dim);
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 3px;
            border-bottom: 4px solid transparent;
            cursor: pointer;
            transition: 0.4s;
        }
        .nav-link-mmt.active, .nav-link-mmt:hover { color: #fff; border-bottom-color: var(--accent-red); text-shadow: 0 0 10px rgba(255,255,255,0.3); }

        /* Cinematic Hero Banner (90vh) */
        .hero-parallax { 
            height: 90vh; 
            width: 100%;
            position: relative; 
            overflow: hidden;
            display: flex;
            align-items: flex-end;
            padding-bottom: 100px;
        }
        .hero-img-luxe {
            position: absolute; top: 0; left: 0; width: 100%; height: 120%;
            background: url('${trip.imageUrl}') center center/cover no-repeat;
            z-index: -1;
            transform: translateY(0);
            transition: transform 0.1s ease-out;
        }
        .hero-overlay { 
            position: absolute; inset: 0; 
            background: linear-gradient(to top, var(--bg-deep) 10%, transparent 50%, rgba(0,0,0,0.4) 100%); 
            z-index: 0;
        }
        .hero-content { position: relative; z-index: 10; padding: 0 80px; width: 100%; }
        .hero-title { 
            font-size: 8rem; font-weight: 950; letter-spacing: -6px; line-height: 0.8; 
            margin-bottom: 25px; color: #fff;
            text-shadow: 0 20px 80px rgba(0,0,0,0.8), 0 0 40px rgba(255,255,255,0.1);
            text-transform: uppercase;
        }
        .hero-meta-grid { display: flex; gap: 40px; align-items: center; }
        .meta-item-luxe { display: flex; align-items: center; gap: 15px; }
        .meta-icon-luxe { width: 50px; height: 50px; background: rgba(230, 57, 70, 0.2); border: 1px solid var(--accent-red); border-radius: 15px; display: flex; align-items: center; justify-content: center; color: var(--accent-red); font-size: 20px; box-shadow: 0 0 20px rgba(230, 57, 70, 0.3); }
        .meta-text-luxe { display: flex; flex-direction: column; }
        .meta-label-luxe { font-size: 11px; font-weight: 900; color: var(--accent-red); text-transform: uppercase; letter-spacing: 2px; }
        .meta-val-luxe { font-size: 18px; font-weight: 800; color: #fff; }

        .layout-container { max-width: 1500px; margin: 60px auto; padding: 0 80px; display: grid; grid-template-columns: 1fr 420px; gap: 60px; }

        /* Storyboard Itinerary */
        .story-card { 
            background: var(--glass-card); border: 1px solid var(--glass-border); border-radius: 30px; 
            padding: 45px; margin-bottom: 40px; transition: 0.4s;
            position: relative; overflow: hidden;
        }
        .story-card:hover { border-color: rgba(230, 57, 70, 0.3); transform: translateY(-10px); background: rgba(255,255,255,0.06); }
        .day-badge { position: absolute; top: 0; left: 0; background: var(--accent-red); color: #fff; padding: 15px 30px; font-weight: 950; font-size: 14px; letter-spacing: 3px; border-bottom-right-radius: 30px; box-shadow: 0 10px 30px rgba(230, 57, 70, 0.4); }
        .story-title { font-size: 28px; font-weight: 900; color: #fff; margin-bottom: 20px; margin-top: 20px; }
        
        /* Floating Action Console (Diamond Polish) */
        .action-console { position: sticky; top: 130px; }
        .booking-card { 
            background: rgba(10, 15, 25, 0.85); 
            backdrop-filter: blur(50px); 
            border: 1px solid rgba(255, 255, 255, 0.15); 
            border-radius: 40px; 
            padding: 50px 40px; 
            box-shadow: 0 50px 100px rgba(0,0,0,0.9);
            position: relative;
        }
        
        .price-display { margin-bottom: 45px; text-align: center; }
        .price-amount { font-size: 4.5rem; font-weight: 950; line-height: 1; color: #fff; text-shadow: 0 0 40px rgba(255,255,255,0.2); letter-spacing: -2px; }
        .price-sub { font-size: 11px; font-weight: 900; color: var(--accent-red); text-transform: uppercase; letter-spacing: 3px; margin-bottom: 12px; }

        .booking-label {
            display: block;
            font-size: 10px;
            font-weight: 950;
            color: var(--accent-red);
            text-transform: uppercase;
            letter-spacing: 2.5px;
            margin-bottom: 15px;
            padding-left: 5px;
        }

        .luxe-input {
            width: 100%;
            background: rgba(255, 255, 255, 0.05) !important;
            border: 1px solid rgba(255, 255, 255, 0.15) !important;
            border-radius: 20px;
            padding: 20px 25px;
            color: #fff !important;
            font-weight: 700;
            font-size: 14px;
            transition: 0.3s;
            appearance: auto;
        }
        .luxe-input:focus {
            background: rgba(255, 255, 255, 0.08) !important;
            border-color: var(--accent-red) !important;
            outline: none;
            box-shadow: 0 0 20px rgba(230, 57, 70, 0.2);
        }
        .luxe-input option { background: #0a0f19; color: #fff; }

        .luxe-btn {
            width: 100%; background: linear-gradient(135deg, #e63946 0%, #b91c1c 100%);
            color: #fff; border: none; padding: 25px; border-radius: 24px;
            font-weight: 950; font-size: 17px; text-transform: uppercase; letter-spacing: 4px;
            box-shadow: 0 15px 45px rgba(230, 57, 70, 0.5); transition: 0.4s;
            cursor: pointer;
            margin-top: 10px;
        }
        .luxe-btn:hover { transform: translateY(-5px); box-shadow: 0 25px 60px rgba(230, 57, 70, 0.7); letter-spacing: 6px; }

        .total-display {
            padding: 30px 5px;
            border-top: 1px solid rgba(255,255,255,0.1);
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .total-label { font-size: 12px; font-weight: 950; color: #fff; text-transform: uppercase; letter-spacing: 2px; }
        .total-amount { font-size: 28px; font-weight: 950; color: var(--accent-red); text-shadow: 0 0 20px rgba(230, 57, 70, 0.3); }

        .vendor-badge-luxe {
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid rgba(255,255,255,0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }
        .vendor-avatar {
            width: 60px; height: 60px;
            border-radius: 50%;
            border: 2px solid var(--accent-red);
            box-shadow: 0 0 20px rgba(230, 57, 70, 0.3);
            object-fit: cover;
        }
        .vendor-info-text { text-align: center; }
        .vendor-name-luxe { font-size: 13px; font-weight: 900; color: #fff; margin-bottom: 4px; }
        .vendor-stars { color: #fbbf24; font-size: 10px; letter-spacing: 2px; }

        @media (max-width: 1200px) {
            .hero-title { font-size: 5rem; letter-spacing: -3px; }
            .layout-container { grid-template-columns: 1fr; }
            .action-console { position: static; margin-top: 40px; }
        }
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

<<<<<<< HEAD
    <div class="hero-parallax">
        <div class="hero-img-luxe" id="heroImg"></div>
=======
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
>>>>>>> 70694c31e39ab00af1555e8b042310beb743f5e8
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1 class="hero-title">${trip.title}</h1>
            <div class="hero-meta-grid">
                <div class="meta-item-luxe">
                    <div class="meta-icon-luxe"><i class="fa fa-map-marker"></i></div>
                    <div class="meta-text-luxe">
                        <span class="meta-label-luxe">Destination</span>
                        <span class="meta-val-luxe">${trip.destination}</span>
                    </div>
                </div>
                <div class="meta-item-luxe">
                    <div class="meta-icon-luxe"><i class="fa fa-clock-o"></i></div>
                    <div class="meta-text-luxe">
                        <span class="meta-label-luxe">Duration</span>
                        <span class="meta-val-luxe">${trip.days} Days / ${trip.nights} Nights</span>
                    </div>
                </div>
                <div class="meta-item-luxe">
                    <div class="meta-icon-luxe"><i class="fa fa-shield"></i></div>
                    <div class="meta-text-luxe">
                        <span class="meta-label-luxe">Adventure Tier</span>
                        <span class="meta-val-luxe">${not empty trip.difficulty ? trip.difficulty : 'Elite Explorer'}</span>
                    </div>
                </div>
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
        <div class="nav-link-mmt active" onclick="scrollToId('overview')">The Experience</div>
        <div class="nav-link-mmt" onclick="scrollToId('itinerary')">Storyline</div>
        <div class="nav-link-mmt" onclick="scrollToId('amenities')">Amenities</div>
        <div class="nav-link-mmt" onclick="scrollToId('stay')">Hospitality</div>
    </div>

    <div class="layout-container">
        <div class="main-content">
            
            <!-- Experience Story -->
            <div id="overview" class="story-card">
                <div class="day-badge">OVERVIEW</div>
                <h2 class="story-title">The Cinematic Journey</h2>
                <p class="text-white-50 lh-lg fs-5" style="font-weight: 500;">${trip.description}</p>
                <div class="mt-5 p-4 rounded-4" style="background: rgba(230, 57, 70, 0.05); border: 1px solid rgba(230, 57, 70, 0.2);">
                    <h5 class="fw-black text-danger text-uppercase small letter-spacing-2 mb-3">Expert Curator Note</h5>
                    <p class="small text-white-50 m-0">"This expedition was curated specifically for those who seek to lose themselves in the raw beauty of ${trip.destination}. From the transportation logistics to the boutique stays, every detail is engineered for high-end discovery."</p>
                </div>
            </div>

<<<<<<< HEAD
            <!-- Storyline Itinerary -->
            <div id="itinerary">
=======
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
>>>>>>> 70694c31e39ab00af1555e8b042310beb743f5e8
                <c:forEach var="i" begin="1" end="${trip.days}">
                    <div class="story-card">
                        <div class="day-badge">DAY 0${i}</div>
                        <h2 class="story-title">Entering the Soul of ${trip.destination}</h2>
                        <div class="d-flex gap-3 mb-4">
                            <span class="badge bg-white text-dark px-3 py-2 rounded-pill fw-bold small text-uppercase">Logistics: ${trip.transportCategory}</span>
                            <span class="badge bg-danger text-white px-3 py-2 rounded-pill fw-bold small text-uppercase">Nature Hike</span>
                        </div>
                        <p class="text-white-50">Day 0${i} is dedicated to exploring the hidden corners of the region. Experience a private, curated journey through the local landscape, featuring exclusive access to sights reserved for elite travelers.</p>
                        <div class="mt-4 d-flex gap-3 overflow-auto pb-2" style="scrollbar-width: none;">
                            <c:set var="galArr" value="${fn:split(trip.mediaUrls, ',')}" />
                            <img src="${not empty galArr[0] ? galArr[0] : trip.imageUrl}" class="rounded-4" style="height: 180px; width: 280px; object-fit: cover; border: 1px solid var(--glass-border);">
                            <img src="${not empty galArr[1] ? galArr[1] : trip.imageUrl}" class="rounded-4" style="height: 180px; width: 280px; object-fit: cover; border: 1px solid var(--glass-border);">
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Amenities Mosaic -->
            <div id="amenities" class="story-card">
                <div class="day-badge">INCLUSIONS</div>
                <h2 class="story-title">Elite Hospitality Package</h2>
                <div class="amenity-mosaic">
                    <c:set var="incs" value="${fn:split(trip.inclusions, ',')}" />
                    <c:forEach var="inc" items="${incs}">
                        <div class="amenity-item">
                            <i class="fa fa-diamond amenity-icon"></i>
                            <div class="amenity-label">${fn:trim(inc)}</div>
                        </div>
                    </c:forEach>
                    <div class="amenity-item">
                        <i class="fa fa-bus amenity-icon"></i>
                        <div class="amenity-label">Private ${trip.transportCategory}</div>
                    </div>
                    <div class="amenity-item">
                        <i class="fa fa-camera-retro amenity-icon"></i>
                        <div class="amenity-label">Photography Support</div>
                    </div>
                </div>
            </div>

            <!-- Stay Section -->
            <div id="stay" class="story-card">
                <div class="day-badge">STAY</div>
                <h2 class="story-title">Boutique ${trip.stayCategory} Accommodation</h2>
                <div class="row g-4 mt-2">
                    <div class="col-md-5">
                        <img src="${not empty galArr[2] ? galArr[2] : trip.imageUrl}" class="w-100 rounded-5" style="height: 300px; object-fit: cover; border: 2px solid var(--glass-border);">
                    </div>
                    <div class="col-md-7 d-flex flex-direction-column justify-content-center">
                        <h4 class="fw-black text-white mb-3">Premium ${trip.stayType}</h4>
                        <p class="text-white-50">Immerse yourself in high-end comfort. Our stays are hand-picked for their unique character, luxury service, and perfect location.</p>
                        <div class="d-flex flex-wrap gap-2 mt-3">
                            <c:set var="amens" value="${fn:split(trip.stayAmenities, ',')}" />
                            <c:forEach var="amen" items="${amens}">
                                <span class="badge border border-secondary px-3 py-2 rounded-pill small fw-bold">${fn:trim(amen)}</span>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Floating Action Sidebar -->
        <div class="sidebar-area">
            <div class="action-console">
                <div class="booking-card">
                    <div class="price-display">
                        <div class="price-sub">Exclusive Explorer Fare</div>
                        <div class="price-amount">₹${trip.price}</div>
                        <div class="small fw-bold text-white-50 mt-2">Per Traveler • All Logistics Included</div>
                    </div>

                    <form action="<c:url value='/user/booking/submit'/>" method="POST" id="luxeBookingForm">
                        <input type="hidden" name="tripId" value="${trip.id}">
                        <input type="hidden" name="tripType" value="Package">

                        <div class="mb-5">
                            <label class="booking-label">1. Select Your Batch</label>
                            <select name="selectedDate" class="luxe-input" required>
                                <c:forEach var="s" items="${schedules}">
                                    <option value="${s.startDate}">${s.startDate} (${s.availableSeats} Seats)</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-5">
                            <label class="booking-label">2. Total Explorers</label>
                            <select name="travelers" class="luxe-input" onchange="updateLuxePrice()" id="paxSelect">
                                <c:forEach var="p" begin="1" end="10"><option value="${p}">${p} Adults</option></c:forEach>
                            </select>
                        </div>

                        <div class="mb-5">
                            <label class="booking-label">3. Special Concierge Requests</label>
                            <textarea name="guestDetails" class="luxe-input" style="height: 120px; resize: none;" placeholder="Dietary needs, room preferences, special occasions..."></textarea>
                        </div>

                        <div class="total-display">
                            <div class="total-label">Total Journey</div>
                            <div id="finalTotal" class="total-amount">₹${trip.price}</div>
                        </div>

                        <button type="submit" class="luxe-btn" ${trip.soldOut ? 'disabled' : ''}>
                            ${trip.soldOut ? 'BATCH FULL' : 'RESERVE MY SPOT'}
                        </button>
                    </form>

                    <div class="vendor-badge-luxe">
                        <img src="https://ui-avatars.com/api/?name=${fn:replace(trip.vendor.businessName, ' ', '+')}&background=e63946&color=fff" class="vendor-avatar">
                        <div class="vendor-info-text">
                            <div class="vendor-name-luxe">EXPERT: ${trip.vendor.businessName}</div>
                            <div class="vendor-stars">
                                <i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i>
                                <span class="ms-2 opacity-50" style="font-size: 8px;">VERIFIED</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const basePrice = ${trip.price};
        
        // Parallax Effect
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const heroImg = document.getElementById('heroImg');
            heroImg.style.transform = 'translateY(' + (scrolled * 0.4) + 'px)';
        });

        function updateLuxePrice() {
            const pax = document.getElementById('paxSelect').value;
            const total = basePrice * pax;
            document.getElementById('finalTotal').innerText = '₹' + total.toLocaleString('en-IN');
        }

        function scrollToId(id) {
            const element = document.getElementById(id);
            const offset = 100;
            const bodyRect = document.body.getBoundingClientRect().top;
            const elementRect = element.getBoundingClientRect().top;
            const elementPosition = elementRect - bodyRect;
            const offsetPosition = elementPosition - offset;

            window.scrollTo({
                top: offsetPosition,
                behavior: 'smooth'
            });

            document.querySelectorAll('.nav-link-mmt').forEach(el => el.classList.remove('active'));
            event.target.classList.add('active');
        }
    </script>
</body>
</html>

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