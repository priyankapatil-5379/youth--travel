<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Guest Manifest | Youth Travel</title>
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
            --success: #10b981;
            --warning: #f59e0b;
            --info: #3b82f6;
            --danger: #e63946;
            --sidebar-width: 260px;
        }

        body {
            background-color: var(--bg-body);
            color: var(--text-main);
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            -webkit-font-smoothing: antialiased;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            padding: 40px !important;
        }

        .page-header {
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            font-weight: 800;
            font-size: 28px;
            color: var(--text-main);
            margin: 0;
            letter-spacing: -0.5px;
        }

        .btn-primary {
            background-color: var(--accent-red) !important;
            border: none !important;
            border-radius: 10px !important;
            padding: 10px 20px !important;
            font-weight: 700 !important;
            box-shadow: 0 4px 12px rgba(230, 57, 70, 0.2);
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            background-color: #d62828 !important;
            box-shadow: 0 8px 20px rgba(230, 57, 70, 0.3);
        }

        .manifest-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: #ffffff;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-muted);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 16px 24px;
        }

        .table tbody td {
            border-bottom: 1px solid var(--border-color);
            padding: 20px 24px;
            vertical-align: middle;
            color: var(--text-main);
            font-size: 14px;
            font-weight: 500;
        }

        .status-pill {
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: #dcfce7;
            color: var(--success);
            border: 1px solid #bbf7d0;
        }

        .btn-chat {
            background: var(--primary) !important;
            color: #fff !important;
            border-radius: 8px !important;
            padding: 6px 12px !important;
            font-weight: 600 !important;
            transition: all 0.2s ease;
            text-decoration: none !important;
        }

        .btn-chat:hover {
            background: var(--primary-hover) !important;
            transform: translateY(-1px);
        }

        @media (max-width: 991px) {
            .main-content { 
                margin-left: 0 !important; 
                padding: 20px !important; 
                padding-top: 85px !important; 
            }
            .page-header {
                flex-direction: column !important;
                align-items: stretch !important;
                gap: 15px;
            }
            .btn-primary {
                width: 100% !important;
                text-align: center;
            }
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="guest-list" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <h1>Guest Manifest (Automated List)</h1>
            <button class="btn btn-primary">
                <i class="fa fa-download"></i> Download Export (CSV/PDF)
            </button>
        </div>

        <div class="manifest-card">
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Traveler Name</th>
                            <th>Phone</th>
                            <th>Trip / Batch</th>
                            <th>Emergency Contact</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="https://ui-avatars.com/api/?name=${booking.customerName}&background=random"
                                            style="width:30px; height:30px; border-radius:50%;">
                                        <span style="font-weight: 600;">${booking.customerName}</span>
                                    </div>
                                </td>
                                <td style="color: var(--text-muted);">${booking.customerPhone}</td>
                                <td style="font-weight: 700;">
                                    ${booking.trip.title} <br>
                                    <small class="text-muted" style="font-weight: 500;">Batch: 24 May</small>
                                </td>
                                <td style="color: var(--text-muted);">Not Provided</td>
                                <td>
                                    <span class="status-pill">CONFIRMED</span>
                                </td>
                                <td>
                                    <a href="<c:url value='/vendor/booking/${booking.id}/chat'/>" class="btn btn-chat">
                                        <i class="fa fa-comments"></i> Chat
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookings}">
                            <tr>
                                <td colspan="6" style="text-align: center; color: var(--text-muted); padding: 60px;">
                                    <i class="fa fa-users" style="font-size: 48px; color: var(--border-color); display: block; margin-bottom: 20px;"></i>
                                    No confirmed guests found for upcoming trips.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>