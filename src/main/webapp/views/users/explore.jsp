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
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f1f5f9;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { 
            flex: 1; 
            margin-left: 240px; 
            padding: 60px 40px !important; 
            transition: margin-left 0.4s ease;
        }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 100px 24px 40px !important; }
            .explore-header { flex-direction: column; align-items: flex-start; gap: 24px; padding: 24px; }
            .search-container { width: 100% !important; }
            .nav-tabs { overflow-x: auto; padding-bottom: 8px; gap: 20px; border-bottom: 1px solid var(--border-color); }
            .nav-tabs button { white-space: nowrap; }
        }

        @media (max-width: 576px) {
            .users-grid { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 16px; }
            .user-card { padding: 24px; }
            .user-avatar { width: 70px; height: 70px; }
            .user-name { font-size: 16px; }
            .posts-grid { grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); gap: 12px; }
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

        .explore-header { 
            background: var(--bg-card); 
            padding: 40px; 
            border-radius: 20px; 
            border: 1px solid var(--border-color); 
            margin-bottom: 32px; 
            display: flex; 
            justify-content: space-between; 
            align-items: flex-end; 
            box-shadow: 0 1px 3px rgba(0,0,0,0.1); 
        }

        .explore-header h1 { font-size: 28px; font-weight: 800; color: var(--text-main); letter-spacing: -0.5px; margin-bottom: 8px; }
        .explore-header p { color: var(--text-muted); font-weight: 500; font-size: 15px; margin: 0; }

        .search-container { position: relative; width: 400px; }
        .search-container input { 
            width: 100%; 
            background: #f8fafc; 
            border: 1px solid var(--border-color); 
            padding: 14px 20px 14px 48px; 
            border-radius: 12px; 
            color: var(--text-main); 
            outline: none; 
            transition: var(--transition); 
            font-weight: 500;
        }
        .search-container input:focus { border-color: var(--primary); background: #fff; box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1); }
        .search-container i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: var(--text-muted); font-size: 18px; }

        /* Tabs Styling */
        .nav-tabs { display: flex; gap: 32px; border-bottom: 1px solid var(--border-color); margin-bottom: 32px; padding-left: 5px; }
        .nav-tabs button { 
            background: none; border: none; 
            color: var(--text-muted); 
            padding: 12px 0; font-size: 14px; font-weight: 700; 
            cursor: pointer; border-bottom: 2px solid transparent; 
            transition: var(--transition); text-transform: uppercase; letter-spacing: 0.5px; 
        }
        .nav-tabs button.active { color: var(--primary); border-bottom-color: var(--primary); }
        .nav-tabs button:hover:not(.active) { color: var(--text-main); }

        .tab-pane { display: none; }
        .tab-pane.active { display: block; }
        
        /* Grid & Cards */
        .users-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 24px; }
        .user-card { 
            background: var(--bg-card); 
            padding: 32px; 
            border-radius: 20px; 
            border: 1px solid var(--border-color); 
            text-align: center; 
            transition: var(--transition); 
            box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
        }
        .user-card:hover { border-color: var(--primary); transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .user-avatar { width: 90px; height: 90px; border-radius: 50%; object-fit: cover; margin-bottom: 20px; border: 4px solid #f8fafc; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }
        .user-name { font-size: 18px; font-weight: 700; margin: 0 0 4px; color: var(--text-main); }
        .user-username { font-size: 14px; color: var(--primary); margin-bottom: 20px; font-weight: 600; }
        
        .btn-view-profile { 
            background: #e0f2f2; 
            color: var(--primary); 
            border: none;
            padding: 10px 24px; 
            border-radius: 12px; 
            font-size: 13px; font-weight: 700; 
            transition: var(--transition); 
            text-decoration: none !important; 
            display: inline-block; 
        }
        .btn-view-profile:hover { background: var(--primary); color: #fff; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0, 128, 128, 0.2); }

        .posts-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 24px; }
        .post-card { 
            position: relative; border-radius: 20px; overflow: hidden; 
            border: 1px solid var(--border-color); 
            background: var(--bg-card); 
            display: flex; flex-direction: column; 
            transition: var(--transition); 
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .post-card:hover { transform: translateY(-4px); border-color: var(--primary); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .post-card img, .post-card video { width: 100%; aspect-ratio: 1; object-fit: cover; }
        .post-details { padding: 16px; display: flex; flex-direction: column; gap: 8px; }
        .post-caption { font-size: 14px; color: var(--text-main); font-weight: 500; }
        .post-stats { font-size: 12px; color: var(--text-muted); display: flex; gap: 16px; font-weight: 600; }
        .post-stats i { color: var(--accent-red); }
        .post-author { position: absolute; top: 12px; left: 12px; background: rgba(255,255,255,0.85); backdrop-filter: blur(8px); padding: 6px 14px; border-radius: 100px; font-size: 11px; color: var(--text-main); font-weight: 700; border: 1px solid var(--border-color); }
        
        .advices-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 24px; }
        .advice-card { 
            background: var(--bg-card); 
            padding: 24px; 
            border-radius: 20px; 
            border: 1px solid var(--border-color); 
            box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
            transition: var(--transition);
        }
        .advice-card:hover { border-color: var(--primary); transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .advice-card h4 { margin: 0 0 12px; font-size: 17px; color: var(--text-main); font-weight: 700; }
        .advice-card p { font-size: 14px; color: var(--text-muted); line-height: 1.6; margin: 0; font-weight: 400; }
        .advice-author { display: flex; align-items: center; gap: 12px; margin-top: 20px; border-top: 1px solid var(--border-color); padding-top: 20px; }
        .advice-author img { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; border: 2px solid #f8fafc; }
        .advice-author span { font-size: 13px; color: var(--text-main); font-weight: 600; }

        /* Modal Overhaul */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(15, 23, 42, 0.5); z-index: 2000; backdrop-filter: blur(4px); }
        .modal-content-custom { 
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); 
            width: 95%; max-width: 640px; max-height: 85vh; 
            overflow-y: auto; background: #ffffff; 
            border: 1px solid var(--border-color); border-radius: 24px; 
            padding: 32px; color: var(--text-main); 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }
        .modal-close { position: absolute; top: 20px; right: 24px; font-size: 24px; cursor: pointer; color: var(--text-muted); transition: 0.2s; }
        .modal-close:hover { color: var(--accent-red); }
        .modal-advice-detail { background: #f8fafc; border-radius: 16px; padding: 24px; border: 1px solid var(--border-color); }
        .modal-tip-box { background: #ffffff; border: 1px solid var(--border-color); border-radius: 12px; padding: 16px; height: 100%; transition: 0.2s; }
        .modal-tip-box:hover { border-color: var(--primary); }
        .modal-tip-label { color: var(--primary); font-weight: 700; font-size: 11px; text-transform: uppercase; margin-bottom: 8px; display: flex; align-items: center; gap: 8px; }
    </style>
</head>
<body class="premium-theme">
    <div id="pointsModal" class="modal" style="display: none; z-index: 3000;">
        <div class="modal-content-custom" style="max-width: 350px; text-align: center;">
            <span class="modal-close" onclick="hidePoints()">&times;</span>
            <div style="padding: 20px;">
                <div style="position: relative; width: 100px; height: 100px; margin: 0 auto 20px;">
                    <img id="modalUserAvatar" src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 3px solid var(--primary); box-shadow: 0 4px 12px rgba(0,128,128,0.2);">
                    <div style="position: absolute; bottom: -5px; right: -5px; width: 40px; height: 40px; background: var(--primary); border: 3px solid #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
                        <span id="modalPointsValue" style="font-size: 16px; font-weight: 800; color: #fff;">0</span>
                    </div>
                </div>
                <h3 style="font-weight: 700; margin-bottom: 5px; color: var(--text-main); font-size: 18px;">Total Points Earned</h3>
                <h2 id="modalTotalPointsLabel" style="font-size: 32px; font-weight: 800; color: var(--primary); margin-bottom: 10px;">0</h2>
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
                    <h1 style="font-weight: 800; margin: 0; font-size: 32px; color: var(--text-main);">Explore Content</h1>
                    <p style="color: var(--text-muted); margin: 0; font-weight: 600;">Find friends, view memories, and discover travel advice.</p>
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
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>
