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
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .sidebar { width: 240px; background: #161c28; padding-top: 80px; position: fixed; height: 100vh; border-right: 1px solid rgba(255,255,255,0.05); z-index: 100; }
        .nav-menu { list-style: none; padding: 0; margin: 0; }
        .nav-item a { display: flex; align-items: center; padding: 12px 25px; color: rgba(255,255,255,0.6); text-decoration: none; font-weight: 500; transition: var(--transition); gap: 15px; font-size: 15px; }
        .nav-item.active a { background: var(--primary-blue); color: #fff; border-radius: 0 25px 25px 0; margin-right: 15px; }
        .nav-item a:hover:not(.active) { color: #fff; background: rgba(240, 76, 38, 0.1); }
        .main-content { flex: 1; margin-left: 240px; padding: 100px 30px 40px; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: #161c28; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .search-container { position: relative; width: 400px; }
        .search-container input { width: 100%; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 12px 20px 12px 45px; border-radius: 25px; color: #fff; outline: none; transition: var(--transition); }
        .search-container input:focus { border-color: var(--primary-blue); background: rgba(255,255,255,0.08); }
        .search-container i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: var(--text-muted); }
        .nav-tabs { display: flex; gap: 30px; border-bottom: 1px solid rgba(255,255,255,0.1); margin-bottom: 30px; }
        .nav-tabs button { background: none; border: none; color: var(--text-muted); padding: 10px 0; font-size: 16px; font-weight: 600; cursor: pointer; border-bottom: 2px solid transparent; transition: var(--transition); text-transform: uppercase; letter-spacing: 1px; }
        .nav-tabs button.active { color: #fff; border-bottom-color: var(--primary-blue); }
        .tab-pane { display: none; }
        .tab-pane.active { display: block; }
        
        .user-card { background: #161c28; padding: 25px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.05); text-align: center; transition: var(--transition); }
        .user-card:hover { border-color: var(--primary-blue); transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.5); }
        .user-avatar { width: 90px; height: 90px; border-radius: 50%; object-fit: cover; margin-bottom: 15px; border: 3px solid rgba(255,255,255,0.1); }
        .user-name { font-size: 18px; font-weight: 700; margin: 0 0 5px; color: #fff; }
        .user-username { font-size: 14px; color: var(--primary-blue); margin-bottom: 15px; }
        .btn-view-profile { background: rgba(255,255,255,0.05); color: #fff; border: 1px solid rgba(255,255,255,0.1); padding: 8px 20px; border-radius: 20px; font-size: 13px; font-weight: 600; transition: var(--transition); text-decoration: none; display: inline-block; }
        .btn-view-profile:hover { background: var(--primary-blue); border-color: var(--primary-blue); color: #fff; text-decoration: none; }
        .users-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; }
        
        .posts-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 15px; }
        .post-card { position: relative; border-radius: 8px; overflow: hidden; border: 1px solid rgba(255,255,255,0.05); background: #161c28; display: flex; flex-direction: column; }
        .post-card img, .post-card video { width: 100%; aspect-ratio: 1; object-fit: cover; }
        .post-details { padding: 12px; display: flex; flex-direction: column; gap: 8px; }
        .post-caption { font-size: 13px; color: rgba(255,255,255,0.8); }
        .post-stats { font-size: 12px; color: var(--text-muted); display: flex; gap: 15px; }
        .post-author { position: absolute; top: 10px; left: 10px; background: rgba(0,0,0,0.6); padding: 4px 10px; border-radius: 20px; font-size: 12px; color: #fff; }
        
        .advices-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .advice-card { background: #161c28; padding: 20px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.05); }
        .advice-card h4 { margin: 0 0 10px; font-size: 18px; color: #fff; }
        .advice-card p { font-size: 14px; color: var(--text-muted); line-height: 1.5; margin: 0; }
        .advice-author { display: flex; align-items: center; gap: 10px; margin-top: 15px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 15px; }
        .advice-author img { width: 30px; height: 30px; border-radius: 50%; object-fit: cover; }
        .advice-author span { font-size: 13px; color: #fff; }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-logo"><a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <div style="display: flex; align-items: center; gap: 15px;">
                <span style="font-weight: 700;">Hi, ${user.name}</span>
                <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=f04c26&color=fff" />
                <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;">
            </div>
        </div>
    </header>
    <div class="wrapper">
        <aside class="sidebar">
            <ul class="nav-menu">
                <li class="nav-item"><a href="<c:url value='/user/dashboard'/>"><i class="fa fa-th-large"></i> Dashboard</a></li>
                <li class="nav-item active"><a href="<c:url value='/user/explore'/>"><i class="fa fa-users"></i> Explore Users</a></li>
                <li class="nav-item"><a href="<c:url value='/user/my-bookings'/>"><i class="fa fa-calendar-check-o"></i> My Bookings</a></li>
                <li class="nav-item"><a href="<c:url value='/user/saved-trips'/>"><i class="fa fa-heart-o"></i> Saved Trips</a></li>
                <li class="nav-item"><a href="<c:url value='/user/my-reviews'/>"><i class="fa fa-star-o"></i> My Reviews</a></li>
                <li class="nav-item"><a href="<c:url value='/user/payments'/>"><i class="fa fa-credit-card"></i> Payments</a></li>
                <li class="nav-item"><a href="<c:url value='/user/messages'/>"><i class="fa fa-envelope-o"></i> Messages</a></li>
                <li style="margin: 20px 0; border-top: 1px solid rgba(255,255,255,0.1);"></li>
                <li class="nav-item"><a href="<c:url value='/profile'/>"><i class="fa fa-cog"></i> Profile Settings</a></li>
                <li class="nav-item"><a href="<c:url value='/user/logout'/>"><i class="fa fa-sign-out"></i> Logout</a></li>
            </ul>
        </aside>
        <main class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 20px;">
                <div>
                    <h1 style="font-weight: 800; margin: 0; font-size: 32px;">Explore Content</h1>
                    <p style="color: var(--text-muted); margin: 0;">Find friends, view memories, and discover travel advice.</p>
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
                                    <a href="<c:url value='/profile?username=${not empty u.username ? u.username : u.fullName}'/>" class="btn-view-profile">View Profile</a>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1/-1; text-align: center; padding: 80px 20px; background: #161c28; border-radius: 20px; border: 1px dotted rgba(255,255,255,0.1);">
                                <i class="fa fa-users" style="font-size: 50px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                                <h3 style="font-weight: 700;">No users found</h3>
                                <p style="color: var(--text-muted);">Try a different search term.</p>
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
                                <div class="advice-card" onclick="window.location.href='<c:url value='/profile?username=${not empty a.user.username ? a.user.username : a.user.fullName}'/>'" style="cursor: pointer;">
                                    <h4>${a.title}</h4>
                                    <p>${a.content}</p>
                                    <div style="margin-top: 10px; font-size: 12px; color: var(--text-muted);">
                                        <span><i class="fa fa-heart"></i> ${a.likes} likes</span>
                                    </div>
                                    <div class="advice-author">
                                        <img src="${not empty a.user.profilePhoto ? a.user.profilePhoto : 'https://ui-avatars.com/api/?name='.concat(a.user.fullName).concat('&background=random')}">
                                        <span>Shared by <strong>${a.user.fullName}</strong></span>
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
    
    <script>
        function switchTab(tabId) {
            document.querySelectorAll('.nav-tabs button').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
            
            event.target.classList.add('active');
            document.getElementById('tab-' + tabId).classList.add('active');
        }
    </script>
</body>
</html>
