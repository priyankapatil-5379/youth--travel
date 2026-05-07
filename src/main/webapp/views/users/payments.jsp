<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payments | Youth Travel</title>
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
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-body); 
            color: var(--text-main); 
            margin: 0; padding: 0; 
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; }

        .page-header { margin-bottom: 32px; }
        .page-header h1 { font-size: 28px; font-weight: 800; color: var(--text-main); margin: 0; letter-spacing: -0.5px; }
        .page-header p { color: var(--text-muted); margin: 4px 0 0; font-size: 15px; font-weight: 500; }

        .card-white { 
            background: var(--bg-card); 
            padding: 0; 
            border-radius: 16px; 
            border: 1px solid var(--border-color); 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05); 
            overflow: hidden;
        }

        .table { width: 100%; margin-bottom: 0; border-collapse: separate; border-spacing: 0; }
        .table th { 
            background: #f8fafc; 
            color: var(--text-muted); 
            font-size: 12px; 
            font-weight: 700; 
            text-transform: uppercase; 
            letter-spacing: 0.5px; 
            padding: 16px 24px; 
            border-bottom: 1px solid var(--border-color); 
        }
        .table td { 
            padding: 20px 24px; 
            border-bottom: 1px solid var(--border-color); 
            font-size: 14px; 
            color: var(--text-main); 
            vertical-align: middle;
            font-weight: 500;
        }
        .table tr:last-child td { border-bottom: none; }

        .status-badge { 
            padding: 6px 12px; 
            border-radius: 100px; 
            font-size: 11px; 
            font-weight: 700; 
            text-transform: uppercase; 
            letter-spacing: 0.5px; 
        }
        .status-success { background: #f0fdf4; color: #166534; }
        .status-pending { background: #fffbeb; color: #92400e; }
        .status-failed { background: #fef2f2; color: #991b1b; }

        .amount-text { font-weight: 700; color: var(--accent-red); font-size: 15px; }

        .empty-state {
            padding: 80px 40px;
            text-align: center;
        }
        .empty-state i { font-size: 60px; color: #e2e8f0; margin-bottom: 24px; }
        .empty-state p { color: var(--text-muted); font-size: 16px; font-weight: 600; }

        /* Mobile Responsiveness */
        .mobile-header {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 70px;
            background: #ffffff;
            border-bottom: 1px solid var(--border-color);
            padding: 0 24px;
            align-items: center;
            justify-content: space-between;
            z-index: 900;
        }
        .mobile-logo img { height: 45px; width: auto; object-fit: contain; display: block; }
        .hamburger-menu {
            font-size: 24px;
            color: var(--primary);
            cursor: pointer;
            background: none;
            border: none;
            padding: 8px;
        }

        @media (max-width: 991px) {
            .mobile-header { display: flex; }
            .main-content { margin-left: 0; padding: 100px 20px 40px !important; }
        }

        @media (max-width: 576px) {
            .main-content { padding: 90px 15px 30px !important; }
            .page-header h1 { font-size: 22px; }
            .table th, .table td { padding: 12px 16px; font-size: 13px; }
        }
    </style>
</head>
<body class="light-theme">
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="payments" />
        </jsp:include>
        
        <!-- Mobile Header -->
        <header class="mobile-header">
            <div class="mobile-logo">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>
            <button class="hamburger-menu" onclick="toggleMainSidebar()">
                <i class="fa fa-bars"></i>
            </button>
        </header>

        <main class="main-content">
                <div class="page-header">
                    <h1>Payment Records</h1>
                    <p>Transparent tracking of your travel investments</p>
                </div>
            <div class="card-white">
                <c:choose>
                    <c:when test="${not empty payments}">
                        <div class="table-responsive">
                            <table class="table">
                                <thead><tr><th>Package</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead>
                                <tbody>
                                    <c:forEach var="payment" items="${payments}">
                                        <tr>
                                            <td style="font-weight: 700; color: var(--text-main);">${payment.booking.trip.title}</td>
                                            <td class="amount-text">₹${payment.amount}</td>
                                            <td><span class="status-badge status-${payment.status.toLowerCase()}">${payment.status}</span></td>
                                            <td><fmt:parseDate value="${payment.paymentDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" /><fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy, hh:mm a" /></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fa fa-credit-card"></i>
                            <p>No payment records found yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>
