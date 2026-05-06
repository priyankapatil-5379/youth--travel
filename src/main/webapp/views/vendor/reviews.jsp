<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Customer Reviews | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --sidebar-width: 260px;
            --star-gold: #f59e0b;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 40px;
            min-height: 100vh;
            transition: 0.3s;
        }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 20px; }
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .page-header h2 {
            font-weight: 800;
            margin: 0;
            font-size: 32px;
            letter-spacing: -1px;
        }

        .page-header p {
            color: var(--text-muted);
            margin-top: 8px;
            font-size: 15px;
        }

        .rating-summary {
            text-align: right;
            background: #ffffff;
            padding: 16px 24px;
            border-radius: 16px;
            border: 1px solid var(--border-color);
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        .rating-summary .big-star {
            font-size: 32px;
            font-weight: 800;
            color: var(--star-gold);
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 10px;
        }

        .review-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 32px;
            margin-bottom: 24px;
            transition: 0.3s;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            position: relative;
            height: 100%;
        }

        .review-card:hover {
            transform: translateY(-4px);
            border-color: var(--primary);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .trip-tag {
            background: #e0f2f2;
            color: var(--primary);
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 20px;
        }

        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .reviewer-info img {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            object-fit: cover;
        }

        .reviewer-name {
            font-weight: 700;
            font-size: 16px;
            color: var(--text-main);
        }

        .review-date {
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 500;
        }

        .stars {
            color: var(--star-gold);
            font-size: 14px;
            margin-bottom: 16px;
            display: flex;
            gap: 2px;
        }
        
        .review-text {
            color: var(--text-main);
            line-height: 1.7;
            font-size: 15px;
            font-weight: 500;
            font-style: italic;
        }

        .empty-state {
            padding: 80px 20px;
            text-align: center;
            background: white;
            border-radius: 24px;
            border: 1px solid var(--border-color);
        }

        .empty-state i {
            font-size: 56px;
            color: var(--border-color);
            margin-bottom: 24px;
        }

        .empty-state h3 {
            font-weight: 700;
            color: var(--text-main);
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="reviews" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <div>
                <h2>Customer Reviews</h2>
                <p>Authentic traveler feedback and ratings for your published trips.</p>
            </div>
            <div class="rating-summary">
                <div class="big-star">
                    <i class="fa fa-star"></i> 4.8
                </div>
                <div style="color: var(--text-muted); font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Average Rating</div>
            </div>
        </div>

        <div class="row">
            <c:forEach var="review" items="${reviews}">
                <div class="col-md-6 mb-4">
                    <div class="review-card">
                        <div class="trip-tag">
                            <i class="fa fa-map-marker"></i> ${review.trip.title}
                        </div>
                        <div class="reviewer-info">
                            <img src="https://ui-avatars.com/api/?name=${review.user.name}&background=random&rounded=true&size=128">
                            <div>
                                <div class="reviewer-name">${review.user.name}</div>
                                <div class="review-date">${review.createdAt.toLocalDate()}</div>
                            </div>
                        </div>
                        <div class="stars">
                            <c:forEach begin="1" end="${review.rating}">
                                <i class="fa fa-star"></i>
                            </c:forEach>
                            <c:forEach begin="1" end="${5 - review.rating}">
                                <i class="fa fa-star-o" style="color: var(--border-color);"></i>
                            </c:forEach>
                        </div>
                        <p class="review-text">
                            "${review.reviewText}"
                        </p>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty reviews}">
                <div class="col-12">
                    <div class="empty-state">
                        <i class="fa fa-star-half-o"></i>
                        <h3>No Reviews Yet</h3>
                        <p style="color: var(--text-muted);">Once travelers complete their trips and leave feedback, it will appear here.</p>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
</body>
</html>