<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                    --dark-card: rgba(22, 28, 40, 0.7);
                }

                body {
                    font-family: 'Dosis', sans-serif;
                    background-color: #0b0f18;
                    color: rgba(255, 255, 255, 0.92);
                    margin: 0;
                    padding: 0;
                }

                .wrapper {
                    display: flex;
                    min-height: 100vh;
                }

                .header {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    height: 70px;
                    background: #161c28;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 0 30px;
                    z-index: 1000;
                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                }


        /* Existing Package Styles */
        .category-section { margin-bottom: 50px; }
        .category-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 25px; border-left: 4px solid var(--primary-blue); padding-left: 15px; }
        .category-title { font-size: 24px; font-weight: 800; margin: 0; text-transform: uppercase; letter-spacing: 1px; }
        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .package-card { background: var(--dark-card); border-radius: 15px; overflow: hidden; border: 1px solid rgba(255,255,255,0.05); transition: var(--transition); position: relative; }
        .package-card:hover { transform: translateY(-10px); border-color: var(--primary-blue); box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .package-img-wrapper { position: relative; width: 100%; aspect-ratio: 16 / 10; overflow: hidden; background: transparent; }
        .package-img, .package-video { width: 100%; height: 100%; object-fit: cover; object-position: center; transition: opacity 0.4s ease, transform 0.4s ease; position: absolute; top: 0; left: 0; }
        .package-video { opacity: 0; pointer-events: none; }
        .package-card:hover .package-img { opacity: 1 !important; transform: scale(1.1) translateY(-10px) !important; }
        .package-card:hover .package-video { opacity: 1 !important; transform: scale(1.1) !important; }
        
        .play-overlay { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); color: #fff; font-size: 40px; opacity: 0.6; z-index: 2; pointer-events: none; display: none; }
        .has-video .play-overlay { display: block; }
        .package-card:hover .play-overlay { opacity: 0; }
        .package-tag { position: absolute; top: 15px; right: 15px; background: var(--primary-blue); color: #fff; padding: 4px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .package-content { padding: 20px; }
        .package-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: #fff; height: 44px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .package-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 15px; padding-top: 15px; border-top: 1px solid rgba(255,255,255,0.05); }
        .package-price { font-size: 20px; font-weight: 800; color: #fff; }
        .btn-view { background: rgba(255,255,255,0.05); color: #fff; border: 1px solid rgba(255,255,255,0.1); padding: 8px 15px; border-radius: 8px; font-size: 13px; font-weight: 600; transition: var(--transition); }
        .package-card:hover .btn-view { background: var(--primary-blue); border-color: var(--primary-blue); }
        .empty-state { text-align: center; padding: 80px 20px; background: var(--dark-card); border-radius: 20px; border: 1px dotted rgba(255,255,255,0.1); }

        /* Sold Out Styles */
        .package-card.sold-out { opacity: 0.6; filter: grayscale(0.8); cursor: not-allowed; }
        .package-card.sold-out:hover { transform: none; box-shadow: none; border-color: rgba(255,255,255,0.05); }
        .sold-out-badge { position: absolute; top: 15px; left: 15px; background: #e11d48; color: #fff; padding: 5px 12px; border-radius: 6px; font-size: 11px; font-weight: 800; text-transform: uppercase; z-index: 10; box-shadow: 0 4px 10px rgba(225, 29, 72, 0.3); }
        .sold-out .btn-view { display: none; }


                .main-content {
                    flex: 1;
                    margin-left: 240px;
                    padding: 100px 30px 40px;
                }

                /* Search & Filters */
                .offcanvas-filter {
                    position: fixed;
                    top: 0;
                    right: -350px;
                    width: 320px;
                    height: 100vh;
                    background: var(--dark-card);
                    box-shadow: -5px 0 25px rgba(0,0,0,0.8);
                    z-index: 1050;
                    transition: right 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    padding: 0;
                    overflow-y: auto;
                    border-left: 1px solid rgba(255,255,255,0.05);
                }
                .offcanvas-filter.show {
                    right: 0;
                }
                .offcanvas-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100vw;
                    height: 100vh;
                    background: rgba(0,0,0,0.6);
                    backdrop-filter: blur(4px);
                    z-index: 1040;
                    display: none;
                    opacity: 0;
                    transition: opacity 0.3s ease;
                }
                .offcanvas-overlay.show {
                    display: block;
                    opacity: 1;
                }
                .btn-filter-toggle {
                    background: rgba(255,255,255,0.05);
                    border: 1px solid rgba(255,255,255,0.1);
                    color: #fff;
                    padding: 12px 20px;
                    border-radius: 12px;
                    font-weight: 700;
                    cursor: pointer;
                    transition: var(--transition);
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }
                .btn-filter-toggle:hover {
                    background: rgba(255,255,255,0.1);
                    border-color: var(--primary-blue);
                }

                .dash-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 40px;
                    background: rgba(0, 0, 0, 0.3);
                    backdrop-filter: blur(10px);
                    padding: 30px;
                    border-radius: 20px;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
                }

                .search-container {
                    position: relative;
                    width: 350px;
                }

                .search-container input {
                    background: rgba(0, 0, 0, 0.4);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 12px;
                    color: #fff;
                    padding: 12px 40px 12px 20px;
                    width: 100%;
                    transition: var(--transition);
                    text-shadow: 0 1px 2px rgba(0,0,0,0.5);
                }

                .search-container input:focus {
                    border-color: var(--primary-blue);
                    background: rgba(255, 255, 255, 0.08);
                    outline: none;
                    box-shadow: 0 0 15px rgba(230, 57, 70, 0.2);
                }

                .search-container i {
                    position: absolute;
                    right: 15px;
                    top: 50%;
                    transform: translateY(-50%);
                    color: var(--text-muted);
                }

                .filter-card {
                    background: rgba(255, 255, 255, 0.03);
                    backdrop-filter: blur(15px);
                    -webkit-backdrop-filter: blur(15px);
                    border-radius: 20px;
                    padding: 25px;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    margin-bottom: 35px;
                    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
                }

                .filter-label {
                    display: block;
                    font-size: 13px;
                    font-weight: 700;
                    color: var(--text-muted);
                    margin-bottom: 10px;
                    text-transform: uppercase;
                }

                .form-select-custom {
                    background: rgba(0, 0, 0, 0.4);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 10px;
                    color: #fff !important;
                    padding: 8px 15px;
                    width: auto;
                    cursor: pointer;
                    font-weight: 600;
                    text-shadow: 0 1px 2px rgba(0,0,0,0.5);
                }

                .form-select-custom option {
                    background: #ffffff !important;
                    color: #000000 !important;
                }

                .form-select-custom:focus {
                    outline: none;
                    border-color: var(--primary-blue);
                }

                .price-range-container {
                    position: relative;
                    padding: 0 10px;
                }

                .price-slider {
                    -webkit-appearance: none;
                    width: 100%;
                    height: 6px;
                    background: rgba(255, 255, 255, 0.1);
                    border-radius: 5px;
                    outline: none;
                    margin: 15px 0;
                }

                .price-slider::-webkit-slider-thumb {
                    -webkit-appearance: none;
                    appearance: none;
                    width: 18px;
                    height: 18px;
                    background: var(--primary-blue);
                    border-radius: 50%;
                    cursor: pointer;
                    border: 3px solid #fff;
                }

                .price-values {
                    display: flex;
                    justify-content: space-between;
                    font-size: 13px;
                    font-weight: 700;
                    color: #fff;
                }

                .filter-actions {
                    display: flex;
                    justify-content: flex-end;
                    gap: 15px;
                    margin-top: 20px;
                }

                .btn-reset {
                    background: transparent;
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    color: #fff;
                    font-weight: 700;
                    border-radius: 10px;
                    padding: 10px 25px;
                    transition: var(--transition);
                }

                .btn-reset:hover {
                    background: rgba(255, 255, 255, 0.1);
                }

                .btn-apply {
                    background: var(--primary-blue);
                    border: none;
                    color: #fff;
                    font-weight: 700;
                    border-radius: 10px;
                    padding: 10px 25px;
                    transition: var(--transition);
                }

                .btn-apply:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(240, 76, 38, 0.3);
                }

                .results-meta {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 25px;
                }

                .sort-container {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                /* Existing Package Styles */
                .category-section {
                    margin-bottom: 50px;
                }

                .category-header {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    margin-bottom: 25px;
                    border-left: 4px solid var(--primary-blue);
                    padding-left: 15px;
                }

                .category-title {
                    font-size: 24px;
                    font-weight: 800;
                    margin: 0;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    text-shadow: 0 2px 10px rgba(0,0,0,0.8);
                }

                .package-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 25px;
                }

                .package-card {
                    background: rgba(255, 255, 255, 0.03);
                    backdrop-filter: blur(15px);
                    -webkit-backdrop-filter: blur(15px);
                    border-radius: 15px;
                    overflow: hidden;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    transition: var(--transition);
                    position: relative;
                    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.2);
                }

                .package-card:hover {
                    transform: translateY(-10px);
                    border-color: var(--primary-blue);
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
                }

                .package-img-wrapper {
                    position: relative;
                    width: 100%;
                    aspect-ratio: 16 / 10;
                    overflow: hidden;
                    background: #000;
                }

                .package-img,
                .package-video {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    object-position: center;
                    transition: opacity 0.5s ease, transform 0.5s ease;
                    position: absolute;
                    top: 0;
                    left: 0;
                }

                .package-video {
                    opacity: 0;
                    pointer-events: none;
                }

                .package-card:hover .package-img {
                    opacity: 0;
                    transform: scale(1.1);
                }

                .package-card:hover .package-video {
                    opacity: 1;
                    transform: scale(1.1);
                }

                .play-overlay {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    color: #fff;
                    font-size: 40px;
                    opacity: 0.6;
                    z-index: 2;
                    pointer-events: none;
                    display: none;
                }

                .has-video .play-overlay {
                    display: block;
                }

                .package-card:hover .play-overlay {
                    opacity: 0;
                }

                .package-tag {
                    position: absolute;
                    top: 15px;
                    right: 15px;
                    background: var(--primary-blue);
                    color: #fff;
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 11px;
                    font-weight: 700;
                    text-transform: uppercase;
                }

                .package-content {
                    padding: 20px;
                }

                .package-title {
                    font-size: 18px;
                    font-weight: 700;
                    margin-bottom: 10px;
                    color: #fff;
                    height: 44px;
                    overflow: hidden;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
                }

                .package-footer {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    margin-top: 15px;
                    padding-top: 15px;
                    border-top: 1px solid rgba(255, 255, 255, 0.05);
                }

                .package-price {
                    font-size: 20px;
                    font-weight: 800;
                    color: #fff;
                    text-shadow: 0 2px 4px rgba(0,0,0,0.3);
                }

                .btn-view {
                    background: rgba(255, 255, 255, 0.05);
                    color: #fff;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    padding: 8px 15px;
                    border-radius: 8px;
                    font-size: 13px;
                    font-weight: 600;
                    transition: var(--transition);
                }

                .package-card:hover .btn-view {
                    background: var(--primary-blue);
                    border-color: var(--primary-blue);
                }

                .empty-state {
                    text-align: center;
                    padding: 80px 20px;
                    background: var(--dark-card);
                    border-radius: 20px;
                    border: 1px dotted rgba(255, 255, 255, 0.1);
                }

                @media (max-width: 991px) {
                    .main-content { margin-left: 0; padding: 90px 20px 40px; }
                    .dash-header { flex-direction: column; align-items: flex-start; gap: 20px; padding: 20px; }
                    .search-container { width: 100% !important; }
                    .results-meta { flex-direction: column; align-items: flex-start; gap: 15px; }
                    .sort-container { flex-direction: column; width: 100%; align-items: flex-start; }
                    .sort-container > div { width: 100%; justify-content: space-between; }
                }

                @media (max-width: 576px) {
                    .package-grid { grid-template-columns: 1fr; }
                    .category-title { font-size: 20px; }
                    .category-header { flex-direction: column; align-items: flex-start; gap: 5px; }
                }

                /* Prevent infinite horizontal stretch on ultra-wide screens */
                @media (min-width: 2000px) {
                    .header, .main-content {
                        max-width: 1920px;
                        margin-left: auto;
                        margin-right: auto;
                    }
                    .wrapper { justify-content: center; }
                }
            </style>
        </head>

        <body class="premium-theme">
            <!-- Sunlight Rays -->
            <div class="sun-rays-container">
                <div class="ray ray-1"></div>
                <div class="ray ray-2"></div>
                <div class="ray ray-3"></div>
                <div class="ray ray-4"></div>
            </div>
            <header class="header">
                <div class="header-logo"><a href="<c:url value='/'/>"><img
                            src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
                <div style="display: flex; align-items: center; gap: 20px;">
                    <a href="<c:url value='/vendor/login'/>" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: #fff; text-decoration: none; padding: 8px 15px; border-radius: 8px; font-size: 13px; font-weight: 600; transition: 0.3s; opacity: 0.8;" onmouseover="this.style.opacity='1'; this.style.background='rgba(255,255,255,0.1)'" onmouseout="this.style.opacity='0.8'; this.style.background='rgba(255,255,255,0.05)'">Vendor Portal</a>
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <span style="font-weight: 700;">Hi, ${user.name}</span>
                        <c:set var="defaultAvatar"
                            value="https://ui-avatars.com/api/?name=${user.name}&background=f04c26&color=fff" />
                        <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}"
                            style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;">
                    </div>
                </div>
            </header>
            <div class="wrapper">
                <jsp:include page="user-sidebar.jsp">
                    <jsp:param name="activePage" value="dashboard" />
                </jsp:include>
                <main class="main-content">
                    <form action="<c:url value='/user/dashboard'/>" method="GET" id="filterForm">
                        <div class="dash-header">
                            <div>
                                <h1 style="font-weight: 800; margin: 0; font-size: 32px; text-shadow: 0 4px 15px rgba(0,0,0,0.8); color: #fff;">Dashboard</h1>
                                <p style="color: #fff; margin: 0; text-shadow: 0 2px 8px rgba(0,0,0,0.8); font-weight: 600; font-size: 15px;">Discover amazing travel packages and plan your next adventure.</p>
                            </div>
                            <div style="display: flex; gap: 15px; align-items: center;">
                                <div class="search-container" style="width: 300px;">
                                    <input type="text" name="search" value="${currentParams.search}"
                                        placeholder="Search trips, destinations...">
                                    <i class="fa fa-search"></i>
                                </div>
                                <button type="button" class="btn-filter-toggle" onclick="toggleFilter()">
                                    <i class="fa fa-sliders"></i> Filters
                                </button>
                            </div>
                        </div>

                        <!-- Offcanvas Overlay -->
                        <div class="offcanvas-overlay" id="filterOverlay" onclick="toggleFilter()"></div>

                        <!-- OFFCANVAS FILTER SIDEBAR -->
                        <div class="offcanvas-filter" id="filterSidebar">
                            <div style="display: flex; justify-content: space-between; align-items: center; padding: 25px; border-bottom: 1px solid rgba(255,255,255,0.05);">
                                <h4 style="font-weight: 800; margin: 0; color: #fff; font-size: 20px;">Filters</h4>
                                <button type="button" onclick="toggleFilter()" style="background: none; border: none; color: var(--text-muted); font-size: 20px; cursor: pointer;">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                            
                            <div style="display: flex; flex-direction: column; gap: 20px; padding: 25px;">
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Destination</label>
                                        <select name="destination" class="form-select-custom" style="width: 100%;">
                                            <option value="All Destinations">All Destinations</option>
                                            <c:forEach var="dest" items="${destinations}">
                                                <option value="${dest}" ${currentParams.destination==dest ? 'selected' : ''}>${dest}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Trip Type</label>
                                        <select name="tripType" class="form-select-custom" style="width: 100%;">
                                            <option value="All Types">All Types</option>
                                            <option value="Adventure" ${currentParams.tripType=='Adventure' ? 'selected' : ''}>Adventure</option>
                                            <option value="Solo" ${currentParams.tripType=='Solo' ? 'selected' : ''}>Solo</option>
                                            <option value="Group" ${currentParams.tripType=='Group' ? 'selected' : ''}>Group</option>
                                            <option value="Workation" ${currentParams.tripType=='Workation' ? 'selected' : ''}>Workation</option>
                                            <option value="Festivals" ${currentParams.tripType=='Festivals' ? 'selected' : ''}>Festivals</option>
                                            <option value="Volunteering" ${currentParams.tripType=='Volunteering' ? 'selected' : ''}>Volunteering</option>
                                            <option value="Nightlife" ${currentParams.tripType=='Nightlife' ? 'selected' : ''}>Nightlife</option>
                                            <option value="Content Creation" ${currentParams.tripType=='Content Creation' ? 'selected' : ''}>Content Creation</option>
                                            <option value="Wellness" ${currentParams.tripType=='Wellness' ? 'selected' : ''}>Wellness</option>
                                            <option value="Budget Backpacking" ${currentParams.tripType=='Budget Backpacking' ? 'selected' : ''}>Budget Backpacking</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Duration</label>
                                        <select name="duration" class="form-select-custom" style="width: 100%;">
                                            <option value="All Durations">All Durations</option>
                                            <option value="1-3 Days" ${currentParams.duration=='1-3 Days' ? 'selected' : ''}>1-3 Days</option>
                                            <option value="4-7 Days" ${currentParams.duration=='4-7 Days' ? 'selected' : ''}>4-7 Days</option>
                                            <option value="7+ Days" ${currentParams.duration=='7+ Days' ? 'selected' : ''}>7+ Days</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Departure City</label>
                                        <select name="departureCity" class="form-select-custom" style="width: 100%;">
                                            <option value="Any">Any City</option>
                                            <option value="Delhi" ${currentParams.departureCity=='Delhi' ? 'selected' : ''}>Delhi</option>
                                            <option value="Mumbai" ${currentParams.departureCity=='Mumbai' ? 'selected' : ''}>Mumbai</option>
                                            <option value="Bengaluru" ${currentParams.departureCity=='Bengaluru' ? 'selected' : ''}>Bengaluru</option>
                                            <option value="Chennai" ${currentParams.departureCity=='Chennai' ? 'selected' : ''}>Chennai</option>
                                            <option value="Kolkata" ${currentParams.departureCity=='Kolkata' ? 'selected' : ''}>Kolkata</option>
                                            <option value="Hyderabad" ${currentParams.departureCity=='Hyderabad' ? 'selected' : ''}>Hyderabad</option>
                                            <option value="Pune" ${currentParams.departureCity=='Pune' ? 'selected' : ''}>Pune</option>
                                            <option value="Ahmedabad" ${currentParams.departureCity=='Ahmedabad' ? 'selected' : ''}>Ahmedabad</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Travel Month</label>
                                        <select name="travelMonth" class="form-select-custom" style="width: 100%;">
                                            <option value="Any">Any Month</option>
                                            <option value="January" ${currentParams.travelMonth=='January' ? 'selected' : ''}>January</option>
                                            <option value="February" ${currentParams.travelMonth=='February' ? 'selected' : ''}>February</option>
                                            <option value="March" ${currentParams.travelMonth=='March' ? 'selected' : ''}>March</option>
                                            <option value="April" ${currentParams.travelMonth=='April' ? 'selected' : ''}>April</option>
                                            <option value="May" ${currentParams.travelMonth=='May' ? 'selected' : ''}>May</option>
                                            <option value="June" ${currentParams.travelMonth=='June' ? 'selected' : ''}>June</option>
                                            <option value="July" ${currentParams.travelMonth=='July' ? 'selected' : ''}>July</option>
                                            <option value="August" ${currentParams.travelMonth=='August' ? 'selected' : ''}>August</option>
                                            <option value="September" ${currentParams.travelMonth=='September' ? 'selected' : ''}>September</option>
                                            <option value="October" ${currentParams.travelMonth=='October' ? 'selected' : ''}>October</option>
                                            <option value="November" ${currentParams.travelMonth=='November' ? 'selected' : ''}>November</option>
                                            <option value="December" ${currentParams.travelMonth=='December' ? 'selected' : ''}>December</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Price Range</label>
                                        <div class="price-range-container">
                                            <input type="range" name="maxPrice" class="price-slider" min="0" max="100000" step="500" value="${currentParams.maxPrice}" oninput="updatePrice(this.value)">
                                            <div class="price-values">
                                                <span>₹0</span>
                                                <span id="priceVal">₹${currentParams.maxPrice}+</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="filter-actions" style="display: flex; flex-direction: column; gap: 10px; margin-top: 10px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.05);">
                                        <button type="submit" class="btn-apply" style="width: 100%; border-radius: 12px;">Apply Filters</button>
                                        <button type="button" class="btn-reset" onclick="window.location.href='/user/dashboard'" style="width: 100%; justify-content: center; border-radius: 12px;">Reset</button>
                                    </div>
                                </div> <!-- End Padding Container -->
                            </div> <!-- End Offcanvas Sidebar -->
                            
                            <!-- MAIN CONTENT AREA -->
                            <div style="width: 100%;">
                                <div class="results-meta" style="margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;">
                                    <div style="font-weight: 700; font-size: 16px; text-shadow: 0 2px 10px rgba(0,0,0,0.8); color: #fff;">Showing ${totalCount} packages</div>
                                    <div class="sort-container" style="display: flex; align-items: center; gap: 15px;">
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <span style="font-size: 13px; font-weight: 700; color: #fff; text-shadow: 0 1px 5px rgba(0,0,0,0.8);">Group by:</span>
                                            <select name="groupBy" class="form-select-custom" style="width: auto; padding: 8px 15px; border-radius: 10px;" onchange="this.form.submit()">
                                                <option value="travelerType" ${currentParams.groupBy == 'travelerType' ? 'selected' : ''}>Traveler Type</option>
                                                <option value="activity" ${currentParams.groupBy == 'activity' ? 'selected' : ''}>Activity</option>
                                                <option value="adventure" ${currentParams.groupBy == 'adventure' ? 'selected' : ''}>Adventures</option>
                                                <option value="transport" ${currentParams.groupBy == 'transport' ? 'selected' : ''}>Transport</option>
                                                <option value="stay" ${currentParams.groupBy == 'stay' ? 'selected' : ''}>Stay Category</option>
                                            </select>
                                        </div>
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <span style="font-size: 13px; font-weight: 700; color: #fff; text-shadow: 0 1px 5px rgba(0,0,0,0.8);">Sort by:</span>
                                            <select name="sortBy" class="form-select-custom" style="width: auto; padding: 8px 15px; border-radius: 10px;" onchange="this.form.submit()">
                                                <option value="latest" ${currentParams.sortBy == 'latest' ? 'selected' : ''}>Latest</option>
                                                <option value="priceLow" ${currentParams.sortBy == 'priceLow' ? 'selected' : ''}>Price: Low to High</option>
                                                <option value="priceHigh" ${currentParams.sortBy == 'priceHigh' ? 'selected' : ''}>Price: High to Low</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>


                    <c:choose>
                        <c:when test="${not empty groupedPackages}">
                            <c:forEach var="entry" items="${groupedPackages}">
                                <section class="category-section">
                                    <div class="category-header">
                                        <h2 class="category-title">${entry.key}</h2>
                                        <span
                                            style="color: var(--text-muted); font-size: 14px; font-weight: 600;">${entry.value.size()}
                                            Packages</span>
                                    </div>
                                    <div class="package-grid">
                                        <c:forEach var="trip" items="${entry.value}">
                                            <c:set var="videoUrl" value="" />
                                            <c:set var="hasVideo" value="false" />
                                            <c:forEach var="url" items="${trip.mediaUrls.split(',')}">
                                                <c:if
                                                    test="${url.toLowerCase().endsWith('.mp4') || url.toLowerCase().endsWith('.webm') || url.toLowerCase().endsWith('.mov')}">
                                                    <c:set var="videoUrl" value="${url}" />
                                                    <c:set var="hasVideo" value="true" />
                                                </c:if>
                                            </c:forEach>

                                            <div class="package-card ${hasVideo ? 'has-video' : ''} ${trip.soldOut ? 'sold-out' : ''}"
                                                onmouseenter="${!trip.soldOut ? 'playVideo(this)' : ''}" onmouseleave="${!trip.soldOut ? 'pauseVideo(this)' : ''}">
                                                <div class="package-img-wrapper">
                                                    <c:if test="${trip.soldOut}">
                                                        <span class="sold-out-badge">Sold Out</span>
                                                    </c:if>
                                                    <img src="${not empty trip.imageUrl ? trip.imageUrl : 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80'}"
                                                        class="package-img" loading="lazy">
                                                    <c:if test="${hasVideo && !trip.soldOut}">
                                                        <video class="package-video" muted loop playsinline
                                                            preload="none">
                                                            <source src="${videoUrl}" type="video/mp4">
                                                        </video>
                                                        <i class="fa fa-play-circle play-overlay"></i>
                                                    </c:if>
                                                    <span class="package-tag">${entry.key}</span>
                                                </div>
                                                <div class="package-content">
                                                    <h4 class="package-title">${trip.title}</h4>
                                                    <div style="font-size: 13px; color: var(--text-muted);"><i
                                                            class="fa fa-map-marker"></i> ${trip.destination}</div>
                                                    <div
                                                        style="font-size: 12px; color: var(--text-muted); margin-top: 5px;">
                                                        <i class="fa fa-calendar"></i> ${trip.days} Days /
                                                        ${trip.nights} Nights
                                                    </div>
                                                    <div
                                                        style="font-size: 11px; margin-top: 8px; display: flex; gap: 8px; flex-wrap: wrap;">
                                                        <c:if test="${not empty trip.ageGroup}">
                                                            <span
                                                                style="background: rgba(255,255,255,0.05); padding: 2px 6px; border-radius: 4px; border: 1px solid rgba(255,255,255,0.1);">
                                                                <i class="fa fa-users"
                                                                    style="color: var(--primary-blue);"></i>
                                                                ${trip.ageGroup}
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${trip.studentDiscountAvailable}">
                                                            <span
                                                                style="background: rgba(40,167,69,0.1); color: #28a745; padding: 2px 6px; border-radius: 4px; border: 1px solid rgba(40,167,69,0.2);">
                                                                <i class="fa fa-id-card-o"></i> Student Discount
                                                            </span>
                                                        </c:if>
                                                    </div>

                                                    <div class="package-footer">
                                                        <div class="package-price">₹${trip.price} <span>/ person</span>
                                                        </div>
                                                        <a href="<c:url value='/user/package/${trip.id}'/>"
                                                            class="btn-view">View Details</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fa fa-suitcase"
                                    style="font-size: 60px; color: rgba(255,255,255,0.05); margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 700; color: #fff;">No Packages Found</h3>
                                <p style="color: var(--text-muted); max-width: 400px; margin: 0 auto;">Try adjusting
                                    your filters or search keywords to find what you're looking for.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                            </div> <!-- End Right Column -->
                        </div> <!-- End Flex Container -->
                    </form>
                </main>
            </div>
            <script>
                function updatePrice(val) {
                    document.getElementById('priceVal').innerText = '₹' + val + (val == 100000 ? '+' : '');
                }

                function playVideo(card) {
                    const video = card.querySelector('.package-video');
                    if (video) {
                        if (video.readyState < 2) video.load(); // Lazy load video
                        video.play().catch(e => console.log("Video play blocked:", e));
                    }
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
                    
                    sidebar.classList.toggle('show');
                    
                    if (overlay.classList.contains('show')) {
                        overlay.style.opacity = '0';
                        setTimeout(() => overlay.classList.remove('show'), 300);
                    } else {
                        overlay.classList.add('show');
                        // trigger reflow
                        void overlay.offsetWidth;
                        overlay.style.opacity = '1';
                    }
                }

            </script>
        </body>

        </html>