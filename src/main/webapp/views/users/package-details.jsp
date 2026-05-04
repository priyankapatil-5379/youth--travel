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

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-light);
            margin: 0; padding: 0;
        }

        .container-main { max-width: 1200px; margin: 40px auto; padding: 0 20px; display: grid; grid-template-columns: 1.8fr 1fr; gap: 30px; }

        .btn-back { background: rgba(255,255,255,0.1); color: #fff; border: none; padding: 8px 15px; border-radius: 8px; font-weight: 600; font-size: 14px; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; margin-bottom: 20px; }

        /* Left Section */
        .main-visual { position: relative; border-radius: 20px; overflow: hidden; margin-bottom: 30px; }
        .main-visual img { width: 100%; height: 450px; object-fit: cover; }
        .play-btn { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 60px; height: 60px; background: rgba(255,255,255,0.2); backdrop-filter: blur(5px); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; color: #fff; cursor: pointer; }
        .type-tag { position: absolute; top: 20px; right: 20px; background: var(--accent-red); padding: 4px 12px; border-radius: 6px; font-size: 12px; font-weight: 800; }

        .thumbnail-gallery { display: flex; gap: 12px; margin-bottom: 30px; }
        .thumb-item { flex: 1; height: 70px; border-radius: 10px; overflow: hidden; border: 2px solid transparent; cursor: pointer; }
        .thumb-item.active { border-color: var(--accent-red); }
        .thumb-item img { width: 100%; height: 100%; object-fit: cover; }

        .trip-title { font-size: 32px; font-weight: 800; margin-bottom: 10px; }
        .trip-meta { display: flex; gap: 20px; color: var(--text-muted); font-size: 14px; font-weight: 600; margin-bottom: 20px; }
        .trip-meta span i { color: var(--accent-red); margin-right: 5px; }

        .section-title { font-size: 18px; font-weight: 800; margin-bottom: 20px; color: #fff; }
        .desc-text { color: var(--text-muted); font-size: 15px; line-height: 1.6; margin-bottom: 30px; }

        .inclusions-grid { display: flex; gap: 25px; margin-bottom: 40px; }
        .inclusion-item { text-align: center; }
        .inclusion-icon { width: 45px; height: 45px; background: rgba(255,255,255,0.05); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-bottom: 8px; font-size: 18px; color: var(--text-muted); }
        .inclusion-label { font-size: 11px; font-weight: 600; color: var(--text-muted); text-transform: uppercase; }

        .itinerary-list { border-left: 2px solid var(--border); padding-left: 30px; position: relative; }
        .itinerary-day { position: relative; margin-bottom: 30px; }
        .day-dot { position: absolute; left: -41px; top: 0; width: 20px; height: 20px; background: var(--bg-dark); border: 3px solid var(--accent-red); border-radius: 50%; }
        .day-title { font-size: 16px; font-weight: 800; color: #fff; margin-bottom: 5px; }
        .day-subtitle { font-size: 13px; font-weight: 700; color: var(--text-muted); margin-bottom: 10px; }
        .day-content { font-size: 14px; color: var(--text-muted); line-height: 1.5; }

        /* Right Sidebar */
        .sidebar-card { background: var(--card-bg); border-radius: 24px; padding: 30px; border: 1px solid var(--border); position: sticky; top: 40px; }
        .price-header { display: flex; align-items: baseline; gap: 8px; margin-bottom: 25px; }
        .price-val { font-size: 32px; font-weight: 800; color: #fff; }
        .price-label { color: var(--text-muted); font-size: 14px; font-weight: 600; }

        .field-group { margin-bottom: 25px; position: relative; }
        .field-label { display: block; font-size: 13px; font-weight: 700; color: var(--text-muted); margin-bottom: 10px; text-transform: uppercase; }
        .date-input-wrapper { position: relative; }
        .input-dark { background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 12px; color: #fff; padding: 12px 40px 12px 15px; width: 100%; outline: none; font-weight: 600; appearance: none; -webkit-appearance: none; cursor: pointer; }
        .date-input-wrapper i { position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: var(--text-muted); pointer-events: none; }


        .counter-box { display: flex; align-items: center; justify-content: space-between; background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 12px; padding: 10px 20px; }
        .counter-btn { width: 30px; height: 30px; background: rgba(255,255,255,0.1); border: none; border-radius: 8px; color: #fff; font-size: 18px; font-weight: 800; display: flex; align-items: center; justify-content: center; cursor: pointer; }

        .price-details { margin-top: 30px; padding-top: 25px; border-top: 1px dashed var(--border); }
        .price-row { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 14px; font-weight: 600; color: var(--text-muted); }
        .total-row { border-top: 1px solid var(--border); margin-top: 15px; padding-top: 15px; font-size: 18px; font-weight: 800; color: #fff; }

        .btn-book { width: 100%; background: var(--accent-red); color: #fff; border: none; padding: 18px; border-radius: 16px; font-weight: 800; font-size: 16px; margin-top: 30px; cursor: pointer; transition: 0.3s; text-transform: uppercase; }
        .btn-book:hover { transform: translateY(-3px); box-shadow: 0 10px 25px rgba(225, 29, 72, 0.4); }

        .secure-badge { display: flex; align-items: center; justify-content: center; gap: 8px; font-size: 12px; font-weight: 600; color: #22c55e; margin-top: 20px; }

        /* Skeleton Loading */
        .skeleton { background: linear-gradient(90deg, #1e293b 25%, #334155 50%, #1e293b 75%); background-size: 200% 100%; animation: shimmer 1.5s infinite; border-radius: 10px; }
        @keyframes shimmer { 0% { background-position: 200% 0; } 100% { background-position: -200% 0; } }

        @media (max-width: 991px) { .container-main { grid-template-columns: 1fr; } .sidebar-card { position: static; } }
    </style>
</head>
<body>

    <input type="hidden" id="packageIdValue" value="${trip.id}">

    <div class="container-main">
        <!-- Left Column -->
        <div class="content-left">
            <a href="<c:url value='/user/dashboard'/>" class="btn-back"><i class="fa fa-arrow-left"></i> Back to Trips</a>

            <!-- Skeletons -->
            <div id="skeletons">
                <div class="skeleton" style="width: 100%; height: 450px; border-radius: 20px; margin-bottom: 30px;"></div>
                <div class="skeleton" style="width: 80%; height: 40px; margin-bottom: 20px;"></div>
                <div class="skeleton" style="width: 60%; height: 20px; margin-bottom: 40px;"></div>
            </div>

            <!-- Real Content (Initially Hidden) -->
            <div id="realContent" style="display: none;">
                <div class="main-visual">
                    <img id="mainImg" src="" alt="Trip Visual">
                    <div class="play-btn"><i class="fa fa-play"></i></div>
                    <div class="type-tag" id="tripCategory">GROUP</div>
                </div>

                <div class="thumbnail-gallery" id="thumbGallery"></div>

                <h1 class="trip-title" id="tripTitle"></h1>
                <div class="trip-meta" id="tripMeta"></div>

                <div class="desc-text" id="tripDesc"></div>

                <div class="section-title">Inclusions</div>
                <div class="inclusions-grid">
                    <div class="inclusion-item"><div class="inclusion-icon"><i class="fa fa-hotel"></i></div><div class="inclusion-label">Hotel Stay</div></div>
                    <div class="inclusion-item"><div class="inclusion-icon"><i class="fa fa-cutlery"></i></div><div class="inclusion-label">Meals</div></div>
                    <div class="inclusion-item"><div class="inclusion-icon"><i class="fa fa-bus"></i></div><div class="inclusion-label">Transport</div></div>
                    <div class="inclusion-item"><div class="inclusion-icon"><i class="fa fa-user-secret"></i></div><div class="inclusion-label">Guide</div></div>
                    <div class="inclusion-item"><div class="inclusion-icon"><i class="fa fa-fire"></i></div><div class="inclusion-label">Campfire</div></div>
                    <div class="inclusion-item"><div class="inclusion-icon"><i class="fa fa-camera"></i></div><div class="inclusion-label">Sightseeing</div></div>
                </div>

                <div class="section-title">Itinerary</div>
                <div class="itinerary-list" id="itineraryList"></div>
            </div>
        </div>

        <!-- Right Sidebar -->
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

                    <!-- Main Layout -->
                    <div class="content-container">

                        <!-- Left Column: Details -->
                        <div class="left-col">

                            <div class="section-box">
                                <h2 class="section-title"><i class="fa fa-info-circle"></i> About This Trip</h2>
                                <p style="color: rgba(255,255,255,0.7); line-height: 1.8; font-size: 16px;">
                                    ${trip.description != null ? trip.description : 'Join us for an unforgettable
                                    journey to ' += trip.destination += '. Experience the thrill of adventure and the
                                    beauty of nature.'}
                                </p>
                                <div class="tag-cloud">
                                    <c:if test="${not empty trip.category}"><span class="tag"><i class="fa fa-tag"></i>
                                            ${trip.category}</span></c:if>
                                    <c:if test="${not empty trip.difficulty}"><span class="tag"><i
                                                class="fa fa-free-code-camp"></i> ${trip.difficulty}</span></c:if>
                                    <c:if test="${not empty trip.transportCategory}"><span class="tag"><i
                                                class="fa fa-bus"></i> ${trip.transportCategory}</span></c:if>
                                    <c:if test="${not empty trip.stayCategory}"><span class="tag"><i
                                                class="fa fa-bed"></i> ${trip.stayCategory}</span></c:if>
                                    <c:if test="${not empty trip.ageGroup}"><span class="tag"><i
                                                class="fa fa-users"></i> ${trip.ageGroup}</span></c:if>
                                </div>
                            </div>

                            <div class="section-box">
                                <h2 class="section-title"><i class="fa fa-bed"></i> Stay & Accommodation</h2>
                                <div
                                    class="d-flex align-items-center gap-3 mb-3 p-3 bg-dark rounded-4 border border-secondary border-opacity-10">
                                    <div
                                        style="background: rgba(240, 76, 38, 0.1); color: #f04c26; padding: 15px; border-radius: 12px; font-size: 20px;">
                                        <i class="fa fa-university"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-white">${not empty trip.stayName ? trip.stayName :
                                            'Premium Accommodation'}</div>
                                        <div class="small text-white-50">${trip.stayCategory} • ${trip.stayType} •
                                            ${trip.roomSharing} Sharing</div>
                                    </div>
                                </div>
                                <c:if test="${not empty trip.stayDescription}">
                                    <p class="small text-white-50 mb-3">${trip.stayDescription}</p>
                                </c:if>

                                <!-- Stay Gallery (If backend maps stayPhotos to a gallery list) -->
                                <div class="d-flex flex-wrap gap-2 mt-2">
                                    <c:forEach var="photo" items="${stayGallery}" varStatus="status">
                                        <img src="${photo}" class="rounded-3"
                                            style="width: 100px; height: 100px; object-fit: cover; border: 1px solid rgba(255,255,255,0.1);">
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Pre-process Itinerary JSON in JS later if needed, for now just show a visual mock/raw -->
                            <div class="section-box">
                                <h2 class="section-title"><i class="fa fa-map"></i> Tour Itinerary</h2>
                                <div class="timeline" id="itinerary-timeline">
                                    <!-- We will render JS parsed itinerary here, but if empty show fallback -->
                                    <c:if test="${empty trip.itinerary}">
                                        <div class="day-node">
                                            <div class="day-title">Day 1: Departure & Arrival</div>
                                            <div class="day-desc">Assemble at the pickup point. Journey begins towards
                                                the destination. Reach your stay, check-in, and relax.</div>
                                        </div>
                                        <div class="day-node">
                                            <div class="day-title">Day 2: Exploration & Adventure</div>
                                            <div class="day-desc">Full day of sightseeing, activities, and creating
                                                memories. Evening campfire and group activities.</div>
                                        </div>
                                        <div class="day-node">
                                            <div class="day-title">Day 3: Return Journey</div>
                                            <div class="day-desc">Check out and begin the return journey. Drop-off at
                                                the original pickup points.</div>
                                        </div>
                                    </c:if>
                                </div>
                                <c:if test="${not empty trip.itinerary}">
                                    <!-- Hidden div to hold json string for JS parsing -->
                                    <div id="raw-itinerary" style="display:none;">${trip.itinerary}</div>
                                </c:if>
                            </div>

                            <div class="section-box" style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                                <div>
                                    <h2 class="section-title"><i class="fa fa-check-circle" style="color: #28a745;"></i>
                                        What's Included</h2>
                                    <div
                                        style="color: rgba(255,255,255,0.7); line-height: 1.8; font-size: 15px; white-space: pre-line;">
                                        <c:choose>
                                            <c:when test="${not empty trip.inclusions}">${trip.inclusions}</c:when>
                                            <c:otherwise>✓ Transportation
                                                ✓ Accommodation
                                                ✓ Selected Meals
                                                ✓ Guide/Trek Leader
                                                ✓ First Aid</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div>
                                    <h2 class="section-title"><i class="fa fa-times-circle" style="color: #dc3545;"></i>
                                        What's Excluded</h2>
                                    <div
                                        style="color: rgba(255,255,255,0.7); line-height: 1.8; font-size: 15px; white-space: pre-line;">
                                        <c:choose>
                                            <c:when test="${not empty trip.exclusions}">${trip.exclusions}</c:when>
                                            <c:otherwise>✗ Personal Expenses
                                                ✗ Optional Activities
                                                ✗ Anything not mentioned in inclusions</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${not empty trip.reviews}">
                                <div class="section-box">
                                    <h2 class="section-title"><i class="fa fa-star"></i> Traveler Reviews</h2>
                                    <c:forEach var="review" items="${trip.reviews}">
                                        <div
                                            style="border-bottom: 1px solid var(--border-color); padding-bottom: 15px; margin-bottom: 15px;">
                                            <div
                                                style="display: flex; justify-content: space-between; align-items: center;">
                                                <div style="font-weight: 700; color: #fff;">${review.user.name}</div>
                                                <div style="color: #f59e0b; font-size: 12px;">
                                                    <c:forEach begin="1" end="${review.rating}"><i
                                                            class="fa fa-star"></i></c:forEach>
                                                </div>
                                            </div>
                                            <p
                                                style="color: rgba(255,255,255,0.6); font-size: 14px; margin-top: 5px; margin-bottom: 0;">
                                                "${review.reviewText}"</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>

                        </div>

                        <!-- Right Column: Booking Widget -->
                        <div class="right-col">
                            <div class="booking-widget">
                                <div class="price-display">₹
                                    <fmt:formatNumber value="${trip.price}" pattern="#,##0" /> <span>/ person</span>
                                </div>

                                <form action="<c:url value='/user/booking/submit'/>" method="POST">
                                    <input type="hidden" name="tripId" value="${trip.id}">
                                    <input type="hidden" name="tripType"
                                        value="${not empty trip.category ? trip.category : 'Standard'}">
                                    <input type="hidden" name="guestDetails" value="N/A">

                                    <label class="form-label">Select Date & Schedule</label>
                                    <select id="scheduleSelect" name="selectedDate" class="custom-select" onchange="handleScheduleChange()" required>
                                        <option value="" data-seats="30" disabled selected>Choose an available date...</option>
                                        <c:forEach var="schedule" items="${schedules}">
                                            <option value="${schedule.startDate} to ${schedule.endDate}" data-seats="${schedule.availableSeats}">
                                                ${schedule.startDate} to ${schedule.endDate}
                                                (${schedule.availableSeats} seats left)
                                            </option>
                                        </c:forEach>
                                        <c:if test="${empty schedules}">
                                            <option value="" data-seats="0" disabled>No upcoming schedules available</option>
                                        </c:if>
                                    </select>

                                    <style>
                                        input[type="number"]::-webkit-inner-spin-button, 
                                        input[type="number"]::-webkit-outer-spin-button { 
                                            -webkit-appearance: none; 
                                            margin: 0; 
                                        }
                                        input[type="number"] {
                                            -moz-appearance: textfield;
                                        }
                                    </style>
                                    <label class="form-label">Number of Travelers</label>
                                    <div class="traveler-counter" style="display: flex; align-items: center; justify-content: space-between; background: rgba(0, 0, 0, 0.3); border: 1px solid var(--border-color); border-radius: 12px; padding: 8px 15px;">
                                        <button type="button" class="btn-counter" onclick="updateTravelers(-1)" style="background: rgba(255,255,255,0.1); border: none; color: #fff; font-size: 18px; cursor: pointer; width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: var(--transition);" onmouseover="this.style.background='var(--primary-blue)'" onmouseout="this.style.background='rgba(255,255,255,0.1)'"><i class="fa fa-minus" style="font-size: 12px;"></i></button>
                                        <input type="number" id="travelers" name="travelers" value="1" min="1" max="30" readonly style="background: transparent; border: none; color: #fff; text-align: center; font-size: 18px; font-weight: 700; width: 60px; outline: none;">
                                        <button type="button" class="btn-counter" onclick="updateTravelers(1)" style="background: rgba(255,255,255,0.1); border: none; color: #fff; font-size: 18px; cursor: pointer; width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: var(--transition);" onmouseover="this.style.background='var(--primary-blue)'" onmouseout="this.style.background='rgba(255,255,255,0.1)'"><i class="fa fa-plus" style="font-size: 12px;"></i></button>
                                    </div>

                                    <button type="submit" class="btn-book" ${trip.soldOut
                                        ? 'disabled style="background:gray;"' : '' }>
                                        ${trip.soldOut ? 'Sold Out' : 'Book Now'}
                                    </button>
                                    <a href="<c:url value='/user/save-trip/${trip.id}'/>" class="btn-save"
                                        style="display: block; text-align: center; margin-top: 12px; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: #fff; padding: 15px; border-radius: 12px; font-weight: 700; text-decoration: none; transition: 0.3s;">
                                        <i class="fa fa-heart-o"></i> Save to Wishlist
                                    </a>

                                    <div
                                        style="text-align: center; margin-top: 15px; font-size: 13px; color: var(--text-muted);">
                                        <i class="fa fa-shield"></i> Secure Booking • Instant Confirmation
                                    </div>
                                </form>

                                <!-- Vendor Profile snippet -->
                                <div class="vendor-info">
                                    <img src="${not empty trip.vendor.logoPath ? trip.vendor.logoPath : 'https://ui-avatars.com/api/?name=' += trip.vendor.businessName}"
                                        class="vendor-avatar">
                                    <div>
                                        <div style="font-weight: 700; font-size: 15px; color: #fff;">Operated by</div>
                                        <div style="color: var(--primary-blue); font-weight: 800;">
                                            ${trip.vendor.businessName}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

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
                <div class="secure-badge"><i class="fa fa-shield"></i> 100% Secure & Safe Payments</div>
            </div>
        </div>
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
                const response = await fetch(`/api/packages/${packageId}`);
                if (!response.ok) throw new Error("Failed to load");
                tripData = await response.json();
                renderUI();
            } catch (err) {
                console.error(err);
                showToast("Failed to load package details.");
            }
        }

        function renderUI() {
            const { trip, schedules } = tripData;
            document.getElementById('skeletons').style.display = 'none';
            document.getElementById('realContent').style.display = 'block';

            document.getElementById('tripTitle').innerText = trip.title;
            document.getElementById('tripCategory').innerText = trip.category || "GROUP";
            document.getElementById('priceDisplay').innerText = "₹" + trip.price.toLocaleString('en-IN');
            
            document.getElementById('tripMeta').innerHTML = `
                <span><i class="fa fa-map-marker"></i> ` + trip.destination + `</span>
                <span><i class="fa fa-calendar"></i> ` + trip.days + ` Days / ` + trip.nights + ` Nights</span>
                <span><i class="fa fa-star"></i> ` + (trip.averageRating || '4.8') + ` (120 Reviews)</span>
            `;

            document.getElementById('tripDesc').innerText = trip.description;

            // Gallery
            const media = trip.mediaUrls ? trip.mediaUrls.split(',') : [];
            const mainImg = media.length > 0 ? media[0] : "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=1200";
            document.getElementById('mainImg').src = mainImg;

            const galleryHtml = media.slice(0, 4).map((url, i) => `
                <div class="thumb-item ` + (i === 0 ? 'active' : '') + `" onclick="setMainImage('` + url + `', this)">
                    <img src="` + url + `" alt="Thumb">
                </div>
            `).join('');
            document.getElementById('thumbGallery').innerHTML = galleryHtml;

            // Itinerary
            if (trip.itinerary) {
                const plan = JSON.parse(trip.itinerary);
                document.getElementById('itineraryList').innerHTML = plan.map(day => `
                    <div class="itinerary-day">
                        <div class="day-dot"></div>
                        <div class="day-title">Day ` + day.day + `</div>
                        <div class="day-subtitle">` + day.title + `</div>
                        <div class="day-content">` + day.description + `</div>
                    </div>
                `).join('');
            }

            // Schedules
            const availableDates = schedules.map(s => s.startDate);
            picker = flatpickr("#datePicker", {
                enable: availableDates,
                dateFormat: "d M Y",
                disableMobile: "true",
                theme: "dark",
                onChange: function(selectedDates, dateStr) {
                    updatePricing();
                }
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
            const price = tripData.trip.price;
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