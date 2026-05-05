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
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #e63946; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 100px 30px 40px; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: rgba(0,0,0,0.4); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .explore-header { background: rgba(0,0,0,0.3); backdrop-filter: blur(10px); padding: 30px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.1); margin-bottom: 30px; display: flex; justify-content: space-between; align-items: flex-end; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3); }
        .search-container { position: relative; width: 400px; }
        .search-container input { width: 100%; background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.2); padding: 12px 20px 12px 45px; border-radius: 25px; color: #fff; outline: none; transition: var(--transition); backdrop-filter: blur(5px); }
        .search-container input:focus { border-color: var(--primary-blue); background: rgba(0,0,0,0.6); box-shadow: 0 0 15px rgba(230, 57, 70, 0.2); }
        .search-container i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: #fff; }
        .nav-tabs { display: flex; gap: 30px; border-bottom: 1px solid rgba(255,255,255,0.1); margin-bottom: 30px; padding-left: 10px; }
        .nav-tabs button { background: none; border: none; color: rgba(255,255,255,0.6); padding: 10px 0; font-size: 16px; font-weight: 700; cursor: pointer; border-bottom: 2px solid transparent; transition: var(--transition); text-transform: uppercase; letter-spacing: 1px; text-shadow: 0 2px 4px rgba(0,0,0,0.5); }
        .nav-tabs button.active { color: #fff; border-bottom-color: var(--primary-blue); text-shadow: 0 2px 10px rgba(230, 57, 70, 0.5); }
        .tab-pane { display: none; }
        .tab-pane.active { display: block; }
        
        .user-card { background: rgba(0,0,0,0.3); backdrop-filter: blur(15px); padding: 30px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.1); text-align: center; transition: var(--transition); box-shadow: 0 8px 32px 0 rgba(0,0,0,0.3); }
        .user-card:hover { border-color: var(--primary-blue); transform: translateY(-5px); box-shadow: 0 15px 35px rgba(230,57,70,0.2); }
        .user-avatar { width: 100px; height: 100px; border-radius: 50%; object-fit: cover; margin-bottom: 20px; border: 4px solid rgba(255,255,255,0.1); box-shadow: 0 5px 15px rgba(0,0,0,0.5); }
        .user-name { font-size: 20px; font-weight: 800; margin: 0 0 5px; color: #fff; text-shadow: 0 2px 5px rgba(0,0,0,0.8); }
        .user-username { font-size: 14px; color: var(--primary-blue); margin-bottom: 20px; font-weight: 700; text-shadow: 0 1px 3px rgba(0,0,0,0.3); }
        .btn-view-profile { background: rgba(255,255,255,0.1); color: #fff; border: 1px solid rgba(255,255,255,0.2); padding: 10px 25px; border-radius: 25px; font-size: 14px; font-weight: 700; transition: var(--transition); text-decoration: none; display: inline-block; backdrop-filter: blur(5px); }
        .btn-view-profile:hover { background: var(--primary-blue); border-color: var(--primary-blue); color: #fff; transform: scale(1.05); }
        .users-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 25px; }
        
        .posts-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; }
        .post-card { position: relative; border-radius: 15px; overflow: hidden; border: 1px solid rgba(255,255,255,0.1); background: rgba(0,0,0,0.3); backdrop-filter: blur(10px); display: flex; flex-direction: column; transition: var(--transition); }
        .post-card:hover { transform: translateY(-5px); border-color: var(--primary-blue); }
        .post-card img, .post-card video { width: 100%; aspect-ratio: 1; object-fit: cover; }
        .post-details { padding: 15px; display: flex; flex-direction: column; gap: 8px; }
        .post-caption { font-size: 14px; color: #fff; font-weight: 500; text-shadow: 0 1px 3px rgba(0,0,0,0.5); }
        .post-stats { font-size: 13px; color: rgba(255,255,255,0.7); display: flex; gap: 15px; font-weight: 600; }
        .post-author { position: absolute; top: 12px; left: 12px; background: rgba(0,0,0,0.5); backdrop-filter: blur(5px); padding: 5px 12px; border-radius: 20px; font-size: 12px; color: #fff; font-weight: 700; border: 1px solid rgba(255,255,255,0.1); }
        
        .advices-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 25px; }
        .advice-card { background: rgba(0,0,0,0.3); backdrop-filter: blur(15px); padding: 25px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.1); box-shadow: 0 8px 32px 0 rgba(0,0,0,0.3); }
        .advice-card:hover { border-color: var(--primary-blue); transform: translateY(-5px); }
        .advice-card h4 { margin: 0 0 12px; font-size: 18px; color: #fff; font-weight: 800; text-shadow: 0 2px 5px rgba(0,0,0,0.8); }
        .advice-card p { font-size: 15px; color: rgba(255,255,255,0.8); line-height: 1.6; margin: 0; font-weight: 500; text-shadow: 0 1px 3px rgba(0,0,0,0.5); }
        .advice-author { display: flex; align-items: center; gap: 12px; margin-top: 18px; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 18px; }
        .advice-author img { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; border: 2px solid rgba(255,255,255,0.2); }
        .advice-author span { font-size: 14px; color: #fff; font-weight: 700; text-shadow: 0 1px 3px rgba(0,0,0,0.5); }
        .btn-view-profile { background: var(--primary-blue); color: white; padding: 8px 16px; border-radius: 10px; font-weight: 700; font-size: 12px; text-decoration: none; transition: 0.3s; }
        .btn-view-profile:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(230, 57, 70, 0.3); color: white; }

        /* Advice Details in Modal */
        .modal-advice-detail { background: rgba(0,0,0,0.4); border-radius: 15px; padding: 20px; border: 1px solid rgba(255,255,255,0.1); }
        .modal-tip-box { background: rgba(230, 57, 70, 0.05); border: 1px solid rgba(230, 57, 70, 0.1); border-radius: 12px; padding: 12px; height: 100%; }
        .modal-tip-label { color: var(--primary-blue); font-weight: 700; font-size: 11px; text-transform: uppercase; margin-bottom: 5px; display: flex; align-items: center; gap: 8px; }
        
        /* Modal Fixes */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); z-index: 2000; backdrop-filter: blur(8px); }
        .modal-content-custom { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 90%; max-width: 600px; max-height: 90vh; overflow-y: auto; background: #0b0f18; border: 1px solid rgba(255,255,255,0.1); border-radius: 20px; padding: 25px; color: white; }
        .modal-close { position: absolute; top: 15px; right: 20px; font-size: 24px; cursor: pointer; color: #7e8c9a; }
        
        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 90px 20px 40px; }
            .explore-header { flex-direction: column; align-items: flex-start; gap: 20px; padding: 20px; }
            .search-container { width: 100% !important; }
            .nav-tabs { overflow-x: auto; padding-bottom: 5px; gap: 20px; }
            .nav-tabs button { white-space: nowrap; }
        }

        @media (max-width: 576px) {
            .users-grid { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 15px; }
            .user-card { padding: 20px; }
            .user-avatar { width: 80px; height: 80px; }
            .user-name { font-size: 16px; }
            .posts-grid { grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); gap: 10px; }
            .advices-grid { grid-template-columns: 1fr; }
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
        <div class="header-logo"><a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
        <div style="display: flex; align-items: center; gap: 20px;">
                <div style="display: flex; align-items: center; gap: 15px; cursor: pointer;" onclick="showMyPoints()">
                    <span style="font-weight: 700;">Hi, ${user.name}</span>
                    <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=f04c26&color=fff" />
                    <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover; border: 2px solid rgba(255,255,255,0.2);">
                </div>
        </div>
    </header>
    <div id="pointsModal" class="modal" style="display: none; z-index: 3000;">
        <div class="modal-content-custom" style="max-width: 350px; text-align: center;">
            <span class="modal-close" onclick="hidePoints()">&times;</span>
            <div style="padding: 20px;">
                <div style="position: relative; width: 100px; height: 100px; margin: 0 auto 20px;">
                    <img id="modalUserAvatar" src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 3px solid var(--primary-blue); box-shadow: 0 0 25px rgba(230,57,70,0.3);">
                    <div style="position: absolute; bottom: -5px; right: -5px; width: 40px; height: 40px; background: var(--primary-blue); border: 3px solid #0b0f18; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.5);">
                        <span id="modalPointsValue" style="font-size: 16px; font-weight: 800; color: #fff;">0</span>
                    </div>
                </div>
                <h3 style="font-weight: 700; margin-bottom: 5px; color: #fff; font-size: 18px;">Total Points Earned</h3>
                <h2 id="modalTotalPointsLabel" style="font-size: 32px; font-weight: 800; color: var(--primary-blue); margin-bottom: 10px;">0</h2>
                <p style="color: var(--text-muted); font-size: 13px; margin-bottom: 25px;">Track your traveler influence across the platform!</p>
                
                <div style="text-align: left; background: rgba(255,255,255,0.03); padding: 15px; border-radius: 12px; border: 1px solid rgba(255,255,255,0.05);">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 12px;">
                        <span><i class="fa fa-heart" style="color: var(--primary-blue); width: 18px;"></i> Like received</span>
                        <span style="font-weight: 700; color: #4caf50;">+10 pts</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 12px;">
                        <span><i class="fa fa-eye" style="color: var(--primary-blue); width: 18px;"></i> Memory view</span>
                        <span style="font-weight: 700; color: #4caf50;">+2 pts</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 12px;">
                        <span><i class="fa fa-user" style="color: var(--primary-blue); width: 18px;"></i> Profile visit</span>
                        <span style="font-weight: 700; color: #4caf50;">+1 pt</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="explore" />
        </jsp:include>
        <main class="main-content">
            <div class="explore-header">
                <div>
                    <h1 style="font-weight: 800; margin: 0; font-size: 32px; color: #fff; text-shadow: 0 4px 15px rgba(0,0,0,0.8);">Explore Content</h1>
                    <p style="color: #fff; margin: 0; font-weight: 600; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">Find friends, view memories, and discover travel advice.</p>
                </div>
                <form action="<c:url value='/user/explore'/>" method="GET">
                    <div class="search-container">
                        <input type="text" name="search" value="${searchQuery}" placeholder="Search anything...">
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
                                    <div style="margin: 10px 0; font-size: 13px; font-weight: 700; color: #ff9f43; background: rgba(255,159,67,0.1); padding: 5px 15px; border-radius: 20px; display: inline-block; border: 1px solid rgba(255,159,67,0.2);">
                                        <i class="fa fa-star"></i> ${u.travelPoints} Points
                                    </div>
                                    <a href="<c:url value='/profile?username=${not empty u.username ? u.username : u.fullName}'/>" class="btn-view-profile">View Profile</a>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1/-1; text-align: center; padding: 80px 20px; background: rgba(0,0,0,0.3); backdrop-filter: blur(10px); border-radius: 20px; border: 1px dotted rgba(255,255,255,0.2);">
                                <i class="fa fa-users" style="font-size: 60px; color: rgba(255,255,255,0.1); margin-bottom: 20px; text-shadow: 0 0 20px rgba(0,0,0,0.5);"></i>
                                <h3 style="font-weight: 800; color: #fff; text-shadow: 0 2px 10px rgba(0,0,0,0.8);">No users found</h3>
                                <p style="color: #fff; font-weight: 600; text-shadow: 0 2px 5px rgba(0,0,0,0.5);">Try a different search term.</p>
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
                                    <div class="post-author">@${p.user.fullName}</div>
                                    <c:choose>
                                        <c:when test="${p.mediaType == 'video'}">
                                            <video src="${p.mediaUrl}" muted loop onmouseover="this.play()" onmouseout="this.pause()"></video>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${p.mediaUrl}" loading="lazy">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="post-details">
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
                            <div style="grid-column: 1/-1; text-align: center; padding: 80px 20px; background: #161c28; border-radius: 20px; border: 1px dotted rgba(255,255,255,0.1);">
                                <i class="fa fa-image" style="font-size: 50px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 700;">No memories found</h3>
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
                                    
                                    <div style="margin-top: 15px; font-size: 12px; color: rgba(255,255,255,0.6);">
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
                            <div style="grid-column: 1/-1; text-align: center; padding: 80px 20px; background: #161c28; border-radius: 20px; border: 1px dotted rgba(255,255,255,0.1);">
                                <i class="fa fa-lightbulb-o" style="font-size: 50px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 700;">No advice found</h3>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Advice Detail Modal -->
    <div id="adviceModal" class="modal">
        <div class="modal-content-custom">
            <span class="modal-close" onclick="closeModal()">&times;</span>
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
                                <div style="font-size: 13px; color: #fff;">\${t.val}</div>
                            </div>
                        </div>
                    `;
                }
            });

            detail.innerHTML = `
                <div style="text-align:center; margin-bottom: 25px;">
                    <h2 style="margin:0; font-weight:800; color:var(--primary-blue);">\${adv.title}</h2>
                    <span style="color:var(--text-dim); text-transform:uppercase; font-size:12px; letter-spacing:1px;">\${adv.categories || 'General'}</span>
                </div>
                <div style="background: rgba(255,255,255,0.03); padding: 20px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.05); margin-bottom: 20px;">
                    <p style="font-size:15px; line-height:1.7; color:#eee; margin:0;">\${adv.content}</p>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 15px; margin-bottom: 25px;">
                    \${tipsHtml}
                </div>
                <div style="border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px; display: flex; align-items: center; justify-content: space-between;">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <img src="\${(adv.authorPhoto && adv.authorPhoto !== 'null' && adv.authorPhoto !== '') ? adv.authorPhoto : 'https://ui-avatars.com/api/?name=' + adv.authorName + '&background=random'}" style="width: 40px; height: 40px; border-radius: 50%; border: 2px solid var(--primary-blue);">
                        <div>
                            <div style="font-size: 14px; font-weight: 700; color: #fff;">\${adv.authorName}</div>
                            <div style="font-size: 12px; color: var(--text-dim);">@\${adv.authorUsername}</div>
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
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>
