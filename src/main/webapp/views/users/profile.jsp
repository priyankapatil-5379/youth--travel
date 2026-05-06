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
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Dosis:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { 
            --bg-deep: #000a12;
            --accent-orange: #e63946;
            --glass-bg: rgba(255, 255, 255, 0.03);
            --glass-border: rgba(255, 255, 255, 0.1);
            --text-main: #ffffff;
            --text-dim: #94a3b8;
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
            font-family: 'Outfit', sans-serif; 
            background-color: var(--bg-deep);
            background: radial-gradient(circle at 50% 0%, #001f3f, #000a12);
            color: var(--text-main);
            margin: 0;
            min-height: 100vh;
            padding-bottom: 80px;
            overflow-x: hidden;
        }

        /* Immersive Background System */
        .sun-rays { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; pointer-events: none; opacity: 0.3; }
        .ray { position: absolute; top: -20%; width: 100px; height: 150%; background: linear-gradient(180deg, rgba(255,255,255,0.1) 0%, transparent 80%); filter: blur(50px); transform-origin: top center; animation: ray-swing 10s ease-in-out infinite alternate; }
        @keyframes ray-swing { 0% { transform: rotate(-8deg) scaleX(1); opacity: 0.3; } 100% { transform: rotate(8deg) scaleX(0.8); opacity: 0.6; } }

        .main-container { max-width: 1200px; margin: 0 auto; padding: 120px 20px 40px; position: relative; z-index: 1; }

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

        /* Premium Header */
        .profile-header { 
            display: flex; align-items: flex-start; gap: 80px; margin-bottom: 60px; padding: 50px; 
            background: rgba(0,0,0,0.4); 
            backdrop-filter: blur(20px); 
            border-radius: 40px; 
            border: 1px solid rgba(255,255,255,0.1); 
            box-shadow: 0 25px 60px rgba(0,0,0,0.5); 
        }
        
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
        .display-name { font-size: 20px; font-weight: 700; margin-bottom: 10px; color: #fff; text-shadow: 0 2px 8px rgba(0,0,0,0.8); text-transform: uppercase; }
        .btn-edit-premium { 
            background: rgba(255,255,255,0.1); 
            border: 1px solid var(--glass-border); 
            color: white; 
            padding: 8px 25px; 
            border-radius: 10px; 
            font-size: 14px; 
            font-weight: 700;
            backdrop-filter: blur(10px);
            transition: 0.3s;
            text-shadow: 0 1px 3px rgba(0,0,0,0.5);
        }
        .btn-edit-premium:hover { background: rgba(255,255,255,0.2); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255,255,255,0.1); }

        .info-column { flex: 1; padding-top: 10px; }
        .username-row { display: flex; align-items: center; gap: 10px; margin-bottom: 25px; font-size: 26px; color: #fff; font-weight: 600; text-shadow: 0 2px 10px rgba(0,0,0,0.8); }
        .stats-row { display: flex; gap: 40px; margin-bottom: 30px; }
        .stat-item { display: flex; align-items: baseline; gap: 8px; }
        .stat-num { font-size: 28px; font-weight: 800; color: #ff9f43; text-shadow: 0 2px 8px rgba(0,0,0,0.5); }
        .stat-label { font-size: 18px; color: #fff; font-weight: 600; text-shadow: 0 2px 5px rgba(0,0,0,0.5); }

        .icon-metrics { display: flex; gap: 20px; color: var(--text-dim); font-size: 18px; }
        .metric-item { display: flex; align-items: center; gap: 8px; background: var(--glass-bg); padding: 5px 15px; border-radius: 20px; border: 1px solid var(--glass-border); }

        .reputation-badge {
            background: linear-gradient(135deg, rgba(255, 159, 67, 0.2), rgba(255, 159, 67, 0.05));
            border: 1px solid rgba(255, 159, 67, 0.3);
            padding: 10px 20px;
            border-radius: 15px;
            text-align: center;
            min-width: 100px;
            box-shadow: 0 4px 15px rgba(255, 159, 67, 0.1);
        }
        .reputation-value { font-size: 24px; font-weight: 800; color: #ff9f43; line-height: 1; }
        .reputation-label { font-size: 10px; color: #ff9f43; text-transform: uppercase; letter-spacing: 1px; font-weight: 700; margin-top: 4px; }

        /* Content Divider */
        .content-divider { border-top: 1px solid var(--glass-border); margin: 40px 0; display: flex; justify-content: center; position: relative; }
        .tabs-header { position: absolute; top: -15px; display: flex; gap: 100px; background: transparent; padding: 0 40px; }
        .tab-trigger { font-size: 16px; font-weight: 800; color: rgba(255,255,255,0.6); cursor: pointer; display: flex; align-items: center; gap: 10px; text-transform: uppercase; letter-spacing: 1.5px; text-shadow: 0 2px 8px rgba(0,0,0,0.8); transition: 0.3s; }
        .tab-trigger.active { color: white; transform: scale(1.1); text-shadow: 0 2px 15px rgba(255,255,255,0.5); }

        /* Tab Content Layout */
        .content-grid { display: block; min-height: 400px; margin-right: 100px;}
        
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
            color: #ffffff !important; 
            border: 1px solid rgba(255,255,255,0.2) !important;
            cursor: pointer;
            height: 45px !important;
            line-height: 1.5 !important;
        }
        select.form-control option {
            background-color: #1a2a2a !important;
            color: #ffffff !important;
            padding: 15px !important;
        }
        /* Ensure the selected value is visible */
        select.form-control:focus {
            outline: none !important;
            border-color: #ff9f43 !important;
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

    <div class="wrapper" style="display: flex; min-height: 100vh;">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="profile" />
        </jsp:include>
        
        <main class="main-content" style="flex: 1; margin-left: 240px; padding: 100px 30px 40px;">


    <!-- Nuclear Option Modals (Pure JS/CSS - 100% Reliable) -->
    <div id="adviceModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content">
            <span class="modal-close-btn" onclick="closeModal('adviceModal')">&times;</span>
            <h3 id="adviceModalTitle" style="margin-top: 0; margin-bottom: 25px; font-weight: 700;">Share Travel Wisdom</h3>
            <form id="uploadAdviceForm">
                <input type="hidden" name="adviceId" id="adviceId">
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
                        <option value="Food & Culture">Food & Culture</option>
                        <option value="Road Trip">Road Trip</option>
                    </select>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Your Review / Experience</label>
                    <textarea name="content" class="form-control" rows="4" placeholder="Share your experience and tips..." required></textarea>
                </div>
                
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Best Time to Visit</label>
                    <textarea name="bestTimeToVisit" class="form-control" rows="2" placeholder="When should people visit?"></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">What to Pack</label>
                    <textarea name="whatToPack" class="form-control" rows="2" placeholder="Essential items to carry..."></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Safety Tips</label>
                    <textarea name="safetyTips" class="form-control" rows="2" placeholder="How to stay safe..."></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Money & Budget Tips</label>
                    <textarea name="budgetTips" class="form-control" rows="2" placeholder="Cost estimates and saving tips..."></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Stay & Food Advice</label>
                    <textarea name="stayFoodAdvice" class="form-control" rows="2" placeholder="Recommended places to stay and eat..."></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Transport Tips</label>
                    <textarea name="transportTips" class="form-control" rows="2" placeholder="How to get around?"></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Network & Connectivity</label>
                    <textarea name="connectivityTips" class="form-control" rows="2" placeholder="SIM cards, WiFi availability..."></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Local Rules / Permissions</label>
                    <textarea name="localRules" class="form-control" rows="2" placeholder="Permits, cultural etiquette..."></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Environmental / Responsible Travel Tips</label>
                    <textarea name="environmentalTips" class="form-control" rows="2" placeholder="How to travel sustainably..."></textarea>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Pro Tips</label>
                    <textarea name="proTips" class="form-control" rows="2" placeholder="Hidden gems and expert advice..."></textarea>
                </div>
                
                <button type="submit" id="adviceSubmitBtn" class="btn btn-primary" style="margin-top: 25px; width: 100%; font-weight: 700; background: #ff9f43; border: none; padding: 12px; border-radius: 12px;">Post Advice</button>
            </form>
        </div>
    </div>

    <div id="adviceDetailModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content" style="max-width: 600px;">
            <span class="modal-close-btn" onclick="closeModal('adviceDetailModal')">&times;</span>
            <div id="adviceDetailContent">
                <!-- Populated by JS -->
            </div>
        </div>
    </div>

    <!-- Points Detail Modal -->
    <div id="pointsDetailModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content" style="max-width: 350px; text-align: center;">
            <span class="modal-close-btn" onclick="closeModal('pointsDetailModal')">&times;</span>
            <div style="padding: 10px;">
                <div style="position: relative; width: 100px; height: 100px; margin: 0 auto 20px;">
                    <img id="modalHeaderAvatar" src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 3px solid #ff9f43; box-shadow: 0 0 25px rgba(255,159,67,0.3);">
                    <div style="position: absolute; bottom: -5px; right: -5px; width: 40px; height: 40px; background: #ff9f43; border: 3px solid #1a2a2a; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.5);">
                        <span id="headerPointsValue" style="font-size: 16px; font-weight: 800; color: #fff;">0</span>
                    </div>
                </div>
                <h3 style="font-weight: 700; margin-bottom: 5px; color: #fff; font-size: 18px;">Total Points Earned</h3>
                <h2 id="modalTotalPointsLabel" style="font-size: 32px; font-weight: 800; color: #ff9f43; margin-bottom: 10px;">0</h2>
                <p style="color: var(--text-dim); font-size: 13px; margin-bottom: 25px;">Sharing is earning! Your points reflect your impact on the community.</p>
                
                <div style="text-align: left; background: rgba(255,255,255,0.03); padding: 15px; border-radius: 12px; border: 1px solid rgba(255,255,255,0.05);">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 12px;">
                        <span><i class="fa fa-heart" style="color: #ff9f43; width: 18px;"></i> Engagement</span>
                        <span style="font-weight: 700; color: #28a745;">+10 pts</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 12px;">
                        <span><i class="fa fa-eye" style="color: #ff9f43; width: 18px;"></i> Content reach</span>
                        <span style="font-weight: 700; color: #28a745;">+2 pts</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 12px;">
                        <span><i class="fa fa-user" style="color: #ff9f43; width: 18px;"></i> Platform presence</span>
                        <span style="font-weight: 700; color: #28a745;">+1 pt</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="postModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content">
            <span class="modal-close-btn" onclick="closeModal('postModal')">&times;</span>
            <h3 id="postModalTitle" style="margin-top: 0; margin-bottom: 25px; font-weight: 700;">New Travel Memory</h3>
            <form id="uploadPostForm">
                <input type="hidden" name="postId" id="postId">
                <div class="form-group">
                    <div id="mediaPreview" style="display:none; width: 100%; aspect-ratio: 1; border-radius: 10px; overflow: hidden; margin-bottom: 15px; background: #000;"></div>
                    <input type="file" name="media" id="mediaInput" class="form-control" accept="image/*,video/*" required>
                </div>
                <div class="form-group" style="margin-top: 15px;">
                    <label class="form-label">Where did this happen?</label>
                    <textarea name="caption" class="form-control" rows="3" placeholder="Describe your memory..."></textarea>
                </div>
                <button type="submit" id="postSubmitBtn" class="btn btn-primary" style="margin-top: 25px; width: 100%; font-weight: 700; background: #ff9f43; border: none; padding: 12px; border-radius: 12px;">Post to Journey</button>
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

    <!-- Profile Photo Upload Modal -->
    <div id="profilePhotoModal" class="unbreakable-modal">
        <div class="unbreakable-modal-content" style="max-width: 400px;">
            <span class="modal-close-btn" onclick="closeModal('profilePhotoModal')">&times;</span>
            <h3 style="margin-bottom: 20px; font-weight: 800; color: #ff9f43; text-align: center;">Update Profile Photo</h3>
            <form id="profilePhotoForm" onsubmit="handleProfilePhotoUpload(event)">
                <div class="mb-4">
                    <label class="form-label">Select Image</label>
                    <input type="file" name="photo" id="profilePhotoInput" class="form-control" accept="image/*" required onchange="previewPhoto(this)">
                </div>
                <div id="photoPreview" style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden; margin: 0 auto 20px; border: 3px solid #ff9f43; display: none;">
                    <img id="photoPreviewImg" src="" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; font-weight: 700;">Upload & Save</button>
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
                    <div class="plus-btn" onclick="openModal('profilePhotoModal')"><i class="fa fa-camera"></i></div>
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
                    <div class="reputation-badge">
                        <div class="reputation-value" id="countPoints">0</div>
                        <div class="reputation-label">Traveler Points</div>
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
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0" style="color: var(--text-dim); text-transform: uppercase; font-size: 14px; letter-spacing: 1px;">My Memories</h5>
                    <button class="btn btn-sm" style="background: #ff9f43; color: white; border-radius: 10px; font-weight: 600; font-size: 12px; padding: 6px 15px; border: none; gap:20px ; margin-bottom: 25px;" onclick="prepareNewPost()">
                        <i class="fa fa-plus"></i> New Memory
                    </button>
                </div>
                <div class="posts-side-grid" id="postsGrid">
                    <!-- Posts dynamic -->
                </div>
            </div>

            <!-- Right: Advice Cards -->
            <div id="adviceSection">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0" style="color: var(--text-dim); text-transform: uppercase; font-size: 14px; letter-spacing: 1px;">My Advices</h5>
                    <button class="btn btn-sm" style="background: white; color: black; border-radius: 10px; font-weight: 600; font-size: 12px; padding: 6px 12px; border: none;" onclick="prepareNewAdvice()">
                        <i class="fa fa-plus"></i> New Advice
                    </button>
                </div>
                <div class="advices-side-grid" id="adviceGrid">
                    <!-- Advices dynamic -->
                </div>
            </div>
        </section>
    </main>

        </main>
    </div>

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
                const postId = $('#postId').val();
                const url = postId ? ('/user/profile/api/posts/' + postId + '/update') : '/user/profile/api/posts/upload';
                
                let fd = new FormData(this);
                $.ajax({
                    url: url,
                    type: 'POST',
                    data: fd,
                    processData: false,
                    contentType: false,
                    success: function() { 
                        closeModal('postModal'); 
                        $('#uploadPostForm')[0].reset();
                        $('#postId').val('');
                        $('#mediaPreview').hide();
                        loadProfileData(); 
                    },
                    error: function(err) {
                        alert('Operation failed: ' + err.responseText);
                    }
                });
            });

            $('#uploadAdviceForm').on('submit', function(e) {
                e.preventDefault();
                const adviceId = $('#adviceId').val();
                const url = adviceId ? ('/user/profile/api/advices/' + adviceId + '/update') : '/user/profile/api/advices/post';
                
                $.ajax({
                    url: url,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        title: $('#uploadAdviceForm input[name="title"]').val(),
                        categories: $('#uploadAdviceForm select[name="categories"]').val(),
                        content: $('#uploadAdviceForm textarea[name="content"]').val(),
                        bestTimeToVisit: $('#uploadAdviceForm textarea[name="bestTimeToVisit"]').val(),
                        whatToPack: $('#uploadAdviceForm textarea[name="whatToPack"]').val(),
                        safetyTips: $('#uploadAdviceForm textarea[name="safetyTips"]').val(),
                        budgetTips: $('#uploadAdviceForm textarea[name="budgetTips"]').val(),
                        stayFoodAdvice: $('#uploadAdviceForm textarea[name="stayFoodAdvice"]').val(),
                        transportTips: $('#uploadAdviceForm textarea[name="transportTips"]').val(),
                        connectivityTips: $('#uploadAdviceForm textarea[name="connectivityTips"]').val(),
                        localRules: $('#uploadAdviceForm textarea[name="localRules"]').val(),
                        environmentalTips: $('#uploadAdviceForm textarea[name="environmentalTips"]').val(),
                        proTips: $('#uploadAdviceForm textarea[name="proTips"]').val()
                    }),
                    success: function() { 
                        closeModal('adviceModal'); 
                        $('#uploadAdviceForm')[0].reset();
                        $('#adviceId').val('');
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

        function toggleAdviceLike(adviceId, element, event) {
            event.stopPropagation();
            const icon = $(element);
            const countSpan = icon.closest('.advice-premium-card').find('.advice-likes-count');
            let currentCount = parseInt(countSpan.text().trim()) || 0;
            
            if (icon.hasClass('liked')) {
                icon.removeClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount - 1) + ' likes');
            } else {
                icon.addClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount + 1) + ' likes');
            }
            $.post('/user/profile/api/advices/' + adviceId + '/like');
        }

        function prepareNewAdvice() {
            $('#adviceId').val('');
            $('#adviceModalTitle').text('Share Travel Wisdom');
            $('#adviceSubmitBtn').text('Post Advice');
            $('#uploadAdviceForm')[0].reset();
            openModal('adviceModal');
        }

        function editAdvice(adv) {
            $('#adviceId').val(adv.id);
            $('#adviceModalTitle').text('Refine Travel Wisdom');
            $('#adviceSubmitBtn').text('Update Advice');
            
            const form = $('#uploadAdviceForm');
            form.find('input[name="title"]').val(adv.title);
            form.find('select[name="categories"]').val(adv.categories);
            form.find('textarea[name="content"]').val(adv.content);
            form.find('textarea[name="bestTimeToVisit"]').val(adv.bestTimeToVisit);
            form.find('textarea[name="whatToPack"]').val(adv.whatToPack);
            form.find('textarea[name="safetyTips"]').val(adv.safetyTips);
            form.find('textarea[name="budgetTips"]').val(adv.budgetTips);
            form.find('textarea[name="stayFoodAdvice"]').val(adv.stayFoodAdvice);
            form.find('textarea[name="transportTips"]').val(adv.transportTips);
            form.find('textarea[name="connectivityTips"]').val(adv.connectivityTips);
            form.find('textarea[name="localRules"]').val(adv.localRules);
            form.find('textarea[name="environmentalTips"]').val(adv.environmentalTips);
            form.find('textarea[name="proTips"]').val(adv.proTips);
            
            openModal('adviceModal');
        }

        function showAdviceDetail(adv) {
            const detail = $('#adviceDetailContent');
            detail.empty();
            
            let iconClass = 'fa-lightbulb-o';
            if (adv.categories === 'Solo Travel') iconClass = 'fa-user';
            else if (adv.categories === 'Adventure Trip') iconClass = 'fa-mountain';
            else if (adv.categories === 'Budget Travel') iconClass = 'fa-money';
            else if (adv.categories === 'Luxury Escape') iconClass = 'fa-diamond';
            else if (adv.categories === 'Food & Culture') iconClass = 'fa-cutlery';
            else if (adv.categories === 'Road Trip') iconClass = 'fa-car';

            let html = '<div style="text-align:center; margin-bottom: 25px;">' +
                       '<div class="advice-icon-box" style="width: 60px; height: 60px; font-size: 30px; margin: 0 auto 15px;"><i class="fa ' + iconClass + '"></i></div>' +
                       '<h2 style="margin:0; font-weight:800; color:#ff9f43;">' + adv.title + '</h2>' +
                       '<span style="color:var(--text-dim); text-transform:uppercase; font-size:12px; letter-spacing:1px;">' + (adv.categories || 'General') + '</span>' +
                       '</div>' +
                       '<div style="background: rgba(255,255,255,0.03); padding: 20px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.05); margin-bottom: 20px;">' +
                       '<p style="font-size:15px; line-height:1.7; color:#eee; margin:0;">' + adv.content + '</p>' +
                       '</div>' +
                       '<div class="row g-3">';
            
            const tips = [
                { label: 'Best Time to Visit', val: adv.bestTimeToVisit, icon: 'fa-calendar' },
                { label: 'What to Pack', val: adv.whatToPack, icon: 'fa-suitcase' },
                { label: 'Safety Tips', val: adv.safetyTips, icon: 'fa-shield' },
                { label: 'Money & Budget', val: adv.budgetTips, icon: 'fa-money' },
                { label: 'Stay & Food', val: adv.stayFoodAdvice, icon: 'fa-bed' },
                { label: 'Transport', val: adv.transportTips, icon: 'fa-car' },
                { label: 'Network', val: adv.connectivityTips, icon: 'fa-wifi' },
                { label: 'Rules', val: adv.localRules, icon: 'fa-gavel' },
                { label: 'Eco Tips', val: adv.environmentalTips, icon: 'fa-leaf' },
                { label: 'Pro Tips', val: adv.proTips, icon: 'fa-star' }
            ];
            
            tips.forEach(t => {
                if (t.val && t.val.trim() !== '') {
                    html += '<div class="col-md-6">' +
                            '<div style="padding: 12px; background: rgba(255,159,67,0.05); border: 1px solid rgba(255,159,67,0.1); border-radius: 12px; height: 100%;">' +
                            '<div style="color: #ff9f43; font-weight: 700; font-size: 11px; text-transform: uppercase; margin-bottom: 5px; display: flex; align-items: center; gap: 8px;">' +
                            '<i class="fa ' + t.icon + '"></i> ' + t.label + '</div>' +
                            '<div style="font-size: 13px; color: #fff;">' + t.val + '</div>' +
                            '</div></div>';
                }
            });

            html += '</div>';
            detail.append(html);
            openModal('adviceDetailModal');
        }

        function showMyPoints() {
            // Use existing data if available, or fetch
            if (dataCache && dataCache.user) {
                const pts = dataCache.user.travelPoints || 0;
                $('#headerPointsValue').text(pts);
                $('#modalTotalPointsLabel').text(pts);
            } else {
                $.get('/user/profile/api/data?username=' + profileUsername, function(data) {
                    const pts = data.user.travelPoints || 0;
                    $('#headerPointsValue').text(pts);
                    $('#modalTotalPointsLabel').text(pts);
                });
            }
            openModal('pointsDetailModal');
        }

        function deleteAdvice(adviceId) {
            if (confirm('Are you sure you want to delete this advice?')) {
                $.ajax({
                    url: '/user/profile/api/advices/' + adviceId,
                    type: 'DELETE',
                    success: function() {
                        loadProfileData();
                    }
                });
            }
        }
        
        let dataCache = null;
        function loadProfileData() {
            $.get('/user/profile/api/data?username=' + profileUsername, function(data) {
                dataCache = data;
                $('#countPosts').text(data.postsCount || 0);
                $('#countPoints').text(data.user.travelPoints || 0);
                $('#displayUsername').text(data.user.username || 'user');
                
                if(!data.isOwnProfile) {
                    $('.btn-edit-premium').hide();
                    $('.plus-btn').hide();
                    $('#adviceSection button').hide();
                    $('#postsSection button').hide();
                }
                
                renderPosts(data.posts, data.likedPostIds || []);
                renderAdvices(data.advices, data.likedAdviceIds || []);
            });
        }

        function previewPhoto(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    $('#photoPreviewImg').attr('src', e.target.result);
                    $('#photoPreview').show();
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function handleProfilePhotoUpload(event) {
            event.preventDefault();
            const formData = new FormData(event.target);
            
            $.ajax({
                url: '/user/profile/api/upload-photo',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    closeModal('profilePhotoModal');
                    loadProfileData();
                    // Update header avatar too
                    if (response.profilePhoto) {
                        $('header.header img').attr('src', response.profilePhoto);
                        $('#mainAvatar').replaceWith('<img src="' + response.profilePhoto + '" class="avatar-img" id="mainAvatar">');
                    }
                },
                error: function() {
                    alert('Failed to upload photo');
                }
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
                
                // Action Buttons for own profile
                if (dataCache && dataCache.isOwnProfile) {
                    html += '<div style="position: absolute; top: 10px; left: 10px; display: flex; gap: 8px; z-index: 20;">' +
                            '<i class="fa fa-pencil" style="cursor: pointer; background: rgba(0,0,0,0.6); color: #ff9f43; padding: 6px; border-radius: 50%; font-size: 14px;" onclick="editPost(' + JSON.stringify(post).replace(/"/g, '&quot;') + ', event)"></i>' +
                            '<i class="fa fa-trash" style="cursor: pointer; background: rgba(0,0,0,0.6); color: #e63946; padding: 6px; border-radius: 50%; font-size: 14px;" onclick="deleteMemory(' + post.id + ', event)"></i>' +
                            '</div>';
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
            let currentCount = parseInt(countSpan.text().trim()) || 0;
            
            if (icon.hasClass('liked')) {
                icon.removeClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount - 1));
            } else {
                icon.addClass('liked');
                countSpan.html('<i class="fa fa-heart"></i> ' + (currentCount + 1));
            }
            $.post('/user/profile/api/posts/' + postId + '/like');
        }

        function prepareNewPost() {
            $('#postId').val('');
            $('#postModalTitle').text('New Travel Memory');
            $('#postSubmitBtn').text('Post to Journey');
            $('#uploadPostForm')[0].reset();
            $('#mediaPreview').hide();
            openModal('postModal');
        }

        function editPost(post, event) {
            event.stopPropagation();
            $('#postId').val(post.id);
            $('#postModalTitle').text('Refine Travel Memory');
            $('#postSubmitBtn').text('Update Memory');
            
            const form = $('#uploadPostForm');
            form.find('textarea[name="caption"]').val(post.caption);
            
            const preview = $('#mediaPreview');
            preview.empty().show();
            if (post.mediaType === 'video') {
                preview.append('<video src="' + post.mediaUrl + '" style="width:100%;height:100%;object-fit:cover;" autoplay muted loop></video>');
            } else {
                preview.append('<img src="' + post.mediaUrl + '" style="width:100%;height:100%;object-fit:cover;">');
            }
            
            // File input is not required for update
            $('#mediaInput').prop('required', false);
            
            openModal('postModal');
        }

        function deleteMemory(postId, event) {
            event.stopPropagation();
            if (confirm('Are you sure you want to delete this memory?')) {
                $.ajax({
                    url: '/user/profile/api/posts/' + postId,
                    type: 'DELETE',
                    success: function() {
                        loadProfileData();
                    }
                });
            }
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
                else if (adv.categories === 'Food & Culture') iconClass = 'fa-cutlery';
                else if (adv.categories === 'Road Trip') iconClass = 'fa-car';

                let isLiked = likedAdviceIds.includes(adv.id);
                let heartClass = isLiked ? 'fa-heart liked' : 'fa-heart';

                let html = '<div class="advice-premium-card" style="position: relative; cursor: pointer;" onclick="showAdviceDetail(' + JSON.stringify(adv).replace(/"/g, '&quot;') + ')">';
                
                // Show Edit/Delete only on own profile
                if (dataCache && dataCache.isOwnProfile) {
                    html += '<div style="position: absolute; top: 15px; right: 45px; display: flex; gap: 10px; z-index: 10;">' +
                            '<i class="fa fa-pencil" style="cursor: pointer; color: #ff9f43;" onclick="event.stopPropagation(); editAdvice(' + JSON.stringify(adv).replace(/"/g, '&quot;') + ')"></i>' +
                            '<i class="fa fa-trash" style="cursor: pointer; color: #e63946;" onclick="event.stopPropagation(); deleteAdvice(' + adv.id + ')"></i>' +
                            '</div>';
                }

                html += '<i class="fa ' + heartClass + ' post-like-btn" style="bottom: auto; top: 15px; right: 15px; font-size: 18px;" onclick="toggleAdviceLike(' + adv.id + ', this, event)"></i>' +
                    '<div class="advice-header">' +
                    '<div class="advice-icon-box"><i class="fa ' + iconClass + '"></i></div>' +
                    '<div class="ms-3">' +
                    '<h4 class="advice-title">' + adv.title + '</h4>' +
                    '<span style="font-size: 10px; color: #ff9f43; text-transform: uppercase;">' + (adv.categories || 'General') + '</span>' +
                    '</div>' +
                    '</div>' +
                    '<p class="advice-body">' + adv.content + '</p>';
                
                // Add conditional fields
                const tips = [
                    { label: 'Best Time', val: adv.bestTimeToVisit },
                    { label: 'Packing', val: adv.whatToPack },
                    { label: 'Safety', val: adv.safetyTips },
                    { label: 'Budget', val: adv.budgetTips },
                    { label: 'Food & Stay', val: adv.stayFoodAdvice },
                    { label: 'Transport', val: adv.transportTips },
                    { label: 'Network', val: adv.connectivityTips },
                    { label: 'Local Rules', val: adv.localRules },
                    { label: 'Eco Tips', val: adv.environmentalTips },
                    { label: 'Pro Tips', val: adv.proTips }
                ];
                
                tips.forEach(t => {
                    if (t.val && t.val.trim() !== '') {
                        html += '<div style="margin-top: 10px; font-size: 11px; border-left: 2px solid #ff9f43; padding-left: 8px;">' +
                                '<strong style="color: #ff9f43;">' + t.label + ':</strong> ' + t.val + '</div>';
                    }
                });

                html += '<div style="margin-top: 15px; font-size: 12px; color: var(--text-muted);">' +
                    '<span class="advice-likes-count"><i class="fa fa-heart"></i> ' + adv.likes + ' likes</span>' +
                    '</div>' +
                    '</div>';
                grid.append(html);
            });
        }

        function toggleAdviceLike(adviceId, element, event) {
            event.stopPropagation();
            const icon = $(element);
            const countSpan = icon.closest('.advice-premium-card').find('.advice-likes-count');
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
