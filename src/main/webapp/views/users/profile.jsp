<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${user.fullName} | Youth Travel Profile</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-light: #e0f2f2;
            --primary-hover: #077378;
            --accent-coral: #ff9f43;
            --bg-body: #f1f5f9;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --sidebar-width: 260px;
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            --glass-bg: rgba(255, 255, 255, 0.7);
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
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; }

        .main-container { max-width: 1200px; margin: 0 auto; position: relative; }

        /* Profile Hero Section */
        .profile-hero {
            position: relative;
            background: #ffffff;
            border-radius: 30px;
            padding: 40px;
            margin-bottom: 40px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-premium);
            overflow: hidden;
            display: flex;
            align-items: center;
            gap: 40px;
            min-height: 350px;
        }

        /* Decorative Background elements */
        .hero-bg-visual {
            position: absolute;
            right: 0;
            top: 0;
            height: 100%;
            width: 100%;
            opacity: 0.12;
            pointer-events: none;
            z-index: 0;
            background-image: 
                url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1000 300'%3E%3Cpath d='M800 100 L850 50 L900 100 Z M700 80 L740 40 L780 80 Z' fill='%23008080'/%3E%3Cpath d='M0 300 L200 150 L400 250 L600 50 L850 200 L1000 150 L1000 300 L0 300 Z' fill='%23008080'/%3E%3Ccircle cx='150' cy='50' r='1' fill='%23008080'/%3E%3Ccircle cx='250' cy='80' r='1' fill='%23008080'/%3E%3Cpath d='M400 30 L410 25 L420 30' fill='none' stroke='%23008080' stroke-width='1'/%3E%3Cpath d='M430 40 L440 35 L450 40' fill='none' stroke='%23008080' stroke-width='1'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: bottom right;
            background-size: contain;
        }

        .avatar-section {
            position: relative;
            z-index: 2;
            flex-shrink: 0;
        }

        .avatar-ring {
            width: 200px;
            height: 200px;
            padding: 8px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent-coral), #4facfe);
            box-shadow: 0 10px 30px rgba(0, 128, 128, 0.2);
            position: relative;
        }

        .avatar-main {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 6px solid #ffffff;
            object-fit: cover;
            background: #f8fafc;
        }

        .avatar-upload-btn {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 44px;
            height: 44px;
            background: var(--primary);
            color: white;
            border: 4px solid white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: var(--transition);
        }

        .avatar-upload-btn:hover { transform: scale(1.1) rotate(5deg); background: var(--primary-hover); }

        .profile-info {
            flex: 1;
            z-index: 2;
        }

        .profile-header-top {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 5px;
        }

        .profile-name {
            font-size: 32px;
            font-weight: 800;
            letter-spacing: -1px;
            margin: 0;
            color: var(--text-main);
        }

        .verified-badge {
            color: #3b82f6;
            font-size: 20px;
        }

        .profile-username {
            font-size: 16px;
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 12px;
        }

        .profile-location {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .profile-bio {
            font-size: 15px;
            color: var(--text-main);
            line-height: 1.6;
            margin-bottom: 24px;
            max-width: 500px;
        }

        .profile-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 25px;
        }

        .tag-pill {
            padding: 6px 14px;
            border-radius: 100px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .tag-green { background: #ecfdf5; color: #059669; }
        .tag-blue { background: #eff6ff; color: #2563eb; }
        .tag-orange { background: #fff7ed; color: #ea580c; }

        .profile-meta-footer {
            display: flex;
            align-items: center;
            gap: 25px;
            font-size: 13px;
            color: var(--text-muted);
        }

        .profile-meta-item { display: flex; align-items: center; gap: 8px; }
        .online-status { width: 8px; height: 8px; border-radius: 50%; background: #10b981; }

        .stats-and-actions {
            display: flex;
            flex-direction: column;
            gap: 20px;
            z-index: 2;
        }

        .stats-grid {
            display: flex;
            gap: 20px;
        }

        .stat-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            padding: 20px;
            border-radius: 20px;
            min-width: 140px;
            text-align: center;
            transition: var(--transition);
        }

        .stat-card:hover { transform: translateY(-5px); background: #ffffff; box-shadow: 0 10px 20px rgba(0,0,0,0.05); }

        .stat-value {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-main);
            display: block;
        }

        .stat-label {
            font-size: 11px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .stat-icon {
            margin-top: 10px;
            font-size: 18px;
            color: var(--primary);
            opacity: 0.6;
        }

        .hero-action-box {
            background: var(--primary);
            border-radius: 20px;
            padding: 20px;
            color: white;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 10px 20px rgba(0, 128, 128, 0.2);
        }

        .action-content h6 { margin: 0; font-weight: 700; font-size: 14px; }
        .action-content p { margin: 0; font-size: 11px; opacity: 0.8; }

        .action-badge {
            width: 44px; height: 44px;
            background: rgba(255,255,255,0.2);
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
        }

        .btn-edit-profile {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            width: fit-content;
        }

        .btn-edit-profile:hover { background: var(--primary-hover); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0, 128, 128, 0.2); }

        /* Tabs Section */
        .tabs-nav {
            display: flex;
            gap: 40px;
            border-bottom: 2px solid var(--border-color);
            margin-bottom: 30px;
            padding-left: 20px;
        }

        .tab-item {
            padding: 15px 10px;
            font-weight: 700;
            font-size: 14px;
            color: var(--text-muted);
            cursor: pointer;
            position: relative;
            transition: var(--transition);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .tab-item:hover { color: var(--primary); }
        .tab-item.active { color: var(--primary); }
        .tab-item.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--primary);
            border-radius: 3px;
            box-shadow: 0 -2px 10px rgba(0, 128, 128, 0.4);
        }

        /* Memory Cards */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 800;
            color: var(--text-main);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title::after {
            content: '';
            width: 40px;
            height: 4px;
            background: var(--accent-coral);
            border-radius: 2px;
            margin-left: 10px;
        }

        .btn-add-memory {
            background: var(--accent-coral);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
        }

        .btn-add-memory:hover { background: #f39c12; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 159, 67, 0.3); }

        .memory-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
        }

        .memory-card {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            transition: var(--transition);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        .memory-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            border-color: var(--primary);
        }

        .memory-media {
            position: relative;
            height: 240px;
            overflow: hidden;
        }

        .memory-media img, .memory-media video {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .memory-card:hover .memory-media img { transform: scale(1.05); }

        .category-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--glass-bg);
            backdrop-filter: blur(5px);
            padding: 6px 14px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 800;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 6px;
            z-index: 2;
        }

        .memory-actions-overlay {
            position: absolute;
            top: 15px;
            left: 15px;
            display: flex;
            gap: 8px;
            opacity: 0;
            transition: var(--transition);
            z-index: 2;
        }

        .memory-card:hover .memory-actions-overlay { opacity: 1; }

        .action-circle-btn {
            width: 36px; height: 36px;
            background: rgba(0,0,0,0.5);
            color: white;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer;
            transition: var(--transition);
        }

        .action-circle-btn:hover { background: var(--primary); transform: scale(1.1); }
        .action-circle-btn.delete:hover { background: var(--accent-red); }

        .memory-body { padding: 20px; }
        .memory-title { font-size: 18px; font-weight: 800; color: var(--text-main); margin-bottom: 8px; }
        .memory-desc { font-size: 14px; color: var(--text-muted); line-height: 1.5; margin-bottom: 15px; }

        .memory-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #f1f5f9;
        }

        .memory-stats { display: flex; gap: 15px; font-size: 13px; font-weight: 600; }
        .stat-icon-text { display: flex; align-items: center; gap: 5px; color: var(--text-muted); transition: 0.2s; }
        .stat-icon-text.liked { color: var(--accent-coral); }
        .memory-time { font-size: 12px; color: var(--text-muted); font-weight: 500; }

        /* Advice specific cards */
        .advice-card {
            background: white;
            border-radius: 24px;
            padding: 25px;
            border: 1px solid var(--border-color);
            transition: var(--transition);
            position: relative;
        }

        .advice-card:hover { border-color: var(--primary); transform: translateY(-5px); box-shadow: var(--shadow-premium); }
        
        .advice-icon-wrap {
            width: 50px; height: 50px;
            background: var(--primary-light);
            color: var(--primary);
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Modals */
        .unbreakable-modal { 
            display: none; position: fixed; inset: 0; 
            background: rgba(15, 23, 42, 0.6); 
            backdrop-filter: blur(8px);
            z-index: 10000; 
        }
        .unbreakable-modal-content {
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
            width: 90%; max-width: 550px; max-height: 90vh; overflow-y: auto;
            background: #ffffff; border-radius: 30px; padding: 40px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }
        .modal-close { position: absolute; top: 25px; right: 25px; font-size: 24px; cursor: pointer; color: var(--text-muted); }

        .form-label { font-size: 12px; font-weight: 800; color: var(--text-main); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; display: block; }
        .form-control { 
            background: #f8fafc; border: 1.5px solid var(--border-color); 
            border-radius: 12px; padding: 12px 18px; font-weight: 500; font-family: inherit;
        }
        .form-control:focus { border-color: var(--primary); box-shadow: 0 0 0 4px var(--primary-light); background: white; outline: none; }
        .btn-submit { background: var(--primary); color: white; border: none; padding: 14px; border-radius: 12px; font-weight: 700; width: 100%; margin-top: 20px; }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 20px !important; }
            .profile-hero { flex-direction: column; text-align: center; padding: 30px; }
            .profile-meta-footer { justify-content: center; flex-wrap: wrap; }
            .stats-grid { flex-wrap: wrap; justify-content: center; }
            .hero-bg-visual { width: 100%; opacity: 0.1; }
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="profile" />
        </jsp:include>
        
        <main class="main-content">
            <div class="main-container">
                
                <!-- Profile Hero Section -->
                <section class="profile-hero">
                    <div class="hero-bg-visual"></div>
                    
                    <div class="avatar-section">
                        <div class="avatar-ring">
                            <c:choose>
                                <c:when test="${not empty user.profilePhoto}">
                                    <img src="${user.profilePhoto}" class="avatar-main" id="mainAvatar">
                                </c:when>
                                <c:otherwise>
                                    <div class="avatar-main" id="mainAvatar" style="background: linear-gradient(135deg, #008080, #4facfe); display: flex; align-items: center; justify-content: center; font-size: 50px; color: white; font-weight: 800;">
                                        ${not empty user.fullName ? user.fullName.substring(0,1).toUpperCase() : 'U'}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="avatar-upload-btn" onclick="openModal('profilePhotoModal')">
                                <i class="fa fa-camera"></i>
                            </div>
                        </div>
                    </div>

                    <div class="profile-info">
                        <div class="profile-header-top">
                            <h1 class="profile-name">${user.fullName}</h1>
                            <i class="fa fa-check-circle verified-badge" title="Verified Traveler"></i>
                        </div>
                        <div class="profile-username">@${user.username}</div>
                        
                        <div class="profile-location">
                            <i class="fa fa-map-marker"></i> <span id="userLocation">${not empty user.city ? user.city : 'India'}</span>
                        </div>

                        <p class="profile-bio">
                            ${not empty user.profession ? user.profession : 'Wanderer at heart. Exploring new places, collecting memories and inspiring others.'}
                        </p>

                        <div class="profile-tags" id="dynamicBadges">
                            <!-- Dynamic Badges -->
                        </div>

                        <div class="profile-meta-footer">
                            <div class="profile-meta-item">
                                <i class="fa fa-calendar-o"></i> Joined <span id="joinedDateDisplay">May 2024</span>
                            </div>
                            <div class="profile-meta-item">
                                <div class="online-status"></div> <span id="lastActiveDisplay">Online now</span>
                            </div>
                        </div>
                         <br>
                        <div class="mt-4">
                            <button class="btn-edit-profile" onclick="openModal('profileModal')">
                                <i class="fa fa-pencil-square-o"></i> Edit Profile
                            </button>
                        </div>
                    </div>

                    <div class="stats-and-actions">
                        <div class="stats-grid">
                            <div class="stat-card">
                                <span class="stat-value" id="countPosts">0</span>
                                <span class="stat-label">Posts</span>
                                <div class="stat-icon"><i class="fa fa-image"></i></div>
                            </div>
                            <div class="stat-card" style="cursor:pointer" onclick="showMyPoints()">
                                <span class="stat-value" id="countPoints">0</span>
                                <span class="stat-label">Traveler Points</span>
                                <div class="stat-icon"><i class="fa fa-trophy"></i></div>
                            </div>
                        </div>

                        <div class="hero-action-box">
                            <div class="action-badge"><i class="fa fa-star"></i></div>
                            <div class="action-content">
                                <h6>Keep going, Explorer! 🌟</h6>
                                <p>You're doing great! Share more memories and earn more traveler points.</p>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Tabs Navigation -->
                <div class="tabs-nav">
                    <div class="tab-item active" data-tab="posts">POSTS</div>
                    <div class="tab-item" data-tab="advice">ADVICES</div>
                </div>

                <!-- Content Sections -->
                <div id="postsSection">
                    <div class="section-header">
                        <h2 class="section-title">My Memories</h2>
                        <button class="btn-add-memory" onclick="prepareNewPost()">
                            <i class="fa fa-plus"></i> New Memory
                        </button>
                    </div>
                    
                    <!-- Filters/Sort Placeholder -->
                  <!-- <div class="d-flex justify-content-end mb-4">
                        <div class="btn-group">
                            <button class="btn btn-white border dropdown-toggle" style="background:white; border-radius:10px; font-size:12px; font-weight:600;">
                                <i class="fa fa-sort-amount-desc me-2"></i> Recent First
                            </button>
                        </div>
                    </div>
					-->

                    <div class="memory-grid" id="postsGrid">
                        <!-- Dynamically Populated -->
                    </div>
                </div>

                <div id="adviceSection" style="display:none;">
                    <div class="section-header">
                        <h2 class="section-title">My Advices</h2>
                        <button class="btn-add-memory" onclick="prepareNewAdvice()">
                            <i class="fa fa-plus"></i> New Advice
                        </button>
                    </div>
                    <div class="memory-grid" id="adviceGrid">
                        <!-- Dynamically Populated -->
                    </div>
                </div>

            </div>
        </main>
    </div>

    <!-- Modals (Functional requirements preserved) -->
    
    <!-- Edit Profile Modal -->
    <div id="profileModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content">
            <span class="modal-close" onclick="closeModal('profileModal')">&times;</span>
            <h3 style="font-weight:800; margin-bottom:30px; letter-spacing:-0.5px;">Update Identity</h3>
            <form id="editProfileForm" enctype="multipart/form-data">
                <div class="mb-4">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" value="${user.username}" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Profession / Bio</label>
                    <textarea name="profession" class="form-control" rows="3">${user.profession}</textarea>
                </div>
                <button type="submit" class="btn-submit">Save Changes</button>
            </form>
        </div>
    </div>

    <!-- Profile Photo Modal -->
    <div id="profilePhotoModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content" style="max-width: 400px; text-align: center;">
            <span class="modal-close" onclick="closeModal('profilePhotoModal')">&times;</span>
            <h3 style="font-weight:800; margin-bottom:25px;">Profile Photo</h3>
            <form id="profilePhotoForm" onsubmit="handleProfilePhotoUpload(event)">
                <div id="photoPreview" style="width: 160px; height: 160px; border-radius: 50%; overflow: hidden; margin: 0 auto 25px; border: 4px solid var(--primary); display: none;">
                    <img id="photoPreviewImg" src="" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <div class="mb-4">
                    <label class="btn btn-outline-primary w-100 py-3" style="border-radius:12px; cursor:pointer;">
                        <i class="fa fa-cloud-upload me-2"></i> Choose Image
                        <input type="file" name="photo" id="profilePhotoInput" hidden accept="image/*" required onchange="previewPhoto(this)">
                    </label>
                </div>
                <button type="submit" class="btn-submit">Upload Photo</button>
            </form>
        </div>
    </div>

    <!-- Post Modal -->
    <div id="postModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content">
            <span class="modal-close" onclick="closeModal('postModal')">&times;</span>
            <h3 id="postModalTitle" style="font-weight:800; margin-bottom:30px;">New Travel Memory</h3>
            <form id="uploadPostForm">
                <input type="hidden" name="postId" id="postId">
                <div id="mediaPreview" style="display:none; width: 100%; aspect-ratio: 16/9; border-radius: 15px; overflow: hidden; margin-bottom: 20px; background: #f1f5f9;"></div>
                <div class="mb-4">
                    <label class="form-label">Media File</label>
                    <input type="file" name="media" id="mediaInput" class="form-control" accept="image/*,video/*" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Caption / Location</label>
                    <textarea name="caption" class="form-control" rows="3" placeholder="Tell us about this memory..."></textarea>
                </div>
                <button type="submit" id="postSubmitBtn" class="btn-submit">Share Memory</button>
            </form>
        </div>
    </div>

    <!-- Advice Modal -->
    <div id="adviceModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content" style="max-width: 600px;">
            <span class="modal-close" onclick="closeModal('adviceModal')">&times;</span>
            <h3 id="adviceModalTitle" style="font-weight:800; margin-bottom:30px;">Share Travel Wisdom</h3>
            <form id="uploadAdviceForm">
                <input type="hidden" name="adviceId" id="adviceId">
                <div class="row">
                    <div class="col-md-7 mb-4">
                        <label class="form-label">Trip Title</label>
                        <input type="text" name="title" class="form-control" placeholder="e.g., Camping in Kasol" required>
                    </div>
                    <div class="col-md-5 mb-4">
                        <label class="form-label">Category</label>
                        <select name="categories" class="form-control">
                            <option value="Solo Travel">Solo Travel</option>
                            <option value="Adventure Trip">Adventure Trip</option>
                            <option value="Budget Travel">Budget Travel</option>
                            <option value="Luxury Escape">Luxury Escape</option>
                            <option value="Food & Culture">Food & Culture</option>
                            <option value="Road Trip">Road Trip</option>
                        </select>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="form-label">General Advice</label>
                    <textarea name="content" class="form-control" rows="3" required placeholder="Main takeaways from your trip..."></textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-4"><label class="form-label">Best Time</label><input type="text" name="bestTimeToVisit" class="form-control"></div>
                    <div class="col-md-6 mb-4"><label class="form-label">Packing</label><input type="text" name="whatToPack" class="form-control"></div>
                </div>
                <button type="submit" id="adviceSubmitBtn" class="btn-submit">Post Advice</button>
            </form>
        </div>
    </div>

    <!-- Points Detail Modal -->
    <div id="pointsDetailModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content" style="max-width: 400px; text-align: center;">
            <span class="modal-close" onclick="closeModal('pointsDetailModal')">&times;</span>
            <div style="font-size: 50px; color: var(--accent-coral); margin-bottom: 20px;"><i class="fa fa-trophy"></i></div>
            <h2 id="modalTotalPointsLabel" style="font-size: 40px; font-weight: 800; color: var(--text-main);">0</h2>
            <p style="color: var(--text-muted); font-weight: 600; text-transform: uppercase; letter-spacing: 1px; font-size: 12px; margin-bottom: 30px;">Total Traveler Points</p>
            
            <div class="text-start" style="background: #f8fafc; padding: 20px; border-radius: 20px; border: 1px solid var(--border-color);">
                <div class="d-flex justify-content-between mb-3">
                    <span style="font-weight: 700; font-size: 13px;"><i class="fa fa-pencil me-2" style="color:var(--primary)"></i> Advices Posted</span>
                    <span style="color: #059669; font-weight: 800;">+50 pts</span>
                </div>
                <div class="d-flex justify-content-between mb-3">
                    <span style="font-weight: 700; font-size: 13px;"><i class="fa fa-image me-2" style="color:var(--primary)"></i> Memories Shared</span>
                    <span style="color: #059669; font-weight: 800;">+20 pts</span>
                </div>
                <div class="d-flex justify-content-between">
                    <span style="font-weight: 700; font-size: 13px;"><i class="fa fa-heart me-2" style="color:var(--accent-coral)"></i> Community Likes</span>
                    <span style="color: #059669; font-weight: 800;">+5 pts / like</span>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        const profileUsername = '${user.username}';
        const currentFullName = '${user.fullName}';
        let dataCache = null;

        function openModal(id) { document.getElementById(id).style.display = 'block'; }
        function closeModal(id) { document.getElementById(id).style.display = 'none'; }

        $(document).ready(function() {
            loadProfileData();

            // Tab Switching
            $('.tab-item').on('click', function() {
                $('.tab-item').removeClass('active');
                $(this).addClass('active');
                
                const tab = $(this).data('tab');
                if (tab === 'advice') {
                    $('#postsSection').hide();
                    $('#adviceSection').fadeIn();
                } else {
                    $('#adviceSection').hide();
                    $('#postsSection').fadeIn();
                }
            });

            // Media Preview
            $('#mediaInput').on('change', function() {
                const file = this.files[0];
                if (file) {
                    const preview = $('#mediaPreview');
                    preview.empty().show();
                    const url = URL.createObjectURL(file);
                    if (file.type.startsWith('video/')) {
                        preview.append('<video src="' + url + '" style="width:100%;height:100%;object-fit:cover;" autoplay muted loop></video>');
                    } else {
                        preview.append('<img src="' + url + '" style="width:100%;height:100%;object-fit:cover;">');
                    }
                }
            });

            // Post Submit
            $('#uploadPostForm').on('submit', function(e) {
                e.preventDefault();
                const postId = $('#postId').val();
                const url = postId ? ('/user/profile/api/posts/' + postId + '/update') : '/user/profile/api/posts/upload';
                let fd = new FormData(this);
                $.ajax({
                    url: url, type: 'POST', data: fd, processData: false, contentType: false,
                    success: function() { 
                        closeModal('postModal'); 
                        $('#uploadPostForm')[0].reset();
                        $('#mediaPreview').hide();
                        loadProfileData(); 
                    }
                });
            });

            // Advice Submit
            $('#uploadAdviceForm').on('submit', function(e) {
                e.preventDefault();
                const adviceId = $('#adviceId').val();
                const url = adviceId ? ('/user/profile/api/advices/' + adviceId + '/update') : '/user/profile/api/advices/post';
                const data = {};
                $(this).serializeArray().forEach(item => { data[item.name] = item.value; });
                $.ajax({
                    url: url, type: 'POST', contentType: 'application/json', data: JSON.stringify(data),
                    success: function() { 
                        closeModal('adviceModal'); 
                        $('#uploadAdviceForm')[0].reset();
                        loadProfileData(); 
                    }
                });
            });

            // Profile Edit
            $('#editProfileForm').on('submit', function(e) {
                e.preventDefault();
                $.ajax({
                    url: '/user/profile/api/update',
                    type: 'POST',
                    data: new FormData(this),
                    processData: false,
                    contentType: false,
                    success: function() { location.reload(); }
                });
            });
        });

        function loadProfileData() {
            $.get('/user/profile/api/data?username=' + profileUsername, function(data) {
                dataCache = data;
                $('#countPosts').text(data.postsCount || 0);
                $('#countPoints').text(data.user.travelPoints || 0);
                $('#joinedDateDisplay').text(data.joinedDateFormatted || 'May 2024');
                $('#userLocation').text(data.user.city || 'India');
                
                // Last active calculation
                if (data.lastActiveAtRaw) {
                    const status = timeAgo(data.lastActiveAtRaw);
                    if (status.includes('seconds')) {
                        $('#lastActiveDisplay').text('Online now');
                        $('.online-status').css('background', '#10b981');
                    } else {
                        $('#lastActiveDisplay').text('Last active ' + status);
                        $('.online-status').css('background', '#64748b');
                    }
                }

                // Render Badges
                const badgeContainer = $('#dynamicBadges');
                badgeContainer.empty();
                if (data.badges) {
                    data.badges.forEach((badge, idx) => {
                        const types = ['tag-green', 'tag-blue', 'tag-orange'];
                        const type = types[idx % types.length];
                        badgeContainer.append(`<span class="tag-pill ${type}">${badge}</span>`);
                    });
                }
                
                if(!data.isOwnProfile) {
                    $('.btn-edit-profile').hide();
                    $('.avatar-upload-btn').hide();
                    $('.btn-add-memory').hide();
                }
                
                renderPosts(data.posts, data.likedPostIds || []);
                renderAdvices(data.advices, data.likedAdviceIds || []);
            });
                function timeAgo(date) {
            if (!date) return 'Just now';
            const seconds = Math.floor((new Date() - new Date(date)) / 1000);
            let interval = seconds / 31536000;
            if (interval > 1) return Math.floor(interval) + " years ago";
            interval = seconds / 2592000;
            if (interval > 1) return Math.floor(interval) + " months ago";
            interval = seconds / 86400;
            if (interval > 1) return Math.floor(interval) + " days ago";
            interval = seconds / 3600;
            if (interval > 1) return Math.floor(interval) + " hours ago";
            interval = seconds / 60;
            if (interval > 1) return Math.floor(interval) + " minutes ago";
            return Math.floor(seconds) + " seconds ago";
        }

        function renderPosts(posts, likedPostIds) {
            const grid = $('#postsGrid');
            grid.empty();
            if (!posts || posts.length === 0) {
                grid.append('<div style="grid-column: 1/-1; text-align: center; color: var(--text-muted); padding: 60px;">No memories shared yet.</div>');
                return;
            }
            posts.forEach(post => {
                const isVideo = post.mediaUrl.toLowerCase().match(/\.(mp4|webm|mov)$/);
                const isLiked = likedPostIds.includes(post.id);
                
                let html = `
                    <div class="memory-card">
                        <div class="memory-media">
                            <div class="category-badge"><i class="fa fa-map-marker"></i> Adventure</div>
                            \${isVideo ? `<video src="\${post.mediaUrl}" muted loop onmouseover="this.play()" onmouseout="this.pause()"></video>` : `<img src="\${post.mediaUrl}" loading="lazy">`}
                            \${dataCache.isOwnProfile ? `
                                <div class="memory-actions-overlay">
                                    <div class="action-circle-btn" onclick="editPost(\${JSON.stringify(post).replace(/"/g, '&quot;')}, event)"><i class="fa fa-pencil"></i></div>
                                    <div class="action-circle-btn delete" onclick="deleteMemory(\${post.id}, event)"><i class="fa fa-trash"></i></div>
                                </div>
                            ` : ''}
                        </div>
                        <div class="memory-body">
                            <h4 class="memory-title">Travel Memory</h4>
                            <p class="memory-desc">\${post.caption || 'Exploring the unseen wonders of nature.'}</p>
                            <div class="memory-footer">
                                <div class="memory-stats">
                                    <div class="stat-icon-text \${isLiked ? 'liked' : ''}" onclick="toggleLike(\${post.id}, this, event)">
                                        <i class="fa \${isLiked ? 'fa-heart' : 'fa-heart-o'}"></i> \${post.likes || 0}
                                    </div>
                                    <div class="stat-icon-text"><i class="fa fa-eye"></i> \${post.views || 0}</div>
                                </div>
                                <div class="memory-time">\${timeAgo(post.createdAt)}</div>
                            </div>
                        </div>
                    </div>
                `;
                grid.append(html);
            });
        }

        function renderAdvices(advices, likedAdviceIds) {
            const grid = $('#adviceGrid');
            grid.empty();
            if (!advices || advices.length === 0) {
                grid.append('<div style="grid-column: 1/-1; text-align: center; color: var(--text-muted); padding: 60px;">No advices shared yet.</div>');
                return;
            }
            advices.forEach(adv => {
                const isLiked = likedAdviceIds.includes(adv.id);
                let html = `
                    <div class="advice-card">
                        <div class="category-badge" style="background:#fff7ed; color:#ea580c;"><i class="fa fa-bolt"></i> \${adv.categories || 'Tips'}</div>
                        <div class="advice-icon-wrap"><i class="fa fa-lightbulb-o"></i></div>
                        <h4 class="memory-title">\${adv.title}</h4>
                        <p class="memory-desc">\${adv.content}</p>
                        \${adv.bestTimeToVisit ? `<div style="font-size:12px; margin-bottom:10px; color:var(--text-muted)"><strong>Best Time:</strong> \${adv.bestTimeToVisit}</div>` : ''}
                        <div class="memory-footer">
                            <div class="memory-stats">
                                <div class="stat-icon-text \${isLiked ? 'liked' : ''}" onclick="toggleAdviceLike(\${adv.id}, this, event)">
                                    <i class="fa \${isLiked ? 'fa-heart' : 'fa-heart-o'}"></i> \${adv.likes || 0}
                                </div>
                            </div>
                            <div class="d-flex gap-3 align-items-center">
                                <span class="memory-time">\${timeAgo(adv.createdAt)}</span>
                                \${dataCache.isOwnProfile ? `
                                    <i class="fa fa-pencil text-muted" style="cursor:pointer" onclick="editAdvice(\${JSON.stringify(adv).replace(/"/g, '&quot;')})"></i>
                                    <i class="fa fa-trash text-danger" style="cursor:pointer" onclick="deleteAdvice(\${adv.id})"></i>
                                ` : ''}
                            </div>
                        </div>
                    </div>
                `;
                grid.append(html);
            });
        }  }

        function toggleLike(postId, el, e) {
            e.stopPropagation();
            const icon = $(el).find('i');
            let count = parseInt($(el).text());
            if ($(el).hasClass('liked')) {
                $(el).removeClass('liked'); icon.removeClass('fa-heart').addClass('fa-heart-o');
                $(el).html('<i class="fa fa-heart-o"></i> ' + (count - 1));
            } else {
                $(el).addClass('liked'); icon.removeClass('fa-heart-o').addClass('fa-heart');
                $(el).html('<i class="fa fa-heart"></i> ' + (count + 1));
            }
            $.post('/user/profile/api/posts/' + postId + '/like');
        }

        function toggleAdviceLike(id, el, e) {
            e.stopPropagation();
            const icon = $(el).find('i');
            let count = parseInt($(el).text());
            if ($(el).hasClass('liked')) {
                $(el).removeClass('liked'); icon.removeClass('fa-heart').addClass('fa-heart-o');
                $(el).html('<i class="fa fa-heart-o"></i> ' + (count - 1));
            } else {
                $(el).addClass('liked'); icon.removeClass('fa-heart-o').addClass('fa-heart');
                $(el).html('<i class="fa fa-heart"></i> ' + (count + 1));
            }
            $.post('/user/profile/api/advices/' + id + '/like');
        }

        function deleteMemory(id, e) {
            e.stopPropagation();
            if(confirm('Delete memory?')) {
                $.ajax({ url: '/user/profile/api/posts/' + id, type: 'DELETE', success: loadProfileData });
            }
        }

        function deleteAdvice(id) {
            if(confirm('Delete advice?')) {
                $.ajax({ url: '/user/profile/api/advices/' + id, type: 'DELETE', success: loadProfileData });
            }
        }

        function editPost(post, e) {
            e.stopPropagation();
            $('#postId').val(post.id);
            $('#postModalTitle').text('Refine Travel Memory');
            $('#postSubmitBtn').text('Update Memory');
            $('textarea[name="caption"]').val(post.caption);
            $('#mediaInput').prop('required', false);
            openModal('postModal');
        }

        function editAdvice(adv) {
            $('#adviceId').val(adv.id);
            $('input[name="title"]').val(adv.title);
            $('select[name="categories"]').val(adv.categories);
            $('textarea[name="content"]').val(adv.content);
            $('input[name="bestTimeToVisit"]').val(adv.bestTimeToVisit);
            openModal('adviceModal');
        }

        function previewPhoto(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = e => { $('#photoPreviewImg').attr('src', e.target.result); $('#photoPreview').show(); }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function handleProfilePhotoUpload(e) {
            e.preventDefault();
            $.ajax({
                url: '/user/profile/api/upload-photo', type: 'POST', data: new FormData(e.target),
                processData: false, contentType: false,
                success: function() { closeModal('profilePhotoModal'); loadProfileData(); location.reload(); }
            });
        }

        function prepareNewPost() {
            $('#postId').val('');
            $('#uploadPostForm')[0].reset();
            $('#mediaInput').prop('required', true);
            $('#mediaPreview').hide();
            openModal('postModal');
        }

        function prepareNewAdvice() {
            $('#adviceId').val('');
            $('#uploadAdviceForm')[0].reset();
            openModal('adviceModal');
        }

        function showMyPoints() {
            $('#modalTotalPointsLabel').text($('#countPoints').text());
            openModal('pointsDetailModal');
        }
    </script>
</body>
</html>
