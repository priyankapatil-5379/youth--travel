<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reflections | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-teal: #008080;
            --secondary-teal: #077378;
            --accent-coral: #ff9f43;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --border-color: #f1f5f9;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-premium: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-body); 
            color: var(--text-main); 
            margin: 0; 
            letter-spacing: -0.01em;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; }

        .page-header { margin-bottom: 32px; display: flex; justify-content: space-between; align-items: center; }
        .page-header h1 { font-size: 32px; font-weight: 800; margin: 0; color: #1e293b; letter-spacing: -1px; }
        .page-header p { color: var(--text-muted); font-size: 15px; margin-top: 6px; font-weight: 500; }

        .btn-review {
            background: var(--primary-teal); color: white !important; border: none; border-radius: 10px;
            padding: 12px 24px; font-weight: 700; font-size: 14px; display: flex; align-items: center; gap: 10px;
            transition: var(--transition); box-shadow: 0 4px 10px rgba(0, 128, 128, 0.2);
            text-decoration: none;
        }
        .btn-review:hover { background: var(--secondary-teal); transform: translateY(-2px); box-shadow: 0 6px 15px rgba(0, 128, 128, 0.3); }

        /* Stats Row */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 40px; }
        .stat-card {
            background: white; border-radius: 20px; padding: 25px; border: 1px solid var(--border-color);
            display: flex; align-items: center; gap: 20px; transition: var(--transition);
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: var(--shadow-premium); border-color: var(--primary-teal); }
        
        .stat-icon {
            width: 54px; height: 54px; border-radius: 16px; display: flex; align-items: center; 
            justify-content: center; font-size: 22px;
        }
        .icon-blue { background: #f0fdfa; color: #008080; }
        .icon-orange { background: #fffbeb; color: #f59e0b; }
        .icon-green { background: #f0fdf4; color: #10b981; }
        .icon-indigo { background: #eef2ff; color: #6366f1; }
        
        .stat-info .label { font-size: 12px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 4px; display: block; }
        .stat-info .value { font-size: 28px; font-weight: 900; color: #1e293b; display: block; line-height: 1; }
        .stat-info .sub { font-size: 12px; color: var(--text-muted); font-weight: 600; margin-top: 4px; display: block; }

        .layout-grid { display: grid; grid-template-columns: 1fr 360px; gap: 32px; }

        /* Review Card Layout */
        .section-label { font-size: 14px; font-weight: 800; color: #1e293b; margin-bottom: 24px; text-transform: uppercase; letter-spacing: 1px; display: block; }

        .review-card {
            background: white; border-radius: 24px; padding: 0; margin-bottom: 30px;
            border: 1px solid var(--border-color); box-shadow: var(--shadow-sm);
            overflow: hidden; transition: var(--transition);
        }
        .review-card:hover { border-color: var(--primary-teal); box-shadow: var(--shadow-premium); }

        .review-inner { display: flex; padding: 24px; gap: 24px; }
        .trip-thumb { width: 140px; height: 140px; border-radius: 18px; object-fit: cover; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }
        
        .review-content-main { flex: 1; }
        .review-header-top { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px; }
        .trip-title { font-size: 18px; font-weight: 800; color: #1e293b; margin: 0; }
        .trip-location { font-size: 13px; color: var(--text-muted); font-weight: 600; display: flex; align-items: center; gap: 4px; margin-top: 2px; }
        
        .badge-status { background: #f0fdf4; color: #10b981; font-size: 11px; font-weight: 800; padding: 5px 12px; border-radius: 100px; text-transform: uppercase; }
        .dots-btn { color: var(--text-muted); cursor: pointer; padding: 5px; border-radius: 50%; transition: 0.2s; }
        .dots-btn:hover { background: #f1f5f9; color: var(--text-main); }

        .stars-row { display: flex; gap: 4px; margin: 12px 0; font-size: 14px; }
        .star-filled { color: #f59e0b; }
        .star-empty { color: #e2e8f0; }

        .review-quote { font-size: 16px; font-weight: 800; color: #1e293b; margin-bottom: 10px; }
        .review-text { font-size: 14px; color: var(--text-muted); line-height: 1.6; margin-bottom: 20px; font-weight: 500; }

        .tag-row { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 20px; }
        .tag-pill { background: #f0fdfa; color: #0d9488; font-size: 11px; font-weight: 700; padding: 5px 14px; border-radius: 100px; }

        .gallery-row { display: flex; gap: 10px; margin-bottom: 10px; }
        .gallery-img { width: 64px; height: 64px; border-radius: 12px; object-fit: cover; border: 2px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.05); transition: 0.3s; cursor: pointer; }
        .gallery-img:hover { transform: scale(1.1); z-index: 2; }

        .card-footer-meta { padding: 12px 24px; background: #fafafa; border-top: 1px solid #f8fafc; text-align: right; }
        .time-ago { font-size: 11px; font-weight: 700; color: #94a3b8; text-transform: uppercase; }

        /* Sidebar Widgets */
        .sidebar-widgets { display: flex; flex-direction: column; gap: 24px; }
        .widget-card { background: white; border-radius: 24px; padding: 24px; border: 1px solid var(--border-color); box-shadow: var(--shadow-sm); }
        .widget-card h4 { font-size: 14px; font-weight: 800; color: #1e293b; margin-bottom: 20px; text-transform: uppercase; letter-spacing: 0.5px; }

        /* Rating Distribution */
        .dist-list { display: flex; flex-direction: column; gap: 12px; }
        .dist-row { display: flex; align-items: center; gap: 12px; }
        .dist-label { font-size: 12px; font-weight: 700; color: var(--text-muted); width: 60px; }
        .dist-bar-bg { flex: 1; height: 8px; background: #f1f5f9; border-radius: 100px; overflow: hidden; }
        .dist-bar-fill { height: 100%; background: #10b981; border-radius: 100px; }
        .dist-value { font-size: 12px; font-weight: 700; color: var(--text-muted); width: 45px; text-align: right; }

        /* Activity List */
        .activity-list { display: flex; flex-direction: column; gap: 20px; }
        .activity-item { display: flex; gap: 15px; align-items: flex-start; }
        .activity-icon { width: 36px; height: 36px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 16px; }
        .activity-icon.teal { background: #f0fdfa; color: #0d9488; }
        .activity-icon.blue { background: #eff6ff; color: #2563eb; }
        .activity-icon.purple { background: #faf5ff; color: #9333ea; }
        
        .activity-info p { font-size: 13px; font-weight: 700; color: #334155; margin: 0; line-height: 1.4; }
        .activity-info span { font-size: 11px; color: #94a3b8; font-weight: 600; }

        /* Level Card */
        .level-card { text-align: center; }
        .badge-visual { width: 80px; height: 80px; margin: 0 auto 20px; display: flex; align-items: center; justify-content: center; background: #fffbeb; border-radius: 50%; border: 6px solid #fef3c7; color: #d97706; font-size: 32px; box-shadow: 0 10px 15px -3px rgba(217, 119, 6, 0.1); }
        .level-card h5 { font-size: 18px; font-weight: 800; color: #1e293b; margin-bottom: 8px; }
        .level-card p { font-size: 13px; color: var(--text-muted); line-height: 1.5; margin-bottom: 20px; }
        .level-stats { padding-top: 15px; border-top: 1px solid #f1f5f9; font-size: 12px; font-weight: 800; color: var(--text-muted); }

        /* Pagination */
        .pagination-area { display: flex; justify-content: center; align-items: center; gap: 20px; margin-top: 20px; padding: 20px 0; }
        .pagination-info { font-size: 13px; font-weight: 700; color: var(--text-muted); }
        .page-btns { display: flex; gap: 8px; }
        .page-num { width: 32px; height: 32px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 13px; font-weight: 700; color: var(--text-muted); cursor: pointer; transition: 0.2s; }
        .page-num:hover { background: #f1f5f9; color: var(--primary-teal); }
        .page-num.active { background: var(--primary-teal); color: white; box-shadow: 0 4px 10px rgba(0, 128, 128, 0.3); }

        @media (max-width: 1200px) {
            .layout-grid { grid-template-columns: 1fr; }
            .sidebar-widgets { display: grid; grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 768px) {
            .main-content { margin-left: 0; padding: 20px !important; }
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
            .sidebar-widgets { grid-template-columns: 1fr; }
            .review-inner { flex-direction: column; }
            .trip-thumb { width: 100%; height: 200px; }
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="reviews" />
        </jsp:include>
        
        <main class="main-content">
            <div class="page-header">
                <div>
                    <h1>My Reflections</h1>
                    <p>The stories you've shared from your journeys</p>
                </div>
                <a href="<c:url value='/user/my-bookings'/>" class="btn-review">
                    <i class="fa fa-pencil"></i> Write a Review
                </a>
            </div>

            <!-- Stats Dashboard -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon icon-blue"><i class="fa fa-commenting"></i></div>
                    <div class="stat-info">
                        <span class="label">Total Reviews</span>
                        <span id="stat-total" class="value">${reviews.size()}</span>
                        <span class="sub">All time</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon icon-orange"><i class="fa fa-star"></i></div>
                    <div class="stat-info">
                        <span class="label">Average Rating</span>
                        <span id="stat-avg" class="value">0.0</span>
                        <span class="sub">All time</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon icon-green"><i class="fa fa-bolt"></i></div>
                    <div class="stat-info">
                        <span class="label">Helpful Votes</span>
                        <span id="stat-helpful" class="value">0</span>
                        <span class="sub">From explorers</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon icon-indigo"><i class="fa fa-eye"></i></div>
                    <div class="stat-info">
                        <span class="label">Views</span>
                        <span id="stat-views" class="value">0</span>
                        <span class="sub">All time</span>
                    </div>
                </div>
            </div>

            <div class="layout-grid">
                <!-- Main Column -->
                <div class="reviews-feed">
                    <span class="section-label">Your Reviews</span>
                    <div id="reviews-container">
                        <c:choose>
                            <c:when test="${not empty reviews}">
                                <c:forEach var="r" items="${reviews}">
                                    <div class="review-card">
                                        <div class="review-inner">
                                            <img src="${not empty r.trip.imageUrl ? r.trip.imageUrl : 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400'}" class="trip-thumb" alt="Trip">
                                            <div class="review-content-main">
                                                <div class="review-header-top">
                                                    <div>
                                                        <h3 class="trip-title">${r.trip.title}</h3>
                                                        <span class="trip-location"><i class="fa fa-map-marker"></i> ${r.trip.destination}, India</span>
                                                    </div>
                                                    <div class="d-flex align-items-center gap-3">
                                                        <span class="badge-status">Published</span>
                                                        <i class="fa fa-ellipsis-v dots-btn"></i>
                                                    </div>
                                                </div>
                                                <div class="stars-row">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fa fa-star ${i <= r.rating ? 'star-filled' : 'star-empty'}"></i>
                                                    </c:forEach>
                                                </div>
                                                <h4 class="review-quote">${not empty r.title ? r.title : 'My Journey Reflection'}</h4>
                                                <p class="review-text">${r.reviewText}</p>
                                                
                                                <div class="tag-row">
                                                    <c:if test="${not empty r.tags}">
                                                        <c:forEach var="tag" items="${r.tags.split(',')}">
                                                            <span class="tag-pill">${tag.trim()}</span>
                                                        </c:forEach>
                                                    </c:if>
                                                </div>
                                                
                                                <div class="gallery-row">
                                                    <c:if test="${not empty r.photos}">
                                                        <c:forEach var="photo" items="${r.photos.split(',')}">
                                                            <img src="${photo}" class="gallery-img">
                                                        </c:forEach>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer-meta">
                                            <span class="time-ago">
                                                <fmt:parseDate value="${r.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 60px; background: white; border-radius: 24px; border: 2px dashed var(--border-color);">
                                    <i class="fa fa-camera-retro" style="font-size: 40px; color: var(--text-muted); margin-bottom: 20px;"></i>
                                    <h3 style="font-weight: 800; color: var(--text-main);">No reflections yet</h3>
                                    <p style="color: var(--text-muted);">Share your journey experiences and help other explorers!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="pagination-area">
                        <span class="pagination-info">Showing 1 to ${reviews.size()} of ${reviews.size()} reviews</span>
                        <div class="page-btns">
                            <div class="page-num active">1</div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar column -->
                <div class="sidebar-column">
                    <div class="sidebar-widgets">
                        <div class="widget-card">
                            <h4>Rating Distribution</h4>
                            <div class="dist-list" id="rating-dist">
                                <!-- Dynamic via JS -->
                            </div>
                        </div>

                        <div class="widget-card">
                            <h4>Recent Activity</h4>
                            <div class="activity-list" id="activity-list">
                                <!-- Dynamic via JS -->
                            </div>
                        </div>

                        <div class="widget-card level-card">
                            <h4>Traveler Level</h4>
                            <div class="badge-visual"><i class="fa fa-trophy"></i></div>
                            <h5 id="level-title">Traveler</h5>
                            <p>Great job! Keep sharing your amazing experiences.</p>
                            <div class="level-stats">
                                <span id="level-stats-text">${reviews.size()} Reviews • Level 1</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            calculateStats();
        });

        function calculateStats() {
            const reviews = [];
            let totalHelpful = 0;
            let totalViews = 0;

            <c:forEach var="r" items="${reviews}">
                reviews.push({ 
                    rating: ${r.rating}, 
                    title: "${r.trip.title}", 
                    helpful: ${r.helpfulVotes != null ? r.helpfulVotes : 0},
                    views: ${r.views != null ? r.views : 0}
                });
                totalHelpful += ${r.helpfulVotes != null ? r.helpfulVotes : 0};
                totalViews += ${r.views != null ? r.views : 0};
            </c:forEach>

            // Average Rating
            if(reviews.length > 0) {
                const totalRating = reviews.reduce((acc, r) => acc + r.rating, 0);
                const avg = (totalRating / reviews.length).toFixed(1);
                $('#stat-avg').text(avg);
                $('#stat-helpful').text(totalHelpful);
                $('#stat-views').text(totalViews);
            }

            // Distribution
            const dist = {5:0, 4:0, 3:0, 2:0, 1:0};
            reviews.forEach(r => dist[r.rating]++);
            
            let distHtml = '';
            const totalCount = reviews.length || 1;
            for(let i=5; i>=1; i--) {
                const pct = Math.round((dist[i] / totalCount) * 100);
                distHtml += `
                    <div class="dist-row">
                        <span class="dist-label">\${i} Stars</span>
                        <div class="dist-bar-bg">
                            <div class="dist-bar-fill" style="width: \${pct}%"></div>
                        </div>
                        <span class="dist-value">\${dist[i]} (\${pct}%)</span>
                    </div>
                `;
            }
            $('#rating-dist').html(distHtml);

            // Level Logic
            const count = reviews.length;
            let level = 1;
            let title = "Traveler";
            if (count >= 10) { level = 3; title = "Expert Explorer"; }
            else if (count >= 5) { level = 2; title = "Explorer"; }
            
            $('#level-title').text(title);
            $('#level-stats-text').text(`\${count} Reviews • Level \${level}`);

            // Activity
            const icons = ['teal', 'blue', 'purple'];
            let activityHtml = '';
            reviews.slice(0, 3).forEach((r, i) => {
                activityHtml += `
                    <div class="activity-item">
                        <div class="activity-icon \${icons[i]}"><i class="fa fa-commenting"></i></div>
                        <div class="activity-info">
                            <p>Your review on \${r.title}</p>
                            <span>Recently</span>
                        </div>
                    </div>
                `;
            });
            $('#activity-list').html(activityHtml || '<p style="font-size:12px; color:var(--text-muted)">No recent activity</p>');
        }
    </script>
</body>
</html>
