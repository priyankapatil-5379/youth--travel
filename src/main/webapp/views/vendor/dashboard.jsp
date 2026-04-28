<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vendor Dashboard | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root {
            --primary-color: #f04c26;
            --primary-gradient: linear-gradient(135deg, #f04c26 0%, #d84422 100%);
            --bg-color: #0b0f18;
            --card-bg: rgba(255, 255, 255, 0.03);
            --card-border: rgba(255, 255, 255, 0.05);
            --text-main: #ffffff;
            --text-muted: rgba(255, 255, 255, 0.6);
            --success: #22c55e;
            --warning: #f59e0b;
            --info: #3b82f6;
            --danger: #ef4444;
        }

        body.yt-dark {
            background: var(--bg-color);
            color: var(--text-main);
            font-family: 'Dosis', sans-serif;
            overflow-x: hidden;
        }

        /* --- Main Content Area --- */
        .main-content {
            margin-left: 260px;
            position: relative;
            min-height: 100vh;
            padding: 0 !important;
        }

        /* --- Premium Hero Section --- */
        .hero-section {
            position: relative;
            height: 380px;
            background: linear-gradient(rgba(11, 15, 24, 0.2), var(--bg-color)), url('https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1920&q=80') center/cover;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }

        .hero-content h1 {
            font-size: 48px;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1px;
            background: linear-gradient(to right, #fff, rgba(255,255,255,0.6));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        .hero-content p {
            font-size: 18px;
            color: rgba(255,255,255,0.8);
            margin-top: 10px;
            font-weight: 500;
        }

        /* --- Stats Grid (Overlapping Hero) --- */
        .dashboard-container {
            padding: 0 60px 60px;
            margin-top: -80px;
            position: relative;
            z-index: 10;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: rgba(22, 28, 40, 0.8);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 24px;
            padding: 30px;
            display: flex;
            align-items: center;
            gap: 25px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-decoration: none;
        }

        .stat-card::after {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, transparent 100%);
            opacity: 0;
            transition: 0.4s;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            border-color: rgba(255,255,255,0.2);
            box-shadow: 0 20px 40px rgba(0,0,0,0.4);
        }
        .stat-card:hover::after { opacity: 1; }

        .stat-icon {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            position: relative;
            z-index: 2;
        }

        .stat-icon.primary { background: rgba(240, 76, 38, 0.15); color: var(--primary-color); border: 1px solid rgba(240, 76, 38, 0.3); }
        .stat-icon.success { background: rgba(34, 197, 94, 0.15); color: var(--success); border: 1px solid rgba(34, 197, 94, 0.3); }
        .stat-icon.warning { background: rgba(245, 158, 11, 0.15); color: var(--warning); border: 1px solid rgba(245, 158, 11, 0.3); }
        .stat-icon.info { background: rgba(59, 130, 246, 0.15); color: var(--info); border: 1px solid rgba(59, 130, 246, 0.3); }

        .stat-info { position: relative; z-index: 2; }
        .stat-info h3 {
            font-size: 36px;
            font-weight: 800;
            margin: 0;
            color: #fff;
            line-height: 1;
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 14px;
            margin: 8px 0 0;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* --- Charts & Lists Area --- */
        .grid-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .panel-box {
            background: rgba(22, 28, 40, 0.6);
            border: 1px solid var(--card-border);
            border-radius: 24px;
            padding: 30px;
            display: flex;
            flex-direction: column;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .panel-header h4 {
            font-weight: 800;
            font-size: 22px;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .panel-header a {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            background: rgba(240, 76, 38, 0.1);
            padding: 6px 15px;
            border-radius: 20px;
            transition: 0.3s;
        }
        .panel-header a:hover { background: var(--primary-color); color: #fff; }

        /* --- Recent Trips List --- */
        .recent-trip-item {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 15px;
            background: rgba(255,255,255,0.02);
            border: 1px solid transparent;
            border-radius: 16px;
            transition: 0.3s;
            text-decoration: none;
            margin-bottom: 15px;
        }
        .recent-trip-item:last-child { margin-bottom: 0; }

        .recent-trip-item:hover {
            background: rgba(255,255,255,0.05);
            border-color: var(--card-border);
            transform: translateX(5px);
        }

        .rt-img {
            width: 70px;
            height: 70px;
            border-radius: 14px;
            object-fit: cover;
            background: rgba(255,255,255,0.05);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 24px;
        }

        .rt-details { flex-grow: 1; }
        .rt-title { font-weight: 800; font-size: 16px; color: #fff; margin: 0 0 5px; }
        .rt-meta { display: flex; justify-content: space-between; align-items: center; }
        .rt-loc { font-size: 13px; color: var(--text-muted); font-weight: 600; }
        
        .status-badge {
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
        }
        .status-active { background: rgba(34,197,94,0.1); color: #22c55e; border: 1px solid rgba(34,197,94,0.2); }
        .status-inactive { background: rgba(239,68,68,0.1); color: #ef4444; border: 1px solid rgba(239,68,68,0.2); }

        /* --- Quick Actions --- */
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 25px;
        }

        .action-card {
            background: rgba(22, 28, 40, 0.6);
            border: 1px solid var(--card-border);
            border-radius: 24px;
            padding: 35px;
            position: relative;
            overflow: hidden;
            transition: all 0.4s;
            text-decoration: none;
            color: #fff;
            display: flex;
            flex-direction: column;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 5px;
            background: var(--primary-gradient);
            opacity: 0;
            transition: 0.4s;
        }

        .action-card:hover {
            transform: translateY(-8px);
            border-color: rgba(255,255,255,0.1);
            background: rgba(255,255,255,0.03);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            color: #fff;
        }
        .action-card:hover::before { opacity: 1; }

        .action-card i.main-icon {
            font-size: 45px;
            color: var(--primary-color);
            margin-bottom: 25px;
            filter: drop-shadow(0 5px 10px rgba(240,76,38,0.4));
            transition: 0.4s;
        }
        .action-card:hover i.main-icon { transform: scale(1.1); }

        .action-card h4 {
            font-size: 24px;
            font-weight: 800;
            margin: 0 0 12px;
        }

        .action-card p {
            color: var(--text-muted);
            font-size: 15px;
            line-height: 1.7;
            margin: 0;
            font-weight: 500;
        }

        .action-card .arrow-btn {
            margin-top: auto;
            padding-top: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--primary-color);
            font-weight: 700;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: 0.3s;
        }
        .action-card:hover .arrow-btn { gap: 15px; }

    </style>
</head>

<body class="yt-dark">

    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
    </jsp:include>

    <div class="main-content">
        
        <div class="hero-section">
            <div class="hero-content">
                <h1>Welcome back, ${loggedInVendor.businessName != null ? loggedInVendor.businessName : 'Partner'}! 👋</h1>
                <p>Here is what's happening across your travel ecosystem today.</p>
            </div>
        </div>

        <div class="dashboard-container">
            
            <div class="stats-grid">
                <a href="<c:url value='/vendor/tours'/>" class="stat-card">
                    <div class="stat-icon primary"><i class="fa fa-map"></i></div>
                    <div class="stat-info">
                        <h3>${tourCount != null ? tourCount : '0'}</h3>
                        <p>Total Tours Hosted</p>
                    </div>
                </a>
                <a href="<c:url value='/vendor/tours?filter=ACTIVE'/>" class="stat-card">
                    <div class="stat-icon success"><i class="fa fa-rocket"></i></div>
                    <div class="stat-info">
                        <h3>${activeTourCount != null ? activeTourCount : '0'}</h3>
                        <p>Active Listings</p>
                    </div>
                </a>
                <a href="<c:url value='/vendor/bookings'/>" class="stat-card">
                    <div class="stat-icon warning"><i class="fa fa-ticket"></i></div>
                    <div class="stat-info">
                        <h3>${bookingCount != null ? bookingCount : '0'}</h3>
                        <p>Total Bookings</p>
                    </div>
                </a>
                <a href="<c:url value='/vendor/earnings'/>" class="stat-card">
                    <div class="stat-icon info"><i class="fa fa-inr"></i></div>
                    <div class="stat-info">
                        <h3>14.2K</h3>
                        <p>Est. Revenue (Mock)</p>
                    </div>
                </a>
            </div>

            <div class="grid-layout">
                <div class="panel-box">
                    <div class="panel-header">
                        <h4><i class="fa fa-bar-chart" style="color: var(--primary-color);"></i> Performance Analytics</h4>
                    </div>
                    <div style="flex-grow: 1; display: flex; align-items: center; justify-content: center; position: relative;">
                        <canvas id="revenueChart" style="max-height: 350px; width: 100%;"></canvas>
                    </div>
                </div>

                <div class="panel-box">
                    <div class="panel-header">
                        <h4><i class="fa fa-compass" style="color: var(--warning);"></i> Latest Trips</h4>
                        <a href="<c:url value='/vendor/tours'/>">View All</a>
                    </div>
                    
                    <div style="display: flex; flex-direction: column;">
                        <c:choose>
                            <c:when test="${not empty recentTrips}">
                                <c:forEach items="${recentTrips}" var="trip">
                                    <a href="<c:url value='/vendor/edit-trip/${trip.id}'/>" class="recent-trip-item">
                                        <c:choose>
                                            <c:when test="${not empty trip.imageUrl}">
                                                <img src="<c:url value='${trip.imageUrl}'/>" class="rt-img">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="rt-img"><i class="fa fa-image"></i></div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="rt-details">
                                            <h5 class="rt-title">${trip.title}</h5>
                                            <div class="rt-meta">
                                                <span class="rt-loc"><i class="fa fa-map-marker"></i> ${trip.destination}</span>
                                                <span class="status-badge ${trip.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">${trip.status}</span>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 50px 20px; opacity: 0.5;">
                                    <i class="fa fa-folder-open-o" style="font-size: 40px; margin-bottom: 15px;"></i>
                                    <p style="margin: 0; font-size: 16px; font-weight: 600;">Your portfolio is empty.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="panel-header" style="margin-top: 50px;">
                <h4 style="font-size: 28px;"><i class="fa fa-bolt" style="color: var(--primary-color);"></i> Command Center</h4>
            </div>
            
            <div class="action-cards">
                <a href="<c:url value='/vendor/add-trip'/>" class="action-card">
                    <i class="fa fa-paper-plane-o main-icon"></i>
                    <h4>Launch Experience</h4>
                    <p>Create a stunning new travel package. Define itineraries, dynamic pricing slots, and target specific youth demographics.</p>
                    <div class="arrow-btn">Start Building <i class="fa fa-long-arrow-right"></i></div>
                </a>
                
                <a href="<c:url value='/vendor/inventory'/>" class="action-card">
                    <i class="fa fa-calendar-check-o main-icon"></i>
                    <h4>Manage Availability</h4>
                    <p>Open new batches, manage seating capacities, and adjust dynamic pricing for upcoming long weekends and holidays.</p>
                    <div class="arrow-btn">View Calendar <i class="fa fa-long-arrow-right"></i></div>
                </a>
                
                <a href="<c:url value='/vendor/guest-list'/>" class="action-card">
                    <i class="fa fa-users main-icon"></i>
                    <h4>Traveler Manifests</h4>
                    <p>Download guest lists for your upcoming departures, verify documents, and ensure everything is ready for the trip.</p>
                    <div class="arrow-btn">See Travelers <i class="fa fa-long-arrow-right"></i></div>
                </a>
            </div>

        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Premium Gradient for Line Chart
            const revCtx = document.getElementById('revenueChart').getContext('2d');
            let gradient = revCtx.createLinearGradient(0, 0, 0, 350);
            gradient.addColorStop(0, 'rgba(240, 76, 38, 0.5)');
            gradient.addColorStop(1, 'rgba(240, 76, 38, 0.0)');

            new Chart(revCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                    datasets: [{
                        label: 'Revenue (₹)',
                        data: [12000, 19000, 15000, 28000, 22000, 35000, 42000],
                        borderColor: '#f04c26',
                        backgroundColor: gradient,
                        tension: 0.4,
                        fill: true,
                        borderWidth: 4,
                        pointBackgroundColor: '#161c28',
                        pointBorderColor: '#f04c26',
                        pointBorderWidth: 3,
                        pointRadius: 6,
                        pointHoverRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false }, tooltip: { backgroundColor: 'rgba(11,15,24,0.9)', titleFont: { size: 14, family: 'Dosis' }, bodyFont: { size: 16, family: 'Dosis', weight: 'bold' }, padding: 15, cornerRadius: 10, displayColors: false } },
                    scales: {
                        y: { beginAtZero: true, grid: { color: 'rgba(255,255,255,0.05)', drawBorder: false }, ticks: { color: 'rgba(255,255,255,0.5)', font: { family: 'Dosis', size: 13, weight: 'bold' }, padding: 10 } },
                        x: { grid: { display: false, drawBorder: false }, ticks: { color: 'rgba(255,255,255,0.7)', font: { family: 'Dosis', size: 14, weight: 'bold' }, padding: 10 } }
                    }
                }
            });
        });
    </script>
</body>

</html>