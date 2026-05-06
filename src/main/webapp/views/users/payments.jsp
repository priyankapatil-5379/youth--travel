<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payments | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root {
            --sidebar-teal: #14b8a6;
            --sidebar-teal-dark: #0f766e;
            --accent-coral: #ef4444;
            --accent-coral-dark: #dc2626;
            --bg-main: #f8fafc;
            --bg-card: #ffffff;
            --border-light: #e5e7eb;
            --text-main: #1f2937;
            --text-secondary: #6b7280;
            --transition: all 0.3s ease;
        }

        body.theme-light-premium {
            font-family: 'Dosis', sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 40px 40px 40px; }
        
        .card-white { 
            background: #ffffff; 
            padding: 40px; 
            border-radius: 24px; 
            border: 1px solid var(--border-light); 
            box-shadow: 0 10px 30px rgba(0,0,0,0.03); 
        }
        
        .table { color: var(--text-main); margin-bottom: 0; }
        .table th { 
            color: var(--text-secondary); 
            font-size: 11px; 
            font-weight: 800; 
            text-transform: uppercase; 
            border: none; 
            letter-spacing: 1.5px; 
            padding-bottom: 20px; 
        }
        .table td { 
            border-color: #f1f5f9; 
            vertical-align: middle; 
            padding: 20px 10px; 
            font-weight: 600; 
            color: var(--text-main); 
        }
        
        .status-badge { 
            padding: 6px 14px; 
            border-radius: 20px; 
            font-size: 11px; 
            font-weight: 800; 
            text-transform: uppercase; 
            letter-spacing: 0.5px; 
        }
        .status-success { background: rgba(34, 197, 94, 0.1); color: #16a34a; }
        .status-pending { background: rgba(245, 158, 11, 0.1); color: #d97706; }
    </style>
</head>
<body class="theme-light-premium">
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="payments" />
        </jsp:include>
        <main class="main-content">
                <div class="mb-5">
                    <h2 style="font-weight: 800; margin: 0; color: var(--text-main); font-size: 36px; letter-spacing: -1px;">Payment History</h2>
                    <p style="color: var(--text-secondary); margin: 5px 0 0; font-weight: 500; font-size: 16px;">Manage your transaction records</p>
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
                                            <td style="font-weight: 800; color: var(--accent-coral); font-size: 16px;">₹${payment.amount}</td>
                                            <td><span class="status-badge status-${payment.status.toLowerCase()}">${payment.status}</span></td>
                                            <td>${payment.paymentDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center" style="padding: 100px 40px;">
                            <div style="width: 80px; height: 80px; background: rgba(241, 245, 249, 1); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 25px;">
                                <i class="fa fa-credit-card" style="font-size: 32px; color: var(--text-secondary);"></i>
                            </div>
                            <h3 style="color: var(--text-main); font-weight: 800; margin-bottom: 10px;">No payment records found</h3>
                            <p style="color: var(--text-secondary); font-size: 16px;">Manage your transaction records here once you book a trip.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>
