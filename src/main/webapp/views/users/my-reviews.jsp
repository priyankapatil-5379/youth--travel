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
            --bg-body: #f8fafc;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border-color: #f1f5f9;
            --sidebar-width: 260px;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-body); 
            color: var(--text-main); 
            margin: 0; 
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; }

        .page-header { margin-bottom: 32px; display: flex; justify-content: space-between; align-items: flex-start; }
        .page-header h1 { font-size: 28px; font-weight: 800; margin: 0; }
        .page-header p { color: var(--text-muted); font-size: 14px; margin-top: 4px; }

        .btn-review {
            background: var(--primary-teal); color: white; border: none; border-radius: 8px;
            padding: 10px 20px; font-weight: 700; font-size: 14px; display: flex; align-items: center; gap: 8px;
        }

        /* Stats Row */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 32px; }
        .stat-card {
            background: white; border-radius: 20px; padding: 24px; border: 1px solid var(--border-color);
            display: flex; align-items: center; gap: 15px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02);
        }
        .stat-icon {
            width: 44px; height: 44px; border-radius: 12px; display: flex; align-items: center; 
            justify-content: center; font-size: 18px;
        }
        .icon-blue { background: #e0f2fe; color: #008080; }
        .icon-orange { background: #ffedd5; color: #f59e0b; }
        .icon-green { background: #dcfce7; color: #10b981; }
        .icon-indigo { background: #e0e7ff; color: #6366f1; }
        
        .stat-info .label { font-size: 11px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-info .value { font-size: 24px; font-weight: 800; color: #0f172a; display: block; }
        .stat-info .sub { font-size: 11px; color: var(--text-muted); }

        .layout-row { display: grid; grid-template-columns: 1fr 340px; gap: 32px; }

        /* Review Card Layout */
        .review-section-header { font-size: 14px; font-weight: 700; margin-bottom: 20px; color: #0f172a; }

        .review-card {
            background: white; border-radius: 24px; padding: 24px; margin-bottom: 24px;
            border: 1px solid var(--border-color); box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        
        .review-card:hover { transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0,0,0,0.05); }

        .review-top-main { display: flex; gap: 24px; margin-bottom: 20px; }
        .trip-thumb { width: 140px; height: 140px; border-radius: 16px; object-fit: cover; }
        
        .review-header-info { flex: 1; }
        .header-meta-row { display: flex; justify-content: space-between; align-items: flex-start; }
        .trip-name { font-size: 18px; font-weight: 800; color: #0f172a; margin: 0; }
        .trip-loc { font-size: 13px; color: var(--text-muted); margin: 4px 0; }
        
        .badge-published { background: #f0fdf4; color: #166534; padding: 4px 12px; border-radius: 100px; font-size: 10px; font-weight: 800; text-transform: uppercase; }
        .stars { color: #fbbf24; font-size: 16px; margin: 12px 0; }
        
        .review-title { font-size: 15px; font-weight: 700; color: #0f172a; margin-bottom: 8px; }
        .review-desc { font-size: 14px; color: var(--text-muted); line-height: 1.6; margin-bottom: 16px; }

        .tag-row { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 20px; }
        .tag { background: #f1f5f9; color: #475569; padding: 4px 14px; border-radius: 100px; font-size: 11px; font-weight: 600; }

        .photo-row { display: flex; gap: 12px; margin-bottom: 20px; overflow-x: auto; padding-bottom: 10px; }
        .photo-row img { width: 80px; height: 80px; border-radius: 12px; object-fit: cover; border: 1px solid var(--border-color); }

        .review-footer-row { display: flex; justify-content: flex-end; align-items: center; border-top: 1px solid var(--border-color); padding-top: 16px; }
        .time-ago { font-size: 12px; color: var(--text-muted); font-weight: 500; }

        /* Right Sidebar */
        .widget { background: white; border-radius: 20px; padding: 24px; border: 1px solid var(--border-color); margin-bottom: 24px; }
        .widget h4 { font-size: 15px; font-weight: 800; margin-bottom: 20px; }

        .dist-item { display: flex; align-items: center; gap: 12px; margin-bottom: 12px; }
        .dist-label { width: 50px; font-size: 12px; color: var(--text-muted); }
        .dist-progress { flex: 1; height: 6px; background: #f1f5f9; border-radius: 100px; overflow: hidden; }
        .dist-fill { height: 100%; background: #22c55e; border-radius: 100px; }
        .dist-pct { width: 50px; text-align: right; font-size: 11px; color: var(--text-muted); }

        .activity-item { display: flex; gap: 15px; margin-bottom: 20px; }
        .activity-icon { width: 36px; height: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 14px; flex-shrink: 0; }
        .activity-content p { font-size: 13px; font-weight: 700; margin: 0; }
        .activity-content span { font-size: 11px; color: var(--text-muted); }

        .bg-teal-light { background: #ccfbf1; color: #0d9488; }
        .bg-blue-light { background: #dbeafe; color: #2563eb; }
        .bg-purple-light { background: #f3e8ff; color: #9333ea; }

        .traveler-badge-card { text-align: center; }
        .badge-circle { width: 80px; height: 80px; border-radius: 50%; background: #fef3c7; border: 4px solid white; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); margin: 0 auto 16px; display: flex; align-items: center; justify-content: center; font-size: 32px; color: #d97706; }

        .empty-state { text-align: center; padding: 100px 40px; background: white; border-radius: 24px; border: 1px solid var(--border-color); }
        .empty-state i { font-size: 64px; color: #e2e8f0; margin-bottom: 24px; }
        
        .pagination { display: flex; justify-content: center; gap: 10px; margin-top: 40px; font-size: 13px; color: var(--text-muted); align-items: center; }
        .page-link { width: 32px; height: 32px; border: 1px solid var(--border-color); border-radius: 8px; display: flex; align-items: center; justify-content: center; background: white; cursor: pointer; }
        .page-link.active { background: #f1f5f9; color: var(--primary-teal); font-weight: 800; border-color: var(--primary-teal); }
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
                <button class="btn-review" onclick="window.location.href='/user/my-bookings'">
                    <i class="fa fa-pencil-square-o"></i> Write a Review
                </button>
            </div>

            <!-- Stats Overview -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon icon-blue"><i class="fa fa-commenting"></i></div>
                    <div class="stat-info">
                        <span class="label">Total Reviews</span>
                        <span id="stat-total" class="value">0</span>
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
                    <div class="stat-icon icon-green"><i class="fa fa-pulse"></i></div>
                    <div class="stat-info">
                        <span class="label">Helpful Votes</span>
                        <span id="stat-helpful" class="value">0</span>
                        <span class="sub">From other explorers</span>
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

            <div class="layout-row">
                <!-- Left Column -->
                <div>
                    <h2 class="review-section-header">Your Reviews</h2>
                    <div id="reviews-container">
                        <!-- Shimmer/Loading -->
                        <div class="review-card" style="height: 200px; background: white; opacity: 0.5;"></div>
                    </div>

                    <div class="pagination" id="pagination-block" style="display: none;">
                        <span>Showing <span id="page-range">1 to 3</span> of <span id="total-count">3</span> reviews</span>
                        <div style="display: flex; gap: 8px; margin-left: 15px;">
                            <div class="page-link"><i class="fa fa-chevron-left"></i></div>
                            <div class="page-link active">1</div>
                            <div class="page-link">2</div>
                            <div class="page-link">3</div>
                            <div class="page-link"><i class="fa fa-chevron-right"></i></div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="sidebar-widgets">
                    <div class="widget">
                        <h4>Rating Distribution</h4>
                        <div id="rating-dist"></div>
                    </div>

                    <div class="widget">
                        <h4>Recent Activity</h4>
                        <div id="activity-list"></div>
                    </div>

                    <div class="widget traveler-badge-card">
                        <h4>Traveler Level</h4>
                        <div class="badge-circle"><i class="fa fa-shield"></i></div>
                        <h5 style="font-weight: 800; margin-bottom: 5px;">Explorer</h5>
                        <p style="font-size: 12px; color: var(--text-muted); line-height: 1.5;">Great job! Keep sharing your reflections.</p>
                        <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid var(--border-color); font-size: 11px; font-weight: 700; color: var(--text-muted);">
                            8 Reviews • Level 2
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', fetchReviews);

        async function fetchReviews() {
            try {
                const response = await fetch("<c:url value='/user/api/reviews/user'/>");
                if (!response.ok) throw new Error('Server returned ' + response.status);
                const data = await response.json();
                const reviews = Array.isArray(data) ? data : [];
                renderReviews(reviews);
                updateStats(reviews);
            } catch (err) {
                console.error('Error:', err);
                document.getElementById('reviews-container').innerHTML = '<div class="alert alert-danger">Failed to load reviews. Please try again later.</div>';
            }
        }

        function renderReviews(reviews) {
            const container = document.getElementById('reviews-container');
            if (reviews.length === 0) {
                container.innerHTML = `
                    <div class="empty-state">
                        <i class="fa fa-camera-retro"></i>
                        <h2>No reflections yet</h2>
                        <p>Share your journey experiences and help other explorers!</p>
                    </div>
                `;
                return;
            }

            container.innerHTML = reviews.map(r => {
                const img = r.trip.imageUrl || 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600';
                const stars = Array(5).fill(0).map((_, i) => `<i class="fa fa-star \${i < r.rating ? '' : 'text-muted'}" style="color: \${i < r.rating ? '#fbbf24' : '#e2e8f0'}"></i>`).join('');
                const tags = r.tags ? r.tags.split(',').map(t => `<span class="tag">\${t}</span>`).join('') : '';
                const timeAgo = getTimeAgo(new Date(r.createdAt));
                
                let photosHtml = '';
                if (r.photos) {
                    photosHtml = '<div class="photo-row">' + r.photos.split(',').map(p => `<img src="\${p}" alt="Moment">`).join('') + '</div>';
                }

                return `
                    <div class="review-card">
                        <div class="review-top-main">
                            <img src="\${img}" class="trip-thumb" alt="Trip">
                            <div class="review-header-info">
                                <div class="header-meta-row">
                                    <div>
                                        <h3 class="trip-name">\${r.trip.title}</h3>
                                        <p class="trip-loc">\${r.trip.destination}, India</p>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: 15px;">
                                        <span class="badge-published">Published</span>
                                        <i class="fa fa-ellipsis-v" style="color: var(--text-muted); cursor: pointer;"></i>
                                    </div>
                                </div>
                                <div class="stars">\${stars}</div>
                                <h4 class="review-title">\${r.title || 'Incredible Experience!'}</h4>
                                <p class="review-desc">\${r.reviewText}</p>
                                <div class="tag-row">\${tags}</div>
                                \${photosHtml}
                            </div>
                        </div>
                        <div class="review-footer-row">
                            <span class="time-ago">\${timeAgo}</span>
                        </div>
                    </div>
                `;
            }).join('');

            document.getElementById('pagination-block').style.display = 'flex';
            document.getElementById('page-range').innerText = `1 to \${reviews.length}`;
            document.getElementById('total-count').innerText = reviews.length;

            renderDistribution(reviews);
            renderActivity(reviews);
        }

        function updateStats(reviews) {
            document.getElementById('stat-total').innerText = reviews.length;
            const avg = reviews.length ? (reviews.reduce((acc, r) => acc + r.rating, 0) / reviews.length).toFixed(1) : '0.0';
            document.getElementById('stat-avg').innerText = avg;
            document.getElementById('stat-helpful').innerText = Math.floor(reviews.length * 2.5); 
            document.getElementById('stat-views').innerText = Math.floor(reviews.length * 32);
        }

        function renderDistribution(reviews) {
            const counts = { 5:0, 4:0, 3:0, 2:0, 1:0 };
            reviews.forEach(r => counts[r.rating]++);
            const total = reviews.length || 1;
            
            const html = [5,4,3,2,1].map(s => {
                const pct = Math.round((counts[s] / total) * 100);
                return `
                    <div class="dist-item">
                        <span class="dist-label">\${s} Stars</span>
                        <div class="dist-progress">
                            <div class="dist-fill" style="width: \${pct}%"></div>
                        </div>
                        <span class="dist-pct">\${counts[s]} (\${pct}%)</span>
                    </div>
                `;
            }).join('');
            document.getElementById('rating-dist').innerHTML = html;
        }

        function renderActivity(reviews) {
            const icons = ['bg-teal-light', 'bg-blue-light', 'bg-purple-light'];
            const html = reviews.slice(0, 3).map((r, i) => `
                <div class="activity-item">
                    <div class="activity-icon \${icons[i % 3]}"><i class="fa fa-commenting"></i></div>
                    <div class="activity-content">
                        <p>Your review on \${r.trip.title}</p>
                        <span>\${getTimeAgo(new Date(r.createdAt))}</span>
                    </div>
                </div>
            `).join('');
            document.getElementById('activity-list').innerHTML = html || '<p class="text-muted" style="font-size: 12px;">No recent activity</p>';
        }

        function getTimeAgo(date) {
            const seconds = Math.floor((new Date() - date) / 1000);
            if (seconds < 60) return "Just now";
            let interval = seconds / 31536000;
            if (interval > 1) return Math.floor(interval) + " years ago";
            interval = seconds / 2592000;
            if (interval > 1) return Math.floor(interval) + " months ago";
            interval = seconds / 86400;
            if (interval > 1) return Math.floor(interval) + " days ago";
            interval = seconds / 3600;
            if (interval > 1) return Math.floor(interval) + " hours ago";
            interval = seconds / 60;
            if (interval > 1) return Math.floor(interval) + " mins ago";
            return "Just now";
        }
    </script>
</body>
</html>
