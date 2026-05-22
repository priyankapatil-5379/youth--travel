<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Package Booking History - Youth Travel Admin</title>
                <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
                <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
                <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
                <style>
                    body {
                        font-family: 'Inter', sans-serif;
                        background-color: #f1f5f9;
                        color: #0f172a;
                    }

                    .admin-layout {
                        display: flex;
                        min-height: 100vh;
                    }

                    .admin-sidebar {
                        width: 260px;
                        background: #000;
                        color: #fff;
                        flex-shrink: 0;
                        box-shadow: 4px 0 15px rgba(0, 0, 0, 0.5);
                        border-right: 1px solid #222;
                    }

                    .sidebar-header {
                        padding: 30px 20px;
                        text-align: center;
                        border-bottom: 1px solid #222;
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
                        color: #888;
                        text-decoration: none;
                        transition: 0.3s;
                        font-size: 16px;
                        font-weight: 500;
                    }

                    .admin-nav-item i {
                        margin-right: 15px;
                        width: 20px;
                        text-align: center;
                    }

                    .admin-nav-item:hover,
                    .admin-nav-item.active {
                        background: #1a1a1a;
                        color: #fff;
                        text-decoration: none;
                    }

                    .admin-nav-item.active {
                        border-left: 4px solid #ff4d4d;
                        background: rgba(255, 77, 77, 0.1);
                    }

                    .admin-main {
                        flex-grow: 1;
                        padding: 40px;
                        overflow-y: auto;
                    }

                    .admin-header {
                        margin-bottom: 30px;
                    }

                    .admin-header h1 {
                        font-weight: 700;
                        color: #fff;
                        margin: 0;
                        font-size: 28px;
                        text-transform: uppercase;
                    }

                    .breadcrumb-bar {
                        color: #888;
                        font-size: 14px;
                        margin-bottom: 30px;
                    }

                    .breadcrumb-bar a {
                        color: #ff4d4d;
                        text-decoration: none;
                    }

                    .breadcrumb-bar a:hover {
                        text-decoration: underline;
                    }

                    .pkg-info-card {
                        background: #ffffff;
                        border: 1px solid #e2e8f0;
                        border-radius: 16px;
                        padding: 25px 30px;
                        margin-bottom: 30px;
                        display: flex;
                        align-items: center;
                        gap: 25px;
                        box-shadow: 0 1px 3px rgba(0,0,0,0.08);
                    }

                    .pkg-info-icon {
                        width: 64px;
                        height: 64px;
                        background: #e0f2f2;
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 28px;
                        color: #008080;
                        flex-shrink: 0;
                    }

                    .pkg-info-text h2 {
                        color: #0f172a;
                        font-size: 22px;
                        font-weight: 700;
                        margin: 0 0 5px;
                    }

                    .pkg-info-meta {
                        color: #64748b;
                        font-size: 14px;
                    }

                    .pkg-info-meta span {
                        margin-right: 20px;
                    }

                    .pkg-info-meta i {
                        margin-right: 5px;
                        color: #008080;
                    }

                    .admin-section {
                        background: #ffffff;
                        padding: 30px;
                        border-radius: 16px;
                        box-shadow: 0 1px 3px rgba(0,0,0,0.08);
                        border: 1px solid #e2e8f0;
                    }

                    .section-title {
                        font-size: 18px;
                        font-weight: 700;
                        color: #0f172a;
                        margin-bottom: 25px;
                        padding-bottom: 15px;
                        border-bottom: 1px solid #e2e8f0;
                    }

                    .section-title span {
                        background: #e0f2f2;
                        color: #008080;
                        border-radius: 20px;
                        padding: 3px 12px;
                        font-size: 13px;
                        margin-left: 10px;
                    }

                    .table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .table thead th {
                        background: transparent;
                        color: #64748b;
                        font-weight: 700;
                        text-transform: uppercase;
                        font-size: 12px;
                        padding: 15px;
                        border: none;
                        border-bottom: 2px solid #e2e8f0;
                    }

                    .table tbody td {
                        padding: 15px;
                        vertical-align: middle;
                        border-top: 1px solid #f1f5f9;
                        color: #334155;
                    }

                    .table tbody tr:hover {
                        background: #f8fafc;
                    }

                    .status-done {
                        background: #dcfce7;
                        color: #15803d;
                        padding: 4px 10px;
                        border-radius: 6px;
                        font-weight: 700;
                        font-size: 12px;
                    }

                    .empty-state {
                        text-align: center;
                        padding: 50px;
                        color: #94a3b8;
                    }

                    .empty-state i {
                        font-size: 48px;
                        display: block;
                        margin-bottom: 15px;
                        color: #cbd5e1;
                    }

                    .breadcrumb-bar { color: #64748b; font-size: 14px; margin-bottom: 30px; }
                    .breadcrumb-bar a { color: #008080; text-decoration: none; font-weight: 600; }
                    .breadcrumb-bar a:hover { text-decoration: underline; }

                    .back-btn {
                        background: #e0f2f2;
                        color: #008080;
                        border: 1px solid #008080;
                        padding: 8px 20px;
                        border-radius: 8px;
                        font-weight: 600;
                        text-decoration: none;
                        font-size: 14px;
                        transition: 0.2s;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .back-btn:hover {
                        background: #008080;
                        color: #fff;
                        text-decoration: none;
                    }
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
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item active">
                    <i class="fa fa-motorcycle"></i> Manage Trips
                </a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item ">
                    <i class="fa fa-users"></i> User Accounts
                </a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item ">
                    <i class="fa fa-handshake-o"></i> Vendor Requests
                </a>
                <a href="<c:url value='/admin/payouts'/>" class="admin-nav-item ">
                    <i class="fa fa-money"></i> Payout Requests
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
                            <a href="<c:url value='/admin/trips'/>"><i class="fa fa-arrow-left"></i> Back to All
                                Packages</a>
                            <span style="margin: 0 8px;">/</span>
                            <span>${pkg.title}</span>
                        </div>
                        <header class="admin-header">
                            <h1>Booking History</h1>
                        </header>

                        <!-- Package Info Card -->
                        <div class="pkg-info-card">
                            <div class="pkg-info-icon"><i class="fa fa-suitcase"></i></div>
                            <div class="pkg-info-text">
                                <h2>${pkg.title}</h2>
                                <div class="pkg-info-meta">
                                    <span><i class="fa fa-building"></i>${pkg.vendor.businessName}</span>
                                    <span><i class="fa fa-map-marker"></i>${pkg.destination}</span>
                                    <span><i class="fa fa-inr"></i>₹${pkg.price}</span>
                                    <span><i class="fa fa-users"></i><strong
                                            style="color:#fff;">${not empty bookings ? bookings.size() : 0}</strong> bookings</span>
                                </div>
                            </div>
                        </div>

                        <!-- Booking History Table -->
                        <div class="admin-section">
                            <div class="section-title">
                                Users Who Used This Package
                                <span>${not empty bookings ? bookings.size() : 0}</span>
                            </div>
                            <c:choose>
                                <c:when test="${empty bookings}">
                                    <div class="empty-state">
                                        <i class="fa fa-users"></i>
                                        <p>No users have booked this package yet.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>User Name</th>
                                                    <th>Email</th>
                                                    <th>Booking Date</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="booking" items="${bookings}" varStatus="s">
                                                    <tr>
                                                        <td style="color:#555;">${s.index + 1}</td>
                                                        <td><strong>${booking.user.fullName}</strong></td>
                                                        <td>${booking.user.email}</td>
                                                        <td>
                                                            <fmt:parseDate value="${booking.bookingDate}"
                                                                pattern="yyyy-MM-dd'T'HH:mm" var="bd" />
                                                            <fmt:formatDate value="${bd}"
                                                                pattern="dd MMM yyyy, HH:mm" />
                                                        </td>
                                                        <td><span class="status-done">${booking.status}</span></td>
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