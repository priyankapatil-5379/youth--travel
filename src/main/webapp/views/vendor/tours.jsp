<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Tours | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        .main-content {
            padding: 40px;
            margin-left: 260px;
            min-height: 100vh;
        }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 20px; }
        }

        /* GRID SYSTEM */
        .trip-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            padding-bottom: 60px;
        }

        @media (max-width: 1200px) {
            .trip-grid { grid-template-columns: repeat(3, 1fr); }
        }

        @media (max-width: 991px) {
            .trip-grid { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 576px) {
            .trip-grid { grid-template-columns: 1fr; }
        }

        /* CARD DESIGN */
        .trip-card {
            display: flex;
            flex-direction: column;
            background: rgba(26, 31, 43, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            height: 100%;
            position: relative;
        }

        .trip-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: #f04c26;
            box-shadow: 0 20px 40px rgba(0,0,0,0.4);
            z-index: 10;
        }

        /* IMAGE AREA */
        .card-image-box {
            height: 180px;
            position: relative;
            overflow: hidden;
        }

        .card-image-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .trip-card:hover .card-image-box img {
            transform: scale(1.1);
        }

        /* BADGES */
        .badge-duration {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(0,0,0,0.6);
            backdrop-filter: blur(5px);
            color: #fff;
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            z-index: 2;
        }

        .badge-price {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #f04c26;
            color: #fff;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 800;
            box-shadow: 0 4px 10px rgba(240, 76, 38, 0.3);
            z-index: 2;
        }

        /* CARD CONTENT */
        .card-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .card-location {
            font-size: 11px;
            color: #f04c26;
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 12px;
            line-height: 1.3;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 46px;
        }

        .card-meta-box {
            background: rgba(255,255,255,0.03);
            padding: 10px 15px;
            border-radius: 12px;
            margin-bottom: 20px;
        }

        .meta-item {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: rgba(255,255,255,0.5);
            margin-bottom: 4px;
        }

        .meta-item:last-child { margin-bottom: 0; }

        .meta-item span:last-child { color: #fff; font-weight: 600; }

        /* ACTION AREA */
        .card-action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid rgba(255,255,255,0.05);
            margin-top: auto;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }

        .status-active { background: #22c55e; box-shadow: 0 0 10px rgba(34, 197, 94, 0.5); }
        .status-inactive { background: #ef4444; }

        .status-text {
            font-size: 11px;
            font-weight: 600;
            color: rgba(255,255,255,0.6);
            display: flex;
            align-items: center;
        }

        .btn-group-mini {
            display: flex;
            gap: 8px;
        }

        .btn-mini {
            width: 32px;
            height: 32px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255,255,255,0.05);
            color: #fff;
            border: 1px solid rgba(255,255,255,0.08);
            transition: all 0.2s;
            text-decoration: none;
            font-size: 12px;
        }

        .btn-mini:hover {
            background: #f04c26;
            border-color: #f04c26;
            color: #fff;
            transform: translateY(-3px);
        }

        .btn-mini.btn-view:hover { background: #3b82f6; border-color: #3b82f6; }
        .btn-mini.btn-delete:hover { background: #ef4444; border-color: #ef4444; }

    </style>
</head>

<body class="yt-dark premium-theme">
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="tours" />
    </jsp:include>

    <div class="main-content">
        <div class="container-fluid">
            <c:if test="${not empty message}">
                <div class="alert alert-success" style="border-radius: 15px; border: none; background: rgba(34, 197, 94, 0.1); color: #22c55e; margin-bottom: 30px;">
                    <i class="fa fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <div style="margin-bottom: 40px; display: flex; justify-content: space-between; align-items: flex-end;">
                <div>
                    <h1 style="font-weight: 800; font-size: 36px; margin: 0; color: #fff; letter-spacing: -1px;">Tour Portfolio</h1>
                    <p style="color: rgba(255,255,255,0.5); margin: 8px 0 0 0; font-size: 16px;">Manage your travel packages and departures</p>
                </div>
                <a href="<c:url value='/vendor/add-trip'/>" class="btn btn-primary" style="background: linear-gradient(135deg, #f04c26, #ff6b4a); border: none; padding: 14px 28px; border-radius: 15px; font-weight: 700; box-shadow: 0 10px 20px rgba(240, 76, 38, 0.2);">
                    <i class="fa fa-plus"></i> Create New Trip
                </a>
            </div>

            <div class="trip-grid">
                <c:forEach items="${trips}" var="trip">
                    <div class="trip-card">
                        <div class="card-image-box">
                            <div class="badge-duration">${trip.duration}</div>
                            <div class="badge-price">₹${trip.price}</div>
                            <c:choose>
                                <c:when test="${not empty trip.imageUrl}">
                                    <img src="<c:url value='${trip.imageUrl}'/>" alt="${trip.title}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&q=80&w=600" alt="Default">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="card-content">
                            <div class="card-location">
                                <i class="fa fa-map-marker"></i> ${trip.destination}
                            </div>
                            <h3 class="card-title">${trip.title}</h3>
                            
                            <div class="card-meta-box">
                                <div class="meta-item">
                                    <span>Category</span>
                                    <span>${not empty trip.category ? trip.category : 'Adventure'}</span>
                                </div>
                                <div class="meta-item">
                                    <span>Difficulty</span>
                                    <span>${not empty trip.difficulty ? trip.difficulty : 'Medium'}</span>
                                </div>
                            </div>

                            <div class="card-action-bar">
                                <div class="status-text">
                                    <span class="status-dot ${trip.status.equalsIgnoreCase('Active') ? 'status-active' : 'status-inactive'}"></span>
                                    ${trip.status}
                                </div>
                                <div class="btn-group-mini">
                                    <a href="<c:url value='/vendor/view-trip/${trip.id}'/>" class="btn-mini btn-view" title="View Details">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/edit-trip/${trip.id}'/>" class="btn-mini" title="Edit">
                                        <i class="fa fa-pencil"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/toggle-status/${trip.id}'/>" class="btn-mini" title="Toggle Visibility">
                                        <i class="fa fa-power-off"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/delete-trip/${trip.id}'/>" class="btn-mini btn-delete" title="Delete" onclick="return confirm('Archive this package?')">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty trips}">
                <div style="text-align: center; padding: 80px 20px; background: rgba(255,255,255,0.02); border-radius: 30px; border: 2px dashed rgba(255,255,255,0.05); margin-top: 30px;">
                    <i class="fa fa-map-o" style="font-size: 60px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                    <h2 style="color: rgba(255,255,255,0.4); font-weight: 700;">No Packages Found</h2>
                    <p style="color: rgba(255,255,255,0.2);">Start expanding your portfolio by adding a new trip.</p>
                </div>
            </c:if>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script>
        function toggleSidebar() {
            $('.sidebar').toggleClass('show');
            $('.sidebar-overlay').toggleClass('show');
        }
    </script>
</body>
</html>