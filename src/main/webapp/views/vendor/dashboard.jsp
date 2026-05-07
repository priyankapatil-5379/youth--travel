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
            background-color: var(--bg-body);
            color: var(--text-main);
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            -webkit-font-smoothing: antialiased;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            padding: 40px !important;
        }

        /* Professional Header */
        .dashboard-header {
            margin-bottom: 32px;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .header-content h1 {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
            color: var(--text-main);
            letter-spacing: -0.5px;
        }

        .header-content p {
            margin: 4px 0 0;
            color: var(--text-muted);
            font-size: 15px;
            font-weight: 500;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: all 0.2s ease;
            text-decoration: none;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            border-color: var(--primary);
        }

        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .stat-icon.primary { background: #e0f2f2; color: var(--primary); }
        .stat-icon.success { background: #dcfce7; color: var(--success); }
        .stat-icon.warning { background: #fef3c7; color: var(--warning); }
        .stat-icon.info { background: #dbeafe; color: var(--info); }

        .stat-info h3 {
            font-size: 24px;
            font-weight: 700;
            margin: 0;
            color: var(--text-main);
            line-height: 1;
        }

        .stat-info p {
            color: var(--text-muted);
            font-size: 12px;
            margin: 6px 0 0;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Panels */
        .grid-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
            margin-bottom: 32px;
        }

        .panel-box {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .panel-header h4 {
            font-weight: 700;
            font-size: 18px;
            margin: 0;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .panel-header a {
            color: var(--accent-red);
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 8px;
            background: #e0f2f2;
            transition: 0.2s;
        }

        .panel-header a:hover { 
            background: var(--primary);
            color: #ffffff;
        }

        /* Recent Trips */
        .recent-trip-item {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 12px;
            border-radius: 12px;
            transition: 0.2s;
            text-decoration: none;
            margin-bottom: 8px;
            border: 1px solid transparent;
        }

        .recent-trip-item:last-child { margin-bottom: 0; }

        .recent-trip-item:hover {
            background: #f8fafc;
            border-color: var(--border-color);
        }

        .rt-img {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            object-fit: cover;
            background: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 18px;
        }

        .rt-details { flex-grow: 1; min-width: 0; }
        .rt-title { 
            font-weight: 600; 
            font-size: 14px; 
            color: var(--text-main); 
            margin: 0 0 2px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .rt-meta { display: flex; justify-content: space-between; align-items: center; }
        .rt-loc { font-size: 12px; color: var(--text-muted); }
        
        .status-badge {
            padding: 2px 8px;
            border-radius: 6px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
        }
        .status-active { background: #dcfce7; color: #15803d; }
        .status-inactive { background: #fee2e2; color: #b91c1c; }

        /* Action Cards */
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
        }

        .action-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 32px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: flex;
            flex-direction: column;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        .action-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            border-color: var(--primary);
        }

        .action-card i.main-icon {
            font-size: 32px;
            color: var(--primary);
            margin-bottom: 24px;
        }

        .action-card h4 {
            font-size: 20px;
            font-weight: 700;
            margin: 0 0 12px;
            color: var(--text-main);
        }

        .action-card p {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.6;
            margin: 0;
            font-weight: 400;
        }

        .action-card .arrow-btn {
            margin-top: 24px;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        @media (max-width: 991px) {
            .grid-layout { grid-template-columns: 1fr; }
            .main-content { 
                margin-left: 0 !important; 
                padding: 20px !important; 
                padding-top: 85px !important; 
            }
            .dashboard-header { 
                flex-direction: column; 
                align-items: stretch !important; 
                gap: 15px; 
            }
            .header-actions {
                width: 100%;
            }
            .header-actions .btn {
                display: block;
                width: 100%;
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .header-content h1 {
                font-size: 22px !important;
            }
            .stat-card {
                padding: 16px !important;
                gap: 12px !important;
            }
            .stat-icon {
                width: 48px !important;
                height: 48px !important;
                font-size: 18px !important;
            }
            .stat-info h3 {
                font-size: 20px !important;
            }
            .action-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
    </jsp:include>

    <div class="main-content">
        
        <div class="dashboard-header">
            <div class="header-content">
                <h1>Welcome back, ${loggedInVendor.businessName != null ? loggedInVendor.businessName : 'Partner'}! 👋</h1>
                <p>Monitor your performance and manage your travel offerings.</p>
            </div>
            <div class="header-actions">
                <a href="<c:url value='/vendor/add-trip'/>" class="btn btn-danger" style="background-color: var(--accent-red); border: none; border-radius: 10px; padding: 10px 20px; font-weight: 600;">
                    <i class="fa fa-plus"></i> New Trip
                </a>
            </div>
        </div>

        <div class="stats-grid">
            <a href="<c:url value='/vendor/tours'/>" class="stat-card">
                <div class="stat-icon primary"><i class="fa fa-map"></i></div>
                <div class="stat-info">
                    <h3>${tourCount != null ? tourCount : '0'}</h3>
                    <p>Total Tours</p>
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
                    <p>Est. Revenue</p>
                </div>
            </a>
        </div>

        <div class="grid-layout">
            <div class="panel-box">
                <div class="panel-header">
                    <h4><i class="fa fa-area-chart" style="color: var(--primary);"></i> Revenue Analytics</h4>
                </div>
                <div style="flex-grow: 1; min-height: 350px; display: flex; align-items: center; justify-content: center; position: relative;">
                    <canvas id="revenueChart" style="width: 100%;"></canvas>
                </div>
            </div>

            <div class="panel-box">
                <div class="panel-header">
                    <h4><i class="fa fa-compass" style="color: var(--warning);"></i> Recent Trips</h4>
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
                                            <span class="status-badge ${trip.status.equalsIgnoreCase('Active') ? 'status-active' : 'status-inactive'}">${trip.status}</span>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 60px 20px; color: var(--text-muted);">
                                <i class="fa fa-folder-open-o" style="font-size: 40px; margin-bottom: 15px; opacity: 0.3;"></i>
                                <p style="margin: 0; font-size: 14px; font-weight: 500;">No trips found.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="panel-header" style="margin-top: 24px;">
            <h4 style="font-size: 22px;"><i class="fa fa-bolt" style="color: var(--primary);"></i> Quick Actions</h4>
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

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const revCtx = document.getElementById('revenueChart').getContext('2d');
            
            // Refined Gradient
            let gradient = revCtx.createLinearGradient(0, 0, 0, 300);
            gradient.addColorStop(0, 'rgba(0, 128, 128, 0.1)');
            gradient.addColorStop(1, 'rgba(0, 128, 128, 0.0)');

            new Chart(revCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                    datasets: [{
                        label: 'Revenue (₹)',
                        data: [12000, 19000, 15000, 28000, 22000, 35000, 42000],
                        borderColor: '#008080',
                        backgroundColor: gradient,
                        tension: 0.4,
                        fill: true,
                        borderWidth: 3,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#008080',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6,
                        pointHoverBackgroundColor: '#008080',
                        pointHoverBorderColor: '#ffffff',
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        intersect: false,
                        mode: 'index',
                    },
                    plugins: { 
                        legend: { display: false },
                        tooltip: { 
                            backgroundColor: '#0f172a',
                            titleFont: { size: 13, family: 'Inter', weight: '600' },
                            bodyFont: { size: 14, family: 'Inter' },
                            padding: 12,
                            cornerRadius: 8,
                            displayColors: false
                        } 
                    },
                    scales: {
                        y: { 
                            beginAtZero: true, 
                            grid: { color: '#f1f5f9', drawBorder: false },
                            ticks: { color: '#64748b', font: { family: 'Inter', size: 12 }, padding: 8 }
                        },
                        x: { 
                            grid: { display: false, drawBorder: false },
                            ticks: { color: '#64748b', font: { family: 'Inter', size: 12 }, padding: 8 }
                        }
                    }
                }
            });
        });
    </script>
</body>

</html>