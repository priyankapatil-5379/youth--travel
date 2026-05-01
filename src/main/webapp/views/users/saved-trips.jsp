<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        .package-card { background: rgba(0,0,0,0.4); backdrop-filter: blur(15px); border-radius: 15px; overflow: hidden; border: 1px solid rgba(255,255,255,0.1); transition: var(--transition); position: relative; box-shadow: 0 8px 32px 0 rgba(0,0,0,0.3); }
        .package-card:hover { transform: translateY(-5px); border-color: var(--primary-blue); }
        .package-img { height: 180px; width: 100%; object-fit: cover; }
        .package-content { padding: 20px; }
        .package-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: #fff; text-shadow: 0 2px 4px rgba(0,0,0,0.5); }
        .package-price { font-size: 20px; font-weight: 800; color: #fff; text-shadow: 0 2px 4px rgba(0,0,0,0.3); }

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
            <a href="<c:url value='/vendor/login'/>" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: #fff; text-decoration: none; padding: 8px 15px; border-radius: 8px; font-size: 13px; font-weight: 600; transition: 0.3s; opacity: 0.8;" onmouseover="this.style.opacity='1'; this.style.background='rgba(255,255,255,0.1)'" onmouseout="this.style.opacity='0.8'; this.style.background='rgba(255,255,255,0.05)'">Vendor Portal</a>
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
                                    <img src="${not empty saved.trip.imageUrl ? saved.trip.imageUrl : 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80'}" class="package-img">
                                    <div class="package-content">
                                        <div style="font-size: 12px; color: #fff; text-transform: uppercase; font-weight: 700; margin-bottom: 5px; text-shadow: 0 1px 3px rgba(0,0,0,0.5);"><i class="fa fa-map-marker" style="color: var(--primary-blue);"></i> ${saved.trip.destination}</div>
                                        <div class="package-title"><a href="<c:url value='/user/package/${saved.trip.id}'/>" style="color: inherit; text-decoration: none;">${saved.trip.title}</a></div>
                                        <div class="package-price">₹${saved.trip.price}</div>
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
