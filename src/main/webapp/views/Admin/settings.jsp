<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Settings - Youth Travel Admin</title>
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
        .admin-section { background: #1e1e26; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); border: 1px solid #2a2a35; margin-bottom: 30px; }
        
        .form-group label { font-weight: 600; color: #aaa; margin-bottom: 10px; }
        .form-control { background: #2a2a35; border: 1px solid #3a3a45; color: #fff; height: 45px; border-radius: 8px; }
        .form-control:focus { background: #333; border-color: #ff4d4d; color: #fff; box-shadow: none; }
        .form-control[readonly] { background: #15151a; border-color: #222; color: #666; cursor: not-allowed; }
        
        .section-title { font-size: 18px; font-weight: 700; color: #fff; margin-bottom: 25px; display: flex; align-items: center; }
        .section-title i { margin-right: 12px; color: #ff4d4d; }
        
        .alert-success { background: rgba(76, 175, 80, 0.1); border: 1px solid #4caf50; color: #4caf50; border-radius: 8px; }
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
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item"><i class="fa fa-envelope"></i> Inquiries</a>
                <a href="<c:url value='/admin/settings'/>" class="admin-nav-item active"><i class="fa fa-cog"></i> Settings</a>
                <div style="margin-top: 50px; border-top: 1px solid #222; padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item"><i class="fa fa-sign-out"></i> Back to Site</a>
                </div>
            </nav>
        </aside>
        <main class="admin-main">
            <header class="admin-header"><h1>Settings & Security</h1></header>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <!-- General Settings (Read Only) -->
            <div class="admin-section">
                <div class="section-title"><i class="fa fa-globe"></i> General Information</div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Website Name</label>
                            <input type="text" class="form-control" value="${admin.siteName != null ? admin.siteName : 'Youth Travel'}" readonly title="Locked by system">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Admin Access Email</label>
                            <input type="email" class="form-control" value="${admin.email != null ? admin.email : 'admin@youthtravel.in'}" readonly title="Locked by system">
                        </div>
                    </div>
                </div>
                <p style="color: #666; font-size: 13px; margin-top: 10px;"><i class="fa fa-info-circle"></i> Basic site info is managed via system configuration and cannot be changed here.</p>
            </div>

            <!-- Security & System Settings -->
            <div class="admin-section">
                <div class="section-title"><i class="fa fa-lock"></i> Security & System Control</div>
                <form action="<c:url value='/admin/updateSettings'/>" method="POST">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" name="newPassword" class="form-control" placeholder="Leave blank to keep current">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Maintenance Mode</label>
                                <select name="maintenanceMode" class="form-control">
                                    <option value="false" ${!admin.maintenanceMode ? 'selected' : ''}>Disabled (Live)</option>
                                    <option value="true" ${admin.maintenanceMode ? 'selected' : ''}>Enabled (Maintenance)</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary" style="background: #ff4d4d; border: none; padding: 10px 30px; font-weight: 700;">Update Settings</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
