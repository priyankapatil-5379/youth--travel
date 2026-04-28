<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reviews | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .sidebar { width: 240px; background: #161c28; padding-top: 80px; position: fixed; height: 100vh; border-right: 1px solid rgba(255,255,255,0.05); }
        .nav-menu { list-style: none; padding: 0; margin: 0; }
        .nav-item a { display: flex; align-items: center; padding: 12px 25px; color: rgba(255,255,255,0.6); text-decoration: none; font-weight: 500; transition: var(--transition); gap: 15px; font-size: 15px; }
        .nav-item.active a { background: var(--primary-blue); color: #fff; border-radius: 0 25px 25px 0; margin-right: 15px; }
        .nav-item a:hover:not(.active) { color: #fff; background: rgba(240, 76, 38, 0.1); }
        .main-content { flex: 1; margin-left: 240px; padding: 100px 30px 40px; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: #161c28; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .review-card { background: #161c28; padding: 25px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.05); margin-bottom: 20px; transition: var(--transition); }
        .review-card:hover { border-color: var(--primary-blue); }
        .stars { color: #ffc107; font-size: 14px; margin-bottom: 10px; }
        .package-name { font-size: 18px; font-weight: 700; color: #fff; margin-bottom: 5px; }
        .review-date { font-size: 12px; color: var(--text-muted); margin-bottom: 15px; }
        .review-text { font-size: 15px; color: rgba(255,255,255,0.8); line-height: 1.6; }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-logo"><a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <a href="<c:url value='/user/dashboard'/>" class="btn" style="background: var(--primary-blue); color: #fff; font-weight: 700; border-radius: 8px; padding: 8px 20px; border: none; font-size: 14px; transition: var(--transition);">
                Back to Dashboard
            </a>
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
                <li class="nav-item"><a href="<c:url value='/user/my-bookings'/>"><i class="fa fa-calendar-check-o"></i> My Bookings</a></li>
                <li class="nav-item"><a href="<c:url value='/user/saved-trips'/>"><i class="fa fa-heart-o"></i> Saved Trips</a></li>
                <li class="nav-item active"><a href="<c:url value='/user/my-reviews'/>"><i class="fa fa-star-o"></i> My Reviews</a></li>
                <li class="nav-item"><a href="<c:url value='/user/payments'/>"><i class="fa fa-credit-card"></i> Payments</a></li>
                <li class="nav-item"><a href="<c:url value='/user/messages'/>"><i class="fa fa-envelope-o"></i> Messages</a></li>
                <li style="margin: 20px 0; border-top: 1px solid rgba(255,255,255,0.1);"></li>
                <li class="nav-item"><a href="<c:url value='/user/profile'/>"><i class="fa fa-cog"></i> Profile Settings</a></li>
                <li class="nav-item"><a href="<c:url value='/user/logout'/>"><i class="fa fa-sign-out"></i> Logout</a></li>
            </ul>
        </aside>
        <main class="main-content">
            <div class="mb-4">
                <div>
                    <h2 style="font-weight: 800; margin: 0;">My Reviews</h2>
                    <p style="color: var(--text-muted); margin: 0;">Feedback you've shared on your adventures</p>
                </div>
            </div>
            <c:choose>
                <c:when test="${not empty reviews}">
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-card">
                            <div class="stars">
                                <c:forEach begin="1" end="${review.rating}"><i class="fa fa-star"></i></c:forEach>
                                <c:forEach begin="${review.rating + 1}" end="5"><i class="fa fa-star-o"></i></c:forEach>
                            </div>
                            <div class="package-name">${review.tripPackage.title}</div>
                            <div class="review-date">${review.createdAt}</div>
                            <div class="review-text">${review.reviewText}</div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="background: #161c28; padding: 60px; border-radius: 15px; text-align: center; border: 1px solid rgba(255,255,255,0.05);">
                        <i class="fa fa-star-o" style="font-size: 50px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                        <h3 style="font-weight: 700;">No reviews yet</h3>
                        <p style="color: var(--text-muted);">You haven't shared your thoughts on any trips yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>
