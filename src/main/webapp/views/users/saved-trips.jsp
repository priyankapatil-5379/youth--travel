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
        :root { --primary-blue: #e63946; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 100px 30px 40px; }
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: rgba(0,0,0,0.4); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .package-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; margin-top: 20px; }
        .package-card { background: rgba(20, 25, 35, 0.6); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); border-radius: 20px; overflow: hidden; border: 1px solid rgba(255, 255, 255, 0.08); transition: all 0.3s ease; position: relative; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3); }
        .package-card:hover { transform: translateY(-8px); border-color: rgba(230, 57, 70, 0.5); box-shadow: 0 15px 40px rgba(230, 57, 70, 0.2), inset 0 0 20px rgba(230, 57, 70, 0.05); }
        .package-img-wrapper { position: relative; width: 100%; aspect-ratio: 16 / 10; overflow: hidden; background: #000; }
        .package-img-wrapper::after { content: ''; position: absolute; bottom: 0; left: 0; right: 0; height: 60%; background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, transparent 100%); pointer-events: none; z-index: 1; }
        .package-img { width: 100%; height: 100%; object-fit: cover; object-position: center; transition: opacity 0.5s ease, transform 0.5s ease; position: absolute; top: 0; left: 0; z-index: 0; }
        .package-card:hover .package-img { opacity: 0.8; transform: scale(1.1); }
        .package-content { padding: 25px 20px; }
        .package-title { font-size: 20px; font-weight: 800; letter-spacing: 0.5px; margin-bottom: 15px; color: #fff; height: 52px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; text-shadow: 0 2px 6px rgba(0,0,0,0.8); }
        .package-meta { font-size: 14px; color: rgba(255,255,255,0.85); margin-bottom: 8px; display: flex; align-items: center; }
        .package-meta i { width: 20px; text-align: center; color: var(--primary-blue); margin-right: 8px; font-size: 16px; }
        .package-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 1px solid rgba(255, 255, 255, 0.08); }
        .package-price { font-size: 24px; font-weight: 900; color: #fff; text-shadow: 0 0 15px rgba(255,255,255,0.4); display: flex; align-items: baseline; gap: 5px; }
        .package-price span { font-size: 13px; font-weight: 500; color: rgba(255,255,255,0.6); text-shadow: none; }
        .btn-view { background: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0.05)); backdrop-filter: blur(5px); color: #fff; border: 1px solid rgba(255, 255, 255, 0.2); padding: 10px 18px; border-radius: 12px; font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; transition: all 0.3s ease; text-decoration: none; }
        .package-card:hover .btn-view { background: linear-gradient(135deg, var(--primary-blue), #c1121f); border-color: transparent; transform: scale(1.05); box-shadow: 0 5px 15px rgba(230, 57, 70, 0.4); }

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
<body class="premium-theme">
    <!-- Sunlight Rays -->
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
    </div>
    <header class="header">
        <div class="header-logo"><a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <div style="display: flex; align-items: center; gap: 15px;">
                <span style="font-weight: 700;">Hi, ${user.name}</span>
                <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=f04c26&color=fff" />
                <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;">
            </div>
        </div>
    </header>
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="saved" />
        </jsp:include>
        <main class="main-content">
            <div class="container-fluid">
                <div class="mb-4">
                    <h2 style="font-weight: 800; margin: 0; color: #fff; text-shadow: 0 4px 15px rgba(0,0,0,0.8); font-size: 32px;">Saved Packages</h2>
                    <p style="color: #fff; margin: 0; font-weight: 600; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">Your collection of dream adventures</p>
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
                        <div style="background: #161c28; padding: 60px; border-radius: 15px; text-align: center; border: 1px solid rgba(255,255,255,0.05);">
                            <i class="fa fa-heart-o" style="font-size: 50px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                            <h3 style="font-weight: 700;">No saved packages yet</h3>
                            <p style="color: var(--text-muted);">Start exploring and save the packages you love!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>

