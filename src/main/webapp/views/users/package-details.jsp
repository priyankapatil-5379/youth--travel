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
        function scrollToId(id) {
            document.getElementById(id).scrollIntoView({ behavior: 'smooth', block: 'start' });
            document.querySelectorAll('.nav-link-mmt').forEach(el => el.classList.remove('active'));
            event.target.classList.add('active');
        }
    </script>
</body>
</html>