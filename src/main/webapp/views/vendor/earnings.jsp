<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Earnings Analytics | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --success: #10b981;
            --danger: #ef4444;
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
            .main-content { 
                margin-left: 0 !important; 
                padding: 20px !important; 
                padding-top: 85px !important; 
            }
        }

        .page-header {
            margin-bottom: 40px;
        }

        .page-header h1 {
            font-weight: 800;
            font-size: 32px;
            color: var(--text-main);
            margin: 0;
            letter-spacing: -1px;
        }

        .analytics-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 32px;
            height: 100%;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        .earning-label {
            color: var(--text-muted);
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .earning-amount {
            font-size: 42px;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 12px;
            letter-spacing: -1px;
        }

        .growth-indicator {
            font-size: 13px;
            font-weight: 700;
            color: var(--success);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .payout-tracker h4 {
            font-weight: 800;
            font-size: 18px;
            margin-bottom: 24px;
            letter-spacing: -0.5px;
        }

        .payout-stat {
            padding: 16px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }

        .payout-stat .label {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 4px;
            letter-spacing: 0.5px;
        }

        .payout-stat .value {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-main);
        }

        .btn-payout {
            background: var(--accent-red);
            color: #ffffff;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            padding: 14px;
            width: 100%;
            margin-top: 24px;
            transition: 0.2s;
            box-shadow: 0 4px 12px rgba(230, 57, 70, 0.2);
        }

        .btn-payout:hover {
            transform: translateY(-2px);
            background: #d62828;
            box-shadow: 0 8px 20px rgba(230, 57, 70, 0.3);
        }

        .transaction-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            margin-top: 40px;
            overflow: hidden;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        .card-header {
            padding: 20px 24px;
            background: #f8fafc;
            border-bottom: 1px solid var(--border-color);
        }

        .card-header h5 {
            margin: 0;
            font-weight: 800;
            font-size: 16px;
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
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="earnings" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <h1>Financial Analytics</h1>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="analytics-card">
                    <p class="earning-label">Total Confirmed Earnings</p>
                    <div class="earning-amount">₹${totalEarnings != null ? totalEarnings : '0.00'}</div>
                    <div class="growth-indicator">
                        <i class="fa fa-arrow-up"></i> 100% Verified Revenue
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="analytics-card payout-tracker">
                    <h4>Payout Tracker</h4>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="payout-stat">
                                <div class="label">Gross Revenue</div>
                                <div class="value">₹${totalEarnings}</div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="payout-stat">
                                <div class="label">Platform Fee (10%)</div>
                                <div class="value" style="color: var(--danger);">- ₹${totalEarnings * 0.1}</div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="payout-stat">
                                <div class="label">Withdrawable Amount</div>
                                <div class="value" style="color: var(--success);">₹${totalEarnings * 0.9}</div>
                            </div>
                        </div>
                    </div>
                    <button class="btn-payout">Request Instant Payout</button>
                </div>
            </div>
        </div>

        <div class="transaction-card">
            <div class="card-header">
                <h5>Recent Transactions</h5>
            </div>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Trip</th>
                            <th>Customer</th>
                            <th>Amount</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookings}" var="booking">
                            <c:if test="${booking.status == 'Confirmed' || booking.status == 'Completed'}">
                                <tr>
                                    <td style="color: var(--text-muted);">${booking.bookingDate}</td>
                                    <td style="font-weight: 700;">${booking.trip.title}</td>
                                    <td>${booking.customerName}</td>
                                    <td style="color: var(--primary); font-weight: 800;">₹${booking.totalPrice}</td>
                                    <td>
                                        <span class="status-pill">${booking.status}</span>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty bookings}">
                            <tr>
                                <td colspan="5" style="text-align: center; color: var(--text-muted); padding: 60px;">
                                    <i class="fa fa-history" style="font-size: 48px; color: var(--border-color); display: block; margin-bottom: 20px;"></i>
                                    No transaction history found yet.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
</body>
</html>