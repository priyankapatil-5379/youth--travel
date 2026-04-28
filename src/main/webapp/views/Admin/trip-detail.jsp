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
                <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
                <style>
                    body {
                        font-family: 'Dosis', sans-serif;
                        background-color: #0f1015;
                        color: #fff;
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
                        background: #1e1e26;
                        border: 1px solid #2a2a35;
                        border-radius: 15px;
                        padding: 25px 30px;
                        margin-bottom: 30px;
                        display: flex;
                        align-items: center;
                        gap: 25px;
                    }

                    .pkg-info-icon {
                        width: 64px;
                        height: 64px;
                        background: rgba(255, 77, 77, 0.1);
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 28px;
                        color: #ff4d4d;
                        flex-shrink: 0;
                    }

                    .pkg-info-text h2 {
                        color: #fff;
                        font-size: 22px;
                        font-weight: 700;
                        margin: 0 0 5px;
                    }

                    .pkg-info-meta {
                        color: #888;
                        font-size: 14px;
                    }

                    .pkg-info-meta span {
                        margin-right: 20px;
                    }

                    .pkg-info-meta i {
                        margin-right: 5px;
                        color: #ff4d4d;
                    }

                    .admin-section {
                        background: #1e1e26;
                        padding: 30px;
                        border-radius: 15px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                        border: 1px solid #2a2a35;
                    }

                    .section-title {
                        font-size: 18px;
                        font-weight: 700;
                        color: #fff;
                        margin-bottom: 25px;
                        padding-bottom: 15px;
                        border-bottom: 1px solid #2a2a35;
                    }

                    .section-title span {
                        background: rgba(255, 77, 77, 0.1);
                        color: #ff4d4d;
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
                        background: #2a2a35;
                        color: #888;
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 12px;
                        padding: 15px;
                        border: none;
                    }

                    .table tbody td {
                        padding: 15px;
                        vertical-align: middle;
                        border-top: 1px solid #2a2a35;
                        color: #ddd;
                    }

                    .table tbody tr:hover {
                        background: #252530;
                    }

                    .status-done {
                        background: rgba(76, 175, 80, 0.1);
                        color: #4caf50;
                        padding: 4px 10px;
                        border-radius: 6px;
                        font-weight: 700;
                        font-size: 12px;
                    }

                    .empty-state {
                        text-align: center;
                        padding: 50px;
                        color: #555;
                    }

                    .empty-state i {
                        font-size: 48px;
                        display: block;
                        margin-bottom: 15px;
                        color: #333;
                    }

                    .back-btn {
                        background: #2a2a35;
                        color: #fff;
                        border: none;
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
                        background: #3a3a45;
                        color: #fff;
                        text-decoration: none;
                    }
                </style>
            </head>

            <body>
                <div class="admin-layout">
                    <aside class="admin-sidebar">
                        <div class="sidebar-header">
                            <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>"
                                    alt="Youth Travel"></a>
                        </div>
                        <nav class="admin-nav">
                            <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item"><i
                                    class="fa fa-th-large"></i> Dashboard</a>
                            <a href="<c:url value='/admin/trips'/>" class="admin-nav-item active"><i
                                    class="fa fa-suitcase"></i> Manage Trips</a>
                            <a href="<c:url value='/admin/users'/>" class="admin-nav-item"><i class="fa fa-users"></i>
                                User Accounts</a>
                            <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item"><i
                                    class="fa fa-handshake-o"></i> Vendor Requests</a>
                            <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item"><i
                                    class="fa fa-envelope"></i> Inquiries</a>
                            <div style="margin-top: 50px; border-top: 1px solid #222; padding-top: 20px;">
                                <a href="<c:url value='/'/>" class="admin-nav-item"><i class="fa fa-sign-out"></i> Back
                                    to Site</a>
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
                                            style="color:#fff;">${bookings.size()}</strong> bookings</span>
                                </div>
                            </div>
                        </div>

                        <!-- Booking History Table -->
                        <div class="admin-section">
                            <div class="section-title">
                                Users Who Used This Package
                                <span>${bookings.size()}</span>
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