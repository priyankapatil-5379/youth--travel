<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trip Details | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/dark.css">
    <style>
        :root {
            --bg-dark: #020617;
            --card-bg: #0f172a;
            --accent-red: #e11d48;
            --text-light: #f8fafc;
            --text-muted: #94a3b8;
            --border: rgba(255, 255, 255, 0.1);
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
    </style>
</head>
<body>

    <input type="hidden" id="packageIdValue" value="${trip.id}">

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
                    </div>
                `).join('');
            }

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

            updatePricing();
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
    </script>
</body>
</html>