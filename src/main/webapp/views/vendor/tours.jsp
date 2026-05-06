<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tour Portfolio | Youth Travel</title>
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
            --success: #10b981;
            --warning: #f59e0b;
            --info: #3b82f6;
            --danger: #e63946;
            --sidebar-width: 260px;
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

        /* Header Area */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .header-title h1 {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-main);
            margin: 0;
            letter-spacing: -0.5px;
        }

        .header-title p {
            color: var(--text-muted);
            margin: 4px 0 0;
            font-size: 14px;
        }

        .btn-create {
            background-color: var(--accent-red);
            color: #ffffff;
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 10px 15px -3px rgba(230, 57, 70, 0.3);
            transition: all 0.2s;
            text-decoration: none;
        }

        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 20px -3px rgba(230, 57, 70, 0.4);
            color: #ffffff;
            filter: brightness(1.1);
        }

        /* Filter Section (Optional but nice) */
        .filter-bar {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 16px 24px;
            margin-bottom: 32px;
            display: flex;
            gap: 20px;
            align-items: center;
        }

        /* Trip Grid */
        .trip-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 24px;
        }

        /* Trip Card */
        .trip-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .trip-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px -5px rgba(0, 0, 0, 0.1);
            border-color: var(--primary);
        }

        .card-image {
            height: 200px;
            position: relative;
            overflow: hidden;
        }

        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .trip-card:hover .card-image img {
            transform: scale(1.05);
        }

        .badge-tag {
            position: absolute;
            top: 12px;
            left: 12px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(4px);
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .price-tag {
            position: absolute;
            bottom: 12px;
            right: 12px;
            background: var(--accent-red);
            color: #fff;
            padding: 6px 14px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 800;
            box-shadow: 0 4px 6px -1px rgba(230, 57, 70, 0.3);
        }

        .card-body {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .card-category {
            font-size: 11px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-main);
            margin: 0 0 12px;
            line-height: 1.4;
        }

        .card-meta {
            display: flex;
            gap: 16px;
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border-color);
        }

        .meta-info {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            color: var(--text-muted);
        }

        .meta-info i {
            color: var(--primary);
            font-size: 14px;
        }

        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: transparent;
            padding: 0;
            border: none;
        }

        .status-badge {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        .dot.active { background: var(--success); box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1); }
        .dot.inactive { background: var(--danger); box-shadow: 0 0 0 3px rgba(230, 57, 70, 0.1); }

        .action-btns {
            display: flex;
            gap: 8px;
        }

        .btn-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f1f5f9;
            color: var(--text-muted);
            transition: 0.2s;
            text-decoration: none;
        }

        .btn-icon:hover {
            background: var(--primary);
            color: #ffffff;
            transform: translateY(-2px);
        }

        .btn-icon.delete:hover {
            background: var(--danger);
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: var(--bg-card);
            border: 2px dashed var(--border-color);
            border-radius: 20px;
            margin-top: 20px;
        }

        .empty-state i {
            font-size: 48px;
            color: var(--border-color);
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        .empty-state p {
            color: var(--text-muted);
        }

        /* Alert Styling */
        .alert-custom {
            background-color: #dcfce7;
            border: 1px solid #bbf7d0;
            color: #166534;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="tours" />
    </jsp:include>

    <div class="main-content">
        <div class="container-fluid">
            
            <c:if test="${not empty message}">
                <div class="alert-custom">
                    <i class="fa fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <div class="page-header">
                <div class="header-title">
                    <h1>Tour Portfolio</h1>
                    <p>Manage and monitor your travel packages and departures</p>
                </div>
                <a href="<c:url value='/vendor/add-trip'/>" class="btn-create">
                    <i class="fa fa-plus"></i> Create New Trip
                </a>
            </div>

            <div class="trip-grid">
                <c:forEach items="${trips}" var="trip">
                    <div class="trip-card">
                        <div class="card-image">
                            <div class="badge-tag">${trip.duration}</div>
                            <div class="price-tag">₹${trip.price}</div>
                            <c:choose>
                                <c:when test="${not empty trip.imageUrl}">
                                    <img src="<c:url value='${trip.imageUrl}'/>" alt="${trip.title}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&q=80&w=600" alt="Default">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="card-body">
                            <div class="card-category">${not empty trip.category ? trip.category : 'Adventure'}</div>
                            <h3 class="card-title">${trip.title}</h3>
                            
                            <div class="card-meta">
                                <div class="meta-info">
                                    <i class="fa fa-map-marker"></i>
                                    <span>${trip.destination}</span>
                                </div>
                                <div class="meta-info">
                                    <i class="fa fa-signal"></i>
                                    <span>${not empty trip.difficulty ? trip.difficulty : 'Medium'}</span>
                                </div>
                            </div>

                            <div class="card-footer">
                                <div class="status-badge">
                                    <div class="dot ${trip.status.equalsIgnoreCase('Active') ? 'active' : 'inactive'}"></div>
                                    <span style="color: ${trip.status.equalsIgnoreCase('Active') ? 'var(--success)' : 'var(--danger)'}">
                                        ${trip.status}
                                    </span>
                                </div>
                                <div class="action-btns">
                                    <a href="<c:url value='/vendor/view-trip/${trip.id}'/>" class="btn-icon" title="View Details">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/edit-trip/${trip.id}'/>" class="btn-icon" title="Edit">
                                        <i class="fa fa-pencil"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/toggle-status/${trip.id}'/>" class="btn-icon" title="Toggle Status">
                                        <i class="fa fa-power-off"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/delete-trip/${trip.id}'/>" class="btn-icon delete" title="Delete" onclick="return confirm('Archive this package?')">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty trips}">
                <div class="empty-state">
                    <i class="fa fa-map-o"></i>
                    <h3>No Packages Found</h3>
                    <p>Start expanding your portfolio by adding your first travel package.</p>
                    <div style="margin-top: 24px;">
                        <a href="<c:url value='/vendor/add-trip'/>" class="btn-create" style="display: inline-flex;">
                            <i class="fa fa-plus"></i> Create Your First Trip
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
</body>
</html>