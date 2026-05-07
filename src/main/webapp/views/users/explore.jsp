<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Community | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-light: #e0f2f2;
            --primary-hover: #077378;
            --accent-coral: #ff9f43;
            --accent-blue: #4facfe;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --sidebar-width: 260px;
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            --glass-bg: rgba(255, 255, 255, 0.8);
            --glass-border: rgba(255, 255, 255, 0.5);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-body); 
            color: var(--text-main); 
            margin: 0; padding: 0; 
            overflow-x: hidden;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 30px !important; }

        .main-container { max-width: 1400px; margin: 0 auto; position: relative; }

        /* Explore Hero Section */
        .explore-hero {
            position: relative;
            background: #ffffff;
            border-radius: 30px;
            padding: 40px;
            margin-bottom: 40px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-premium);
            overflow: hidden;
            min-height: 320px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .hero-bg-visual {
            position: absolute;
            right: -10%;
            top: -20%;
            height: 140%;
            width: 60%;
            opacity: 0.15;
            pointer-events: none;
            z-index: 0;
            background-image: 
                url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1000 600'%3E%3Cpath d='M0 600 L300 200 L500 450 L750 50 L1000 400 L1000 600 Z' fill='%23008080'/%3E%3Cpath d='M0 600 L200 400 L400 550 L600 300 L850 500 L1000 400 L1000 600 Z' fill='%23008080' opacity='0.5'/%3E%3Cpath d='M400 50 L410 45 L420 50 M450 70 L460 65 L470 70 M380 90 L390 85 L400 90' fill='none' stroke='%23008080' stroke-width='2'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: center;
            background-size: contain;
        }

        .hero-content { position: relative; z-index: 2; max-width: 650px; }
        .hero-content h1 { font-size: 38px; font-weight: 900; letter-spacing: -1.5px; margin-bottom: 15px; color: var(--text-main); }
        .hero-content h1 span { color: var(--accent-coral); position: relative; }
        .hero-content h1 span::after { content: '✨'; position: absolute; top: -10px; right: -30px; font-size: 24px; }
        .hero-content p { font-size: 16px; color: var(--text-muted); font-weight: 500; line-height: 1.6; margin-bottom: 30px; }

        /* Filter Section */
        .filter-bar {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            position: relative;
            z-index: 2;
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 300px;
        }
        .search-box input {
            width: 100%;
            background: #f8fafc;
            border: 1px solid var(--border-color);
            padding: 14px 20px 14px 50px;
            border-radius: 16px;
            font-weight: 600;
            font-size: 14px;
            transition: var(--transition);
        }
        .search-box input:focus { border-color: var(--primary); background: white; box-shadow: 0 0 0 4px var(--primary-light); outline: none; }
        .search-box i { position: absolute; left: 20px; top: 50%; transform: translateY(-50%); color: var(--text-muted); font-size: 18px; }

        .filter-select {
            background: #f8fafc;
            border: 1px solid var(--border-color);
            padding: 14px 20px;
            border-radius: 16px;
            font-weight: 700;
            font-size: 13px;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            transition: var(--transition);
            min-width: 160px;
        }
        .filter-select:hover { border-color: var(--primary); background: white; }
        .filter-select select { border: none; background: transparent; font-weight: inherit; font-size: inherit; color: inherit; outline: none; width: 100%; cursor: pointer; }

        /* Tabs Navigation */
        .tabs-nav {
            display: flex;
            gap: 15px;
            margin-bottom: 35px;
            background: #ffffff;
            padding: 8px;
            border-radius: 20px;
            width: fit-content;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02);
        }

        .tab-item {
            padding: 12px 25px;
            border-radius: 14px;
            font-weight: 800;
            font-size: 13px;
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .tab-item i { font-size: 16px; }
        .tab-item:hover { color: var(--primary); background: var(--bg-body); }
        .tab-item.active { background: var(--primary); color: white; box-shadow: 0 10px 15px -3px rgba(0, 128, 128, 0.3); }

        .tab-count {
            background: rgba(255,255,255,0.2);
            padding: 2px 8px;
            border-radius: 100px;
            font-size: 10px;
            font-weight: 900;
        }
        .tab-item:not(.active) .tab-count { background: var(--primary-light); color: var(--primary); }

        /* Sections Grid */
        .tab-pane { display: none; animation: slideUp 0.5s ease; }
        .tab-pane.active { display: block; }
        @keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        /* Traveler Cards */
        .users-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .user-card {
            background: white;
            border-radius: 24px;
            padding: 30px 20px;
            border: 1px solid var(--border-color);
            text-align: center;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        .user-card:hover { transform: translateY(-10px); border-color: var(--primary); box-shadow: 0 20px 30px -10px rgba(0,0,0,0.08); }
        
        .user-lvl-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--primary);
            color: white;
            font-size: 10px;
            font-weight: 900;
            padding: 4px 10px;
            border-radius: 100px;
            box-shadow: 0 4px 10px rgba(0,128,128,0.2);
        }

        .user-card-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            padding: 5px;
            background: linear-gradient(135deg, var(--primary), var(--accent-blue));
            margin: 0 auto 20px;
            position: relative;
        }
        .user-card-avatar img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 4px solid white; }
        
        .online-dot {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 14px;
            height: 14px;
            background: #10b981;
            border: 3px solid white;
            border-radius: 50%;
        }

        .user-card h3 { font-size: 18px; font-weight: 800; color: var(--text-main); margin-bottom: 4px; }
        .user-card .username { font-size: 13px; color: var(--primary); font-weight: 700; margin-bottom: 12px; display: block; }
        .user-card .location { font-size: 12px; color: var(--text-muted); font-weight: 600; margin-bottom: 20px; display: flex; align-items: center; justify-content: center; gap: 5px; }

        .user-tags { display: flex; flex-wrap: wrap; justify-content: center; gap: 6px; margin-bottom: 25px; }
        .tag-pill { font-size: 10px; font-weight: 800; padding: 4px 12px; border-radius: 100px; text-transform: uppercase; letter-spacing: 0.5px; }
        .tag-green { background: #ecfdf5; color: #059669; }
        .tag-blue { background: #eff6ff; color: #2563eb; }
        .tag-orange { background: #fff7ed; color: #ea580c; }

        .user-card-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
        }
        .points-box { text-align: left; }
        .points-box span { font-size: 10px; font-weight: 800; color: var(--text-muted); text-transform: uppercase; display: block; }
        .points-box strong { font-size: 14px; font-weight: 900; color: var(--accent-coral); }

        .btn-follow {
            background: var(--primary);
            color: white !important;
            padding: 8px 18px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 800;
            border: none;
            transition: var(--transition);
        }
        .btn-follow:hover { background: var(--primary-hover); transform: scale(1.05); }

        /* Memory Cards (Instagram style) */
        .explore-content-layout { display: flex; gap: 30px; }
        .memories-column { flex: 2; }
        .sidebar-column { flex: 1; }

        .memory-posts-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 25px; }
        
        .memory-post-card {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            transition: var(--transition);
        }
        .memory-post-card:hover { transform: translateY(-5px); border-color: var(--primary); box-shadow: var(--shadow-premium); }

        .post-header { padding: 15px 20px; display: flex; align-items: center; gap: 12px; }
        .post-author-img { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; }
        .post-author-info span { font-size: 13px; font-weight: 800; color: var(--text-main); display: block; }
        .post-author-info small { font-size: 11px; color: var(--text-muted); font-weight: 600; }

        .post-media { width: 100%; aspect-ratio: 1; position: relative; overflow: hidden; background: #f1f5f9; }
        .post-media img, .post-media video { width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; }
        .memory-post-card:hover .post-media img { transform: scale(1.05); }

        .post-body { padding: 20px; }
        .post-caption { font-size: 14px; color: var(--text-main); font-weight: 500; line-height: 1.5; margin-bottom: 15px; }
        
        .post-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .action-btns { display: flex; gap: 15px; font-size: 20px; }
        .action-btns i { cursor: pointer; transition: 0.2s; color: var(--text-main); }
        .action-btns i:hover { color: var(--primary); transform: scale(1.1); }
        .action-btns i.fa-heart:hover { color: #e63946; }

        .post-stats-text { font-size: 13px; font-weight: 800; color: var(--text-main); }

        /* Advice Cards */
        .advice-list { display: flex; flex-direction: column; gap: 20px; }
        .advice-mini-card {
            background: white;
            padding: 20px;
            border-radius: 20px;
            border: 1px solid var(--border-color);
            transition: var(--transition);
        }
        .advice-mini-card:hover { border-color: var(--primary); transform: translateX(5px); box-shadow: 0 10px 20px rgba(0,0,0,0.03); }
        
        .advice-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 15px; }
        .advice-user { display: flex; align-items: center; gap: 10px; }
        .advice-user img { width: 30px; height: 30px; border-radius: 50%; object-fit: cover; }
        .advice-user span { font-size: 12px; font-weight: 800; }
        
        .advice-time { font-size: 11px; color: var(--text-muted); font-weight: 600; }
        
        .advice-title { font-size: 15px; font-weight: 800; color: var(--text-main); margin-bottom: 8px; display: block; }
        .advice-title:hover { color: var(--primary); text-decoration: none; }
        .advice-desc { font-size: 13px; color: var(--text-muted); line-height: 1.5; margin-bottom: 15px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        
        .advice-footer { display: flex; justify-content: space-between; align-items: center; }
        .advice-tag { background: var(--primary-light); color: var(--primary); padding: 4px 10px; border-radius: 8px; font-size: 10px; font-weight: 800; }
        .advice-votes { font-size: 12px; color: var(--text-muted); font-weight: 700; display: flex; align-items: center; gap: 5px; }

        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .section-header h2 { font-size: 20px; font-weight: 900; margin: 0; color: var(--text-main); }
        .view-all-link { font-size: 13px; font-weight: 700; color: var(--primary); display: flex; align-items: center; gap: 5px; }
        .view-all-link:hover { text-decoration: none; color: var(--primary-hover); }

        @media (max-width: 1200px) {
            .explore-content-layout { flex-direction: column; }
            .sidebar-column { order: -1; }
        }

        @media (max-width: 768px) {
            .main-content { margin-left: 0; padding: 15px !important; }
            .explore-hero { padding: 30px 20px; text-align: center; }
            .hero-content { margin: 0 auto; }
            .filter-bar { flex-direction: column; }
            .search-box, .filter-select { width: 100%; }
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="explore" />
        </jsp:include>
        
        <main class="main-content">
            <div class="main-container">
                
                <!-- Explore Hero Section -->
                <section class="explore-hero">
                    <div class="hero-bg-visual"></div>
                    <div class="hero-content">
                        <h1>Explore <span>Community</span></h1>
                        <p>Discover travelers, real stories and helpful advice from around the world. Connect with the global community of explorers.</p>
                        
                        <form action="<c:url value='/user/explore'/>" method="GET" class="filter-bar">
                            <div class="search-box">
                                <i class="fa fa-search"></i>
                                <input type="text" name="search" value="${searchQuery}" placeholder="Search travelers, memories, advice, destinations...">
                            </div>
                            
                            <div class="filter-select">
                                <i class="fa fa-th-large"></i>
                                <select name="category" onchange="this.form.submit()">
                                    <option value="">All Categories</option>
                                    <option value="Solo" ${param.category == 'Solo' ? 'selected' : ''}>Solo Travel</option>
                                    <option value="Adventure" ${param.category == 'Adventure' ? 'selected' : ''}>Adventure</option>
                                    <option value="Luxury" ${param.category == 'Luxury' ? 'selected' : ''}>Luxury</option>
                                    <option value="Budget" ${param.category == 'Budget' ? 'selected' : ''}>Budget</option>
                                </select>
                            </div>

                            <div class="filter-select">
                                <i class="fa fa-globe"></i>
                                <select name="country" onchange="this.form.submit()">
                                    <option value="">All Countries</option>
                                    <option value="India" ${param.country == 'India' ? 'selected' : ''}>India</option>
                                    <option value="USA" ${param.country == 'USA' ? 'selected' : ''}>USA</option>
                                    <option value="UK" ${param.country == 'UK' ? 'selected' : ''}>UK</option>
                                    <option value="Australia" ${param.country == 'Australia' ? 'selected' : ''}>Australia</option>
                                </select>
                            </div>

                            <div class="filter-select">
                                <i class="fa fa-sort-amount-desc"></i>
                                <select name="sortBy" onchange="this.form.submit()">
                                    <option value="latest" ${param.sortBy == 'latest' ? 'selected' : ''}>Sort By: Latest</option>
                                    <option value="popular" ${param.sortBy == 'popular' ? 'selected' : ''}>Sort By: Popular</option>
                                </select>
                            </div>
                        </form>
                    </div>
                </section>

                <!-- Professional Tabs -->
                <div class="tabs-nav">
                    <div class="tab-item active" data-tab="travelers">
                        <i class="fa fa-users"></i> Travelers <span class="tab-count">${users.size()}</span>
                    </div>
                    <div class="tab-item" data-tab="memories">
                        <i class="fa fa-image"></i> Memories <span class="tab-count">${posts.size()}</span>
                    </div>
                    <div class="tab-item" data-tab="advice">
                        <i class="fa fa-lightbulb-o"></i> Advice <span class="tab-count">${advices.size()}</span>
                    </div>
                </div>

                <!-- Travelers Tab -->
                <div id="tab-travelers" class="tab-pane active">
                    <div class="section-header">
                        <h2>Community Explorers</h2>
                        <a href="#" class="view-all-link">Discover More <i class="fa fa-arrow-right"></i></a>
                    </div>
                    <div class="users-grid">
                        <c:choose>
                            <c:when test="${not empty users}">
                                <c:forEach var="u" items="${users}">
                                    <div class="user-card">
                                        <div class="user-lvl-badge">LEVEL ${(u.travelPoints / 250).intValue() + 1}</div>
                                        <div class="user-card-avatar">
                                            <c:set var="userAvatar" value="${not empty u.profilePhoto ? u.profilePhoto : 'https://ui-avatars.com/api/?name='.concat(u.fullName).concat('&background=008080&color=fff')}" />
                                            <img src="${userAvatar}" alt="${u.fullName}">
                                            <div class="online-dot"></div>
                                        </div>
                                        <h3>${u.fullName}</h3>
                                        <span class="username">@${not empty u.username ? u.username : 'traveler'}</span>
                                        <div class="location"><i class="fa fa-map-marker"></i> ${not empty u.city ? u.city : 'Explorer'}</div>
                                        
                                        <p style="font-size: 12px; color: var(--text-muted); margin: 10px 0 20px; line-height: 1.4; height: 34px; overflow: hidden;">
                                            ${not empty u.bio ? u.bio : (not empty u.profession ? u.profession : 'Wanderer at heart. Exploring new places and sharing memories.')}
                                        </p>

                                        <div class="user-tags">
                                            <c:forEach var="badge" items="${u.getDynamicBadges(0)}" varStatus="st">
                                                <c:set var="badgeClass" value="${st.index % 3 == 0 ? 'tag-green' : (st.index % 3 == 1 ? 'tag-blue' : 'tag-orange')}" />
                                                <span class="tag-pill ${badgeClass}">${badge}</span>
                                            </c:forEach>
                                        </div>
                                        
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="grid-column: 1/-1; text-align: center; padding: 60px; background: white; border-radius: 24px; border: 2px dashed var(--border-color);">
                                    <p style="color: var(--text-muted); font-weight: 600;">No community travelers found matching your search.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Combined Memories & Advice Tab -->
                <div id="tab-memories" class="tab-pane">
                    <div class="section-header">
                        <h2>Community Stories</h2>
                        <div class="d-flex gap-3">
                            <span style="font-size:12px; font-weight:700; color:var(--text-muted);"><i class="fa fa-circle text-success me-1"></i> Live Feed</span>
                        </div>
                    </div>
                    <div class="memory-posts-grid">
                        <c:forEach var="p" items="${posts}">
                            <div class="memory-post-card">
                                <div class="post-header">
                                    <img src="${not empty p.user.profilePhoto ? p.user.profilePhoto : 'https://ui-avatars.com/api/?name='.concat(p.user.fullName).concat('&background=random')}" class="post-author-img">
                                    <div class="post-author-info">
                                        <span>${p.user.fullName}</span>
                                        <small><i class="fa fa-globe"></i> ${not empty p.user.city ? p.user.city : 'Traveler'}</small>
                                    </div>
                                    <div class="ms-auto" style="font-size:10px; color:var(--text-muted); font-weight:700;">2H AGO</div>
                                </div>
                                <div class="post-media" onclick="window.location.href='/profile?username=${not empty p.user.username ? p.user.username : p.user.fullName}'" style="cursor:pointer">
                                    <c:choose>
                                        <c:when test="${p.mediaType == 'video'}">
                                            <video src="${p.mediaUrl}" muted loop onmouseover="this.play()" onmouseout="this.pause()"></video>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${p.mediaUrl}" loading="lazy">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="category-badge" style="top:15px; left:15px; right:auto;"><i class="fa fa-map-marker"></i> Adventure</div>
                                </div>
                                <div class="post-body">
                                    <p class="post-caption"><strong>${p.user.fullName}</strong> ${p.caption}</p>
                                    <div class="post-actions">
                                        <div class="action-btns">
                                            <i class="fa fa-heart-o" onclick="this.classList.toggle('fa-heart'); this.classList.toggle('fa-heart-o'); this.style.color=this.classList.contains('fa-heart')?'#e63946':''"></i>
                                            <i class="fa fa-comment-o"></i>
                                            <i class="fa fa-paper-plane-o"></i>
                                        </div>
                                        <i class="fa fa-bookmark-o"></i>
                                    </div>
                                    <div class="post-stats-text">${p.likes} likes • ${p.views} views</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div id="tab-advice" class="tab-pane">
                    <div class="section-header">
                        <h2>Travel Wisdom</h2>
                        <button class="filter-select" style="padding: 8px 15px; font-size: 11px;"><i class="fa fa-filter"></i> Filter Tips</button>
                    </div>
                    <div class="memory-posts-grid">
                        <c:forEach var="a" items="${advices}">
                            <div class="advice-mini-card">
                                <div class="advice-header">
                                    <div class="advice-user">
                                        <img src="${not empty a.user.profilePhoto ? a.user.profilePhoto : 'https://ui-avatars.com/api/?name='.concat(a.user.fullName).concat('&background=random')}">
                                        <span>${a.user.fullName}</span>
                                    </div>
                                    <div class="advice-tag">${not empty a.categories ? a.categories : 'Expert Tip'}</div>
                                </div>
                                <a href="#" class="advice-title">${a.title}</a>
                                <p class="advice-desc">${a.content}</p>
                                <div class="advice-footer">
                                    <div class="advice-votes">
                                        <i class="fa fa-thumbs-up" style="color:var(--primary)"></i> ${a.likes} community helpful
                                    </div>
                                    <div class="d-flex gap-3">
                                        <i class="fa fa-share-alt" style="cursor:pointer; color:var(--text-muted)"></i>
                                        <i class="fa fa-bookmark-o" style="cursor:pointer; color:var(--text-muted)"></i>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.tab-item').on('click', function() {
                $('.tab-item').removeClass('active');
                $(this).addClass('active');
                
                const tabId = $(this).data('tab');
                $('.tab-pane').removeClass('active');
                $('#tab-' + tabId).addClass('active');
            });
        });

        function toggleFollow(userId, btn) {
            $(btn).prop('disabled', true).text('...');
            $.post('/user/profile/api/follow/' + userId, function(res) {
                if(res === 'Followed') {
                    $(btn).text('Following').css('background', '#64748b').prop('disabled', false);
                } else {
                    $(btn).text('Follow').css('background', 'var(--primary)').prop('disabled', false);
                }
            }).fail(function() {
                $(btn).text('Follow').prop('disabled', false);
            });
        }
    </script>
</body>
</html>
