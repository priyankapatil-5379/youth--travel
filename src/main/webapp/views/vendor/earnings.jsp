<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Earnings | Youth Travel</title>
            <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
            <style>
                body.yt-dark {
                    background: #0b0f18;
                    color: #fff;
                    font-family: 'Dosis', sans-serif;
                }

                .earning-card {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 20px;
                    padding: 30px;
                    text-align: center;
                }

                .earning-amount {
                    font-size: 48px;
                    font-weight: 800;
                    color: #10b981;
                    margin: 15px 0;
                }

                .transaction-card {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 20px;
                    margin-top: 30px;
                    overflow: hidden;
                }

                .table {
                    color: #fff;
                    margin-bottom: 0;
                }

                .table thead th {
                    background: rgba(255, 255, 255, 0.02);
                    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
                    color: rgba(255, 255, 255, 0.4);
                    padding: 20px;
                }

                .table tbody td {
                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                    padding: 20px;
                }
            </style>
        </head>

        <body class="yt-dark">
                <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="earnings" />
    </jsp:include>

    <div class="main-content">
                <div class="mobile-header">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" height="24">
                    <div class="menu-toggle" onclick="toggleSidebar()">
                        <i class="fa fa-bars"></i>
                    </div>
                </div>
                <h1 style="font-weight: 800; font-size: 32px; margin-bottom: 35px;">Financial Analytics</h1>

                <div class="row">
                    <div class="col-md-4">
                        <div class="earning-card">
                            <p style="color: rgba(255,255,255,0.5); font-weight: 600;">Total Confirmed Earnings</p>
                            <div class="earning-amount">₹${totalEarnings != null ? totalEarnings : '0.00'}</div>
                            <div style="font-size: 13px; color: #10b981;"><i class="fa fa-arrow-up"></i> All time
                                revenue</div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="earning-card" style="text-align: left;">
                            <h4 style="font-weight: 700; margin-bottom: 20px;">Payout Tracker</h4>
                            <div class="row">
                                <div class="col-md-4">
                                    <p style="font-size: 13px; color: rgba(255,255,255,0.4); margin-bottom: 5px;">Gross
                                        Revenue</p>
                                    <p style="font-weight: 700; font-size: 18px;">₹${totalEarnings}</p>
                                </div>
                                <div class="col-md-4">
                                    <p style="font-size: 13px; color: rgba(255,255,255,0.4); margin-bottom: 5px;">
                                        Platform Fee (10%)</p>
                                    <p style="font-weight: 700; font-size: 18px; color: #ef4444;">- ₹${totalEarnings *
                                        0.1}</p>
                                </div>
                                <div class="col-md-4">
                                    <p style="font-size: 13px; color: rgba(255,255,255,0.4); margin-bottom: 5px;">
                                        Withdrawable Amount</p>
                                    <p style="font-weight: 700; font-size: 18px; color: #10b981;">₹${totalEarnings *
                                        0.9}</p>
                                </div>
                            </div>
                            <button class="btn btn-primary mt-3 w-100"
                                style="background: #f04c26; border: none; border-radius: 12px; font-weight: 700; padding: 12px;">Request
                                Payout</button>
                        </div>
                    </div>
                </div>

                <div class="transaction-card">
                    <div
                        style="padding: 20px; background: rgba(255,255,255,0.02); border-bottom: 1px solid rgba(255,255,255,0.08);">
                        <h5 style="margin: 0; font-weight: 700;">Recent Transactions</h5>
                    </div>
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
                                        <td>${booking.bookingDate}</td>
                                        <td>${booking.trip.title}</td>
                                        <td>${booking.customerName}</td>
                                        <td style="color: #10b981; font-weight: 800;">₹${booking.totalPrice}</td>
                                        <td>
                                            <span style="padding: 4px 10px; border-radius: 8px; font-size: 11px; font-weight: 800; text-transform: uppercase; background: rgba(34,197,94,0.1); color: #22c55e; border: 1px solid rgba(34,197,94,0.2);">
                                                ${booking.status}
                                            </span>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            <c:if test="${empty bookings}">
                                <tr>
                                    <td colspan="5"
                                        style="text-align: center; color: rgba(255,255,255,0.2); padding: 40px;">No
                                        transaction history found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
            <script>
                function toggleSidebar() {
                    $('.sidebar').toggleClass('show');
                    $('.sidebar-overlay').toggleClass('show');
                }
            </script>
        </body>

        </html>