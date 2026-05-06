<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Bookings | Youth Travel</title>
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
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 40px;
            min-height: 100vh;
            transition: 0.3s;
        }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 20px; }
        }

        .page-header {
            margin-bottom: 40px;
        }

        .page-header h1 {
            font-weight: 800;
            font-size: 28px;
            color: var(--text-main);
            margin: 0;
            letter-spacing: -1px;
        }

        .page-header p {
            color: var(--text-muted);
            margin: 8px 0 0 0;
            font-size: 15px;
        }

        .booking-table-card {
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
            background: #f8fafc;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-muted);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 16px 20px;
        }

        .table tbody td {
            border-bottom: 1px solid var(--border-color);
            padding: 16px 20px;
            vertical-align: middle;
            color: var(--text-main);
            font-size: 14px;
        }

        .customer-info .name { font-weight: 700; color: var(--text-main); }
        .customer-info .phone { font-size: 12px; color: var(--text-muted); }

        .trip-info .title { font-weight: 600; color: var(--text-main); }
        .trip-info .dest { font-size: 12px; color: var(--text-muted); }

        .price-value { font-weight: 700; color: var(--success); }

        .status-badge {
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .status-pending { background: #fef3c7; color: var(--warning); }
        .status-confirmed { background: #dcfce7; color: var(--success); }
        .status-cancelled { background: #fee2e2; color: var(--danger); }
        .status-completed { background: #e0f2fe; color: var(--info); }

        .action-btns {
            display: flex;
            gap: 8px;
        }

        .btn-action {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f1f5f9;
            color: var(--text-muted);
            transition: 0.2s;
            text-decoration: none;
            border: none;
        }

        .btn-action:hover {
            background: var(--primary);
            color: #ffffff;
            transform: translateY(-2px);
        }

        .btn-approve:hover { background: var(--success); color: white; }
        .btn-reject:hover { background: var(--danger); color: white; }

        .alert-custom {
            background-color: #dcfce7;
            border: 1px solid #bbf7d0;
            color: #166534;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 30px;
            font-weight: 500;
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="bookings" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <h1>Manage Bookings</h1>
            <p>Review and manage your trip reservations and customer requests.</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert-custom">
                <i class="fa fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <div class="booking-table-card table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Trip Details</th>
                        <th>Date</th>
                        <th>Revenue</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${bookings}" var="booking">
                        <tr>
                            <td>
                                <div class="customer-info">
                                    <div class="name">${booking.customerName}</div>
                                    <div class="phone">${booking.customerPhone}</div>
                                </div>
                            </td>
                            <td>
                                <div class="trip-info">
                                    <div class="title">${booking.trip.title}</div>
                                    <div class="dest">${booking.trip.destination}</div>
                                </div>
                            </td>
                            <td style="color: var(--text-muted);">
                                ${booking.bookingDate}
                            </td>
                            <td>
                                <div class="price-value">₹${booking.totalPrice}</div>
                            </td>
                            <td>
                                <span class="status-badge status-${booking.status.toLowerCase()}">${booking.status}</span>
                            </td>
                            <td>
                                <div class="action-btns">
                                    <a href="<c:url value='/vendor/booking/${booking.id}/chat'/>" class="btn-action" title="Chat with Customer">
                                        <i class="fa fa-comment"></i>
                                    </a>
                                    <c:if test="${booking.status == 'Pending'}">
                                        <a href="<c:url value='/vendor/update-booking/${booking.id}/Confirmed'/>"
                                            class="btn-action btn-approve" title="Confirm Booking">
                                            <i class="fa fa-check"></i>
                                        </a>
                                        <a href="<c:url value='/vendor/update-booking/${booking.id}/Cancelled'/>"
                                            class="btn-action btn-reject" title="Cancel Booking">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${booking.status == 'Confirmed'}">
                                        <a href="<c:url value='/vendor/update-booking/${booking.id}/Completed'/>"
                                            class="btn-action" style="background: #e0f2fe; color: var(--info);" title="Mark as Completed">
                                            <i class="fa fa-flag-checkered"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${booking.status != 'Pending' && booking.status != 'Confirmed'}">
                                        <span style="font-size: 11px; color: var(--text-muted); font-weight: 600;">PROCESSED</span>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 80px 20px;">
                                <i class="fa fa-calendar-o" style="font-size: 48px; color: var(--border-color); display: block; margin-bottom: 20px;"></i>
                                <h3 style="color: var(--text-muted); font-weight: 700;">No Bookings Found</h3>
                                <p style="color: var(--text-muted);">When customers book your trips, they will appear here.</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
</body>
</html>