<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Accounts - Youth Travel Admin</title>
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
        .table { width: 100%; border-collapse: collapse; }
        .table thead th { background: #2a2a35; color: #888; font-weight: 600; text-transform: uppercase; font-size: 12px; padding: 15px; border: none; }
        .table tbody td { padding: 15px; vertical-align: middle; border-top: 1px solid #2a2a35; color: #ddd; }
        .table tbody tr:hover { background: #252530; cursor: pointer; }
        .user-avatar { width: 38px; height: 38px; border-radius: 50%; background: rgba(255,77,77,0.15); color: #ff4d4d; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 15px; margin-right: 10px; }
        .user-name { font-weight: 700; color: #fff; font-size: 15px; }
        .user-email { color: #888; font-size: 13px; }
        .view-btn { background: #ff4d4d; color: #fff; border: none; padding: 6px 16px; border-radius: 6px; font-weight: 600; text-decoration: none; font-size: 13px; transition: 0.2s; }
        .view-btn:hover { background: #e60000; color: #fff; text-decoration: none; }
        .empty-state { text-align: center; padding: 60px; color: #555; }
        .empty-state i { font-size: 64px; display: block; margin-bottom: 20px; color: #333; }
        .empty-state h2 { color: #666; }
        .reg-date { color: #666; font-size: 13px; }
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
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item"><i class="fa fa-suitcase"></i> Manage Trips</a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item active"><i class="fa fa-users"></i> User Accounts</a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item"><i class="fa fa-handshake-o"></i> Vendor Requests</a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item"><i class="fa fa-envelope"></i> Inquiries</a>
                <div style="margin-top: 50px; border-top: 1px solid #222; padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item"><i class="fa fa-sign-out"></i> Back to Site</a>
                </div>
            </nav>
        </aside>
        <main class="admin-main">
            <header class="admin-header">
                <h1>User Accounts</h1>
            </header>
            <div class="admin-section">
                <c:choose>
                    <c:when test="${empty users}">
                        <div class="empty-state">
                            <i class="fa fa-users"></i>
                            <h2>No Users Registered</h2>
                            <p>Registered travelers will appear here once they sign up.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>User</th>
                                        <th>Phone</th>
                                        <th>Registered On</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${users}" varStatus="s">
                                        <tr onclick="window.location='<c:url value='/admin/users/${u.id}'/>'">
                                            <td style="color:#555;">${s.index + 1}</td>
                                            <td>
                                                <div style="display:flex; align-items:center;">
                                                    <div class="user-avatar">${fn:toUpperCase(fn:substring(u.name, 0, 1))}</div>
                                                    <div>
                                                        <div class="user-name">${u.name}</div>
                                                        <div class="user-email">${u.email}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>${u.phone != null ? u.phone : '—'}</td>
                                            <td class="reg-date">${u.registeredAt}</td>
                                            <td>
                                                <a href="<c:url value='/admin/users/${u.id}'/>" class="view-btn" onclick="event.stopPropagation()">
                                                    <i class="fa fa-eye"></i> View Profile
                                                </a>
                                            </td>
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
