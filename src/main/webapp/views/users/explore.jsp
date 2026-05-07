<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Users | Youth Travel</title>
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
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-body); 
            color: var(--text-main); 
            margin: 0; padding: 0; 
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; transition: margin-left 0.4s ease; }

        /* Professional Explore Header */
        .explore-header { 
            background: var(--bg-card); 
            padding: 32px; 
            border-radius: 16px; 
            border: 1px solid var(--border-color); 
            margin-bottom: 32px; 
            display: flex; 
            justify-content: space-between; 
            align-items: flex-end; 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1); 
        }

        .explore-header h1 { font-size: 28px; font-weight: 800; color: var(--text-main); margin: 0; letter-spacing: -0.5px; }
        .explore-header p { color: var(--text-muted); margin: 4px 0 0; font-size: 15px; font-weight: 500; }

        .search-container { position: relative; width: 400px; }
        .search-container input { 
            width: 100%; 
            background: #ffffff; 
            border: 1px solid var(--border-color); 
            padding: 12px 20px 12px 45px; 
            border-radius: 12px; 
            color: var(--text-main); 
            outline: none; 
            transition: var(--transition); 
            font-weight: 500;
        }
        .search-container input:focus { border-color: var(--primary); box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1); }
        .search-container i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: var(--text-muted); font-size: 16px; }

        /* Modern Tabs */
        .nav-tabs { 
            display: flex; 
            gap: 8px; 
            background: #e2e8f0; 
            padding: 4px; 
            border-radius: 12px; 
            margin-bottom: 32px; 
            border: none;
            width: fit-content;
        }
        .nav-tabs button { 
            background: none; 
            border: none; 
            color: var(--text-muted); 
            padding: 10px 24px; 
            font-size: 14px; 
            font-weight: 600; 
            cursor: pointer; 
            border-radius: 10px;
            transition: var(--transition); 
        }
        .nav-tabs button.active { 
            background: #ffffff; 
            color: var(--primary); 
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        
        .tab-pane { display: none; animation: fadeIn 0.4s ease-out; }
        .tab-pane.active { display: block; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

        /* Traveler Cards */
        .users-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 24px; }
        .user-card { 
            background: var(--bg-card); 
            padding: 32px 24px; 
            border-radius: 16px; 
            border: 1px solid var(--border-color); 
            text-align: center; 
            transition: var(--transition); 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05); 
        }
        .user-card:hover { border-color: var(--primary); transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        
        .user-avatar { width: 90px; height: 90px; border-radius: 50%; object-fit: cover; margin-bottom: 20px; border: 3px solid #f8fafc; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
        .user-name { font-size: 18px; font-weight: 700; margin: 0 0 4px; color: var(--text-main); }
        .user-username { font-size: 13px; color: var(--primary); margin-bottom: 16px; font-weight: 600; }
        
        .points-badge { 
            margin: 0 0 20px; 
            font-size: 12px; 
            font-weight: 700; 
            color: #d97706; 
            background: #fffbeb; 
            padding: 6px 16px; 
            border-radius: 100px; 
            display: inline-block; 
            border: 1px solid #fef3c7; 
        }

        .btn-view-profile { 
            background: var(--primary); 
            color: #ffffff !important; 
            padding: 10px 24px; 
            border-radius: 10px; 
            font-size: 13px; 
            font-weight: 700; 
            transition: var(--transition); 
            text-decoration: none !important; 
            display: inline-block; 
        }
        .btn-view-profile:hover { background: var(--primary-hover); transform: translateY(-1px); }

        /* Memory Cards */
        .posts-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 24px; }
        .post-card { 
            background: var(--bg-card); 
            border-radius: 16px; 
            overflow: hidden; 
            border: 1px solid var(--border-color); 
            transition: var(--transition); 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05); 
        }
        .post-card:hover { transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); border-color: var(--primary); }
        
        .post-media-wrapper { position: relative; width: 100%; aspect-ratio: 1; overflow: hidden; background: #f1f5f9; }
        .post-card img, .post-card video { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .post-card:hover img, .post-card:hover video { transform: scale(1.05); }
        
        .post-author-overlay { 
            position: absolute; top: 12px; left: 12px; 
            background: rgba(255, 255, 255, 0.9); 
            backdrop-filter: blur(4px); 
            padding: 6px 12px; 
            border-radius: 100px; 
            font-size: 11px; 
            color: var(--text-main); 
            font-weight: 700; 
            border: 1px solid rgba(255,255,255,0.2); 
            z-index: 5;
        }

        .post-info { padding: 16px; }
        .post-caption { font-size: 13px; color: var(--text-main); font-weight: 500; margin-bottom: 12px; line-height: 1.5; }
        .post-stats { font-size: 12px; color: var(--text-muted); display: flex; gap: 16px; font-weight: 600; border-top: 1px solid var(--border-color); padding-top: 12px; }
        .post-stats i { color: var(--primary); }
        
        /* Advice Cards */
        .advices-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 24px; }
        .advice-card { 
            background: var(--bg-card); 
            padding: 24px; 
            border-radius: 16px; 
            border: 1px solid var(--border-color); 
            transition: var(--transition); 
            box-shadow: 0 1px 3px 0 rgba(0,0,0,0.05); 
        }
        .advice-card:hover { border-color: var(--primary); transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .advice-card h4 { margin: 0 0 12px; font-size: 18px; color: var(--text-main); font-weight: 700; }
        .advice-card p { font-size: 14px; color: var(--text-muted); line-height: 1.6; margin: 0; font-weight: 400; height: 66px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; }
        
        .advice-meta { margin-top: 16px; font-size: 12px; font-weight: 600; color: var(--text-muted); display: flex; gap: 12px; }
        .advice-author { display: flex; align-items: center; gap: 12px; margin-top: 20px; border-top: 1px solid var(--border-color); padding-top: 16px; }
        .advice-author img { width: 32px; height: 32px; border-radius: 50%; object-fit: cover; }
        .advice-author span { font-size: 13px; color: var(--text-main); font-weight: 600; }

        /* Modal Customization */
        .modal { 
            background: rgba(15, 23, 42, 0.5); 
            backdrop-filter: blur(8px); 
        }
        .modal-content-custom { 
            background: #ffffff; 
            border: 1px solid var(--border-color); 
            border-radius: 20px; 
            padding: 32px; 
            color: var(--text-main); 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }
        .modal-close { color: var(--text-muted); transition: 0.2s; cursor: pointer; }
        .modal-close:hover { color: var(--accent-red); }

        .modal-tip-box { background: #f8fafc; border: 1px solid var(--border-color); border-radius: 12px; padding: 16px; }
        .modal-tip-label { color: var(--primary); font-weight: 700; font-size: 11px; text-transform: uppercase; margin-bottom: 8px; display: flex; align-items: center; gap: 8px; }
        
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

        @media (max-width: 991px) {
            .mobile-header { display: flex; }
            .main-content { margin-left: 0; padding: 100px 20px 40px !important; }
            .explore-header { flex-direction: column; align-items: stretch; gap: 24px; padding: 24px; }
            .search-container { width: 100% !important; }
            .nav-tabs { width: 100%; overflow-x: auto; white-space: nowrap; padding-bottom: 8px; -webkit-overflow-scrolling: touch; }
            .nav-tabs button { flex: 0 0 auto; }
        }

        @media (max-width: 576px) {
            .main-content { padding: 90px 15px 30px !important; }
            .explore-header h1 { font-size: 22px; }
            .users-grid, .posts-grid, .advices-grid { grid-template-columns: 1fr; }
            .user-card { padding: 24px 16px; }
        }
    </style>
</head>
<body class="light-theme">
    <div id="pointsModal" class="modal" style="display: none; z-index: 3000;">
        <div class="modal-content-custom" style="max-width: 400px; text-align: center; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%);">
            <span class="modal-close" onclick="hidePoints()" style="position: absolute; top: 20px; right: 20px; font-size: 24px;">&times;</span>
            <div style="padding: 10px;">
                <div style="position: relative; width: 100px; height: 100px; margin: 0 auto 24px;">
                    <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=008080&color=fff" />
                    <img id="modalUserAvatar" src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 4px solid var(--primary); box-shadow: 0 10px 25px rgba(0, 128, 128, 0.15);">
                    <div style="position: absolute; bottom: -5px; right: -5px; width: 36px; height: 36px; background: var(--primary); border: 3px solid #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
                        <span id="modalPointsValue" style="font-size: 14px; font-weight: 800; color: #fff;">0</span>
                    </div>
                </div>
                <h3 style="font-weight: 800; margin-bottom: 4px; color: var(--text-main); font-size: 20px;">Influence Points</h3>
                <h2 id="modalTotalPointsLabel" style="font-size: 36px; font-weight: 800; color: var(--primary); margin-bottom: 8px;">0</h2>
                <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 24px;">Your traveler impact across the platform</p>
                
                <div style="text-align: left; background: #f8fafc; padding: 20px; border-radius: 16px; border: 1px solid var(--border-color);">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 13px;">
                        <span><i class="fa fa-heart" style="color: var(--accent-red); width: 20px;"></i> Like received</span>
                        <span style="font-weight: 700; color: #10b981;">+10 pts</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 13px;">
                        <span><i class="fa fa-eye" style="color: var(--primary); width: 20px;"></i> Memory view</span>
                        <span style="font-weight: 700; color: #10b981;">+2 pts</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 13px;">
                        <span><i class="fa fa-user" style="color: var(--primary); width: 20px;"></i> Profile visit</span>
                        <span style="font-weight: 700; color: #10b981;">+1 pt</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="explore" />
        </jsp:include>
        
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
            <div class="explore-header">
                <div>
                    <h1>Explore Community</h1>
                    <p>Connect with travelers and discover shared memories.</p>
                </div>
                <form action="<c:url value='/user/explore'/>" method="GET">
                    <div class="search-container">
                        <input type="text" name="search" value="${searchQuery}" placeholder="Search travelers or advice...">
                        <i class="fa fa-search"></i>
                    </div>
                </form>
            </div>

            <div class="nav-tabs">
                <button class="active" onclick="switchTab('users')">Travelers (${users.size()})</button>
                <button onclick="switchTab('posts')">Memories (${posts.size()})</button>
                <button onclick="switchTab('advices')">Advice (${advices.size()})</button>
            </div>

            <div id="tab-users" class="tab-pane active">
                <div class="users-grid">
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:forEach var="u" items="${users}">
                                <div class="user-card">
                                    <img src="${not empty u.profilePhoto ? u.profilePhoto : 'https://ui-avatars.com/api/?name='.concat(u.fullName).concat('&background=random')}" class="user-avatar">
                                    <h3 class="user-name">${u.fullName}</h3>
                                    <p class="user-username">@${not empty u.username ? u.username : 'traveler'}</p>
                                    <div class="points-badge" onclick="showMyPoints()" style="cursor:pointer">
                                        <i class="fa fa-star"></i> ${u.travelPoints} Points
                                    </div>
                                    <a href="<c:url value='/profile?username=${not empty u.username ? u.username : u.fullName}'/>" class="btn-view-profile">View Profile</a>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1/-1; text-align: center; padding: 80px 20px; background: var(--bg-card); border-radius: 20px; border: 2px dashed var(--border-color);">
                                <i class="fa fa-users" style="font-size: 60px; color: #e2e8f0; margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 800; color: var(--text-main);">No travelers found</h3>
                                <p style="color: var(--text-muted); font-weight: 500;">Try a different search term.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div id="tab-posts" class="tab-pane">
                <div class="posts-grid">
                    <c:choose>
                        <c:when test="${not empty posts}">
                            <c:forEach var="p" items="${posts}">
                                <div class="post-card" onclick="window.location.href='<c:url value='/profile?username=${not empty p.user.username ? p.user.username : p.user.fullName}'/>'" style="cursor: pointer;">
                                    <div class="post-media-wrapper">
                                        <div class="post-author-overlay">@${p.user.fullName}</div>
                                        <c:choose>
                                            <c:when test="${p.mediaType == 'video'}">
                                                <video src="${p.mediaUrl}" muted loop onmouseover="this.play()" onmouseout="this.pause()"></video>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${p.mediaUrl}" loading="lazy">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="post-info">
                                        <c:if test="${not empty p.caption}">
                                            <div class="post-caption">${p.caption}</div>
                                        </c:if>
                                        <div class="post-stats">
                                            <span><i class="fa fa-heart"></i> ${p.likes}</span>
                                            <span><i class="fa fa-eye"></i> ${p.views}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1/-1; text-align: center; padding: 80px 20px; background: var(--bg-card); border-radius: 20px; border: 2px dashed var(--border-color);">
                                <i class="fa fa-image" style="font-size: 50px; color: #e2e8f0; margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 700; color: var(--text-main);">No memories found</h3>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div id="tab-advices" class="tab-pane">
                <div class="advices-grid">
                    <c:choose>
                        <c:when test="${not empty advices}">
                            <c:forEach var="a" items="${advices}">
                                <div class="advice-card" 
                                     data-title="${a.title}"
                                     data-content="${a.content}"
                                     data-categories="${a.categories}"
                                     data-best="${a.bestTimeToVisit}"
                                     data-pack="${a.whatToPack}"
                                     data-safety="${a.safetyTips}"
                                     data-budget="${a.budgetTips}"
                                     data-stay="${a.stayFoodAdvice}"
                                     data-transport="${a.transportTips}"
                                     data-network="${a.connectivityTips}"
                                     data-rules="${a.localRules}"
                                     data-eco="${a.environmentalTips}"
                                     data-pro="${a.proTips}"
                                     data-author-name="${a.user.fullName}"
                                     data-author-username="${not empty a.user.username ? a.user.username : a.user.fullName}"
                                     data-author-photo="${not empty a.user.profilePhoto ? a.user.profilePhoto : ''}"
                                     onclick="handleAdviceClick(this)"
                                     style="cursor: pointer;">
                                    <h4>${a.title}</h4>
                                    <p>${a.content}</p>
                                    
                                    <div class="advice-meta">
                                        <span><i class="fa fa-heart"></i> ${a.likes} likes</span>
                                    </div>
                                    <div class="advice-author">
                                        <c:set var="authorAvatar" value="https://ui-avatars.com/api/?name=${a.user.fullName}&background=random" />
                                        <img src="${not empty a.user.profilePhoto ? a.user.profilePhoto : authorAvatar}">
                                        <span>Shared by ${not empty a.user.username ? a.user.username : a.user.fullName}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1/-1; text-align: center; padding: 80px 20px; background: var(--bg-card); border-radius: 20px; border: 2px dashed var(--border-color);">
                                <i class="fa fa-lightbulb-o" style="font-size: 50px; color: #e2e8f0; margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 700; color: var(--text-main);">No advice found</h3>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Advice Detail Modal -->
    <div id="adviceModal" class="modal" style="display:none; z-index: 2001;">
        <div class="modal-content-custom" style="max-width: 800px; width: 90%; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); max-height: 90vh; overflow-y: auto;">
            <span class="modal-close" onclick="closeModal()" style="position: absolute; top: 20px; right: 20px; font-size: 24px;">&times;</span>
            <div id="adviceDetailContent">
                <!-- Populated by JS -->
            </div>
        </div>
    </div>
    
    <script>
        function switchTab(tabId) {
            document.querySelectorAll('.nav-tabs button').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
            
            event.target.classList.add('active');
            document.getElementById('tab-' + tabId).classList.add('active');
        }

        function showMyPoints() {
            const modal = document.getElementById('pointsModal');
            
            // Fetch latest points
            fetch('/user/profile/api/data')
                .then(res => res.json())
                .then(data => {
                    const pts = data.user.travelPoints || 0;
                    document.getElementById('modalPointsValue').innerText = pts;
                    document.getElementById('modalTotalPointsLabel').innerText = pts;
                });

            modal.style.display = 'block';
        }

        function hidePoints() {
            document.getElementById('pointsModal').style.display = 'none';
        }

        function handleAdviceClick(el) {
            const adv = {
                title: el.getAttribute('data-title'),
                content: el.getAttribute('data-content'),
                categories: el.getAttribute('data-categories'),
                bestTimeToVisit: el.getAttribute('data-best'),
                whatToPack: el.getAttribute('data-pack'),
                safetyTips: el.getAttribute('data-safety'),
                budgetTips: el.getAttribute('data-budget'),
                stayFoodAdvice: el.getAttribute('data-stay'),
                transportTips: el.getAttribute('data-transport'),
                connectivityTips: el.getAttribute('data-network'),
                localRules: el.getAttribute('data-rules'),
                environmentalTips: el.getAttribute('data-eco'),
                proTips: el.getAttribute('data-pro'),
                authorName: el.getAttribute('data-author-name'),
                authorUsername: el.getAttribute('data-author-username'),
                authorPhoto: el.getAttribute('data-author-photo')
            };
            showAdviceDetail(adv);
        }

        function showAdviceDetail(adv) {
            const detail = document.getElementById('adviceDetailContent');
            let tipsHtml = '';
            
            const tips = [
                { label: 'Best Time', val: adv.bestTimeToVisit, icon: 'fa-calendar' },
                { label: 'Packing', val: adv.whatToPack, icon: 'fa-suitcase' },
                { label: 'Safety', val: adv.safetyTips, icon: 'fa-shield' },
                { label: 'Budget', val: adv.budgetTips, icon: 'fa-money' },
                { label: 'Stay & Food', val: adv.stayFoodAdvice, icon: 'fa-bed' },
                { label: 'Transport', val: adv.transportTips, icon: 'fa-car' },
                { label: 'Network', val: adv.connectivityTips, icon: 'fa-wifi' },
                { label: 'Rules', val: adv.localRules, icon: 'fa-gavel' },
                { label: 'Eco Tips', val: adv.environmentalTips, icon: 'fa-leaf' },
                { label: 'Pro Tips', val: adv.proTips, icon: 'fa-star' }
            ];

            tips.forEach(t => {
                if (t.val && t.val.trim() !== '' && t.val !== 'null') {
                    tipsHtml += `
                        <div style="margin-bottom: 15px;">
                            <div class="modal-tip-box">
                                <div class="modal-tip-label"><i class="fa \${t.icon}"></i> \${t.label}</div>
                                <div style="font-size: 13px; color: var(--text-main);">\${t.val}</div>
                            </div>
                        </div>
                    `;
                }
            });

            detail.innerHTML = `
                <div style="text-align:center; margin-bottom: 25px;">
                    <h2 style="margin:0; font-weight:800; color:var(--primary);">\${adv.title}</h2>
                    <span style="color:var(--text-muted); text-transform:uppercase; font-size:12px; letter-spacing:1px;">\${adv.categories || 'General'}</span>
                </div>
                <div style="background: #f8fafc; padding: 24px; border-radius: 16px; border: 1px solid var(--border-color); margin-bottom: 24px;">
                    <p style="font-size:15px; line-height:1.7; color:var(--text-main); margin:0; font-weight: 500;">\${adv.content}</p>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 16px; margin-bottom: 32px;">
                    \${tipsHtml}
                </div>
                <div style="border-top: 1px solid var(--border-color); padding-top: 24px; display: flex; align-items: center; justify-content: space-between;">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <img src="\${(adv.authorPhoto && adv.authorPhoto !== 'null' && adv.authorPhoto !== '') ? adv.authorPhoto : 'https://ui-avatars.com/api/?name=' + adv.authorName + '&background=008080&color=fff'}" style="width: 44px; height: 44px; border-radius: 50%; border: 2px solid var(--primary);">
                        <div>
                            <div style="font-size: 14px; font-weight: 700; color: var(--text-main);">\${adv.authorName}</div>
                            <div style="font-size: 12px; color: var(--text-muted);">@\${adv.authorUsername}</div>
                        </div>
                    </div>
                    <a href="/profile?username=\${adv.authorUsername}" class="btn-view-profile">View Profile</a>
                </div>
            `;
            
            document.getElementById('adviceModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('adviceModal').style.display = 'none';
        }

        // Close on click outside
        window.onclick = function(event) {
            const modal = document.getElementById('adviceModal');
            const pointsModal = document.getElementById('pointsModal');
            if (event.target == modal) {
                closeModal();
            }
            if (event.target == pointsModal) {
                hidePoints();
            }
        }
    </script>
</body>
</html>
