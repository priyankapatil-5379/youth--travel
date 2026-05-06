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

            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-light);
            margin: 0; padding: 0;
            overflow-x: hidden;
        }

        /* Immersive Background System */
        .ocean-bg { position: fixed; inset: 0; background: radial-gradient(circle at 50% 0%, #001f3f, #000a12); z-index: -2; }
        .sun-rays { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; pointer-events: none; opacity: 0.3; }
        .ray { position: absolute; top: -20%; width: 100px; height: 150%; background: linear-gradient(180deg, rgba(255,255,255,0.1) 0%, transparent 80%); filter: blur(50px); transform-origin: top center; animation: ray-swing 10s ease-in-out infinite alternate; }
        @keyframes ray-swing { 0% { transform: rotate(-8deg) scaleX(1); opacity: 0.3; } 100% { transform: rotate(8deg) scaleX(0.8); opacity: 0.6; } }

        .wrapper { display: flex; min-height: 100vh; position: relative; z-index: 1; }

        /* Floating Super-Glass Header */
        .header { 
            position: fixed; top: 0; left: 0; right: 0; height: 75px; 
            background: rgba(0, 0, 0, 0.4); 
            backdrop-filter: blur(15px); 
            -webkit-backdrop-filter: blur(15px);
            display: flex; align-items: center; justify-content: space-between; 
            padding: 0 40px; z-index: 1000; 
            border-bottom: 1px solid rgba(255, 255, 255, 0.08); 
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
        }

        .main-content { flex: 1; margin-left: 240px; padding: 130px 40px 60px; }

        /* Dashboard Hero Section (High Contrast Fix) */
        .dash-header { 
            display: flex; justify-content: space-between; align-items: center; 
            margin-bottom: 60px; 
            padding: 60px 50px; 
            background: linear-gradient(180deg, rgba(0,0,0,0.6) 0%, transparent 100%);
            border-radius: 32px; 
            border: 1px solid rgba(255,255,255,0.15);
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        }

        .dash-title-luxe {
            font-size: 68px; font-weight: 950; letter-spacing: -3px; line-height: 0.8;
            color: #fff;
            text-shadow: 0 10px 40px rgba(0,0,0,0.9), 0 0 20px rgba(255,255,255,0.2);
            text-transform: uppercase;
        }
        .dash-subtitle-luxe {
            font-size: 13px; font-weight: 900; color: rgba(255,255,255,1);
            text-transform: uppercase; letter-spacing: 2.5px;
            margin-top: 15px;
            text-shadow: 0 4px 15px rgba(0,0,0,0.9);
        }

        /* Search & Filter Luxe (High Visibility) */
        .search-container { position: relative; width: 440px; }
        .search-container input { 
            background: rgba(0, 0, 0, 0.7) !important; 
            backdrop-filter: blur(15px);
            border: 2px solid rgba(255, 255, 255, 0.3); 
            border-radius: 100px; color: #fff !important; 
            padding: 22px 60px 22px 30px; width: 100%; 
            font-weight: 700; font-size: 16px;
            transition: var(--transition);
        }
        .search-container input::placeholder { color: rgba(255,255,255,0.6); }
        .search-container i { position: absolute; right: 25px; top: 50%; transform: translateY(-50%); color: #fff; font-size: 22px; text-shadow: 0 0 15px var(--accent-red); }

        .btn-luxe-filter { 
            background: linear-gradient(135deg, #e63946 0%, #b91c1c 100%) !important; 
            color: #fff !important; 
            border: 1px solid rgba(255, 255, 255, 0.3) !important; 
            padding: 16px 40px; 
            border-radius: 100px; 
            font-weight: 900; 
            font-size: 14px; 
            text-transform: uppercase; 
            letter-spacing: 3px; 
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
            cursor: pointer; 
            display: flex; 
            align-items: center; 
            box-shadow: 0 10px 30px rgba(230, 57, 70, 0.5), inset 0 0 10px rgba(255,255,255,0.2);
            backdrop-filter: blur(5px);
			gap:5px;
			margin-left: 250px;
			margin-top: 30px;
        }
        .btn-luxe-filter:hover { 
            transform: translateY(-5px) scale(1.05); 
            box-shadow: 0 20px 50px rgba(230, 57, 70, 0.8); 
            border-color: #fff !important;
            letter-spacing: 4px;
        }
        .btn-luxe-filter i { font-size: 16px; text-shadow: 0 0 10px rgba(255,255,255,0.5); }

        /* Modern Filter Nav */
        .filter-nav { display: flex; gap: 15px; margin-bottom: 40px; overflow-x: auto; padding-bottom: 10px; scrollbar-width: none; }
        .filter-item { 
            padding: 12px 30px; background: rgba(255,255,255,0.03); 
            border: 1px solid var(--glass-border); border-radius: 100px; 
            color: var(--text-dim); font-weight: 800; font-size: 12px; 
            text-transform: uppercase; letter-spacing: 2px; cursor: pointer; 
            transition: var(--transition); white-space: nowrap;
        }
        .filter-item:hover { color: #fff; background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.2); }
        .filter-item.active { background: var(--accent-red); color: #fff; border-color: var(--accent-red); box-shadow: 0 10px 20px rgba(230, 57, 70, 0.3); }

        /* Grid & Cards (Elite Style) */
        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 35px; }
        .package-card { 
            background: rgba(255, 255, 255, 0.02); 
            backdrop-filter: blur(25px); 
            border-radius: 30px; overflow: hidden; 
            border: 1px solid var(--glass-border); 
            transition: var(--transition); position: relative; 
        }
        .package-card:hover { transform: translateY(-12px) scale(1.02); border-color: rgba(230, 57, 70, 0.4); box-shadow: 0 30px 60px rgba(0,0,0,0.5); }

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

        .btn-luxe-filter { background: rgba(255,255,255,0.05); border: 1px solid var(--accent-red); color: #fff; padding: 12px 25px; border-radius: 100px; font-weight: 800; font-size: 14px; transition: 0.3s; cursor: pointer; display: flex; align-items: center; }
        .btn-luxe-filter:hover { background: var(--accent-red); box-shadow: 0 0 20px rgba(230, 57, 70, 0.4); transform: translateY(-2px); }

        /* Unified Dashboard Console (High Visibility Ignite) */
        .dashboard-console { 
            background: rgba(0, 0, 0, 0.5); 
            backdrop-filter: blur(50px);
            border-radius: 35px; 
            border: 2px solid rgba(255, 255, 255, 0.3); 
            box-shadow: 0 40px 120px rgba(0,0,0,0.8), inset 0 0 20px rgba(255,255,255,0.05);
            margin-bottom: 50px;
            overflow: hidden;
            position: relative;
        }

        .console-top { 
            display: flex; justify-content: space-between; align-items: center; 
            padding: 60px 60px 45px; 
        }

        .console-divider { 
            height: 2px; 
            background: linear-gradient(90deg, transparent 0%, rgba(255,255,255,0.4) 50%, transparent 100%);
            width: 100%;
        }

        .console-bottom { 
            display: flex; justify-content: space-between; align-items: center; 
            padding: 30px 60px; 
            background: rgba(255,255,255,0.04);
        }

        .dash-title-luxe {
            font-size: 72px; font-weight: 950; letter-spacing: -4px; line-height: 0.8;
            color: #fff !important; 
            text-shadow: 0 0 30px rgba(255,255,255,0.4), 0 10px 40px rgba(0,0,0,0.9); 
            text-transform: uppercase;
        }
        .dash-subtitle-luxe {
            font-size: 14px; font-weight: 900; color: #fff !important;
            text-transform: uppercase; letter-spacing: 3px; margin-top: 18px;
            text-shadow: 0 4px 15px rgba(0,0,0,1);
        }
        
        .search-container { position: relative; width: 460px; }
        .search-container input { 
            background: rgba(255, 255, 255, 0.1) !important; 
            border: 2px solid rgba(255, 255, 255, 0.4) !important; 
            border-radius: 100px; color: #fff !important; padding: 22px 60px 22px 35px; width: 100%; 
            font-weight: 800; font-size: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
        }
        .search-container input::placeholder { color: rgba(255,255,255,0.7); }
        .search-container i { color: #fff !important; font-size: 22px; text-shadow: 0 0 15px rgba(230, 57, 70, 0.8); }

        .sort-select { 
            background: #0f172a !important; border: 2px solid rgba(255,255,255,0.3) !important; 
            color: #fff !important; padding: 14px 25px; border-radius: 14px; 
            font-weight: 950; cursor: pointer; min-width: 200px; font-size: 14px;
            appearance: auto;
        }
        .sort-select option { background: #0f172a !important; color: #fff !important; }
        .results-count-luxe { font-size: 18px; font-weight: 950; letter-spacing: 3px; text-transform: uppercase; color: #fff !important; text-shadow: 0 4px 20px rgba(0,0,0,0.8); }
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

    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp"><jsp:param name="activePage" value="dashboard" /></jsp:include>
        
        <main class="main-content">
            <form action="<c:url value='/user/dashboard'/>" method="GET" id="filterForm">
                <div class="dashboard-console">
                    <!-- Top Deck -->
                    <div class="console-top">
                        <div>
                            <h1 class="dash-title-luxe m-0">DASHBOARD</h1>
                            <p class="dash-subtitle-luxe m-0">Curated Expeditions for the Modern Adventurer</p>
                        </div>
                        <div class="d-flex gap-4 align-items-center">
                            <div class="search-container">
                                <input type="text" name="search" id="searchInput" value="${currentParams.search}" placeholder="Search destinations..." oninput="searchTrips()">
                                <i class="fa fa-search"></i>
                            </div>
                            <button type="button" class="btn-luxe-filter" onclick="toggleFilter()">
                                <i class="fa fa-sliders me-2"></i> REFINE
                            </button>
                        </div>
                    </div>

                    <!-- Diamond Divider -->
                    <div class="console-divider"></div>

                    <!-- Bottom Deck -->
                    <div class="console-bottom">
                        <div class="results-count-luxe">EXPLORING <span class="text-danger">${totalCount}</span> ADVENTURES</div>
                        <div class="d-flex gap-5 align-items-center">
                            <div class="d-flex align-items-center gap-3">
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
                            <div class="d-flex align-items-center gap-3">
                                <span class="meta-label-luxe">Sort by:</span>
                                <select name="sortBy" class="sort-select" onchange="this.form.submit()">
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
    </script>
</body>
</html>
