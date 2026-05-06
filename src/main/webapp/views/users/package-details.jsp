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
            --glass-card: rgba(255, 255, 255, 0.04);
            --glass-border: rgba(255, 255, 255, 0.12);
            --text-light: #f8fafc;
            --text-dim: #94a3b8;
            --accent-glow: rgba(230, 57, 70, 0.5);
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

    <div class="hero-parallax">
        <div class="hero-img-luxe" id="heroImg"></div>
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

            <!-- Storyline Itinerary -->
            <div id="itinerary">
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
        function scrollToId(id) {
            document.getElementById(id).scrollIntoView({ behavior: 'smooth', block: 'start' });
            document.querySelectorAll('.nav-link-mmt').forEach(el => el.classList.remove('active'));
            event.target.classList.add('active');
        }
    </script>
</body>
</html>