<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vendor Requests - Youth Travel Admin</title>
    
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
        .admin-header { margin-bottom: 40px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header h1 { font-weight: 700; color: #fff; margin: 0; font-size: 28px; text-transform: uppercase; }
        .admin-section { background: #1e1e26; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); border: 1px solid #2a2a35; }
        .table thead th { background: #2a2a35; color: #888; font-weight: 600; text-transform: uppercase; font-size: 12px; padding: 15px; border: none; }
        .table tbody td { padding: 15px; vertical-align: middle; border-top: 1px solid #2a2a35; color: #ddd; }
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
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item active"><i class="fa fa-handshake-o"></i> Vendor Requests</a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item"><i class="fa fa-envelope"></i> Inquiries</a>
                <div style="margin-top: 50px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item"><i class="fa fa-sign-out"></i> Back to Site</a>
                </div>
            </nav>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1>Vendor Requests</h1>
            </header>

            <div class="admin-section">
                <div style="margin-bottom: 20px; display: flex; gap: 10px;">
                    <a href="<c:url value='/admin/vendors'/>" class="btn btn-sm ${empty currentStatus || currentStatus == 'ALL' ? 'btn-primary' : 'btn-secondary'}" style="${empty currentStatus || currentStatus == 'ALL' ? 'background:#ff4d4d; border:none; color:white; padding: 8px 15px; border-radius: 5px; text-decoration: none;' : 'background:#333; border:none; color:white; padding: 8px 15px; border-radius: 5px; text-decoration: none;'}">All Vendors</a>
                    <a href="<c:url value='/admin/vendors?status=PENDING'/>" class="btn btn-sm ${currentStatus == 'PENDING' ? 'btn-primary' : 'btn-secondary'}" style="${currentStatus == 'PENDING' ? 'background:#ff4d4d; border:none; color:white; padding: 8px 15px; border-radius: 5px; text-decoration: none;' : 'background:#333; border:none; color:white; padding: 8px 15px; border-radius: 5px; text-decoration: none;'}">Pending Requests</a>
                </div>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success" style="background-color: rgba(40,167,69,0.2); color: #28a745; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid rgba(40,167,69,0.3);">
                        ${message}
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Business Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty vendors}">
                                    <tr>
                                        <td colspan="5" class="text-center" style="padding: 30px; color: #888;">No vendors found.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="vendor" items="${vendors}">
                                        <tr>
                                            <td><strong>${vendor.businessName}</strong></td>
                                            <td>${vendor.emailId}</td>
                                            <td>${vendor.phoneNumber}</td>
                                            <td>
                                                <span style="padding: 5px 10px; border-radius: 3px; font-size: 12px; font-weight: bold;
                                                    ${vendor.status == 'APPROVED' ? 'background: rgba(40,167,69,0.2); color: #28a745;' : ''}
                                                    ${vendor.status == 'REJECTED' ? 'background: rgba(220,53,69,0.2); color: #dc3545;' : ''}
                                                    ${vendor.status == 'PENDING' ? 'background: rgba(255,193,7,0.2); color: #ffc107;' : ''}
                                                ">
                                                    ${vendor.status}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="<c:url value='/admin/vendors/${vendor.id}'/>" class="btn btn-sm" style="background: #007bff; color: white; padding: 5px 10px; border-radius: 3px; text-decoration: none; font-size: 12px;">View Details</a>
                                            </td>
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
</body>
</html>
