<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Packages | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root {
            --primary-red: #e63946;
            --dark-blue: #002244;
            --glass: rgba(255, 255, 255, 0.1);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Dosis', sans-serif;
            background-color: var(--dark-blue);
            color: #fff;
            margin: 0; padding: 0;
            overflow-x: hidden;
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
            background: linear-gradient(180deg, rgba(255, 230, 120, 0.25) 0%, rgba(255, 220, 80, 0.12) 40%, rgba(255, 255, 255, 0) 100%);
            filter: blur(18px);
            transform-origin: top center;
            border-radius: 50%;
            animation: ray-swing 6s ease-in-out infinite alternate;
        }

        .ray-1 { left: 5%; width: 60px; animation-duration: 7s; animation-delay: 0s; opacity: 0.7; }
        .ray-2 { left: 18%; width: 100px; animation-duration: 9s; animation-delay: 1s; opacity: 0.5; }
        .ray-3 { left: 33%; width: 70px; animation-duration: 6s; animation-delay: 2s; opacity: 0.8; }
        .ray-4 { left: 52%; width: 90px; animation-duration: 8s; animation-delay: 0.5s; opacity: 0.6; }
        .ray-5 { left: 68%; width: 65px; animation-duration: 7.5s; animation-delay: 1.5s; opacity: 0.75; }
        .ray-6 { left: 82%; width: 110px; animation-duration: 10s; animation-delay: 3s; opacity: 0.5; }

        @keyframes ray-swing {
            0% { transform: rotate(-6deg) scaleX(0.9); opacity: 0.2; }
            30% { opacity: 0.9; }
            60% { transform: rotate(4deg) scaleX(1.1); opacity: 0.7; }
            100% { transform: rotate(8deg) scaleX(0.85); opacity: 0.25; }
        }

        /* Nav Sync */
        .yt-main-nav {
            background: rgba(0, 34, 68, 0.8);
            backdrop-filter: blur(15px);
            padding: 15px 0;
            position: fixed;
            top: 0; width: 100%;
            z-index: 1000;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .nav-flex { display: flex; justify-content: space-between; align-items: center; }
        .nav-links a { color: #fff; text-decoration: none; margin-left: 30px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; font-size: 14px; transition: 0.3s; }
        .nav-links a:hover, .nav-links a.active { color: var(--primary-red); }

        .main-container { margin-top: 120px; padding-bottom: 80px; }

        /* Hero Header */
        .explore-hero {
            text-align: center;
            padding: 60px 0;
            margin-bottom: 40px;
        }
        .explore-hero h1 { font-size: 56px; font-weight: 800; text-transform: uppercase; margin-bottom: 15px; letter-spacing: -1px; }
        .explore-hero p { font-size: 20px; opacity: 0.8; max-width: 700px; margin: 0 auto; }

        /* Filter Bar */
        .filter-bar {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 25px 40px;
            border: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 60px;
            display: flex;
            gap: 20px;
            align-items: flex-end;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        .filter-item { flex: 1; }
        .filter-item label { display: block; font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 2px; color: rgba(255,255,255,0.5); margin-bottom: 10px; }
        .luxe-input {
            width: 100%;
            background: rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 12px;
            padding: 12px 20px;
            color: #fff;
            font-weight: 600;
            outline: none;
            transition: var(--transition);
        }
        .luxe-input:focus { border-color: var(--primary-red); background: rgba(0,0,0,0.5); }
        .luxe-select { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='white' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 20px center; }

        .btn-apply {
            background: var(--primary-red);
            color: #fff;
            border: none;
            padding: 14px 40px;
            border-radius: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: var(--transition);
            height: 50px;
        }
        .btn-apply:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(230,57,70,0.4); filter: brightness(1.1); }

        /* Package Cards */
        .category-section { margin-bottom: 60px; }
        .category-title { font-size: 28px; font-weight: 800; margin-bottom: 30px; display: flex; align-items: center; gap: 15px; }
        .category-title::after { content: ''; flex: 1; height: 1px; background: rgba(255,255,255,0.1); }

        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 30px; }
        .package-card {
            background: rgba(0, 34, 68, 0.6);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.1);
            transition: var(--transition);
            position: relative;
        }
        .package-card:hover { transform: translateY(-10px); border-color: var(--primary-red); box-shadow: 0 20px 40px rgba(0,0,0,0.4); }

        .package-img { width: 100%; aspect-ratio: 16/10; object-fit: cover; transition: 0.5s; }
        .package-card:hover .package-img { transform: scale(1.1); }

        .package-content { padding: 30px; }
        .package-name { font-size: 22px; font-weight: 800; margin-bottom: 12px; color: #fff; }
        .package-meta { display: flex; gap: 20px; font-size: 14px; opacity: 0.7; margin-bottom: 25px; }
        .package-meta i { color: var(--primary-red); margin-right: 5px; }

        .package-footer { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px; }
        .package-price { font-size: 24px; font-weight: 900; }
        .package-price span { font-size: 13px; font-weight: 400; opacity: 0.6; }

        .btn-view {
            background: rgba(255,255,255,0.05);
            color: #fff;
            border: 1px solid rgba(255,255,255,0.2);
            padding: 10px 25px;
            border-radius: 10px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
        }
        .package-card:hover .btn-view { background: var(--primary-red); border-color: var(--primary-red); }

        .vendor-tag {
            position: absolute;
            top: 20px; left: 20px;
            background: rgba(0,0,0,0.6);
            backdrop-filter: blur(5px);
            padding: 6px 15px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            z-index: 5;
        }

        /* Empty State */
        .empty-state { text-align: center; padding: 100px 0; opacity: 0.5; }
        .empty-state i { font-size: 80px; margin-bottom: 20px; }

        @media (max-width: 768px) {
            .filter-bar { flex-direction: column; padding: 30px; }
            .explore-hero h1 { font-size: 40px; }
            .btn-apply { width: 100%; }
        }
    </style>
</head>
<body>

    <!-- Sunlight Rays -->
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
        <div class="ray ray-5"></div>
        <div class="ray ray-6"></div>
    </div>

    <!-- Underwater Animation (Global Fish and Divers) -->
    <div class="fish-container">
        <div class="fish fish-1 fish-orange"><div class="fish-body"></div></div>
        <div class="fish fish-2 fish-cyan"><div class="fish-body"></div></div>
        <div class="fish fish-3 fish-purple"><div class="fish-body"></div></div>
        <div class="fish fish-4 fish-gold"><div class="fish-body"></div></div>
        <div class="fish fish-5 fish-red"><div class="fish-body"></div></div>
        <div class="fish fish-6 fish-black"><div class="fish-body"></div></div>
        <div class="diver diver-1">
            <div class="diver-body"></div>
            <div class="bubble-stream"><span></span><span></span><span></span></div>
        </div>
        <div class="diver diver-2">
            <div class="diver-body"></div>
            <div class="bubble-stream"><span></span><span></span><span></span></div>
        </div>
    </div>

    <nav class="yt-main-nav">
        <div class="container">
            <div class="nav-flex">
                <div class="logo">
                    <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" style="height: 40px;" /></a>
                </div>
                <div class="nav-links">
                    <a href="<c:url value='/'/>">Home</a>
                    <a href="<c:url value='/explore-packages'/>" class="active">Explore</a>
                    <a href="<c:url value='/gallery'/>">Gallery</a>
                    <a href="<c:url value='/about'/>">About</a>
                    <a href="<c:url value='/contact'/>">Contact</a>
                    <c:choose>
                        <c:when test="${not empty user}">
                            <a href="<c:url value='/user/dashboard'/>" class="login-btn" style="background: var(--primary-red); padding: 8px 20px; border-radius: 10px;">Dashboard</a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/user/login'/>" class="login-btn" style="background: var(--primary-red); padding: 8px 20px; border-radius: 10px;">Login</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <div class="container main-container">
        <div class="explore-hero">
            <h1>Discover Your Next Adventure</h1>
            <p>Explore curated travel packages from expert vendors across the globe. From mountain treks to beach retreats, find your perfect vibe.</p>
        </div>

        <form action="<c:url value='/explore-packages'/>" method="GET">
            <div class="filter-bar">
                <div class="filter-item">
                    <label>Search Adventures</label>
                    <input type="text" name="search" class="luxe-input" placeholder="E.g. Manali, Trekking..." value="${search}">
                </div>
                <div class="filter-item">
                    <label>Destination</label>
                    <select name="destination" class="luxe-input luxe-select">
                        <option value="All">All Regions</option>
                        <c:forEach var="dest" items="${destinations}">
                            <option value="${dest}" ${destination == dest ? 'selected' : ''}>${dest}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="filter-item">
                    <label>Sort By</label>
                    <select name="sortBy" class="luxe-input luxe-select">
                        <option value="latest" ${sortBy == 'latest' ? 'selected' : ''}>Recently Added</option>
                        <option value="priceLow" ${sortBy == 'priceLow' ? 'selected' : ''}>Price: Low to High</option>
                        <option value="priceHigh" ${sortBy == 'priceHigh' ? 'selected' : ''}>Price: High to Low</option>
                    </select>
                </div>
                <button type="submit" class="btn-apply">Explore</button>
            </div>
        </form>

        <c:choose>
            <c:when test="${not empty groupedPackages}">
                <c:forEach var="entry" items="${groupedPackages}">
                    <section class="category-section">
                        <h2 class="category-title">${entry.key} <span style="font-size: 16px; opacity: 0.5; margin-left: 10px; font-weight: 600;">(${entry.value.size()})</span></h2>
                        <div class="package-grid">
                            <c:forEach var="trip" items="${entry.value}">
                                <div class="package-card">
                                    <div class="vendor-tag"><i class="fa fa-certificate" style="color: #f59e0b; margin-right: 5px;"></i> ${trip.vendor.brandName}</div>
                                    <img src="${trip.imageUrl}" class="package-img" alt="${trip.title}">
                                    <div class="package-content">
                                        <h3 class="package-name">${trip.title}</h3>
                                        <div class="package-meta">
                                            <span><i class="fa fa-map-marker"></i> ${trip.destination}</span>
                                            <span><i class="fa fa-clock-o"></i> ${trip.days}D / ${trip.nights}N</span>
                                        </div>
                                        <div class="package-footer">
                                            <div class="package-price">₹<fmt:formatNumber value="${trip.price}" pattern="#,##0" /> <span>/ person</span></div>
                                            <a href="<c:url value='/user/package/${trip.id}'/>" class="btn-view">View Details</a>
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
                    <i class="fa fa-compass"></i>
                    <h2>No adventures found matching your criteria</h2>
                    <p>Try clearing your filters or searching for something else.</p>
                    <a href="<c:url value='/explore-packages'/>" class="btn-view mt-4" style="display: inline-block;">Clear All Filters</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer Sync -->
    <section class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="footer-content">
                            <div class="footer-logo">
                                <img src="<c:url value='/views/assets/images/footer-logo.png'/>" alt="" />
                            </div>
                            <div class="footer-text">
                                <p>
                                    Travelling is more than just visiting places; it's about the vibes, the stories, and the memories that last a lifetime. Explore the unexplored with Youth Travel!
                                </p>
                            </div>
                            <div class="footer-address">
                                <ul>
                                    <li><i class="fa fa-map-marker" aria-hidden="true"></i> Youth Travel, MG Road, Bengaluru, Karnataka, India
                                    </li>

                                    <li>
                                        <i class="fa fa-phone" aria-hidden="true"></i> +91 98765 43210

                                    </li>
                                    <li>
                                        <i class="fa fa-envelope" aria-hidden="true"></i> support@youthtravel.in

                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="footer-content">
                            <div class="news">
                                <p>
                                    Newsletter Subscribe
                                </p>
                            </div>
                            <div class="subscribe">
                                <form id="newsletterForm" onsubmit="subscribeNewsletter(event)">
                                    <div class="input-group">
                                        <input type="email" id="newsletterEmail" class="form-control" size="50" placeholder="Enter E-mail" required>
                                        <div class="input-group-btn">
                                            <button type="submit" id="subscribeBtn" class="btn btn-danger">Subscribe</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <script>
                                function subscribeNewsletter(e) {
                                    e.preventDefault();
                                    const email = document.getElementById('newsletterEmail').value;
                                    const btn = document.getElementById('subscribeBtn');
                                    const formData = new FormData();
                                    formData.append("name", "Newsletter Subscriber");
                                    formData.append("email", email);
                                    formData.append("message", "Subscribed to newsletter.");
                                    fetch('/enquiry/submit', { method: 'POST', body: formData })
                                    .then(res => {
                                        if(res.ok) {
                                            const originalText = btn.innerHTML;
                                            const originalBg = btn.style.background;
                                            btn.innerHTML = "Subscribed";
                                            btn.style.background = "#4caf50";
                                            btn.disabled = true;
                                            document.getElementById('newsletterEmail').value = "";
                                            setTimeout(() => {
                                                btn.innerHTML = originalText;
                                                btn.style.background = originalBg;
                                                btn.disabled = false;
                                            }, 3000);
                                        }
                                    });
                                }
                            </script>
                            <div class="footer-social">
                                <ul>
                                    <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</body>
</html>
