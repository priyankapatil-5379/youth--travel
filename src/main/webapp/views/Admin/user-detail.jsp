<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${user.name} - User Profile - Youth Travel Admin</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f1f5f9; color: #0f172a; }
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
        .breadcrumb-bar { color: #64748b; font-size: 14px; margin-bottom: 30px; }
        .breadcrumb-bar a { color: #008080; text-decoration: none; font-weight: 600; }
        .breadcrumb-bar a:hover { text-decoration: underline; }

        /* User Profile Card */
        .user-profile-card { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 16px; padding: 30px; margin-bottom: 30px; display: flex; align-items: center; gap: 30px; box-shadow: 0 1px 3px rgba(0,0,0,0.08); }
        .user-avatar-lg { width: 90px; height: 90px; border-radius: 50%; background: #e0f2f2; border: 3px solid rgba(0,128,128,0.2); color: #008080; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 36px; flex-shrink: 0; }
        .user-info h2 { color: #0f172a; font-size: 24px; font-weight: 700; margin: 0 0 8px; }
        .user-meta { display: flex; flex-wrap: wrap; gap: 20px; margin-top: 12px; }
        .user-meta-item { display: flex; align-items: center; gap: 8px; color: #64748b; font-size: 14px; }
        .user-meta-item i { color: #008080; width: 16px; }
        .stat-pills { display: flex; gap: 15px; margin-top: 15px; }
        .stat-pill { background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 8px; padding: 10px 20px; text-align: center; }
        .stat-pill h4 { color: #0f172a; font-size: 22px; font-weight: 800; margin: 0; }
        .stat-pill p { color: #64748b; font-size: 12px; margin: 0; }

        /* History Table */
        .admin-section { background: #ffffff; padding: 30px; border-radius: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.08); border: 1px solid #e2e8f0; }
        .section-title { font-size: 18px; font-weight: 700; color: #0f172a; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: space-between; }
        .section-title span.count-badge { background: #e0f2f2; color: #008080; border-radius: 20px; padding: 3px 12px; font-size: 13px; }
        .table { width: 100%; border-collapse: collapse; }
        .table thead th { background: transparent; color: #64748b; font-weight: 700; text-transform: uppercase; font-size: 12px; padding: 15px; border: none; border-bottom: 2px solid #e2e8f0; }
        .table tbody td { padding: 15px; vertical-align: middle; border-top: 1px solid #f1f5f9; color: #334155; }
        .table tbody tr:hover { background: #f8fafc; }
        .status-done { background: #dcfce7; color: #15803d; padding: 4px 10px; border-radius: 6px; font-weight: 700; font-size: 12px; }
        .pkg-title { font-weight: 700; color: #0f172a; }
        .pkg-vendor { color: #64748b; font-size: 12px; }
        .price-badge { background: #e0f2f2; color: #008080; padding: 3px 9px; border-radius: 5px; font-weight: 700; font-size: 13px; }
        .empty-state { text-align: center; padding: 50px; color: #94a3b8; }
        .empty-state i { font-size: 48px; display: block; margin-bottom: 15px; color: #cbd5e1; }
    </style>
<link rel="stylesheet" href="<c:url value='/views/assets/css/admin-light.css'/>">
</head>
<body class="admin-light-theme">
    <div class="admin-layout">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item ">
                    <i class="fa fa-th-large"></i> Dashboard
                </a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item ">
                    <i class="fa fa-motorcycle"></i> Manage Trips
                </a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item active">
                    <i class="fa fa-users"></i> User Accounts
                </a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item ">
                    <i class="fa fa-handshake-o"></i> Vendor Requests
                </a>
                <a href="<c:url value='/admin/home-images'/>" class="admin-nav-item ">
                    <i class="fa fa-image"></i> Homepage Photos
                </a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item ">
                    <i class="fa fa-envelope"></i> Inquiries
                </a>
                <div style="margin-top: 50px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item">
                        <i class="fa fa-sign-out"></i> Back to Site
                    </a>
                </div>
            </nav>
        </aside>
        <main class="admin-main">
            <div class="breadcrumb-bar">
                <a href="<c:url value='/admin/users'/>"><i class="fa fa-arrow-left"></i> Back to All Users</a>
                <span style="margin: 0 8px;">/</span>
                <span>${user.name}</span>
            </div>

            <!-- User Profile Card -->
            <div class="user-profile-card">
                <div class="user-avatar-lg">
                    ${not empty user.name ? fn:toUpperCase(fn:substring(user.name, 0, 1)) : 'U'}
                </div>
                <div class="user-info" style="flex-grow:1;">
                    <h2>${user.name}</h2>
                    <div class="user-meta">
                        <div class="user-meta-item"><i class="fa fa-envelope"></i>${user.email}</div>
                        <div class="user-meta-item"><i class="fa fa-phone"></i>${user.phone != null ? user.phone : 'Not provided'}</div>
                        <div class="user-meta-item"><i class="fa fa-calendar"></i>
                            Joined ${user.registeredAt}
                        </div>
                    </div>
                    <div class="stat-pills">
                        <div class="stat-pill">
                            <h4>${not empty bookings ? bookings.size() : 0}</h4>
                            <p>Trips Taken</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking History -->
            <div class="admin-section">
                <div class="section-title">
                    Trip Booking History
                    <span class="count-badge">${not empty bookings ? bookings.size() : 0} bookings</span>
                </div>
                <c:choose>
                    <c:when test="${empty bookings}">
                        <div class="empty-state">
                            <i class="fa fa-suitcase"></i>
                            <p>This user hasn't booked any trips yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Package</th>
                                        <th>Vendor</th>
                                        <th>Destination</th>
                                        <th>Price</th>
                                        <th>Booked On</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="b" items="${bookings}" varStatus="s">
                                        <tr>
                                            <td style="color:#555;">${s.index + 1}</td>
                                            <td>
                                                <div class="pkg-title">${b.tripPackage.title}</div>
                                            </td>
                                            <td class="pkg-vendor">${b.tripPackage.vendor.businessName}</td>
                                            <td><i class="fa fa-map-marker" style="color:#ff4d4d; margin-right:4px;"></i>${b.tripPackage.destination}</td>
                                            <td><span class="price-badge">₹${b.tripPackage.price}</span></td>
                                            <td style="color:#888; font-size:13px;">${b.bookingDate}</td>
                                            <td><span class="status-done">${b.status}</span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>
