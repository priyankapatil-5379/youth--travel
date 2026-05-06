<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reviews | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #e63946; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 40px 30px 40px; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: rgba(0,0,0,0.4); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .review-card { background: rgba(0,0,0,0.3); backdrop-filter: blur(15px); padding: 30px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.1); margin-bottom: 25px; transition: var(--transition); box-shadow: 0 8px 32px 0 rgba(0,0,0,0.3); }
        .review-card:hover { border-color: var(--primary-blue); transform: translateY(-3px); }
        .stars { color: #ffc107; font-size: 16px; margin-bottom: 12px; filter: drop-shadow(0 2px 4px rgba(0,0,0,0.5)); }
        .package-name { font-size: 20px; font-weight: 800; color: #fff; margin-bottom: 8px; text-shadow: 0 2px 5px rgba(0,0,0,0.8); }
        .review-date { font-size: 13px; color: rgba(255,255,255,0.6); margin-bottom: 15px; font-weight: 500; }
        .review-text { font-size: 16px; color: #fff; line-height: 1.6; text-shadow: 0 1px 3px rgba(0,0,0,0.5); font-weight: 500; }
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
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="reviews" />
        </jsp:include>
        <main class="main-content">
            <div class="mb-4">
                <div>
                    <h2 style="font-weight: 800; margin: 0; color: #fff; text-shadow: 0 4px 15px rgba(0,0,0,0.8); font-size: 32px;">My Reviews</h2>
                    <p style="color: #fff; margin: 0; font-weight: 600; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">Feedback you've shared on your adventures</p>
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
                            <div class="package-name">${review.trip.title}</div>
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
