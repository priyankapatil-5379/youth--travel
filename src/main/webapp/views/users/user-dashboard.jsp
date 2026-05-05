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
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #e63946;
            --text-muted: #7e8c9a;
            --transition: all 0.3s ease;
            --dark-card: rgba(0, 34, 68, 0.6);
            --accent-red: #e63946;
        }

        body {
            font-family: 'Dosis', sans-serif;
            background-color: #002244;
            color: rgba(255, 255, 255, 0.92);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('<c:url value="/views/assets/images/underwater-theme-bg.png"/>') top center/cover no-repeat;
            z-index: -2;
        }

        /* Sunlight Rays Sync */
        .sun-rays-container {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            z-index: -1;
            pointer-events: none;
            overflow: hidden;
        }

        .ray {
            position: absolute;
            top: -10%;
            width: 80px;
            height: 150%;
            background: linear-gradient(180deg, rgba(255, 230, 120, 0.15) 0%, rgba(255, 220, 80, 0.08) 40%, rgba(255, 255, 255, 0) 100%);
            filter: blur(20px);
            transform-origin: top center;
            border-radius: 50%;
            animation: ray-swing 6s ease-in-out infinite alternate;
        }

        .ray-1 { left: 5%; width: 60px; animation-duration: 7s; animation-delay: 0s; opacity: 0.6; }
        .ray-2 { left: 18%; width: 100px; animation-duration: 9s; animation-delay: 1s; opacity: 0.4; }
        .ray-3 { left: 33%; width: 70px; animation-duration: 6s; animation-delay: 2s; opacity: 0.7; }
        .ray-4 { left: 52%; width: 90px; animation-duration: 8s; animation-delay: 0.5s; opacity: 0.5; }
        .ray-5 { left: 68%; width: 65px; animation-duration: 7.5s; animation-delay: 1.5s; opacity: 0.65; }
        .ray-6 { left: 82%; width: 110px; animation-duration: 10s; animation-delay: 3s; opacity: 0.4; }

        @keyframes ray-swing {
            0% { transform: rotate(-6deg) scaleX(0.9); opacity: 0.1; }
            50% { opacity: 0.8; }
            100% { transform: rotate(8deg) scaleX(0.85); opacity: 0.15; }
        }

        .wrapper { display: flex; min-height: 100vh; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: #161c28; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255, 255, 255, 0.05); }

        .main-content { flex: 1; margin-left: 240px; padding: 100px 30px 40px; transition: margin-left 0.3s; }

        /* Dashboard Components */
        .dash-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(15px); padding: 40px 50px; border-radius: 24px; border: 1px solid rgba(255, 255, 255, 0.1); }

        .search-container { position: relative; width: 350px; }
        .search-container input { background: rgba(0, 0, 0, 0.4); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 12px; color: #fff; padding: 12px 40px 12px 20px; width: 100%; transition: var(--transition); }
        .search-container i { position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: var(--text-muted); }

        /* Grid & Cards */
        .category-section { margin-bottom: 50px; }
        .category-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 25px; border-left: 4px solid var(--primary-blue); padding-left: 15px; }
        .category-title { font-size: 24px; font-weight: 800; margin: 0; text-transform: uppercase; letter-spacing: 1px; }
        
        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .package-card { background: var(--dark-card); backdrop-filter: blur(20px); border-radius: 20px; overflow: hidden; border: 1px solid rgba(255,255,255,0.08); transition: var(--transition); position: relative; display: flex; flex-direction: column; }
        .package-card:hover { transform: translateY(-8px); border-color: rgba(230, 57, 70, 0.5); box-shadow: 0 15px 40px rgba(230, 57, 70, 0.2); }

        .package-img-wrapper { position: relative; width: 100%; aspect-ratio: 16 / 10; overflow: hidden; background: #000; }
        .package-img, .package-video { width: 100%; height: 100%; object-fit: cover; transition: 0.5s ease; position: absolute; top: 0; left: 0; }
        .package-video { opacity: 0; }
        .package-card:hover .package-img { transform: scale(1.1); }
        .package-card:hover .package-video { opacity: 1; transform: scale(1.1); }

        .expert-badge-container { position: absolute; top: 15px; left: 15px; z-index: 5; display: flex; gap: 8px; }
        .expert-badge { padding: 4px 12px; border-radius: 6px; font-size: 10px; font-weight: 800; text-transform: uppercase; box-shadow: 0 4px 12px rgba(0,0,0,0.3); }
        .badge-sold-out { background: #e11d48; color: #fff; }
        .badge-expert { background: #6366f1; color: #fff; }

        .quick-view-overlay { position: absolute; inset: 0; background: rgba(230, 57, 70, 0.4); backdrop-filter: blur(4px); display: flex; align-items: center; justify-content: center; opacity: 0; transition: 0.3s ease; z-index: 4; }
        .package-card:hover .quick-view-overlay { opacity: 1; }
        .btn-quick-view { background: #fff; color: #000; padding: 10px 20px; border-radius: 10px; font-weight: 800; font-size: 12px; transform: translateY(20px); transition: 0.4s; text-decoration: none; }
        .package-card:hover .btn-quick-view { transform: translateY(0); }

        .package-info { padding: 25px 20px; flex: 1; display: flex; flex-direction: column; }
        .package-name { font-size: 20px; font-weight: 800; color: #fff; margin-bottom: 12px; height: 50px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .package-meta { font-size: 14px; color: rgba(255,255,255,0.7); margin-bottom: 8px; }
        .package-meta i { color: var(--primary-blue); margin-right: 8px; }

        .package-footer { display: flex; align-items: center; justify-content: space-between; margin-top: auto; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.08); }
        .package-price { font-size: 22px; font-weight: 900; color: #fff; }
        .package-price span { font-size: 12px; font-weight: 400; opacity: 0.6; }

        .btn-view { background: rgba(255,255,255,0.05); color: #fff; border: 1px solid rgba(255,255,255,0.2); padding: 8px 18px; border-radius: 10px; font-size: 12px; font-weight: 800; text-decoration: none; transition: 0.3s; }
        .package-card:hover .btn-view { background: var(--primary-blue); border-color: var(--primary-blue); box-shadow: 0 5px 15px rgba(230, 57, 70, 0.3); }
        .btn-view.disabled { opacity: 0.5; pointer-events: none; }

        /* Filter Sidebar (Luxe Style) */
        .filter-sidebar { position: fixed; top: 0; right: -400px; width: 380px; height: 100vh; background: rgba(22, 28, 40, 0.95); backdrop-filter: blur(40px); z-index: 1050; transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1); padding: 40px; overflow-y: auto; border-left: 1px solid rgba(255,255,255,0.1); }
        .filter-sidebar.show { right: 0; }
        .filter-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.7); backdrop-filter: blur(5px); z-index: 1040; display: none; }
        .filter-overlay.show { display: block; }

        .filter-label { font-size: 11px; font-weight: 800; color: rgba(255,255,255,0.5); letter-spacing: 2px; margin-bottom: 12px; display: block; }
        .luxe-select { background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; color: #fff; padding: 14px 20px; width: 100%; font-weight: 600; cursor: pointer; transition: 0.3s; appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='white' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 20px center; }
        .luxe-select:hover { background-color: rgba(255,255,255,0.06); border-color: rgba(230, 57, 70, 0.5); }
        .luxe-select option { background: #161c28; color: #fff; padding: 10px; }

        .luxe-range { width: 100%; height: 6px; background: rgba(255,255,255,0.1); border-radius: 10px; appearance: none; outline: none; }
        .luxe-range::-webkit-slider-thumb { appearance: none; width: 22px; height: 22px; background: var(--accent-red); border: 4px solid #fff; border-radius: 50%; cursor: pointer; box-shadow: 0 0 15px rgba(230, 57, 70, 0.5); }

        .btn-apply-filters { width: 100%; background: var(--accent-red); color: #fff; border: none; padding: 18px; border-radius: 14px; font-weight: 900; font-size: 15px; text-transform: uppercase; letter-spacing: 2px; transition: 0.3s; }
        .btn-apply-filters:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(230, 57, 70, 0.4); }
        .btn-reset-filters { width: 100%; background: rgba(255,255,255,0.05); color: #fff; border: 1px solid rgba(255,255,255,0.1); padding: 15px; border-radius: 14px; font-weight: 700; font-size: 14px; transition: 0.3s; }
        .btn-reset-filters:hover { background: rgba(255,255,255,0.1); }

        /* Results Meta */
        .results-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .sort-select { background: rgba(0,0,0,0.3); border: 1px solid rgba(255,255,255,0.1); color: #fff; padding: 8px 15px; border-radius: 10px; font-weight: 700; cursor: pointer; }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 90px 20px 40px; }
            .dash-header { flex-direction: column; align-items: flex-start; gap: 20px; padding: 30px; }
            .search-container { width: 100%; }
        }
    </style>
</head>

<body class="premium-theme">
    <!-- Sunlight Rays Sync -->
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
        <div class="ray ray-5"></div>
        <div class="ray ray-6"></div>
    </div>

    <!-- Rough Edge Filter -->
    <svg width="0" height="0" style="position:absolute;z-index:-1;">
        <filter id="rough-edge">
            <feTurbulence type="fractalNoise" baseFrequency="0.05" numOctaves="3" result="noise" />
            <feDisplacementMap in="SourceGraphic" in2="noise" scale="8" xChannelSelector="R" yChannelSelector="G" />
        </filter>
    </svg>
    <header class="header">
        <div class="header-logo">
            <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a>
        </div>
        <div class="d-flex align-items-center gap-3">
            <span class="fw-bold">Hi, ${user.name}</span>
            <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=e63946&color=fff" />
            <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid rgba(255,255,255,0.2);">
        </div>
    </header>

    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp"><jsp:param name="activePage" value="dashboard" /></jsp:include>
        
        <main class="main-content">
            <form action="<c:url value='/user/dashboard'/>" method="GET" id="filterForm">
                <div class="dash-header">
                    <div>
                        <h1 class="fw-bold m-0" style="font-size: 38px;">Dashboard</h1>
                        <p class="text-white-50 m-0">Discover amazing travel packages and plan your next adventure.</p>
                    </div>
                    <div class="d-flex gap-3 align-items-center">
                        <div class="search-container">
                            <input type="text" name="search" value="${currentParams.search}" placeholder="Search trips..." oninput="handleSearch(this.value)">
                            <i class="fa fa-search"></i>
                        </div>
                        <button type="button" class="btn btn-outline-light rounded-pill px-4" onclick="toggleFilter()">
                            <i class="fa fa-sliders me-2"></i> Filters
                        </button>
                    </div>
                </div>

                <!-- Filter Sidebar (Photo Sync) -->
                <div class="filter-overlay" id="filterOverlay" onclick="toggleFilter()"></div>
                <div class="filter-sidebar" id="filterSidebar">
                    <div class="d-flex justify-content-between align-items-center mb-5">
                        <h2 class="fw-black m-0" style="font-size: 24px; letter-spacing: -1px;">Filters</h2>
                        <button type="button" class="btn-close btn-close-white" onclick="toggleFilter()"></button>
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
                            <span id="priceVal" class="text-white-50">₹0 - ₹${not empty currentParams.maxPrice ? currentParams.maxPrice : '100000'}+</span>
                        </label>
                        <input type="range" class="luxe-range" name="maxPrice" id="filterPrice" min="0" max="100000" step="1000" value="${not empty currentParams.maxPrice ? currentParams.maxPrice : '100000'}" oninput="updatePriceLabel(this.value)">
                        <div class="d-flex justify-content-between small mt-2 text-white-50">
                            <span>₹0</span>
                            <span>₹100000.0+</span>
                        </div>
                    </div>

                    <button type="submit" class="btn-apply-filters mb-3">Apply Filters</button>
                    <button type="button" class="btn-reset-filters" onclick="window.location.href='/user/dashboard'">Reset</button>
                </div>

                <div class="results-meta">
                    <div class="fw-bold">EXPLORING <span class="text-danger">${totalCount}</span> ADVENTURES</div>
                    <div class="d-flex gap-3 align-items-center">
                        <div class="small fw-bold text-white-50">Group by:</div>
                        <select name="groupBy" class="sort-select" onchange="this.form.submit()">
                            <option value="travelerType" ${currentParams.groupBy == 'travelerType' ? 'selected' : ''}>Traveler Type</option>
                            <option value="activity" ${currentParams.groupBy == 'activity' ? 'selected' : ''}>Activity</option>
                        </select>
                        <div class="small fw-bold text-white-50">Sort by:</div>
                        <select name="sortBy" class="sort-select" onchange="this.form.submit()">
                            <option value="latest" ${currentParams.sortBy == 'latest' ? 'selected' : ''}>Latest</option>
                            <option value="priceLow" ${currentParams.sortBy == 'priceLow' ? 'selected' : ''}>Price: Low to High</option>
                        </select>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty groupedPackages}">
                        <c:forEach var="entry" items="${groupedPackages}">
                            <section class="category-section">
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
                                                    <video class="package-video" muted loop playsinline><source src="${videoUrl}" type="video/mp4"></video>
                                                </c:if>
                                                <div class="expert-badge-container">
                                                    <c:choose>
                                                        <c:when test="${trip.soldOut}"><span class="expert-badge badge-sold-out">SOLD OUT</span></c:when>
                                                        <c:otherwise>
                                                            <span class="expert-badge badge-expert">EXPERT PICK</span>
                                                            <span class="expert-badge badge-trending" style="background: #f59e0b; color: #000; margin-left: 5px;">TRENDING</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="wishlist-btn-overlay" style="position: absolute; top: 15px; right: 15px; z-index: 10;">
                                                    <button class="btn btn-link text-white p-0" style="font-size: 20px; text-shadow: 0 2px 10px rgba(0,0,0,0.5);"><i class="fa fa-heart-o"></i></button>
                                                </div>
                                                <div class="quick-view-overlay">
                                                    <a href="<c:url value='/user/package/${trip.id}'/>" class="btn-quick-view">QUICK VIEW</a>
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
                        <div class="text-center py-5 opacity-50">
                            <i class="fa fa-search fa-4x mb-3"></i>
                            <h3>No Adventures Found</h3>
                        </div>
                    </c:otherwise>
                </c:choose>
            </form>
        </main>
    </div>

    <script>
        function filterBy(category) {
            document.querySelectorAll('.filter-item').forEach(el => el.classList.remove('active'));
            if(event) event.target.classList.add('active');

            const cards = document.querySelectorAll('.col-package');
            let found = 0;

            cards.forEach(card => {
                const tripCategory = card.getAttribute('data-category');
                if (category === 'All' || tripCategory === category) {
                    card.style.display = 'block';
                    card.style.opacity = '1';
                    found++;
                } else {
                    card.style.display = 'none';
                }
            });

            const noResult = document.getElementById('noResultsMessage');
            if (noResult) noResult.style.display = (found === 0) ? 'block' : 'none';
        }

        function searchTrips() {
            const query = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.col-package');
            let found = 0;

            cards.forEach(card => {
                const title = card.querySelector('.package-title').innerText.toLowerCase();
                const dest = card.querySelector('.package-meta').innerText.toLowerCase();

                if (title.includes(query) || dest.includes(query)) {
                    card.style.display = 'block';
                    found++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            const noResult = document.getElementById('noResultsMessage');
            if (noResult) noResult.style.display = (found === 0) ? 'block' : 'none';
        }

        function playVideo(card) {
            const video = card.querySelector('.package-video');
            if (video) video.play();
        }

        function pauseVideo(card) {
            const video = card.querySelector('.package-video');
            if (video) {
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
    </script>
</body>
</html>
