<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard - Youth Travel</title>
    
    <!-- Core CSS from Index -->
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Dosis', sans-serif;
            background-color: transparent;
            color: #ffffff;
        }
        
        .admin-layout {
            display: flex;
            min-height: 100vh;
            position: relative;
            z-index: 10;
        }
        
        /* Sidebar Styling */
        .admin-sidebar {
            width: 260px;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            color: #fff;
            flex-shrink: 0;
            transition: all 0.3s;
            box-shadow: 4px 0 15px rgba(0,0,0,0.5);
            border-right: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-header {
            padding: 30px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-header img {
            max-width: 150px;
            filter: brightness(0) invert(1);
        }
        
        .admin-nav {
            padding: 20px 0;
        }
        
        .admin-nav-item {
            padding: 12px 25px;
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            transition: 0.3s;
            font-size: 16px;
            font-weight: 500;
        }
        
        .admin-nav-item i {
            margin-right: 15px;
            width: 20px;
            text-align: center;
            font-size: 18px;
        }
        
        .admin-nav-item:hover, .admin-nav-item.active {
            background: rgba(230, 57, 70, 0.15);
            color: #e63946;
            text-decoration: none;
        }
        
        .admin-nav-item.active {
            border-left: 4px solid #e63946;
        }
        
        /* Main Content */
        .admin-main {
            flex-grow: 1;
            padding: 40px;
            overflow-y: auto;
        }
        
        .admin-header {
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .admin-header h1 {
            font-weight: 700;
            color: #ffffff;
            margin: 0;
            font-size: 28px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Stats Cards */
        .stats-row {
            display: flex;
            gap: 25px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }
        
        .stat-card {
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 20px;
            flex: 1;
            min-width: 200px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            display: flex;
            align-items: center;
            transition: transform 0.3s;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            border-color: #ff4d4d;
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 20px;
        }
        
        .icon-blue { background: rgba(33, 150, 243, 0.1); color: #2196f3; }
        .icon-green { background: rgba(76, 175, 80, 0.1); color: #4caf50; }
        .icon-orange { background: rgba(255, 152, 0, 0.1); color: #ff9800; }
        .icon-red { background: rgba(244, 67, 54, 0.1); color: #f44336; }
        
        .stat-info h3 {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            color: #ffffff;
            text-shadow: 0 2px 8px rgba(0,0,0,0.8);
        }
        
        .stat-info p {
            margin: 0;
            color: #fff;
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-shadow: 0 1px 3px rgba(0,0,0,0.5);
        }
        
        /* Content Sections */
        .admin-section {
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .admin-section-header {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #2a2a35;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .admin-section-header h2 {
            font-size: 20px;
            font-weight: 700;
            margin: 0;
            color: #ffffff;
        }
        
        .table thead th {
            background: transparent !important;
            border-bottom: 2px solid rgba(255,255,255,0.1);
            color: #fff;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-size: 12px;
            padding: 15px;
            border-top: none;
            text-shadow: 0 2px 4px rgba(0,0,0,0.8);
        }
        
        .table tbody td {
            padding: 15px;
            vertical-align: middle;
            color: #dddddd;
            border-top: 1px solid #2a2a35;
        }
        
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-pending { background: rgba(255, 152, 0, 0.1); color: #ff9800; }
        .status-completed { background: rgba(76, 175, 80, 0.1); color: #4caf50; }
        
        .action-btn {
            padding: 5px 15px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            transition: 0.3s;
            background: #ff4d4d;
            border: none;
            color: white;
        }
        .action-btn:hover {
            background: #e60000;
        }
        .btn-default {
            background: #2a2a35;
            color: #fff;
            border: none;
        }
        .btn-default:hover {
            background: #3a3a45;
            color: #fff;
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
    <div class="admin-layout">
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item active">
                    <i class="fa fa-th-large"></i> Dashboard
                </a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item">
                    <i class="fa fa-motorcycle"></i> Manage Trips
                </a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item">
                    <i class="fa fa-users"></i> User Accounts
                </a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item">
                    <i class="fa fa-handshake-o"></i> Vendor Requests
                </a>
                <a href="<c:url value='/admin/home-images'/>" class="admin-nav-item">
                    <i class="fa fa-image"></i> Homepage Photos
                </a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item">
                    <i class="fa fa-envelope"></i> Inquiries
                </a>
                <div style="margin-top: 50px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item">
                        <i class="fa fa-sign-out"></i> Back to Site
                    </a>
                </div>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="admin-main">
            <header class="admin-header">
                <h1 style="font-weight: 800; font-size: 36px; text-shadow: 0 4px 15px rgba(0,0,0,0.8);">Dashboard Overview</h1>
                <div class="admin-user">
                    <span style="color: #888; margin-right: 10px;">Welcome, <strong>System Admin</strong></span>
                    <img src="https://ui-avatars.com/api/?name=Admin&background=ff4d4d&color=fff" alt="Admin" style="width: 40px; height: 40px; border-radius: 50%;">
                </div>
            </header>

            <!-- Stats Overview -->
            <div class="stats-row">
                <div class="stat-card" style="cursor: pointer;" onclick="window.location.href='<c:url value="/admin/users"/>'">
                    <div class="stat-icon icon-blue">
                        <i class="fa fa-users"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${userCount != null ? userCount : 0}</h3>
                        <p>Total Travelers</p>
                    </div>
                </div>
                <div class="stat-card" style="cursor: pointer;" onclick="window.location.href='<c:url value="/admin/trips"/>'">
                    <div class="stat-icon icon-green">
                        <i class="fa fa-motorcycle"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${tripCount != null ? tripCount : 0}</h3>
                        <p>Active Trips</p>
                    </div>
                </div>
                <div class="stat-card" style="cursor: pointer;" onclick="window.location.href='<c:url value="/admin/vendors"/>'">
                    <div class="stat-icon icon-orange">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${vendorCount != null ? vendorCount : 0}</h3>
                        <p>Total Vendors</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon icon-red">
                        <i class="fa fa-inr"></i>
                    </div>
                    <div class="stat-info">
                        <h3>₹${revenue != null ? revenue : 0}</h3>
                        <p>Revenue (MTD)</p>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="admin-section">
                <div class="admin-section-header">
                    <h2>Recent Trip Inquiries</h2>
                    <a href="<c:url value='/admin/inquiries'/>" class="btn btn-sm btn-default">View All</a>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Trip Name</th>
                                <th>Explorer</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty recentInquiries}">
                                    <tr>
                                        <td colspan="5" class="text-center" style="padding: 30px; color: #888;">
                                            <i class="fa fa-folder-open-o" style="font-size: 24px; display: block; margin-bottom: 10px;"></i>
                                            No recent inquiries found.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="inquiry" items="${recentInquiries}">
                                        <tr>
                                            <td><strong>${inquiry.tripName}</strong></td>
                                            <td>${inquiry.explorerName}</td>
                                            <td>${inquiry.date}</td>
                                            <td><span class="status-badge status-${inquiry.statusClass}">${inquiry.status}</span></td>
                                            <td><button class="btn btn-sm btn-primary action-btn">Review</button></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>

    <!-- Scripts -->
    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>
