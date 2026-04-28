<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inquiries - Youth Travel Admin</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        body { font-family: 'Dosis', sans-serif; background-color: #0f1015; color: #fff; }
        .admin-layout { display: flex; min-height: 100vh; }
        .admin-sidebar { width: 260px; background: #000; color: #fff; flex-shrink: 0; box-shadow: 4px 0 15px rgba(0,0,0,0.5); border-right: 1px solid #222; }
        .sidebar-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid #222; }
        .sidebar-header img { max-width: 150px; filter: brightness(0) invert(1); }
        .admin-nav { padding: 20px 0; }
        .admin-nav-item { padding: 12px 25px; display: flex; align-items: center; color: #888; text-decoration: none; transition: 0.3s; font-size: 16px; font-weight: 500; }
        .admin-nav-item i { margin-right: 15px; width: 20px; text-align: center; }
        .admin-nav-item:hover, .admin-nav-item.active { background: #1a1a1a; color: #fff; text-decoration: none; }
        .admin-nav-item.active { border-left: 4px solid #ff4d4d; background: rgba(255,77,77,0.1); }
        .admin-main { flex-grow: 1; padding: 40px; overflow-y: auto; }
        .admin-header { margin-bottom: 40px; }
        .admin-header h1 { font-weight: 700; color: #fff; margin: 0; font-size: 28px; text-transform: uppercase; }
        .admin-section { background: #1e1e26; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); border: 1px solid #2a2a35; }
        
        /* Custom Tabs */
        .nav-tabs { border-bottom: 1px solid #2a2a35; margin-bottom: 30px; }
        .nav-tabs > li > a { color: #888; border: none; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; transition: 0.3s; }
        .nav-tabs > li > a:hover { background: transparent; color: #fff; border: none; }
        .nav-tabs > li.active > a, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover { 
            background: transparent !important; color: #ff4d4d !important; border: none !important; border-bottom: 2px solid #ff4d4d !important; 
        }

        .table thead th { background: #2a2a35; color: #888; font-weight: 600; text-transform: uppercase; font-size: 12px; padding: 15px; border: none; }
        .table tbody td { padding: 15px; vertical-align: middle; border-top: 1px solid #2a2a35; color: #ddd; }
        .status-badge { padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .badge-new { background: rgba(33, 150, 243, 0.1); color: #2196f3; }
        .badge-replied { background: rgba(76, 175, 80, 0.1); color: #4caf50; }
    </style>
</head>
<body>
    <div class="admin-layout">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel"></a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item"><i class="fa fa-motorcycle"></i> Manage Trips</a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item"><i class="fa fa-users"></i> User Accounts</a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item"><i class="fa fa-handshake-o"></i> Vendor Requests</a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item active"><i class="fa fa-envelope"></i> Inquiries</a>
                <div style="margin-top: 50px; border-top: 1px solid #222; padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item"><i class="fa fa-sign-out"></i> Back to Site</a>
                </div>
            </nav>
        </aside>
        <main class="admin-main">
            <header class="admin-header"><h1>Inquiries Management</h1></header>
            
            <div class="admin-section">
                <!-- Tabs Navigation -->
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#user-inquiries" data-toggle="tab">User Inquiries</a></li>
                    <li><a href="#vendor-inquiries" data-toggle="tab">Vendor Inquiries</a></li>
                </ul>

                <!-- Tab Content -->
                <div class="tab-content">
                    <!-- User Inquiries Pane -->
                    <div class="tab-pane active" id="user-inquiries">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Trip Interest</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty userInquiries}">
                                            <tr>
                                                <td colspan="5" class="text-center" style="padding: 40px; color: #555;">
                                                    <i class="fa fa-user-o" style="font-size: 32px; display: block; margin-bottom: 10px;"></i>
                                                    No user inquiries found.
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="inq" items="${userInquiries}">
                                                <tr>
                                                    <td>${inq.name}</td>
                                                    <td>${inq.tripName}</td>
                                                    <td>${inq.date}</td>
                                                    <td><span class="status-badge badge-new">${inq.status}</span></td>
                                                    <td><button class="btn btn-xs btn-primary">View</button></td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Vendor Inquiries Pane -->
                    <div class="tab-pane" id="vendor-inquiries">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Vendor Name</th>
                                        <th>Subject</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty vendorInquiries}">
                                            <tr>
                                                <td colspan="5" class="text-center" style="padding: 40px; color: #555;">
                                                    <i class="fa fa-building-o" style="font-size: 32px; display: block; margin-bottom: 10px;"></i>
                                                    No vendor inquiries found.
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="inq" items="${vendorInquiries}">
                                                <tr>
                                                    <td>${inq.vendorName}</td>
                                                    <td>${inq.subject}</td>
                                                    <td>${inq.date}</td>
                                                    <td><span class="status-badge badge-new">${inq.status}</span></td>
                                                    <td><button class="btn btn-xs btn-primary">View</button></td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Scripts for Tabs -->
    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>
