<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Customer Reviews | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --transition: all 0.3s ease; }
        body.yt-dark { background: #0b0f18; color: #fff; font-family: 'Dosis', sans-serif; }

        .review-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            transition: var(--transition);
        }

        .review-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.05);
        }

        .stars { color: #f59e0b; font-size: 18px; margin-bottom: 10px; }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .reviewer-info img {
            width: 50px; height: 50px; border-radius: 50%; object-fit: cover;
        }

        .trip-tag {
            background: rgba(240, 76, 38, 0.1);
            color: #f04c26;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
            margin-bottom: 15px;
        }
    </style>
</head>

<body class="yt-dark">
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="reviews" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
            <div>
                <h2 style="font-weight: 800; margin: 0; font-size: 32px;">Customer Reviews</h2>
                <p style="color: rgba(255,255,255,0.5); margin-top: 5px;">See what your travelers are saying about your trips.</p>
            </div>
            <div style="text-align: right;">
                <div style="font-size: 36px; font-weight: 800; color: #f59e0b;">
                    <i class="fa fa-star"></i> 4.8
                </div>
                <div style="color: rgba(255,255,255,0.5); font-size: 14px;">Average Rating</div>
            </div>
        </div>

        <div class="row">
            <c:forEach var="review" items="${reviews}">
                <div class="col-md-6 mb-4">
                    <div class="review-card">
                        <div class="trip-tag"><i class="fa fa-map-marker"></i> ${review.trip.title}</div>
                        <div class="reviewer-info">
                            <img src="https://ui-avatars.com/api/?name=${review.user.name}&background=random">
                            <div>
                                <div style="font-weight: 700; font-size: 18px;">${review.user.name}</div>
                                <div style="color: rgba(255,255,255,0.4); font-size: 13px;">${review.createdAt.toLocalDate()}</div>
                            </div>
                        </div>
                        <div class="stars">
                            <c:forEach begin="1" end="${review.rating}">
                                <i class="fa fa-star"></i>
                            </c:forEach>
                            <c:forEach begin="1" end="${5 - review.rating}">
                                <i class="fa fa-star-o" style="color: rgba(255,255,255,0.2);"></i>
                            </c:forEach>
                        </div>
                        <p style="color: rgba(255,255,255,0.8); line-height: 1.6; font-size: 15px;">
                            "${review.reviewText}"
                        </p>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty reviews}">
                <div class="col-12 text-center" style="padding: 80px 20px;">
                    <i class="fa fa-star-half-o" style="font-size: 60px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                    <h3 style="font-weight: 700; color: #fff;">No Reviews Yet</h3>
                    <p style="color: rgba(255,255,255,0.4);">Once travelers complete their trips and leave feedback, it will appear here.</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>