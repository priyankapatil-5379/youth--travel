<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Trips - Youth Travel Admin</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        body { font-family: 'Dosis', sans-serif; background-color: #0f1015; color: #fff; }
        .admin-layout { display: flex; min-height: 100vh; }
        .admin-sidebar { width: 260px; background: #000; color: #fff; flex-shrink: 0; box-shadow: 4px 0 15px rgba(0,0,0,0.5); border-right: 1px solid #222; }
        .sidebar-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid #222; }
        .sidebar-header img { max-width: 150px; filter: brightness(0) invert(1); }
        .admin-nav { padding: 20px 0; }
        .admin-nav-item { padding: 12px 25px; display: flex; align-items: center; color: #888; text-decoration: none; transition: 0.3s; font-size: 16px; font-weight: 500; }
        .admin-nav-item i { margin-right: 15px; width: 20px; text-align: center; }
        .admin-nav-item:hover, .admin-nav-item.active { background: #1a1a1a; color: #fff; text-decoration: none; }
        .admin-nav-item.active { border-left: 4px solid #ff4d4d; background: rgba(255,77,77,0.1); }
        .admin-main { flex-grow: 1; padding: 40px; overflow-y: auto; }
        .admin-header { margin-bottom: 40px; }
        .admin-header h1 { font-weight: 700; color: #fff; margin: 0; font-size: 28px; text-transform: uppercase; }
        .empty-state { text-align: center; padding: 60px; color: #555; }
        .empty-state i { font-size: 64px; display: block; margin-bottom: 20px; color: #333; }
        .empty-state h2 { color: #666; }

        /* Card Layout Styles */
        .packages-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .pkg-card {
            background: #1e1e26;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            border: 1px solid #2a2a35;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s;
        }
        .pkg-card:hover {
            transform: translateY(-5px);
            border-color: #ff4d4d;
        }
        .pkg-cover {
            width: 100%;
            height: 180px;
            overflow: hidden;
            position: relative;
        }
        .pkg-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }
        .pkg-card:hover .pkg-cover img {
            transform: scale(1.1);
        }
        .pkg-header {
            padding: 20px;
            border-bottom: 1px solid #2a2a35;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .pkg-title {
            font-size: 18px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 5px;
        }
        .pkg-destination {
            font-size: 13px;
            color: #888;
        }
        .pkg-price {
            background: rgba(255,77,77,0.1);
            color: #ff4d4d;
            padding: 6px 12px;
            border-radius: 8px;
            font-weight: 800;
            font-size: 16px;
        }
        .pkg-body {
            padding: 20px;
            flex-grow: 1;
        }
        .vendor-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }
        .vendor-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #2a2a35;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #888;
        }
        .vendor-name {
            font-size: 14px;
            color: #ddd;
            font-weight: 600;
        }
        .vendor-label {
            font-size: 11px;
            color: #777;
            text-transform: uppercase;
        }
        .rating-section {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }
        .stars {
            color: #fbbf24;
            font-size: 14px;
        }
        .rating-text {
            color: #aaa;
            font-size: 13px;
            font-weight: 600;
        }
        .reviews-container {
            background: #15151a;
            border-radius: 10px;
            padding: 15px;
            max-height: 150px;
            overflow-y: auto;
        }
        .reviews-container::-webkit-scrollbar {
            width: 4px;
        }
        .reviews-container::-webkit-scrollbar-thumb {
            background: #333;
            border-radius: 4px;
        }
        .review-item {
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid #222;
        }
        .review-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }
        .review-user {
            font-size: 12px;
            color: #ff4d4d;
            font-weight: 600;
            margin-bottom: 4px;
        }
        .review-text {
            font-size: 13px;
            color: #bbb;
            line-height: 1.4;
        }
        .no-reviews {
            color: #666;
            font-size: 13px;
            font-style: italic;
            text-align: center;
            padding: 10px 0;
        }
        .pkg-footer {
            padding: 15px 20px;
            background: #1a1a21;
            border-top: 1px solid #2a2a35;
        }
        .view-btn {
            display: block;
            text-align: center;
            background: #ff4d4d;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 8px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.2s;
        }
        .view-btn:hover { background: #e60000; color: #fff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="admin-layout">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel"></a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item active"><i class="fa fa-suitcase"></i> Manage Trips</a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item"><i class="fa fa-users"></i> User Accounts</a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item"><i class="fa fa-handshake-o"></i> Vendor Requests</a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item"><i class="fa fa-envelope"></i> Inquiries</a>
                <div style="margin-top: 50px; border-top: 1px solid #222; padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item"><i class="fa fa-sign-out"></i> Back to Site</a>
                </div>
            </nav>
        </aside>
        <main class="admin-main">
            <header class="admin-header">
                <h1>All Trip Packages</h1>
            </header>
            <div>
                <c:choose>
                    <c:when test="${empty packages}">
                        <div class="empty-state">
                            <i class="fa fa-suitcase"></i>
                            <h2>No Packages Found</h2>
                            <p>Vendors haven't added any trip packages yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="packages-grid">
                            <c:forEach var="pkg" items="${packages}">
                                <div class="pkg-card">
                                    <div class="pkg-cover">
                                        <c:choose>
                                            <c:when test="${not empty pkg.imageUrl}">
                                                <img src="<c:url value='${pkg.imageUrl}'/>" alt="${pkg.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="<c:url value='/views/assets/images/bg-texture.jpg'/>" alt="No Image">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="pkg-header">
                                        <div>
                                            <div class="pkg-title">${pkg.title}</div>
                                            <div class="pkg-destination"><i class="fa fa-map-marker" style="color:#ff4d4d;"></i> ${pkg.destination}</div>
                                        </div>
                                        <div class="pkg-price">₹${pkg.price}</div>
                                    </div>
                                    
                                    <div class="pkg-body">
                                        <div class="vendor-info">
                                            <div class="vendor-avatar">
                                                <i class="fa fa-building-o"></i>
                                            </div>
                                            <div>
                                                <div class="vendor-label">Added By</div>
                                                <div class="vendor-name">${pkg.vendor.businessName}</div>
                                            </div>
                                        </div>
                                        
                                        <div class="rating-section">
                                            <div class="stars">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="fa ${i <= pkg.averageRating ? 'fa-star' : 'fa-star-o'}"></i>
                                                </c:forEach>
                                            </div>
                                            <div class="rating-text">
                                                ${pkg.averageRating} (${pkg.reviews != null ? pkg.reviews.size() : 0} Reviews)
                                            </div>
                                        </div>
                                        
                                        <div class="reviews-container">
                                            <c:choose>
                                                <c:when test="${pkg.reviews != null && pkg.reviews.size() > 0}">
                                                    <c:forEach var="review" items="${pkg.reviews}">
                                                        <div class="review-item">
                                                            <div class="review-user"><i class="fa fa-user-circle-o"></i> ${review.user.name} <span style="float:right; color:#fbbf24;"><i class="fa fa-star"></i> ${review.rating}</span></div>
                                                            <div class="review-text">"${review.reviewText}"</div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-reviews">No reviews or comments yet.</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <div class="pkg-footer">
                                        <a href="<c:url value='/admin/trips/${pkg.id}'/>" class="view-btn">
                                            <i class="fa fa-eye"></i> View Full Details & Bookings
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>
