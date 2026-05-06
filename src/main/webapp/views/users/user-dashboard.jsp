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
            --sidebar-teal: #14b8a6;
            --sidebar-teal-dark: #0f766e;
            --accent-coral: #ef4444;
            --accent-coral-dark: #dc2626;
            --bg-main: #f8fafc;
            --bg-card: #ffffff;
            --border-light: #e5e7eb;
            --text-main: #1f2937;
            --text-secondary: #6b7280;
            --transition: all 0.3s ease;
        }

        body.theme-light-premium {
            font-family: 'Dosis', sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .main-content { flex: 1; margin-left: 240px; padding: 40px 40px 60px; }

        /* Dashboard Console (Clean Style) */
        .dashboard-console { 
            background: var(--bg-card); 
            border-radius: 24px; 
            border: 1px solid var(--border-light); 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            margin-bottom: 40px;
            overflow: hidden;
        }

        .console-top { 
            display: flex; justify-content: space-between; align-items: center; 
            padding: 30px 40px; 
            gap: 20px;
        }

        .console-divider { 
            height: 1px; 
            background: var(--border-light);
            width: 100%;
        }

        .console-bottom { 
            display: flex; justify-content: space-between; align-items: center; 
            padding: 20px 40px; 
            background: #f9fafb;
            gap: 30px;
        }

        .dash-title-luxe {
            font-size: 32px; font-weight: 800; color: var(--text-main);
            margin: 0;
        }
        .dash-subtitle-luxe {
            font-size: 14px; font-weight: 500; color: var(--text-secondary);
            margin-top: 5px;
        }

        /* Search Container */
        .search-container { position: relative; width: 400px; }
        .search-container input { 
            background: #f1f5f9 !important; 
            border: 1px solid var(--border-light); 
            border-radius: 12px; color: var(--text-main) !important; 
            padding: 14px 50px 14px 20px; width: 100%; 
            font-weight: 600; font-size: 15px;
            transition: var(--transition);
        }
        .search-container input:focus { border-color: var(--sidebar-teal); background: #fff !important; outline: none; box-shadow: 0 0 0 4px rgba(20, 184, 166, 0.1); }
        .search-container i { position: absolute; right: 20px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); font-size: 18px; }

        /* Buttons */
        .btn-luxe-filter { 
            background: var(--accent-coral) !important; 
            color: #fff !important; 
            border: none !important; 
            padding: 12px 24px; 
            border-radius: 12px; 
            font-weight: 700; 
            font-size: 14px; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            transition: all 0.3s ease; 
            cursor: pointer; 
            display: flex; 
            align-items: center; 
            gap: 8px;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
        }
        .btn-luxe-filter:hover { 
            background: var(--accent-coral-dark) !important; 
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.3);
        }

        /* Filter Nav */
        .filter-nav { display: flex; gap: 10px; margin-bottom: 30px; }
        .filter-item { 
            padding: 10px 20px; background: #fff; 
            border: 1px solid var(--border-light); border-radius: 10px; 
            color: var(--text-secondary); font-weight: 700; font-size: 13px; 
            text-transform: uppercase; letter-spacing: 1px; cursor: pointer; 
            transition: var(--transition);
        }
        .filter-item:hover { color: var(--sidebar-teal); border-color: var(--sidebar-teal); background: rgba(20, 184, 166, 0.05); }
        .filter-item.active { background: var(--sidebar-teal); color: #fff; border-color: var(--sidebar-teal); box-shadow: 0 4px 12px rgba(20, 184, 166, 0.2); }

        /* Package Cards */
        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; }
        .package-card { 
            background: var(--bg-card); 
            border-radius: 20px; overflow: hidden; 
            border: 1px solid var(--border-light); 
            transition: var(--transition); position: relative; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }
        .package-card:hover { transform: translateY(-8px); border-color: var(--sidebar-teal); box-shadow: 0 20px 40px rgba(0,0,0,0.08); }

        .package-img-wrapper { position: relative; width: 100%; aspect-ratio: 16 / 10; overflow: hidden; background: #eee; }
        .package-img { width: 100%; height: 100%; object-fit: cover; transition: 0.5s ease; }
        .package-card:hover .package-img { transform: scale(1.05); }

        .package-info { padding: 25px; }
        .package-name { font-size: 18px; font-weight: 800; color: var(--text-main); margin-bottom: 12px; line-height: 1.4; }
        .package-meta { font-size: 14px; color: var(--text-secondary); margin-bottom: 10px; display: flex; align-items: center; gap: 8px; }
        .package-meta i { color: var(--sidebar-teal); }

        .package-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--border-light); }
        .package-price { font-size: 20px; font-weight: 800; color: var(--text-main); }
        .package-price span { font-size: 13px; font-weight: 400; color: var(--text-secondary); }

        .btn-view { 
            display: inline-block;
            background: #f1f5f9; 
            color: var(--text-main); 
            border: 1px solid var(--border-light); 
            padding: 10px 20px; 
            border-radius: 10px; 
            font-size: 13px; 
            font-weight: 700; 
            text-decoration: none; 
            transition: 0.3s; 
            text-transform: uppercase;
        }
        .package-card:hover .btn-view { background: var(--accent-coral); color: #fff; border-color: var(--accent-coral); box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2); }

        /* Filter Sidebar */
        .filter-sidebar { position: fixed; top: 0; right: -400px; width: 380px; height: 100vh; background: #fff; z-index: 1050; transition: 0.4s ease; padding: 40px; overflow-y: auto; box-shadow: -10px 0 30px rgba(0,0,0,0.05); }
        .filter-sidebar.show { right: 0; }
        .filter-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.3); backdrop-filter: blur(4px); z-index: 1040; display: none; }
        .filter-overlay.show { display: block; }

        .luxe-select { background: #f8fafc; border: 1px solid var(--border-light); border-radius: 12px; color: var(--text-main); padding: 12px 15px; width: 100%; font-weight: 600; margin-bottom: 20px; }
        .btn-apply-filters { width: 100%; background: var(--accent-coral); color: #fff; border: none; padding: 15px; border-radius: 12px; font-weight: 800; text-transform: uppercase; margin-bottom: 10px; }
        .btn-reset-filters { width: 100%; background: #f1f5f9; color: var(--text-main); border: 1px solid var(--border-light); padding: 12px; border-radius: 12px; font-weight: 600; }
        }
        .dash-subtitle-luxe {
            font-size: 10px; font-weight: 800; color: rgba(255,255,255,0.6) !important;
            text-transform: uppercase; letter-spacing: 1.5px; margin-top: 5px;
            text-shadow: 0 2px 5px rgba(0,0,0,0.5);
        }
        
        .search-container { position: relative; flex: 1; }
        .search-container input { 
            background: rgba(255, 255, 255, 0.08) !important; 
            border: 1px solid rgba(255, 255, 255, 0.2) !important; 
            border-radius: 12px; color: #fff !important; padding: 12px 50px 12px 20px; width: 100%; 
            font-weight: 600; font-size: 14px;
            transition: var(--transition);
        }
        .search-container input::placeholder { color: rgba(255,255,255,0.7); }
        .search-container i { color: #fff !important; font-size: 22px; text-shadow: 0 0 15px rgba(230, 57, 70, 0.8); }

        .sort-select { 
            background: rgba(255, 255, 255, 0.05) !important; 
            border: 1px solid rgba(255, 255, 255, 0.15) !important; 
            color: #fff !important; padding: 10px 15px; border-radius: 12px; 
            font-weight: 700; cursor: pointer; font-size: 13px;
            appearance: auto; flex: 1; height: 42px;
        }
        .sort-select option { background: #002244 !important; color: #fff !important; }
        .results-count-luxe { font-size: 12px; font-weight: 900; letter-spacing: 1.5px; text-transform: uppercase; color: #fff !important; opacity: 0.8; }
        .meta-label-luxe { font-size: 11px; font-weight: 950; color: rgba(255,255,255,0.9) !important; text-transform: uppercase; letter-spacing: 2px; text-shadow: 0 2px 10px rgba(0,0,0,1); }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 90px 20px 40px; }
            .dash-header { flex-direction: column; align-items: flex-start; gap: 20px; padding: 30px; }
            .search-container { width: 100%; }
        }
    </style>
</head>

<body class="premium-theme">
    <div class="ocean-bg"></div>
    <div class="sun-rays">
        <div class="ray" style="left: 10%; animation-delay: 0s;"></div>
        <div class="ray" style="left: 35%; animation-delay: 2s;"></div>
        <div class="ray" style="left: 65%; animation-delay: 1s;"></div>
        <div class="ray" style="left: 85%; animation-delay: 3s;"></div>
    </div>


    <!-- Rough Edge Filter -->
    <svg width="0" height="0" style="position:absolute;z-index:-1;"><filter id="water-rough"><feTurbulence type="fractalNoise" baseFrequency="0.02" numOctaves="3" result="noise" /><feDisplacementMap in="SourceGraphic" in2="noise" scale="5" xChannelSelector="R" yChannelSelector="G" /></filter></svg>

    <header class="header">
        <div class="header-logo">
            <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a>
        </div>
        <div class="d-flex align-items-center gap-3">
            <span class="fw-bold">EXPLORER: ${user.name}</span>
            <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=e63946&color=fff" />
            <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 38px; height: 38px; border-radius: 12px; border: 2px solid var(--accent-red); box-shadow: 0 0 15px rgba(230, 57, 70, 0.3);">
        </div>
    </header>

<body class="theme-light-premium">
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp"><jsp:param name="activePage" value="dashboard" /></jsp:include>
        
        <main class="main-content">
            <form action="<c:url value='/user/dashboard'/>" method="GET" id="filterForm">
                <div class="dashboard-console">
                    <!-- Elegant Centered Subheading -->
                    <div class="px-5 pt-4 pb-3 text-center">
                        <p class="dash-subtitle-luxe m-0" style="font-size: 14px; letter-spacing: 4px; opacity: 0.9;">Curated Expeditions for the Modern Adventurer</p>
                    </div>

                    <!-- Row 1: Search Controls -->
                    <div class="console-top">
                        <div class="search-container">
                            <input type="text" name="search" id="searchInput" value="${currentParams.search}" placeholder="Search destinations..." oninput="searchTrips()">
                            <i class="fa fa-search"></i>
                        </div>
                        <button type="button" class="btn-luxe-filter" onclick="toggleFilter()" style="height: 42px;">
                            <i class="fa fa-sliders me-2"></i> REFINE
                        </button>
                    </div>

                    <div class="console-divider"></div>

                    <!-- Row 2: Stats & Filters -->
                    <div class="console-bottom">
                        <div class="results-count-luxe">
                            EXPLORING <span class="text-danger">${totalCount}</span> ADVENTURES
                        </div>
                        <div class="d-flex gap-4 align-items-center flex-nowrap flex-direction:row">
                            <div class="d-flex align-items-center gap-2">
                                <span class="meta-label-luxe" style="white-space: nowrap;  ">Group by:</span>
                                <select name="groupBy" class="sort-select" onchange="this.form.submit()" style="min-width: 140px;">
                                    <option value="none" ${currentParams.groupBy == 'none' ? 'selected' : ''}>No Grouping</option>
                                    <option value="category" ${currentParams.groupBy == 'category' ? 'selected' : ''}>Activity</option>
                                    <option value="adventure" ${currentParams.groupBy == 'adventure' ? 'selected' : ''}>Adventures</option>
                                    <option value="stay" ${currentParams.groupBy == 'stay' ? 'selected' : ''}>Stay Type</option>
                                    <option value="transport" ${currentParams.groupBy == 'transport' ? 'selected' : ''}>Transport</option>
                                    <option value="travelerType" ${currentParams.groupBy == 'travelerType' ? 'selected' : ''}>Audience</option>
                                </select>
                            </div>
						 <br>
                            <div class="d-flex align-items-center gap-2">
                                <span class="meta-label-luxe" style="white-space: nowrap;">Sort by:</span>
                                <select name="sortBy" class="sort-select" onchange="this.form.submit()" style="min-width: 140px;">
                                    <option value="latest" ${currentParams.sortBy == 'latest' ? 'selected' : ''}>Latest Arrivals</option>
                                    <option value="priceLow" ${currentParams.sortBy == 'priceLow' ? 'selected' : ''}>Value: Low to High</option>
                                    <option value="priceHigh" ${currentParams.sortBy == 'priceHigh' ? 'selected' : ''}>Luxe: High to Low</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Active Filters Context -->
                <c:if test="${not empty currentParams.search || currentParams.destination != 'All' || currentParams.category != 'All' || currentParams.duration != 'All' || currentParams.departureCity != 'All' || currentParams.month != 'All'}">
                    <div class="d-flex align-items-center gap-3 mb-4 ps-2">
                        <span class="meta-label-luxe opacity-50">Active Filters:</span>
                        <c:if test="${not empty currentParams.search}">
                            <span class="badge bg-danger text-white px-3 py-2 rounded-pill shadow-sm" style="font-size: 11px; font-weight: 800; letter-spacing: 1px;">
                                SEARCH: "${currentParams.search}" 
                                <a href="<c:url value='/user/dashboard?search='/>" class="text-white ms-2"><i class="fa fa-times-circle"></i></a>
                            </span>
                        </c:if>
                        <a href="<c:url value='/user/dashboard'/>" class="text-white-50 small fw-bold text-decoration-none border-bottom border-secondary ms-2 pb-1">Clear All</a>
                    </div>
                </c:if>

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
                                                    <button type="button" onclick="toggleWishlist(${trip.id}, this)" class="btn btn-link p-0" style="font-size: 20px; text-shadow: 0 2px 10px rgba(0,0,0,0.5); border: none; outline: none; box-shadow: none;">
                                                        <i class="fa ${savedTripIds.contains(trip.id) ? 'fa-heart text-danger' : 'fa-heart-o text-white'}"></i>
                                                    </button>
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
                        <div class="text-center py-5 mt-5">
                            <div class="mb-5">
                                <i class="fa fa-compass fa-5x text-white-50 opacity-25"></i>
                            </div>
                            <h2 class="fw-black text-white" style="font-size: 32px; letter-spacing: 2px;">NO ADVENTURES FOUND</h2>
                            <p class="text-white-50 mb-4">We couldn't find any trips matching your current search criteria.</p>
                            <a href="<c:url value='/user/dashboard'/>" class="btn-luxe-filter d-inline-flex">
                                EXPLORE ALL PACKAGES
                            </a>
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

        function toggleWishlist(tripId, btn) {
            const icon = btn.querySelector('i');
            
            // Visual feedback before request
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
            // Check if toast container exists
            let container = document.getElementById('toast-container');
            if (!container) {
                container = document.createElement('div');
                container.id = 'toast-container';
                container.style.cssText = 'position: fixed; bottom: 30px; right: 30px; z-index: 9999;';
                document.body.appendChild(container);
            }

            const toast = document.createElement('div');
            toast.className = 'glass-toast';
            toast.innerHTML = message;
            toast.style.cssText = `
                background: rgba(0, 0, 0, 0.8);
                backdrop-filter: blur(10px);
                color: white;
                padding: 15px 30px;
                border-radius: 12px;
                margin-top: 10px;
                font-weight: 700;
                border: 1px solid rgba(255,255,255,0.1);
                box-shadow: 0 10px 30px rgba(0,0,0,0.5);
                transform: translateX(100px);
                opacity: 0;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            `;
            container.appendChild(toast);

            // Animate in
            setTimeout(() => {
                toast.style.transform = 'translateX(0)';
                toast.style.opacity = '1';
            }, 100);

            // Animate out
            setTimeout(() => {
                toast.style.transform = 'translateX(100px)';
                toast.style.opacity = '0';
                setTimeout(() => toast.remove(), 400);
            }, 3000);
        }
    </script>
</body>
</html>
