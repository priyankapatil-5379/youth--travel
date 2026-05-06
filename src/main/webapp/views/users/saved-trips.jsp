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
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root {
            --sidebar-teal: #14b8a6;
            --sidebar-teal-dark: #0f766e;
            --accent-coral: #ef4444;
            --accent-coral-dark: #dc2626;
            --bg-main: #f8fafc;
            --bg-card: #ffffff;
            --border-light: #e5e7eb;
            --text-main: #1f2937;
            --text-secondary: #6b7280;
            --transition: all 0.3s ease;
        }

        body.theme-light-premium {
            font-family: 'Dosis', sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 40px 30px 40px; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: rgba(0,0,0,0.4); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; margin-top: 30px; }
        .package-card { 
            background: var(--bg-card); 
            border-radius: 20px; overflow: hidden; 
            border: 1px solid var(--border-light); 
            transition: var(--transition); position: relative; 
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03); 
        }
        .package-card:hover { transform: translateY(-8px); border-color: var(--sidebar-teal); box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08); }
        
        .package-img-wrapper { position: relative; width: 100%; aspect-ratio: 16 / 10; overflow: hidden; background: #eee; }
        .package-img { width: 100%; height: 100%; object-fit: cover; transition: 0.5s ease; }
        .package-card:hover .package-img { transform: scale(1.05); }
        
        .package-content { padding: 25px; }
        .package-title { font-size: 18px; font-weight: 800; color: var(--text-main); margin-bottom: 12px; line-height: 1.4; height: 50px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .package-meta { font-size: 14px; color: var(--text-secondary); margin-bottom: 10px; display: flex; align-items: center; gap: 8px; }
        .package-meta i { color: var(--sidebar-teal); }
        
        .package-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--border-light); }
        .package-price { font-size: 20px; font-weight: 800; color: var(--text-main); display: flex; align-items: baseline; gap: 5px; }
        .package-price span { font-size: 13px; font-weight: 400; color: var(--text-secondary); }
        
        .btn-view { 
            display: inline-block;
            background: #f1f5f9; 
            color: var(--text-main); 
            border: 1px solid var(--border-light); 
            padding: 10px 20px; 
            border-radius: 10px; 
            font-size: 13px; 
            font-weight: 700; 
            text-transform: uppercase; 
            transition: 0.3s; 
            text-decoration: none; 
            text-align: center;
        }
        .package-card:hover .btn-view { background: var(--accent-coral); color: #fff; border-color: var(--accent-coral); box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2); }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 90px 20px 40px; }
            .header { padding: 0 15px; }
            .header-logo img { height: 30px !important; }
        }

        @media (max-width: 576px) {
            .package-grid { grid-template-columns: 1fr; }
            h2 { font-size: 24px !important; }
        }

        /* Prevent infinite horizontal stretch on ultra-wide screens */
        @media (min-width: 2000px) {
            .header, .main-content {
                max-width: 1920px;
                margin-left: auto;
                margin-right: auto;
            }
            .wrapper { justify-content: center; }
        }
    </style>
</head>
<body class="theme-light-premium">
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="saved" />
        </jsp:include>
        <main class="main-content">
            <div class="container-fluid">
                <div class="mb-5">
                    <h2 style="font-weight: 800; margin: 0; color: var(--text-main); font-size: 36px; letter-spacing: -1px;">Saved Packages</h2>
                    <p style="color: var(--text-secondary); margin: 5px 0 0; font-weight: 500; font-size: 16px;">Your collection of dream adventures</p>
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
                        <div style="background: #fff; padding: 80px 40px; border-radius: 24px; text-align: center; border: 1px solid var(--border-light); box-shadow: 0 10px 30px rgba(0,0,0,0.02);">
                            <div style="width: 80px; height: 80px; background: rgba(20, 184, 166, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 25px;">
                                <i class="fa fa-heart-o" style="font-size: 32px; color: var(--sidebar-teal);"></i>
                            </div>
                            <h3 style="font-weight: 800; color: var(--text-main); margin-bottom: 10px;">No saved packages yet</h3>
                            <p style="color: var(--text-secondary); font-size: 16px; max-width: 400px; margin: 0 auto;">Start exploring and save the packages you love!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>

