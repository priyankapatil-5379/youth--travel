<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${user.name} | Premium Profile</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { 
            --bg-gradient: linear-gradient(135deg, #2c3e50 0%, #000000 100%);
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
            --accent-blue: #0095f6;
            --accent-orange: #f09433;
            --text-main: #ffffff;
            --text-dim: #b0b0b0;
        }

        /* Force Modals to Front & Premium Styling */
        .modal { z-index: 10000 !important; }
        .modal-backdrop { z-index: 9999 !important; background-color: rgba(0,0,0,0.85) !important; }
        .modal-content { 
            background: #1a2a2a !important; 
            border: 1px solid var(--glass-border) !important;
            border-radius: 20px !important;
            box-shadow: 0 25px 50px rgba(0,0,0,0.8) !important;
            color: #fff !important;
        }
        .modal-header { border-bottom: 1px solid var(--glass-border) !important; padding: 20px 25px !important; }
        .modal-body { padding: 25px !important; }
        .modal-title { font-weight: 700 !important; font-size: 22px !important; }
        .form-label { font-weight: 600 !important; color: #ff9f43 !important; margin-bottom: 8px !important; font-size: 14px !important; text-transform: uppercase; }
        .form-control { 
            background: rgba(255,255,255,0.05) !important; 
            border: 1px solid var(--glass-border) !important; 
            color: #fff !important; 
            border-radius: 12px !important;
            padding: 12px !important;
        }
        .form-control:focus { background: rgba(255,255,255,0.1) !important; border-color: #ff9f43 !important; box-shadow: 0 0 10px rgba(255,159,67,0.2) !important; }
        .btn-primary { background: #ff9f43 !important; border: none !important; padding: 12px !important; border-radius: 12px !important; font-weight: 700 !important; transition: 0.3s !important; }
        .btn-primary:hover { transform: translateY(-2px) !important; box-shadow: 0 8px 20px rgba(255,159,67,0.4) !important; }

        body { 
            font-family: 'Dosis', sans-serif; 
            background: #1a2a2a; /* Deep dark teal base */
            background: linear-gradient(180deg, #243b3b 0%, #121212 100%);
            color: var(--text-main);
            margin: 0;
            min-height: 100vh;
            padding-bottom: 80px;
        }

        .main-container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }

        /* Premium Header */
        .profile-header { display: flex; align-items: flex-start; gap: 80px; margin-bottom: 60px; padding: 20px; }
        
        .avatar-column { display: flex; flex-direction: column; align-items: center; width: 180px; }
        .avatar-wrapper { 
            position: relative; 
            width: 180px; height: 180px; 
            padding: 5px; 
            background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888); 
            border-radius: 50%;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        .avatar-img { width: 100%; height: 100%; border-radius: 50%; border: 4px solid #1a2a2a; object-fit: cover; }
        .plus-btn { 
            position: absolute; bottom: 10px; right: 10px; 
            width: 36px; height: 36px; 
            background: var(--accent-blue); 
            border: 3px solid #1a2a2a; 
            border-radius: 50%; 
            display: flex; align-items: center; justify-content: center; 
            color: white; font-size: 16px; cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }

        .user-meta-below { margin-top: 15px; text-align: center; }
        .display-name { font-size: 18px; font-weight: 600; margin-bottom: 10px; }
        .btn-edit-premium { 
            background: rgba(255,255,255,0.1); 
            border: 1px solid var(--glass-border); 
            color: white; 
            padding: 8px 25px; 
            border-radius: 10px; 
            font-size: 14px; 
            font-weight: 600;
            backdrop-filter: blur(10px);
            transition: 0.3s;
        }
        .btn-edit-premium:hover { background: rgba(255,255,255,0.2); transform: translateY(-2px); }

        .info-column { flex: 1; padding-top: 20px; }
        .username-row { display: flex; align-items: center; gap: 10px; margin-bottom: 25px; font-size: 24px; color: var(--text-dim); }
        .stats-row { display: flex; gap: 40px; margin-bottom: 30px; }
        .stat-item { display: flex; align-items: baseline; gap: 8px; }
        .stat-num { font-size: 24px; font-weight: 700; color: #ff9f43; }
        .stat-label { font-size: 18px; color: var(--text-main); }

        .icon-metrics { display: flex; gap: 20px; color: var(--text-dim); font-size: 18px; }
        .metric-item { display: flex; align-items: center; gap: 8px; background: var(--glass-bg); padding: 5px 15px; border-radius: 20px; border: 1px solid var(--glass-border); }

        /* Content Divider */
        .content-divider { border-top: 1px solid var(--glass-border); margin: 40px 0; display: flex; justify-content: center; position: relative; }
        .tabs-header { position: absolute; top: -15px; display: flex; gap: 100px; background: transparent; padding: 0 40px; }
        .tab-trigger { font-size: 14px; font-weight: 700; color: var(--text-dim); cursor: pointer; display: flex; align-items: center; gap: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .tab-trigger.active { color: white; }

        /* Tab Content Layout */
        .content-grid { display: block; min-height: 400px; }
        
        #postsSection, #adviceSection { width: 100%; transition: 0.3s; }
        #adviceSection { display: none; } /* Hidden by default */
        
        /* Left: Posts */
        .posts-side-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
        .post-card { position: relative; border-radius: 8px; overflow: hidden; cursor: pointer; border: 1px solid var(--glass-border); background: var(--glass-bg); display: flex; flex-direction: column; transition: 0.3s; }
        .post-card:hover { border-color: #ff9f43; background: rgba(255,255,255,0.08); transform: translateY(-3px); }
        .post-media-container { position: relative; width: 100%; aspect-ratio: 1/1; overflow: hidden; }
        .post-media-container img, .post-media-container video { width: 100%; height: 100%; object-fit: cover; transition: 0.5s; }
        .post-card:hover img { transform: scale(1.1); }
        .post-details { padding: 12px; display: flex; flex-direction: column; gap: 8px; border-top: 1px solid rgba(255,255,255,0.05); }
        .post-caption { font-size: 13px; color: rgba(255,255,255,0.8); line-height: 1.4; }
        .post-stats { font-size: 12px; color: var(--text-muted); display: flex; gap: 15px; }
        .post-like-btn { position: absolute; bottom: 10px; right: 10px; font-size: 22px; color: white; cursor: pointer; z-index: 10; text-shadow: 0 2px 8px rgba(0,0,0,0.8); transition: 0.3s; }
        .post-like-btn.liked { color: #ff3b30; text-shadow: 0 2px 8px rgba(255, 59, 48, 0.4); }
        .post-like-btn:hover { transform: scale(1.2); }

        /* Right: Advices */
        .advices-side-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; }
        .advice-premium-card { 
            background: var(--glass-bg); 
            border: 1px solid var(--glass-border); 
            border-radius: 15px; 
            padding: 20px; 
            backdrop-filter: blur(15px);
            display: flex; flex-direction: column; gap: 10px;
            transition: 0.3s;
        }
        .advice-premium-card:hover { background: rgba(255,255,255,0.08); transform: translateY(-5px); }
        .advice-icon-box { width: 40px; height: 40px; background: rgba(255,255,255,0.1); border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 20px; color: #ff9f43; }
        .advice-header { display: flex; align-items: center; gap: 12px; }
        .advice-title { font-size: 16px; font-weight: 700; margin: 0; }
        .advice-body { font-size: 13px; color: var(--text-dim); line-height: 1.4; margin: 0; }

        /* Bottom Nav */
        .bottom-nav { 
            position: fixed; bottom: 0; left: 0; width: 100%; height: 70px; 
            background: rgba(18, 18, 18, 0.8); 
            backdrop-filter: blur(20px);
            border-top: 1px solid var(--glass-border);
            display: flex; align-items: center; justify-content: space-around;
            padding: 0 20px; z-index: 1000;
        }
        .nav-item { font-size: 24px; color: var(--text-dim); cursor: pointer; transition: 0.3s; }
        .nav-item:hover { color: white; transform: scale(1.2); }
        .nav-avatar-small { width: 30px; height: 30px; border-radius: 50%; border: 1px solid white; object-fit: cover; }

        /* Nuclear Option: Unbreakable Modal Styling */
        .unbreakable-modal { 
            display: none; 
            position: fixed; 
            top: 0; left: 0; 
            width: 100%; height: 100%; 
            background: rgba(0,0,0,0.85); 
            z-index: 20000; 
            backdrop-filter: blur(8px);
        }
        .unbreakable-modal-content {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            width: 90%; max-width: 450px;
            max-height: 90vh;
            overflow-y: auto;
            background: #1a2a2a;
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            color: white;
        }
        .modal-close-btn { position: absolute; top: 15px; right: 20px; font-size: 24px; cursor: pointer; color: #7e8c9a; }
        .modal-close-btn:hover { color: white; }

        /* Fix Select Visibility */
        select.form-control { 
            background-color: #243b3b !important; 
            color: white !important; 
            appearance: auto !important;
        }
        select.form-control option {
            background-color: #1a2a2a !important;
            color: white !important;
            padding: 10px !important;
        }

        @media (max-width: 992px) {
            .content-grid { grid-template-columns: 1fr; }
            .profile-header { flex-direction: column; align-items: center; text-align: center; gap: 30px; }
            .info-column { display: flex; flex-direction: column; align-items: center; }
        }
    </style>
    <script>
        function openModal(id) { document.getElementById(id).style.display = 'block'; }
        function closeModal(id) { document.getElementById(id).style.display = 'none'; }
    </script>
</head>
<body>

    <!-- Nuclear Option Modals (Pure JS/CSS - 100% Reliable) -->
    <div id="adviceModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content">
            <span class="modal-close-btn" onclick="closeModal('adviceModal')">&times;</span>
            <h3 style="margin-top: 0; margin-bottom: 25px; font-weight: 700;">Share Travel Wisdom</h3>
            <form id="uploadAdviceForm">
                <div class="form-group">
                    <label class="form-label">Trip Title</label>
                    <input type="text" name="title" class="form-control" placeholder="e.g., Hiking in Manali" required>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Trip Category</label>
                    <select name="categories" class="form-control">
                        <option value="Solo Travel">Solo Travel</option>
                        <option value="Adventure Trip">Adventure Trip</option>
                        <option value="Budget Travel">Budget Travel</option>
                        <option value="Luxury Escape">Luxury Escape</option>
                        <option value="Family Vacation">Family Vacation</option>
                        <option value="Food & Culture">Food & Culture</option>
                        <option value="Road Trip">Road Trip</option>
                    </select>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Your Review / Experience</label>
                    <textarea name="content" class="form-control" rows="4" placeholder="Share your experience and tips..." required></textarea>
                </div>
                <button type="submit" class="btn btn-primary" style="margin-top: 25px; width: 100%; font-weight: 700; background: #ff9f43; border: none; padding: 12px; border-radius: 12px;">Post Advice</button>
            </form>
        </div>
    </div>

    <div id="postModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content">
            <span class="modal-close-btn" onclick="closeModal('postModal')">&times;</span>
            <h3 style="margin-top: 0; margin-bottom: 25px; font-weight: 700;">New Travel Memory</h3>
            <form id="uploadPostForm">
                <div class="form-group">
                    <div id="mediaPreview" style="display:none; width: 100%; aspect-ratio: 1; border-radius: 10px; overflow: hidden; margin-bottom: 15px; background: #000;"></div>
                    <input type="file" name="media" id="mediaInput" class="form-control" accept="image/*,video/*" required>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Where did this happen?</label>
                    <textarea name="caption" class="form-control" rows="3" placeholder="Describe your memory..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary" style="margin-top: 25px; width: 100%; font-weight: 700; background: #ff9f43; border: none; padding: 12px; border-radius: 12px;">Post to Journey</button>
            </form>
        </div>
    </div>

    <div id="profileModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content">
            <span class="modal-close-btn" onclick="closeModal('profileModal')">&times;</span>
            <h3 style="margin-top: 0; margin-bottom: 25px; font-weight: 700;">Update Identity</h3>
            <form id="editProfileForm" enctype="multipart/form-data">
                <div class="form-group" style="margin-bottom: 15px;">
                    <label class="form-label">Profile Photo (Optional)</label>
                    <input type="file" name="profilePhoto" class="form-control" accept="image/*">
                </div>
                <div class="form-group" style="margin-bottom: 15px;">
                    <label class="form-label">Cover Photo (Optional)</label>
                    <input type="file" name="coverPhoto" class="form-control" accept="image/*">
                </div>
                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-control" value="${user.fullName}">
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" value="${user.username}">
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Profession / Bio</label>
                    <input type="text" name="profession" class="form-control" value="${user.profession}">
                </div>
                <button type="submit" class="btn btn-primary" style="margin-top: 25px; width: 100%; font-weight: 700; background: #ff9f43; border: none; padding: 12px; border-radius: 12px;">Save Profile</button>
            </form>
        </div>
    </div>

    <main class="main-container">
        <header class="profile-header">
            <c:choose>
                <c:when test="${not empty user.coverPhoto}">
                    <div class="profile-cover" style="background-image: url('${user.coverPhoto}');"></div>
                </c:when>
                <c:otherwise>
                    <div class="profile-cover"></div>
                </c:otherwise>
            </c:choose>
            <div class="avatar-column">
                <div class="avatar-wrapper">
                    <c:choose>
                        <c:when test="${not empty user.profilePhoto}">
                            <img src="${user.profilePhoto}" class="avatar-img" id="mainAvatar">
                        </c:when>
                        <c:otherwise>
                            <div class="avatar-img" id="mainAvatar" style="background: linear-gradient(135deg, #f04c26, #ff9f43); display: flex; align-items: center; justify-content: center; font-size: 45px; color: white; font-weight: 800; border-radius: 50%;">
                                ${not empty user.fullName ? user.fullName.substring(0,1).toUpperCase() : 'U'}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="plus-btn" onclick="openModal('postModal')"><i class="fa fa-camera"></i></div>
                </div>
                <div class="user-meta-below">
                    <div class="display-name">${user.fullName}</div>
                    <button class="btn-edit-premium" onclick="openModal('profileModal')">Edit profile</button>
                </div>
            </div>

            <div class="info-column">
                <div class="username-row">
                    <span id="displayUsername">${user.username}</span>
                </div>
                
                <div class="stats-row">
                    <div class="stat-item">
                        <span class="stat-num" id="countPosts">0</span>
                        <span class="stat-label">Posts</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-num" id="countFollowers">0</span>
                        <span class="stat-label">Followers</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-num" id="countFollowing">0</span>
                        <span class="stat-label">Following</span>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dynamic Tabs Divider -->
        <div class="content-divider">
            <div class="tabs-header">
                <div class="tab-trigger active"><i class="fa fa-th-large"></i> POSTS</div>
                <div class="tab-trigger"><i class="fa fa-bullhorn"></i> ADVICES</div>
            </div>
        </div>

        <!-- Split Grid Content -->
        <section class="content-grid">
            <!-- Left: Media Posts -->
            <div id="postsSection">
                <div class="posts-side-grid" id="postsGrid">
                    <!-- Posts dynamic -->
                </div>
            </div>

            <!-- Right: Advice Cards -->
            <div id="adviceSection">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0" style="color: var(--text-dim); text-transform: uppercase; font-size: 14px; letter-spacing: 1px;">My Advices</h5>
                    <button class="btn btn-sm" style="background: white; color: black; border-radius: 10px; font-weight: 600; font-size: 12px; padding: 6px 12px; border: none;" onclick="openModal('adviceModal')">
                        <i class="fa fa-plus"></i> New Advice
                    </button>
                </div>
                <div class="advices-side-grid" id="adviceGrid">
                    <!-- Advices dynamic -->
                </div>
            </div>
        </section>
    </main>

    <!-- Bottom Nav -->
    <nav class="bottom-nav">
        <div class="nav-item" onclick="window.location.href='/user/dashboard'"><i class="fa fa-home"></i></div>
        <div class="nav-item" onclick="openModal('postModal')"><i class="fa fa-plus-square"></i></div>
        <div class="nav-item" onclick="window.location.href='/user/profile'"><i class="fa fa-user-circle"></i></div>
    </nav>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
        const currentUsername = '${user.username}';

        $(document).ready(function() {
            loadProfileData();

            $('.tab-trigger').on('click', function() {
                $('.tab-trigger').removeClass('active');
                $(this).addClass('active');
                
                const isAdviceTab = $(this).text().includes('ADVICES');
                if (isAdviceTab) {
                    $('#postsSection').hide();
                    $('#adviceSection').fadeIn();
                } else {
                    $('#adviceSection').hide();
                    $('#postsSection').fadeIn();
                }
            });

            $('#mediaInput').on('change', function() {
                const file = this.files[0];
                if (file) {
                    const preview = $('#mediaPreview');
                    preview.empty().show();
                    if (file.type.startsWith('video/')) {
                        preview.append('<video src="' + URL.createObjectURL(file) + '" style="width:100%;height:100%;object-fit:cover;" autoplay muted loop></video>');
                    } else {
                        preview.append('<img src="' + URL.createObjectURL(file) + '" style="width:100%;height:100%;object-fit:cover;">');
                    }
                }
            });

            $('#uploadPostForm').on('submit', function(e) {
                e.preventDefault();
                let fd = new FormData(this);
                $.ajax({
                    url: '/user/profile/api/posts/upload',
                    type: 'POST',
                    data: fd,
                    processData: false,
                    contentType: false,
                    success: function() { 
                        closeModal('postModal'); 
                        $('#uploadPostForm')[0].reset();
                        $('#mediaPreview').hide();
                        loadProfileData(); 
                    },
                    error: function(err) {
                        alert('Upload failed: ' + err.responseText);
                    }
                });
            });

            $('#uploadAdviceForm').on('submit', function(e) {
                e.preventDefault();
                $.ajax({
                    url: '/user/profile/api/advices/post',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        title: $('#uploadAdviceForm input[name="title"]').val(),
                        categories: $('#uploadAdviceForm select[name="categories"]').val(),
                        content: $('#uploadAdviceForm textarea[name="content"]').val()
                    }),
                    success: function() { 
                        closeModal('adviceModal'); 
                        $('#uploadAdviceForm')[0].reset();
                        loadProfileData(); 
                    }
                });
            });

            $('#editProfileForm').on('submit', function(e) {
                e.preventDefault();
                const formData = new FormData(this);
                const btn = $(this).find('button[type="submit"]');
                btn.text('Saving...').prop('disabled', true);
                
                $.ajax({
                    url: '/user/profile/api/update',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function() { 
                        closeModal('profileModal');
                        location.reload(); 
                    },
                    error: function() {
                        alert('Error updating profile');
                        btn.text('Save Profile').prop('disabled', false);
                    }
                });
            });
        });

        const urlParams = new URLSearchParams(window.location.search);
        const profileUsername = urlParams.get('username') || '${user.username}';

        function loadProfileData() {
            $.get('/user/profile/api/data?username=' + profileUsername, function(data) {
                $('#countPosts').text(data.postsCount || 0);
                $('#countFollowers').text(data.followersCount || 0);
                $('#countFollowing').text(data.followingCount || 0);
                $('#displayUsername').text(data.user.username || 'user');
                
                if(!data.isOwnProfile) {
                    $('.btn-edit-premium').hide();
                    $('.plus-btn').hide();
                    $('#adviceSection button').hide();
                }
                
                renderPosts(data.posts, data.likedPostIds || []);
                renderAdvices(data.advices, data.likedAdviceIds || []);
            });
        }

        function renderPosts(posts, likedPostIds) {
            const grid = $('#postsGrid');
            grid.empty();
            if (!posts || posts.length === 0) {
                grid.append('<div style="grid-column: 1/-1; text-align: center; color: var(--text-dim); padding: 40px;">No memories yet.</div>');
                return;
            }
            posts.forEach(post => {
                const isVideo = post.mediaUrl.toLowerCase().match(/\.(mp4|webm|mov)$/);
                let html = '<div class="post-card">';
                html += '<div class="post-media-container" style="position: relative;">';
                if (isVideo) {
                    html += '<video src="' + post.mediaUrl + '" muted loop onmouseover="this.play()" onmouseout="this.pause()"></video>';
                } else {
                    html += '<img src="' + post.mediaUrl + '" loading="lazy">';
                }
                
                let isLiked = likedPostIds.includes(post.id);
                let heartClass = isLiked ? 'fa-heart liked' : 'fa-heart';
                
                html += '<i class="fa ' + heartClass + ' post-like-btn" onclick="toggleLike(' + post.id + ', this, event)"></i>';
                html += '</div>';
                
                html += '<div class="post-details">';
                if (post.caption) {
                    html += '<div class="post-caption">' + post.caption + '</div>';
                }
                
                html += '<div class="post-stats">' +
                        '<span class="post-likes-count"><i class="fa fa-heart"></i> ' + post.likes + '</span>' +
                        '<span><i class="fa fa-eye"></i> ' + post.views + '</span>' +
                        '</div>';
                        
                html += '</div>'; // end post-details
                
                html += '</div>';
                grid.append(html);
            });
        }

        function toggleLike(postId, element, event) {
            event.stopPropagation();
            const icon = $(element);
            const countSpan = icon.closest('.post-card').find('.post-likes-count');
            let currentCount = parseInt(countSpan.text().trim());
            
            if (icon.hasClass('liked')) {
                icon.removeClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount - 1));
            } else {
                icon.addClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount + 1));
            }
            $.post('/user/profile/api/posts/' + postId + '/like');
        }

        function renderAdvices(advices, likedAdviceIds) {
            const grid = $('#adviceGrid');
            grid.empty();
            
            if (!advices || advices.length === 0) {
                grid.append('<div style="grid-column: 1/-1; text-align: center; color: var(--text-dim); padding: 40px; background: var(--glass-bg); border-radius: 15px;">No advices yet.</div>');
                return;
            }

            advices.forEach(adv => {
                let iconClass = 'fa-lightbulb-o';
                if (adv.categories === 'Solo Travel') iconClass = 'fa-user';
                else if (adv.categories === 'Adventure Trip') iconClass = 'fa-mountain';
                else if (adv.categories === 'Budget Travel') iconClass = 'fa-money';
                else if (adv.categories === 'Luxury Escape') iconClass = 'fa-diamond';
                else if (adv.categories === 'Family Vacation') iconClass = 'fa-users';
                else if (adv.categories === 'Food & Culture') iconClass = 'fa-cutlery';
                else if (adv.categories === 'Road Trip') iconClass = 'fa-car';

                let isLiked = likedAdviceIds.includes(adv.id);
                let heartClass = isLiked ? 'fa-heart liked' : 'fa-heart';

                let html = '<div class="advice-premium-card" style="position: relative;">' +
                    '<i class="fa ' + heartClass + ' post-like-btn" style="bottom: auto; top: 15px; right: 15px; font-size: 18px;" onclick="toggleAdviceLike(' + adv.id + ', this, event)"></i>' +
                    '<div class="advice-header">' +
                    '<div class="advice-icon-box"><i class="fa ' + iconClass + '"></i></div>' +
                    '<div class="ms-3">' +
                    '<h4 class="advice-title">' + adv.title + '</h4>' +
                    '<span style="font-size: 10px; color: #ff9f43; text-transform: uppercase;">' + (adv.categories || 'General') + '</span>' +
                    '</div>' +
                    '</div>' +
                    '<p class="advice-body">' + adv.content + '</p>' +
                    '<div style="margin-top: 10px; font-size: 12px; color: var(--text-muted);">' +
                    '<span class="advice-likes-count"><i class="fa fa-heart"></i> ' + adv.likes + ' likes</span>' +
                    '</div>' +
                    '</div>';
                grid.append(html);
            });
        }

        function toggleAdviceLike(adviceId, element, event) {
            event.stopPropagation();
            const icon = $(element);
            const countSpan = icon.closest('.advice-card').find('.advice-likes-count');
            let currentCount = parseInt(countSpan.text().trim());
            
            if (icon.hasClass('liked')) {
                icon.removeClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount - 1) + ' likes');
            } else {
                icon.addClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount + 1) + ' likes');
            }
            $.post('/user/profile/api/advices/' + adviceId + '/like');
        }
    </script>
</body>
</html>
