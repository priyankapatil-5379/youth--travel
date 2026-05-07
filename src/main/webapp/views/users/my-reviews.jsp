<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reviews | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f1f5f9;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-body); 
            color: var(--text-main); 
            margin: 0; padding: 0; 
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; }

        .page-header { margin-bottom: 32px; }
        .page-header h1 { font-size: 28px; font-weight: 800; color: var(--text-main); margin: 0; letter-spacing: -0.5px; }
        .page-header p { color: var(--text-muted); margin: 4px 0 0; font-size: 15px; font-weight: 500; }

        .review-card { 
            background: var(--bg-card); 
            padding: 32px; 
            border-radius: 16px; 
            border: 1px solid var(--border-color); 
            margin-bottom: 24px; 
            transition: var(--transition); 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05); 
        }
        .review-card:hover { border-color: var(--primary); transform: translateY(-2px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        
        .stars { color: #fbbf24; font-size: 16px; margin-bottom: 16px; display: flex; gap: 4px; }
        .package-name { font-size: 18px; font-weight: 700; color: var(--text-main); margin-bottom: 8px; }
        .review-date { font-size: 13px; color: var(--text-muted); margin-bottom: 16px; font-weight: 600; }
        .review-text { font-size: 15px; color: var(--text-main); line-height: 1.6; font-weight: 400; }

        .empty-state {
            background: var(--bg-card);
            padding: 80px 40px;
            border-radius: 20px;
            text-align: center;
            border: 2px dashed var(--border-color);
        }
        .empty-state i { font-size: 60px; color: #e2e8f0; margin-bottom: 24px; }
        .empty-state h3 { font-size: 20px; font-weight: 800; color: var(--text-main); margin-bottom: 8px; }
        .empty-state p { color: var(--text-muted); font-size: 15px; font-weight: 500; }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 80px 20px 40px !important; }
        }
    </style>
</head>
<body class="light-theme">
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="reviews" />
        </jsp:include>
        <main class="main-content">
            <div class="page-header">
                <h1>My Reflections</h1>
                <p>The stories you've shared from your journeys</p>
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
                    <div class="empty-state">
                        <i class="fa fa-star-o"></i>
                        <h3>No reflections yet</h3>
                        <p>Share your journey experiences and help other explorers!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>
