<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f1f5f9;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --success: #10b981;
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Inter', sans-serif !important;
            background-color: var(--bg-body) !important;
            color: var(--text-main) !important;
            margin: 0;
            padding: 0;
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; transition: margin-left 0.4s ease; }

        /* New Panoramic Banner */
        .dashboard-banner {
            width: 100%;
            height: 240px;
            border-radius: 20px;
            overflow: hidden;
            margin-bottom: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border: 1px solid var(--border-color);
        }
        .dashboard-banner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center 40%;
        }

        /* Redesigned Console Bar */
        .dashboard-console { 
            background: #ffffff; 
            border-radius: 16px; 
            border: 1px solid var(--border-color); 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
            margin-bottom: 32px;
            padding: 16px 24px;
        }

        .console-row {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .search-container { position: relative; flex: 2; min-width: 280px; }
        .search-container input { 
            background: #ffffff !important; 
            border: 1px solid var(--border-color) !important; 
            border-radius: 12px; color: var(--text-main) !important; 
            padding: 14px 16px 14px 48px; width: 100%; 
            font-weight: 500; font-size: 15px;
            transition: all 0.2s;
        }
        .search-container input:focus {
            border-color: var(--primary) !important;
            box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.05) !important;
        }
        .search-container i { 
            position: absolute; left: 18px; top: 50%; transform: translateY(-50%);
            color: var(--text-muted); font-size: 18px; 
        }

        .btn-luxe-filter { 
            background: #ffffff !important; 
            border: 1px solid var(--border-color) !important; 
            color: var(--primary) !important;
            padding: 14px 24px; 
            border-radius: 12px; 
            font-weight: 700; 
            font-size: 14px; 
            transition: all 0.2s;
            display: flex; align-items: center; gap: 8px;
            letter-spacing: 1px;
        }
        .btn-luxe-filter:hover { 
            background: #f8fafc !important;
            border-color: var(--primary) !important;
        }

        .filter-group-inline {
            display: flex;
            align-items: center;
            gap: 10px;
            padding-left: 15px;
        }

        .vertical-divider {
            width: 1px;
            height: 30px;
            background: var(--border-color);
            margin: 0 5px;
        }

        .sort-select { 
            background: #ffffff !important; border: 1px solid var(--border-color) !important; 
            color: var(--text-main) !important; padding: 12px 16px; border-radius: 12px; 
            font-weight: 600; cursor: pointer; font-size: 14px;
            min-width: 160px;
        }

        .meta-label-luxe { font-size: 12px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; white-space: nowrap; }

        /* Grid & Cards */
        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 24px; }
        .package-card { 
            background: #ffffff; 
            border-radius: 16px; overflow: hidden; 
            border: 1px solid var(--border-color); 
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            position: relative;
        }
        .package-card:hover { transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); border-color: var(--primary); }

        .package-img-wrapper { position: relative; width: 100%; aspect-ratio: 16 / 10; overflow: hidden; background: #f1f5f9; }
        .package-img, .package-video { width: 100%; height: 100%; object-fit: cover; transition: all 0.5s ease; }
        .package-card:hover .package-img, .package-card:hover .package-video { transform: scale(1.05); }
        
        .expert-badge-container { position: absolute; top: 12px; left: 12px; z-index: 5; display: flex; gap: 6px; }
        .expert-badge { padding: 4px 10px; border-radius: 6px; font-size: 10px; font-weight: 700; text-transform: uppercase; }
        .badge-sold-out { background: #fee2e2; color: #ef4444; }
        .badge-expert { background: #e0f2f2; color: var(--primary); }
        .badge-trending { background: #fef3c7; color: #d97706; }

        .package-info { padding: 20px; }
        .package-name { font-size: 18px; font-weight: 700; color: var(--text-main); margin-bottom: 8px; height: 44px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .package-meta { font-size: 13px; color: var(--text-muted); margin-bottom: 6px; display: flex; align-items: center; gap: 6px; }
        .package-meta i { color: var(--primary); width: 14px; }

        .package-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 16px; padding-top: 16px; border-top: 1px solid var(--border-color); }
        .package-price { font-size: 20px; font-weight: 800; color: var(--text-main); }
        .package-price span { font-size: 12px; font-weight: 400; color: var(--text-muted); }

        .btn-view { 
            background: var(--primary); color: #ffffff !important; 
            padding: 8px 16px; border-radius: 8px; font-size: 13px; font-weight: 600; 
            text-decoration: none !important; transition: all 0.2s;
        }
        .btn-view:hover { background: var(--primary-hover); transform: translateY(-1px); }
        .btn-view.disabled { background: #e2e8f0; color: #94a3b8 !important; pointer-events: none; }

        /* Filter Sidebar */
        .filter-sidebar { 
            position: fixed; top: 0; right: -400px; width: 380px; height: 100vh; 
            background: #ffffff; z-index: 1050; transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1); 
            padding: 40px; overflow-y: auto; border-left: 1px solid var(--border-color); 
            box-shadow: -10px 0 30px rgba(0,0,0,0.1);
        }
        .filter-sidebar.show { right: 0; }
        .filter-overlay { position: fixed; inset: 0; background: rgba(15, 23, 42, 0.5); backdrop-filter: blur(4px); z-index: 1040; display: none; }
        .filter-overlay.show { display: block; }

        .filter-label { font-size: 12px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 8px; display: block; }
        .luxe-select { 
            background: #ffffff !important; border: 1px solid var(--border-color) !important; 
            border-radius: 10px; color: var(--text-main) !important; padding: 12px 16px; width: 100%; 
            font-weight: 500; cursor: pointer; transition: 0.3s;
        }
        .luxe-select:focus { border-color: var(--primary) !important; box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1) !important; }

        .btn-apply-filters { width: 100%; background: var(--primary); color: #fff; border: none; padding: 14px; border-radius: 10px; font-weight: 700; font-size: 15px; transition: 0.2s; }
        .btn-apply-filters:hover { background: var(--primary-hover); }

        .category-header { margin-bottom: 24px; display: flex; align-items: center; gap: 12px; }
        .category-title { font-size: 20px; font-weight: 800; color: var(--text-main); margin: 0; }
        .bg-danger-soft { background: #fee2e2 !important; color: #ef4444 !important; border-radius: 6px; padding: 4px 10px; font-size: 12px; }

        /* Mobile Responsiveness */
        .mobile-header {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 70px;
            background: #ffffff;
            border-bottom: 1px solid var(--border-color);
            padding: 0 24px;
            align-items: center;
            justify-content: space-between;
            z-index: 900;
        }
        .mobile-logo img { height: 45px; width: auto; object-fit: contain; display: block; }
        .hamburger-menu {
            font-size: 24px;
            color: var(--primary);
            cursor: pointer;
            background: none;
            border: none;
            padding: 8px;
        }

        @media (max-width: 1200px) {
            .console-row { gap: 10px; }
            .search-container { min-width: 200px; }
            .sort-select { min-width: 130px; padding: 12px 10px; }
        }

        @media (max-width: 991px) {
            .mobile-header { display: flex; }
            .main-content { margin-left: 0; padding: 100px 20px 40px !important; }
            .dashboard-banner { height: 180px; }
            .console-row { flex-direction: column; align-items: stretch; gap: 15px; }
            .search-container { width: 100%; }
            .btn-luxe-filter { width: 100%; justify-content: center; }
            .filter-group-inline { padding: 0; border: none; flex-direction: row; justify-content: space-between; }
            .vertical-divider { display: none; }
            .sort-select { flex: 1; }
        }

        @media (max-width: 576px) {
            .main-content { padding: 90px 15px 30px !important; }
            .console-top, .console-bottom { padding: 20px; }
            .package-grid { grid-template-columns: 1fr; }
            .dash-subtitle-luxe { font-size: 11px; letter-spacing: 2px !important; }
        }
    </style>
</head>
<body class="light-theme">
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp"><jsp:param name="activePage" value="dashboard" /></jsp:include>
        
        <!-- Mobile Header -->
        <header class="mobile-header">
            <div class="mobile-logo">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>
            <button class="hamburger-menu" onclick="toggleMainSidebar()">
                <i class="fa fa-bars"></i>
            </button>
        </header>

        <main class="main-content">
            <form action="<c:url value='/user/dashboard'/>" method="GET" id="filterForm">
                <!-- Panoramic Banner -->
                <div class="dashboard-banner">
                    <img src="<c:url value='/views/assets/images/panoramic-hero.png'/>" alt="Mountain Panorama">
                </div>

                <!-- Console Bar -->
                <div class="dashboard-console">
                    <div class="console-row">
                        <div class="search-container">
                            <i class="fa fa-search"></i>
                            <input type="text" name="search" id="searchInput" value="${currentParams.search}" placeholder="Search destinations..." oninput="searchTrips()">
                        </div>
                        
                        <button type="button" class="btn-luxe-filter" onclick="toggleFilter()">
                            <i class="fa fa-sliders"></i> REFINE
                        </button>

                        <div class="vertical-divider d-none d-lg-block"></div>

                        <div class="filter-group-inline">
                            <span class="meta-label-luxe">Group by:</span>
                            <select name="groupBy" class="sort-select" onchange="this.form.submit()">
                                <option value="none" ${currentParams.groupBy == 'none' ? 'selected' : ''}>No Grouping</option>
                                <option value="category" ${currentParams.groupBy == 'category' ? 'selected' : ''}>Activity</option>
                                <option value="adventure" ${currentParams.groupBy == 'adventure' ? 'selected' : ''}>Adventures</option>
                                <option value="stay" ${currentParams.groupBy == 'stay' ? 'selected' : ''}>Stay Type</option>
                                <option value="transport" ${currentParams.groupBy == 'transport' ? 'selected' : ''}>Transport</option>
                                <option value="travelerType" ${currentParams.groupBy == 'travelerType' ? 'selected' : ''}>Audience</option>
                            </select>
                        </div>

                        <div class="vertical-divider d-none d-lg-block"></div>

                        <div class="filter-group-inline">
                            <span class="meta-label-luxe">Sort by:</span>
                            <select name="sortBy" class="sort-select" onchange="this.form.submit()">
                                <option value="latest" ${currentParams.sortBy == 'latest' ? 'selected' : ''}>Latest Arrivals</option>
                                <option value="priceLow" ${currentParams.sortBy == 'priceLow' ? 'selected' : ''}>Value: Low to High</option>
                                <option value="priceHigh" ${currentParams.sortBy == 'priceHigh' ? 'selected' : ''}>Luxe: High to Low</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Active Filters Context -->
                <c:if test="${not empty currentParams.search || currentParams.destination != 'All' || currentParams.category != 'All' || currentParams.duration != 'All' || currentParams.departureCity != 'All' || currentParams.month != 'All'}">
                    <div class="d-flex align-items-center gap-3 mb-4 ps-2">
                        <span class="meta-label-luxe">Active Filters:</span>
                        <c:if test="${not empty currentParams.search}">
                            <span class="badge bg-danger text-white px-3 py-2 rounded-pill shadow-sm" style="font-size: 11px; font-weight: 800; letter-spacing: 1px;">
                                SEARCH: "${currentParams.search}" 
                                <a href="<c:url value='/user/dashboard?search='/>" class="text-white ms-2"><i class="fa fa-times-circle"></i></a>
                            </span>
                        </c:if>
                        <a href="<c:url value='/user/dashboard'/>" class="text-muted small fw-bold text-decoration-none border-bottom border-light ms-2 pb-1">Clear All</a>
                    </div>
                </c:if>

                <!-- Filter Sidebar -->
                <div class="filter-overlay" id="filterOverlay" onclick="toggleFilter()"></div>
                <div class="filter-sidebar" id="filterSidebar">
                    <div class="d-flex justify-content-between align-items-center mb-5">
                        <h2 class="fw-black m-0" style="font-size: 24px; letter-spacing: -1px; color: var(--text-main);">Filters</h2>
                        <button type="button" class="btn-close" onclick="toggleFilter()"></button>
                    </div>

                    <div class="filter-group mb-4">
                        <label class="filter-label">DESTINATION</label>
                        <select class="luxe-select" name="destination" id="filterDest">
                            <option value="All">All Destinations</option>
                            <c:forEach var="dest" items="${destinations}">
                                <option value="${dest}" ${currentParams.destination==dest ? 'selected' : ''}>${dest}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-group mb-4">
                        <label class="filter-label">TRIP TYPE</label>
                        <select class="luxe-select" name="category" id="filterType">
                            <option value="All">All Types</option>
                            <option value="Trekking" ${currentParams.category=='Trekking' ? 'selected' : ''}>Trekking</option>
                            <option value="Camping" ${currentParams.category=='Camping' ? 'selected' : ''}>Camping</option>
                            <option value="Backpacking" ${currentParams.category=='Backpacking' ? 'selected' : ''}>Backpacking</option>
                        </select>
                    </div>

                    <div class="filter-group mb-4">
                        <label class="filter-label">DURATION</label>
                        <select class="luxe-select" name="duration" id="filterDuration">
                            <option value="All">All Durations</option>
                            <option value="Short" ${currentParams.duration=='Short' ? 'selected' : ''}>1-3 Days</option>
                            <option value="Medium" ${currentParams.duration=='Medium' ? 'selected' : ''}>4-7 Days</option>
                            <option value="Long" ${currentParams.duration=='Long' ? 'selected' : ''}>7+ Days</option>
                        </select>
                    </div>

                    <div class="filter-group mb-4">
                        <label class="filter-label">DEPARTURE CITY</label>
                        <select class="luxe-select" name="departureCity" id="filterCity">
                            <option value="All">Any City</option>
                            <option value="Bangalore" ${currentParams.departureCity=='Bangalore' ? 'selected' : ''}>Bangalore</option>
                            <option value="Mumbai" ${currentParams.departureCity=='Mumbai' ? 'selected' : ''}>Mumbai</option>
                            <option value="Delhi" ${currentParams.departureCity=='Delhi' ? 'selected' : ''}>Delhi</option>
                        </select>
                    </div>

                    <div class="filter-group mb-4">
                        <label class="filter-label">TRAVEL MONTH</label>
                        <select class="luxe-select" name="month" id="filterMonth">
                            <option value="All">Any Month</option>
                            <option value="05" ${currentParams.month=='05' ? 'selected' : ''}>May 2026</option>
                            <option value="06" ${currentParams.month=='06' ? 'selected' : ''}>June 2026</option>
                            <option value="07" ${currentParams.month=='07' ? 'selected' : ''}>July 2026</option>
                        </select>
                    </div>

                    <div class="filter-group mb-5">
                        <label class="filter-label d-flex justify-content-between">
                            PRICE RANGE
                            <span id="priceVal" class="text-muted">₹0 - ₹${not empty currentParams.maxPrice ? currentParams.maxPrice : '100000'}+</span>
                        </label>
                        <input type="range" class="form-range" name="maxPrice" id="filterPrice" min="0" max="100000" step="1000" value="${not empty currentParams.maxPrice ? currentParams.maxPrice : '100000'}" oninput="updatePriceLabel(this.value)">
                        <div class="d-flex justify-content-between small mt-2 text-muted">
                            <span>₹0</span>
                            <span>₹100,000+</span>
                        </div>
                    </div>

                    <button type="submit" class="btn-apply-filters mb-3">Apply Filters</button>
                    <button type="button" class="btn-reset-filters" onclick="window.location.href='/user/dashboard'">Reset</button>
                </div>

                <c:choose>
                    <c:when test="${not empty groupedPackages}">
                        <c:forEach var="entry" items="${groupedPackages}">
                            <section class="category-section mb-5">
                                <div class="category-header">
                                    <h2 class="category-title">${entry.key}</h2>
                                    <span class="badge bg-danger-soft text-danger fw-bold">${entry.value.size()} Packages</span>
                                </div>
                                <div class="package-grid">
                                    <c:forEach var="trip" items="${entry.value}">
                                        <c:set var="videoUrl" value="" />
                                        <c:set var="hasVideo" value="false" />
                                        <c:forEach var="url" items="${trip.mediaUrls.split(',')}">
                                            <c:if test="${url.toLowerCase().endsWith('.mp4') || url.toLowerCase().endsWith('.webm')}">
                                                <c:set var="videoUrl" value="${url}" />
                                                <c:set var="hasVideo" value="true" />
                                            </c:if>
                                        </c:forEach>

                                        <div class="package-card ${trip.soldOut ? 'sold-out' : ''}" onmouseenter="playVideo(this)" onmouseleave="pauseVideo(this)">
                                            <div class="package-img-wrapper">
                                                <img src="${trip.imageUrl}" class="package-img">
                                                <c:if test="${hasVideo && !trip.soldOut}">
                                                    <video class="package-video" muted loop playsinline style="position: absolute; inset: 0; opacity: 0; transition: 0.3s;"><source src="${videoUrl}" type="video/mp4"></video>
                                                </c:if>
                                                <div class="expert-badge-container">
                                                    <c:choose>
                                                        <c:when test="${trip.soldOut}"><span class="expert-badge badge-sold-out">SOLD OUT</span></c:when>
                                                        <c:otherwise>
                                                            <span class="expert-badge badge-expert">EXPERT PICK</span>
                                                            <span class="expert-badge badge-trending">TRENDING</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="wishlist-btn-overlay" style="position: absolute; top: 12px; right: 12px; z-index: 10;">
                                                    <button type="button" onclick="toggleWishlist(${trip.id}, this)" class="btn btn-link p-0" style="font-size: 20px; text-shadow: 0 2px 10px rgba(0,0,0,0.5); border: none; outline: none; box-shadow: none;">
                                                        <i class="fa ${savedTripIds.contains(trip.id) ? 'fa-heart text-danger' : 'fa-heart-o text-white'}"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="package-info">
                                                <h3 class="package-name">${trip.title}</h3>
                                                <div class="package-meta"><i class="fa fa-map-marker"></i> ${trip.destination}</div>
                                                <div class="package-meta"><i class="fa fa-calendar"></i> ${trip.days}D / ${trip.nights}N</div>
                                                <div class="package-footer">
                                                    <div class="package-price">₹<fmt:formatNumber value="${trip.price}" pattern="#,##0" /> <span>/ person</span></div>
                                                    <a href="<c:url value='/user/package/${trip.id}'/>" class="btn-view ${trip.soldOut ? 'disabled' : ''}">
                                                        ${trip.soldOut ? 'SOLD OUT' : 'DETAILS'}
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5 mt-5">
                            <div class="mb-5">
                                <i class="fa fa-compass fa-5x text-muted opacity-25"></i>
                            </div>
                            <h2 class="fw-black" style="font-size: 32px; letter-spacing: -1px; color: var(--text-main);">NO ADVENTURES FOUND</h2>
                            <p class="text-muted mb-4">We couldn't find any trips matching your current search criteria.</p>
                            <a href="<c:url value='/user/dashboard'/>" class="btn-luxe-filter d-inline-flex" style="background: var(--primary) !important; color: white !important; border:none !important;">
                                EXPLORE ALL PACKAGES
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </form>
        </main>
    </div>

    <script>
        function searchTrips() {
            const query = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.package-card');
            let found = 0;

            cards.forEach(card => {
                const title = card.querySelector('.package-name').innerText.toLowerCase();
                const dest = card.querySelector('.package-meta').innerText.toLowerCase();

                if (title.includes(query) || dest.includes(query)) {
                    card.style.display = 'block';
                    found++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            // Note: Section headers might need to be hidden too if empty, but for client-side search this is basic.
        }

        function playVideo(card) {
            const video = card.querySelector('.package-video');
            if (video) {
                video.style.opacity = '1';
                video.play();
            }
        }

        function pauseVideo(card) {
            const video = card.querySelector('.package-video');
            if (video) {
                video.style.opacity = '0';
                video.pause();
                video.currentTime = 0;
            }
        }

        function toggleFilter() {
            const sidebar = document.getElementById('filterSidebar');
            const overlay = document.getElementById('filterOverlay');
            if(sidebar) sidebar.classList.toggle('show');
            if(overlay) overlay.classList.toggle('show');
        }

        function updatePriceLabel(val) {
            const label = document.getElementById('priceVal');
            if(label) {
                label.innerText = '₹0 - ₹' + parseInt(val).toLocaleString('en-IN') + (val >= 100000 ? '+' : '');
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
                        showToast('Trip saved to wishlist!');
                    } else {
                        icon.classList.remove('fa-heart', 'text-danger');
                        icon.classList.add('fa-heart-o', 'text-white');
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
                background: rgba(0, 0, 0, 0.85);
                backdrop-filter: blur(10px);
                color: white;
                padding: 15px 30px;
                border-radius: 12px;
                margin-top: 10px;
                font-weight: 700;
                border: 1px solid rgba(255,255,255,0.1);
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                transform: translateX(100px);
                opacity: 0;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
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