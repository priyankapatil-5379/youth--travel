<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saved Trips | Youth Travel</title>
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

        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 24px; }
        
        .package-card { 
            background: var(--bg-card); 
            border-radius: 16px; 
            overflow: hidden; 
            border: 1px solid var(--border-color); 
            transition: var(--transition); 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05); 
            display: flex;
            flex-direction: column;
        }
        .package-card:hover { transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); border-color: var(--primary); }
        
        .package-img-wrapper { position: relative; width: 100%; aspect-ratio: 16 / 10; overflow: hidden; background: #f1f5f9; }
        .package-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .package-card:hover .package-img { transform: scale(1.05); }
        
        .package-content { padding: 24px; flex: 1; display: flex; flex-direction: column; }
        .package-meta { font-size: 13px; color: var(--primary); margin-bottom: 12px; display: flex; align-items: center; font-weight: 600; }
        .package-meta i { margin-right: 8px; }
        
        .package-title { 
            font-size: 18px; 
            font-weight: 700; 
            margin-bottom: 16px; 
            color: var(--text-main); 
            line-height: 1.4;
            height: 50px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .package-footer { 
            display: flex; 
            align-items: center; 
            justify-content: space-between; 
            margin-top: auto; 
            padding-top: 20px; 
            border-top: 1px solid var(--border-color); 
        }
        
        .package-price { font-size: 22px; font-weight: 800; color: var(--text-main); }
        .package-price span { font-size: 13px; font-weight: 500; color: var(--text-muted); }
        
        .btn-view { 
            background: var(--primary); 
            color: #ffffff !important; 
            padding: 10px 20px; 
            border-radius: 10px; 
            font-size: 13px; 
            font-weight: 700; 
            transition: var(--transition); 
            text-decoration: none !important; 
            display: inline-block; 
        }
        .btn-view:hover { background: var(--primary-hover); transform: translateY(-1px); }

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
            <jsp:param name="activePage" value="saved" />
        </jsp:include>
        <main class="main-content">
            <div class="container-fluid">
                <div class="page-header">
                    <h1>Saved Adventures</h1>
                    <p>Your curated collection of dream destinations</p>
                </div>
                <c:choose>
                    <c:when test="${not empty savedPackages}">
                        <div class="package-grid">
                            <c:forEach var="saved" items="${savedPackages}">
                                <div class="package-card">
                                    <div class="package-img-wrapper">
                                        <img src="${not empty saved.trip.imageUrl ? saved.trip.imageUrl : 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80'}" class="package-img">
                                    </div>
                                    <div class="package-content">
                                        <div class="package-meta"><i class="fa fa-map-marker"></i> ${saved.trip.destination}</div>
                                        <div class="package-title">${saved.trip.title}</div>
                                        <div class="package-footer">
                                            <div class="package-price">&#8377;<fmt:formatNumber value="${saved.trip.price}" pattern="#,##0" /> <span>/ person</span></div>
                                            <a href="<c:url value='/user/package/${saved.trip.id}'/>" class="btn-view">View Details</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fa fa-heart-o"></i>
                            <h3>No saved adventures yet</h3>
                            <p>Start exploring and save the journeys that inspire you!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>

