<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>${trip.title} | Youth Travel</title>
                    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
                    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
                    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
                    <style>
                        :root {
                            --primary-blue: #f04c26;
                            --text-muted: #7e8c9a;
                            --transition: all 0.3s ease;
                            --dark-bg: #0b0f18;
                            --dark-card: #161c28;
                            --border-color: rgba(255, 255, 255, 0.08);
                        }

                        body {
                            font-family: 'Dosis', sans-serif;
                            background-color: var(--dark-bg);
                            color: rgba(255, 255, 255, 0.92);
                            margin: 0;
                            padding: 0;
                            overflow-x: hidden;
                        }

                        /* Hero Banner */
                        .hero-banner {
                            position: relative;
                            width: 100%;
                            height: 60vh;
                            min-height: 400px;
                            overflow: hidden;
                        }

                        .hero-bg {
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                            filter: brightness(0.6);
                        }

                        .hero-content {
                            position: absolute;
                            bottom: 0;
                            left: 0;
                            width: 100%;
                            padding: 60px 40px;
                            background: linear-gradient(to top, rgba(11, 15, 24, 1) 0%, rgba(11, 15, 24, 0.8) 40%, rgba(11, 15, 24, 0) 100%);
                        }

                        .hero-title {
                            font-size: clamp(32px, 6vw, 48px);
                            font-weight: 800;
                            margin-bottom: 15px;
                            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
                        }

                        .hero-meta {
                            display: flex;
                            gap: 20px;
                            font-size: 16px;
                            font-weight: 600;
                            color: rgba(255, 255, 255, 0.8);
                        }

                        .hero-meta span {
                            display: flex;
                            align-items: center;
                            gap: 8px;
                        }

                        /* Main Content Layout */
                        .content-container {
                            max-width: 1200px;
                            margin: 40px auto;
                            padding: 0 20px;
                            display: grid;
                            grid-template-columns: 2fr 1fr;
                            gap: 40px;
                        }

                        @media (max-width: 991px) {
                            .hero-banner { height: 45vh; min-height: 300px; }
                            .hero-content { padding: 40px 20px; }
                            .content-container { grid-template-columns: 1fr; gap: 30px; margin: 20px auto; }
                            .booking-widget { position: relative; top: 0; padding: 25px; }
                            .top-nav { left: 20px; top: 15px; }
                            .btn-back { padding: 8px 15px; font-size: 14px; }
                        }

                        @media (max-width: 576px) {
                            .hero-meta { flex-direction: column; gap: 10px; }
                            .section-box { padding: 20px; }
                            .section-box[style*="grid-template-columns: 1fr 1fr"] { grid-template-columns: 1fr !important; }
                        }

                        /* Prevent infinite horizontal stretch on ultra-wide screens */
                        @media (min-width: 2000px) {
                            .hero-banner, .content-container {
                                max-width: 1600px;
                                margin-left: auto;
                                margin-right: auto;
                            }
                        }

                        /* Left Column */
                        .section-box {
                            background: var(--dark-card);
                            border: 1px solid var(--border-color);
                            border-radius: 20px;
                            padding: 30px;
                            margin-bottom: 30px;
                        }

                        .section-title {
                            font-size: 24px;
                            font-weight: 800;
                            margin-bottom: 25px;
                            display: flex;
                            align-items: center;
                            gap: 12px;
                            color: #fff;
                            border-bottom: 1px solid var(--border-color);
                            padding-bottom: 15px;
                        }

                        .section-title i {
                            color: var(--primary-blue);
                        }

                        .tag-cloud {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 10px;
                            margin-top: 15px;
                        }

                        .tag {
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            padding: 6px 15px;
                            border-radius: 20px;
                            font-size: 13px;
                            font-weight: 600;
                            color: rgba(255, 255, 255, 0.8);
                        }

                        .tag i {
                            color: var(--primary-blue);
                            margin-right: 5px;
                        }

                        /* Itinerary Timeline */
                        .timeline {
                            position: relative;
                            padding-left: 30px;
                        }

                        .timeline::before {
                            content: '';
                            position: absolute;
                            left: 0;
                            top: 10px;
                            bottom: 0;
                            width: 2px;
                            background: rgba(255, 255, 255, 0.1);
                        }

                        .day-node {
                            position: relative;
                            margin-bottom: 30px;
                        }

                        .day-node::before {
                            content: '';
                            position: absolute;
                            left: -35px;
                            top: 5px;
                            width: 12px;
                            height: 12px;
                            border-radius: 50%;
                            background: var(--primary-blue);
                            border: 2px solid var(--dark-card);
                            box-shadow: 0 0 0 2px rgba(240, 76, 38, 0.3);
                        }

                        .day-title {
                            font-weight: 800;
                            font-size: 18px;
                            margin-bottom: 10px;
                        }

                        .day-desc {
                            color: rgba(255, 255, 255, 0.6);
                            font-size: 15px;
                            line-height: 1.6;
                        }

                        /* Right Column - Booking Widget */
                        .booking-widget {
                            background: var(--dark-card);
                            border: 1px solid var(--primary-blue);
                            border-radius: 20px;
                            padding: 30px;
                            position: sticky;
                            top: 100px;
                            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
                        }

                        .price-display {
                            font-size: 36px;
                            font-weight: 800;
                            color: #fff;
                            margin-bottom: 5px;
                        }

                        .price-display span {
                            font-size: 14px;
                            color: rgba(255, 255, 255, 0.5);
                            font-weight: 600;
                        }

                        .form-label {
                            font-weight: 700;
                            color: rgba(255, 255, 255, 0.8);
                            margin-bottom: 8px;
                            display: block;
                            margin-top: 20px;
                        }

                        .custom-select {
                            width: 100%;
                            background: rgba(0, 0, 0, 0.3);
                            border: 1px solid var(--border-color);
                            color: #fff;
                            padding: 12px 15px;
                            border-radius: 12px;
                            font-family: inherit;
                            font-size: 15px;
                            font-weight: 600;
                            outline: none;
                            cursor: pointer;
                        }

                        .custom-select option {
                            background: var(--dark-card);
                            color: #fff;
                        }

                        .btn-book {
                            width: 100%;
                            background: var(--primary-blue);
                            color: #fff;
                            border: none;
                            padding: 15px;
                            border-radius: 12px;
                            font-size: 18px;
                            font-weight: 800;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            margin-top: 30px;
                            transition: var(--transition);
                            cursor: pointer;
                        }

                        .btn-book:hover {
                            background: #d84422;
                            transform: translateY(-2px);
                            box-shadow: 0 10px 20px rgba(240, 76, 38, 0.3);
                        }

                        .vendor-info {
                            display: flex;
                            align-items: center;
                            gap: 15px;
                            margin-top: 30px;
                            padding-top: 20px;
                            border-top: 1px solid var(--border-color);
                        }

                        .vendor-avatar {
                            width: 50px;
                            height: 50px;
                            border-radius: 50%;
                            object-fit: cover;
                        }

                        /* Nav */
                        .top-nav {
                            position: absolute;
                            top: 20px;
                            left: 40px;
                            z-index: 10;
                        }

                        .btn-back {
                            background: rgba(0, 0, 0, 0.5);
                            color: #fff;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                            padding: 10px 20px;
                            border-radius: 30px;
                            text-decoration: none;
                            font-weight: 700;
                            backdrop-filter: blur(10px);
                            transition: var(--transition);
                        }

                        .btn-back:hover {
                            background: rgba(255, 255, 255, 0.1);
                            color: #fff;
                        }
                    </style>
                </head>

                <body>

                    <div class="top-nav">
                        <a href="<c:url value='/user/dashboard'/>" class="btn-back"><i class="fa fa-arrow-left"></i>
                            Back to Dashboard</a>
                    </div>

                    <!-- Hero Banner Carousel -->
                    <div class="hero-banner">
                        <div id="tripCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                            <!-- Carousel Indicators -->
                            <div class="carousel-indicators" style="bottom: 80px; z-index: 20;">
                                <button type="button" data-bs-target="#tripCarousel" data-bs-slide-to="0"
                                    class="active"></button>
                                <button type="button" data-bs-target="#tripCarousel" data-bs-slide-to="1"></button>
                                <button type="button" data-bs-target="#tripCarousel" data-bs-slide-to="2"></button>
                                <button type="button" data-bs-target="#tripCarousel" data-bs-slide-to="3"></button>
                            </div>

                            <div class="carousel-inner" style="height: 60vh;">
                                <!-- Main Image (Always First) -->
                                <div class="carousel-item active" style="height: 60vh;">
                                    <img src="${not empty trip.imageUrl ? trip.imageUrl : 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1920&q=80'}"
                                        class="d-block w-100 hero-bg" alt="Main Image">
                                </div>

                                <c:choose>
                                    <c:when test="${not empty gallery && fn:length(gallery) > 1}">
                                        <c:forEach var="url" items="${gallery}" varStatus="status">
                                            <c:if test="${!status.first && status.index < 4}">
                                                <div class="carousel-item" style="height: 60vh;">
                                                    <img src="${url}" class="d-block w-100 hero-bg" alt="Gallery Image">
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <!-- If gallery had less than 4, add fallbacks to reach 4 -->
                                        <c:if test="${fn:length(gallery) < 4}">
                                            <c:forEach begin="${fn:length(gallery)}" end="3" var="i">
                                                <div class="carousel-item" style="height: 60vh;">
                                                    <c:choose>
                                                        <c:when test="${i == 1}"><img
                                                                src="https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1920&q=80"
                                                                class="d-block w-100 hero-bg" alt="Fallback 1"></c:when>
                                                        <c:when test="${i == 2}"><img
                                                                src="https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&w=1920&q=80"
                                                                class="d-block w-100 hero-bg" alt="Fallback 2"></c:when>
                                                        <c:otherwise><img
                                                                src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1920&q=80"
                                                                class="d-block w-100 hero-bg" alt="Fallback 3">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Pure Fallbacks -->
                                        <div class="carousel-item" style="height: 60vh;">
                                            <img src="https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1920&q=80"
                                                class="d-block w-100 hero-bg" alt="Gallery 1">
                                        </div>
                                        <div class="carousel-item" style="height: 60vh;">
                                            <img src="https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&w=1920&q=80"
                                                class="d-block w-100 hero-bg" alt="Gallery 2">
                                        </div>
                                        <div class="carousel-item" style="height: 60vh;">
                                            <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1920&q=80"
                                                class="d-block w-100 hero-bg" alt="Gallery 3">
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#tripCarousel"
                                data-bs-slide="prev" style="z-index: 30; width: 10%;">
                                <span class="carousel-control-prev-icon" aria-hidden="true"
                                    style="background-color: rgba(0,0,0,0.5); border-radius: 50%; padding: 20px;"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#tripCarousel"
                                data-bs-slide="next" style="z-index: 30; width: 10%;">
                                <span class="carousel-control-next-icon" aria-hidden="true"
                                    style="background-color: rgba(0,0,0,0.5); border-radius: 50%; padding: 20px;"></span>
                            </button>
                        </div>

                        <div class="hero-content">
                            <h1 class="hero-title">${trip.title}</h1>
                            <div class="hero-meta">
                                <span><i class="fa fa-map-marker" style="color: var(--primary-blue);"></i>
                                    ${trip.destination}</span>
                                <span><i class="fa fa-clock-o" style="color: var(--primary-blue);"></i> ${trip.days}
                                    Days / ${trip.nights} Nights</span>
                                <span><i class="fa fa-star" style="color: #f59e0b;"></i> ${trip.averageRating > 0 ?
                                    trip.averageRating : 'New'} Rating</span>
                            </div>
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
                                <div class="d-flex align-items-center gap-3 mb-3 p-3 bg-dark rounded-4 border border-secondary border-opacity-10">
                                    <div style="background: rgba(240, 76, 38, 0.1); color: #f04c26; padding: 15px; border-radius: 12px; font-size: 20px;">
                                        <i class="fa fa-university"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-white">${not empty trip.stayName ? trip.stayName : 'Premium Accommodation'}</div>
                                        <div class="small text-white-50">${trip.stayCategory} • ${trip.stayType} • ${trip.roomSharing} Sharing</div>
                                    </div>
                                </div>
                                <c:if test="${not empty trip.stayDescription}">
                                    <p class="small text-white-50 mb-3">${trip.stayDescription}</p>
                                </c:if>
                                
                                <!-- Stay Gallery (If backend maps stayPhotos to a gallery list) -->
                                <div class="d-flex flex-wrap gap-2 mt-2">
                                    <c:forEach var="photo" items="${stayGallery}" varStatus="status">
                                        <img src="${photo}" class="rounded-3" style="width: 100px; height: 100px; object-fit: cover; border: 1px solid rgba(255,255,255,0.1);">
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
                                    <select name="selectedDate" class="custom-select" required>
                                        <option value="" disabled selected>Choose an available date...</option>
                                        <c:forEach var="schedule" items="${schedules}">
                                            <option value="${schedule.startDate} to ${schedule.endDate}">
                                                ${schedule.startDate} to ${schedule.endDate}
                                                (${schedule.availableSeats} seats left)
                                            </option>
                                        </c:forEach>
                                        <c:if test="${empty schedules}">
                                            <option value="" disabled>No upcoming schedules available</option>
                                        </c:if>
                                    </select>

                                    <label class="form-label">Number of Travelers</label>
                                    <select name="travelers" class="custom-select" required>
                                        <option value="1">1 Traveler</option>
                                        <option value="2">2 Travelers</option>
                                        <option value="3">3 Travelers</option>
                                        <option value="4">4 Travelers</option>
                                        <option value="5">5+ Travelers</option>
                                    </select>

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

                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const rawEl = document.getElementById("raw-itinerary");
                            if (rawEl) {
                                const rawContent = rawEl.textContent.trim();
                                try {
                                    const data = JSON.parse(rawContent);
                                    const timeline = document.getElementById("itinerary-timeline");
                                    if (data && Array.isArray(data) && data.length > 0) {
                                        timeline.innerHTML = '';
                                        data.forEach((day, index) => {
                                            const node = document.createElement("div");
                                            node.className = "day-node";
                                            
                                            let galleryHtml = '';
                                            if (day.images && Array.isArray(day.images) && day.images.length > 0) {
                                                galleryHtml = `<div class="day-gallery mt-3 d-flex flex-wrap gap-2">
                                                    \${day.images.map(img => `<img src="\${img}" class="rounded shadow-sm" style="width: 120px; height: 120px; object-fit: cover; border: 2px solid rgba(255,255,255,0.1);">`).join('')}
                                                </div>`;
                                            }

                                            node.innerHTML = `
                                                <div class="day-title">Day \${index + 1}: \${day.title || 'Adventure'}</div>
                                                <div class="day-desc">\${day.activities || day.description || ''}</div>
                                                \${galleryHtml}
                                            `;
                                            timeline.appendChild(node);
                                        });
                                    }
                                } catch (e) {
                                    console.error("Failed to parse itinerary JSON. Raw content:", rawContent);
                                    console.error("Error details:", e);
                                }
                            }
                        });
                    </script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            var myCarousel = document.querySelector('#tripCarousel');
                            if (myCarousel) {
                                new bootstrap.Carousel(myCarousel, {
                                    interval: 3000,
                                    ride: 'carousel'
                                });
                            }
                        });
                    </script>
                </body>

                </html>