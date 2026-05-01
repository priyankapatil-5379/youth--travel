发现<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Enquiries - Youth Travel</title>
    
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Dosis', sans-serif;
            background: #002244 url('<c:url value="/views/assets/images/underwater-theme-bg.png"/>') top center/cover no-repeat fixed;
            color: #ffffff;
        }
        
        .admin-layout {
            display: flex;
            min-height: 100vh;
            position: relative;
            z-index: 10;
        }
        
        .admin-sidebar {
            width: 260px;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            color: #fff;
            flex-shrink: 0;
            border-right: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-header {
            padding: 30px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-header img { max-width: 150px; filter: brightness(0) invert(1); }
        
        .admin-nav { padding: 20px 0; }
        
        .admin-nav-item {
            padding: 12px 25px;
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            transition: 0.3s;
            font-size: 16px;
        }
        
        .admin-nav-item i { margin-right: 15px; width: 20px; text-align: center; }
        
        .admin-nav-item:hover, .admin-nav-item.active {
            background: rgba(230, 57, 70, 0.15);
            color: #e63946;
            text-decoration: none;
        }
        
        .admin-nav-item.active { border-left: 4px solid #e63946; }
        
        .admin-main { flex-grow: 1; padding: 40px; overflow-y: auto; }
        
        .admin-header h1 {
            font-weight: 800;
            font-size: 32px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 30px;
        }
        
        .enquiry-card {
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 25px;
            overflow: hidden;
            transition: 0.3s;
        }
        
        .enquiry-card:hover {
            border-color: #e63946;
            transform: translateY(-5px);
        }
        
        .enquiry-header {
            padding: 20px 25px;
            background: rgba(255,255,255,0.05);
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .enquiry-user-info h4 { margin: 0; font-weight: 800; color: #fff; }
        .enquiry-user-info span { font-size: 13px; color: #aaa; }
        
        .enquiry-body { padding: 25px; }
        .enquiry-body p { font-size: 16px; line-height: 1.7; color: #eee; margin-bottom: 20px; }
        
        .enquiry-meta {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #888;
        }
        
        .enquiry-meta i { color: #e63946; margin-right: 5px; }
        
        .btn-delete {
            background: rgba(230, 57, 70, 0.1);
            color: #e63946;
            border: 1px solid rgba(230, 57, 70, 0.3);
            padding: 8px 15px;
            border-radius: 8px;
            transition: 0.3s;
        }
        
        .btn-delete:hover {
            background: #e63946;
            color: #fff;
        }

        .empty-state {
            text-align: center;
            padding: 80px 0;
            opacity: 0.5;
        }
        .empty-state i { font-size: 64px; margin-bottom: 20px; }
    </style>
</head>

<body>
    <div class="admin-layout">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt=""></a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item">
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
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item active">
                    <i class="fa fa-envelope"></i> Inquiries
                </a>
            </nav>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1>User Enquiries & Messages</h1>
            </header>

            <div class="enquiries-list">
                <c:choose>
                    <c:when test="${empty enquiries}">
                        <div class="empty-state">
                            <i class="fa fa-envelope-o"></i>
                            <h3>No enquiries yet</h3>
                            <p>All user messages from the contact form and chat will appear here.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="enq" items="${enquiries}">
                            <div class="enquiry-card">
                                <div class="enquiry-header">
                                    <div class="enquiry-user-info">
                                        <h4>${enq.name}</h4>
                                        <span>Received on ${enq.formattedDate}</span>
                                    </div>
                                    <form action="<c:url value='/admin/inquiries/${enq.id}/delete'/>" method="post" onsubmit="return confirm('Delete this enquiry?')">
                                        <button type="submit" class="btn-delete">
                                            <i class="fa fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </div>
                                <div class="enquiry-body">
                                    <p>${enq.message}</p>
                                    <div class="enquiry-meta">
                                        <span><i class="fa fa-envelope"></i> ${enq.email}</span>
                                        <c:if test="${not empty enq.phone}">
                                            <span><i class="fa fa-phone"></i> ${enq.phone}</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>
