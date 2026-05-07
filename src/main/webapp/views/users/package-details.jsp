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
            --bg-deep: #ffffff;
            --accent-teal: #0F7C7C;
            --accent-teal-dark: #085a5a;
            --accent-teal-glow: rgba(15, 124, 124, 0.15);
            --glass-card: rgba(0, 0, 0, 0.02);
            --glass-border: rgba(0, 0, 0, 0.08);
            --text-light: #0f172a;
            --text-dim: #64748b;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-light);
            margin: 0; padding: 0;
            overflow-x: hidden;
        }

        /* Premium Light Background System */
        .ocean-bg { position: fixed; inset: 0; background: #f8fafc; z-index: -2; }
        .sun-rays { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; pointer-events: none; opacity: 0.2; }
        .ray { position: absolute; top: -20%; width: 100px; height: 150%; background: linear-gradient(180deg, rgba(15,124,124,0.05) 0%, transparent 80%); filter: blur(40px); transform-origin: top center; animation: ray-swing 8s ease-in-out infinite alternate; }
        @keyframes ray-swing { 0% { transform: rotate(-5deg) scaleX(1); } 100% { transform: rotate(5deg) scaleX(0.8); } }

        /* Premium Light Sticky Nav */
        .glass-nav {
            background: rgba(255, 255, 255, 0.9);
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
        .nav-link-mmt.active, .nav-link-mmt:hover { color: var(--text-light); border-bottom-color: var(--accent-teal); }

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
            background: linear-gradient(to top, var(--bg-deep) 0%, transparent 60%); 
            z-index: 0;
        }
        .hero-content { position: relative; z-index: 10; padding: 0 80px; width: 100%; }
        .hero-title { 
            font-size: 8rem; font-weight: 950; letter-spacing: -6px; line-height: 0.8; 
            margin-bottom: 25px; color: var(--text-light);
            text-transform: uppercase;
        }
        .hero-meta-grid { display: flex; gap: 40px; align-items: center; }
        .meta-item-luxe { display: flex; align-items: center; gap: 15px; }
        .meta-icon-luxe { width: 50px; height: 50px; background: rgba(15, 124, 124, 0.2); border: 1px solid var(--accent-teal); border-radius: 15px; display: flex; align-items: center; justify-content: center; color: var(--accent-teal); font-size: 20px; box-shadow: 0 0 20px rgba(15, 124, 124, 0.3); }
        .meta-text-luxe { display: flex; flex-direction: column; }
        .meta-label-luxe { font-size: 11px; font-weight: 900; color: var(--accent-teal); text-transform: uppercase; letter-spacing: 2px; }
        .meta-val-luxe { font-size: 18px; font-weight: 800; color: var(--text-light); }

        .layout-container { max-width: 1500px; margin: 60px auto; padding: 0 80px; display: grid; grid-template-columns: 1fr 420px; gap: 60px; }

        /* Content Cards (Light Mode) */
        .story-card { 
            background: #ffffff; border: 1px solid var(--glass-border); border-radius: 30px; 
            padding: 45px; margin-bottom: 40px; transition: 0.4s;
            position: relative; overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
        }
        .story-card:hover { border-color: rgba(15, 124, 124, 0.2); transform: translateY(-5px); box-shadow: 0 20px 50px rgba(0,0,0,0.06); }
        .day-badge { position: absolute; top: 0; left: 0; background: var(--accent-teal); color: #fff; padding: 15px 30px; font-weight: 950; font-size: 14px; letter-spacing: 3px; border-bottom-right-radius: 30px; }
        .story-title { font-size: 28px; font-weight: 900; color: var(--text-light); margin-bottom: 20px; margin-top: 20px; }
        
        /* Floating Action Console (Diamond Polish) */
        .action-console { position: sticky; top: 130px; }
        .booking-card { 
            background: #ffffff; 
            border: 1px solid var(--glass-border); 
            border-radius: 40px; 
            padding: 40px 32px; 
            box-shadow: 0 40px 80px rgba(0,0,0,0.08);
            position: relative;
        }
        
        .price-display { margin-bottom: 24px; text-align: center; }
        .price-amount { font-size: 4rem; font-weight: 950; line-height: 1; color: var(--text-light); letter-spacing: -2px; }
        .price-sub { font-size: 11px; font-weight: 900; color: var(--accent-teal); text-transform: uppercase; letter-spacing: 3px; margin-bottom: 8px; }

        .booking-label {
            display: block;
            font-size: 10px;
            font-weight: 950;
            color: var(--accent-teal);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 5px;
            padding-left: 0;
        }

        .luxe-input {
            width: 100%;
            background: #f8fafc !important;
            border: 1px solid #e2e8f0 !important;
            border-radius: 20px;
            padding: 20px 25px;
            color: var(--text-light) !important;
            font-weight: 700;
            font-size: 14px;
            transition: 0.3s;
            appearance: auto;
        }
        .luxe-input:focus {
            background: #ffffff !important;
            border-color: var(--accent-teal) !important;
            outline: none;
            box-shadow: 0 0 0 4px var(--accent-teal-glow);
        }
        .luxe-input option { background: #ffffff; color: var(--text-light); }

        .luxe-btn {
            width: 100%; background: linear-gradient(135deg, var(--accent-teal) 0%, var(--accent-teal-dark) 100%);
            color: #fff; border: none; padding: 25px; border-radius: 24px;
            font-weight: 950; font-size: 17px; text-transform: uppercase; letter-spacing: 4px;
            box-shadow: 0 15px 45px rgba(15, 124, 124, 0.4); transition: 0.4s;
            cursor: pointer;
            margin-top: 10px;
        }
        .luxe-btn:hover { transform: translateY(-5px); box-shadow: 0 25px 60px rgba(15, 124, 124, 0.6); letter-spacing: 6px; }

        .total-display {
            padding: 20px 0;
            border-top: 1px solid var(--glass-border);
            margin-top: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .total-label { font-size: 12px; font-weight: 950; color: var(--text-light); text-transform: uppercase; letter-spacing: 2px; }
        .total-amount { font-size: 28px; font-weight: 950; color: var(--accent-teal); }

        .vendor-badge-luxe {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid var(--glass-border);
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .vendor-avatar {
            width: 28px; height: 28px;
            border-radius: 50%;
            border: 1px solid var(--accent-teal);
            object-fit: cover;
        }
        .vendor-name-luxe { font-size: 13px; font-weight: 900; color: var(--text-light); margin-bottom: 0px; display: flex; align-items: center; gap: 8px; }
        .vendor-stars { color: #fbbf24; font-size: 9px; letter-spacing: 1px; }

        .wishlist-luxe-btn {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 8px 15px;
            color: var(--text-light);
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: 0.3s;
            cursor: pointer;
            margin-top: 10px;
        }
        .wishlist-luxe-btn:hover {
            background: #ffffff;
            border-color: var(--accent-teal);
        }
        .wishlist-luxe-btn i { font-size: 14px; }

        @media (max-width: 1200px) {
            .hero-title { font-size: 5rem; letter-spacing: -3px; }
            .layout-container { grid-template-columns: 1fr; padding: 0 40px; }
            .action-console { position: static; margin-top: 40px; }
            .hero-content { padding: 0 40px; }
            .glass-nav { padding: 0 40px; }
        }

        @media (max-width: 768px) {
            .hero-title { font-size: 3.5rem; letter-spacing: -2px; }
            .hero-meta-grid { flex-wrap: wrap; gap: 20px; }
            .glass-nav { overflow-x: auto; white-space: nowrap; gap: 30px; }
            .layout-container { padding: 0 20px; gap: 30px; }
            .story-card { padding: 30px 20px; }
            .hero-content { padding: 0 20px; padding-bottom: 40px; }
        }

        @media (max-width: 480px) {
            .hero-title { font-size: 2.5rem; letter-spacing: -1px; }
            .price-amount { font-size: 3rem; }
            .luxe-btn { padding: 20px; font-size: 15px; letter-spacing: 2px; }
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
            <div class="d-flex align-items-center gap-4 mb-3">
                <h1 class="hero-title m-0">${trip.title}</h1>
            </div>
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
                <p class="text-muted lh-lg fs-5" style="font-weight: 500;">${trip.description}</p>
                <div class="mt-5 p-4 rounded-4" style="background: var(--accent-teal-glow); border: 1px solid rgba(15, 124, 124, 0.2);">
                    <h5 class="fw-black text-uppercase small letter-spacing-2 mb-3" style="color: var(--accent-teal);">Expert Curator Note</h5>
                    <p class="small text-muted m-0">"This expedition was curated specifically for those who seek to lose themselves in the raw beauty of ${trip.destination}. From the transportation logistics to the boutique stays, every detail is engineered for high-end discovery."</p>
                </div>
            </div>

            <!-- Storyline Itinerary -->
            <div id="itinerary">
                <c:forEach var="i" begin="1" end="${trip.days}">
                    <div class="story-card">
                        <div class="day-badge">DAY 0${i}</div>
                        <h2 class="story-title">Entering the Soul of ${trip.destination}</h2>
                        <div class="d-flex gap-3 mb-4">
                            <span class="badge border border-secondary text-dark px-3 py-2 rounded-pill fw-bold small text-uppercase">Logistics: ${trip.transportCategory}</span>
                            <span class="badge text-white px-3 py-2 rounded-pill fw-bold small text-uppercase" style="background: var(--accent-teal);">Nature Hike</span>
                        </div>
                        <p class="text-muted">Day 0${i} is dedicated to exploring the hidden corners of the region. Experience a private, curated journey through the local landscape, featuring exclusive access to sights reserved for elite travelers.</p>
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
                            <i class="fa fa-diamond amenity-icon" style="color: var(--accent-teal);"></i>
                            <div class="amenity-label">${fn:trim(inc)}</div>
                        </div>
                    </c:forEach>
                    <div class="amenity-item">
                        <i class="fa fa-bus amenity-icon" style="color: var(--accent-teal);"></i>
                        <div class="amenity-label">Private ${trip.transportCategory}</div>
                    </div>
                    <div class="amenity-item">
                        <i class="fa fa-camera-retro amenity-icon" style="color: var(--accent-teal);"></i>
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
                        <h4 class="fw-black text-dark mb-3">Premium ${trip.stayType}</h4>
                        <p class="text-muted">Immerse yourself in high-end comfort. Our stays are hand-picked for their unique character, luxury service, and perfect location.</p>
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
                        <div class="small fw-bold text-muted mt-2">Per Traveler • All Logistics Included</div>
                    </div>

                    <form action="<c:url value='/user/booking/submit'/>" method="POST" id="luxeBookingForm">
                        <input type="hidden" name="tripId" value="${trip.id}">
                        <input type="hidden" name="tripType" value="Package">

                        <div class="mb-3">
                            <label class="booking-label">1. Select Your Batch</label>
                            <select name="selectedDate" class="luxe-input" required>
                                <c:forEach var="s" items="${schedules}">
                                    <option value="${s.startDate}">${s.startDate} (${s.availableSeats} Seats)</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="booking-label">2. Total Explorers</label>
                            <select name="travelers" class="luxe-input" onchange="updateLuxePrice()" id="paxSelect">
                                <c:forEach var="p" begin="1" end="10"><option value="${p}">${p} Adults</option></c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="booking-label">3. Special Concierge Requests</label>
                            <textarea name="guestDetails" class="luxe-input" style="height: 100px; resize: none;" placeholder="Dietary needs, room preferences, special occasions..."></textarea>
                        </div>

                        <div class="total-display">
                            <div class="total-label">Total Journey</div>
                            <div id="finalTotal" class="total-amount" style="color: var(--accent-teal);">₹${trip.price}</div>
                        </div>

                        <button type="submit" class="luxe-btn" ${trip.soldOut ? 'disabled' : ''}>
                            ${trip.soldOut ? 'BATCH FULL' : 'RESERVE MY SPOT'}
                        </button>
                    </form>

                    <div class="vendor-badge-luxe">
                        <div class="d-flex align-items-center justify-content-between w-100">
                            <div class="vendor-info-text text-start">
                                <div class="vendor-name-luxe">
                                    <img src="https://ui-avatars.com/api/?name=${fn:replace(trip.vendor.businessName, ' ', '+')}&background=0F7C7C&color=fff" class="vendor-avatar">
                                    EXPERT: ${trip.vendor.businessName}
                                </div>
                                <div class="vendor-stars" style="color: var(--accent-teal);">
                                    <i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i>
                                    <span class="ms-2 opacity-50" style="font-size: 8px;">VERIFIED</span>
                                </div>
                            </div>
                            <button type="button" onclick="toggleWishlist(${trip.id}, this)" class="wishlist-luxe-btn">
                                <i class="fa ${isSaved ? 'fa-heart text-danger' : 'fa-heart-o'}"></i>
                                <span class="wishlist-text">${isSaved ? 'Saved' : 'Save'}</span>
                            </button>
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
            if (heroImg) {
                heroImg.style.transform = 'translateY(' + (scrolled * 0.4) + 'px)';
            }
        });

        function updateLuxePrice() {
            const pax = document.getElementById('paxSelect').value;
            const total = basePrice * pax;
            document.getElementById('finalTotal').innerText = '₹' + total.toLocaleString('en-IN');
        }

        function scrollToId(id) {
            const element = document.getElementById(id);
            if (!element) return;
            
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
            if(event && event.target && event.target.classList.contains('nav-link-mmt')) {
                event.target.classList.add('active');
            }
        }

        function toggleWishlist(tripId, btn) {
            const icon = btn.querySelector('i');
            icon.style.transform = 'scale(1.3)';
            setTimeout(() => icon.style.transform = 'scale(1)', 200);

            fetch('<c:url value="/user/api/toggle-wishlist/"/>' + tripId, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' }
            })
            .then(response => {
                if (response.status === 401) {
                    window.location.href = '<c:url value="/user/login"/>';
                    return;
                }
                return response.json();
            })
            .then(data => {
                if (data && data.saved !== undefined) {
                    if (data.saved) {
                        icon.classList.remove('fa-heart-o', 'text-white');
                        icon.classList.add('fa-heart', 'text-danger');
                        const text = btn.querySelector('.wishlist-text');
                        if(text) text.innerText = 'Saved in Wishlist';
                        showToast('Trip saved to wishlist!');
                    } else {
                        icon.classList.remove('fa-heart', 'text-danger');
                        icon.classList.add('fa-heart-o');
                        const text = btn.querySelector('.wishlist-text');
                        if(text) text.innerText = 'Add to Wishlist';
                        showToast('Trip removed from wishlist');
                    }
                }
            })
            .catch(error => console.error('Error:', error));
        }

        function showToast(message) {
            let container = document.getElementById('toast-container');
            if (!container) {
                container = document.createElement('div');
                container.id = 'toast-container';
                container.style.cssText = 'position: fixed; bottom: 30px; right: 30px; z-index: 9999;';
                document.body.appendChild(container);
            }

            const toast = document.createElement('div');
            toast.innerHTML = message;
            toast.style.cssText = `
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                color: #0f172a;
                padding: 15px 30px;
                border-radius: 12px;
                margin-top: 10px;
                font-weight: 700;
                border: 1px solid rgba(0,0,0,0.1);
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                transform: translateX(100px);
                opacity: 0;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                font-family: 'Outfit', sans-serif;
            `;
            container.appendChild(toast);

            setTimeout(() => {
                toast.style.transform = 'translateX(0)';
                toast.style.opacity = '1';
            }, 100);

            setTimeout(() => {
                toast.style.transform = 'translateX(100px)';
                toast.style.opacity = '0';
                setTimeout(() => toast.remove(), 400);
            }, 3000);
        }
    </script>
</body>
</html>