<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inventory Management | Youth Travel</title>
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

        .page-header {
            margin-bottom: 40px;
        }

        .page-header h2 {
            font-weight: 800;
            font-size: 28px;
            color: var(--text-main);
            margin: 0;
            letter-spacing: -1px;
        }

        .inventory-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            transition: 0.2s;
        }

        .inventory-card:hover {
            border-color: var(--primary);
            box-shadow: 0 4px 12px -2px rgba(0, 0, 0, 0.05);
        }

        .trip-title {
            font-weight: 700;
            font-size: 18px;
            color: var(--text-main);
            margin-bottom: 4px;
        }

        .trip-meta {
            font-size: 13px;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .trip-meta i {
            color: var(--primary);
        }

        .occupancy-label {
            font-size: 11px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .occupancy-value {
            font-size: 24px;
            font-weight: 800;
            color: var(--primary);
        }

        .status-badge {
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: #e0f2f1;
            color: var(--primary);
        }

        .status-full {
            background: #fee2e2;
            color: var(--danger);
        }

        .btn-action {
            background: #f1f5f9;
            border: 1px solid var(--border-color);
            color: var(--text-main);
            border-radius: 10px;
            padding: 8px 16px;
            font-size: 13px;
            font-weight: 600;
            transition: 0.2s;
        }

        .btn-action:hover {
            background: var(--primary);
            border-color: var(--primary);
            color: #ffffff;
        }

        .inventory-stats {
            display: flex;
            gap: 16px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }

        .stat-box {
            background: #f8fafc;
            padding: 12px 16px;
            border-radius: 12px;
            min-width: 140px;
        }

        .stat-label {
            font-size: 11px;
            font-weight: 600;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .stat-value {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-main);
        }

        .text-danger-custom {
            color: var(--danger);
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="inventory" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <h2>Live Slot & Inventory Management</h2>
        </div>

        <c:forEach var="trip" items="${trips}">
            <c:set var="occupied" value="${occupiedMap[trip.id] != null ? occupiedMap[trip.id] : 0}" />
            <c:set var="total" value="${trip.maxTravelers != null && trip.maxTravelers > 0 ? trip.maxTravelers : 20}" />
            <c:set var="seatsLeft" value="${total - occupied}" />
            <c:set var="occupancy" value="${(occupied * 100) / total}" />

            <div class="inventory-card">
                <div class="row align-items-center">
                    <div class="col-md-4">
                        <div class="trip-title">${trip.title}</div>
                        <div class="trip-meta">
                            <i class="fa fa-map-marker"></i> ${trip.destination}
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="occupancy-label">Total Occupancy</div>
                        <div class="occupancy-value">
                            <fmt:formatNumber value="${occupancy}" maxFractionDigits="0" />%
                        </div>
                    </div>
                    <div class="col-md-3 text-center">
                        <c:choose>
                            <c:when test="${seatsLeft <= 0}">
                                <span class="status-badge status-full">FULLY BOOKED</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-active">ACTIVE SELLING</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-md-2 text-end">
                        <button class="btn-action">Adjust Slots</button>
                    </div>
                </div>

                <div class="inventory-stats">
                    <div class="stat-box">
                        <div class="stat-label">Confirmed Bookings</div>
                        <div class="stat-value">${occupied}</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-label">Remaining Slots</div>
                        <div class="stat-value ${seatsLeft <= 5 ? 'text-danger-custom' : ''}">
                            ${seatsLeft > 0 ? seatsLeft : '0'} ${seatsLeft > 0 ? 'Seats Left' : 'SOLD OUT'}
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty trips}">
            <div style="text-align: center; padding: 60px; background: white; border-radius: 16px; border: 1px solid var(--border-color);">
                <i class="fa fa-list-alt" style="font-size: 48px; color: var(--border-color); margin-bottom: 20px;"></i>
                <h3 style="color: var(--text-muted);">No Active Trips for Inventory</h3>
                <p style="color: var(--text-muted);">Create a trip to start managing live slots.</p>
            </div>
        </c:if>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
</body>
</html>