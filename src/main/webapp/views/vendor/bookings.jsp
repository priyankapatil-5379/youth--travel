<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Manage Bookings | Youth Travel</title>
            <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
            <style>
                body.yt-dark {
                    background: #0b0f18;
                    color: #fff;
                    font-family: 'Dosis', sans-serif;
                }

                .btn-action {
                    width: 32px;
                    height: 32px;
                    border-radius: 8px;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    transition: all 0.2s;
                    border: none;
                    margin-right: 5px;
                    background: #f04c26;
                    color: #fff;
                }

                .btn-action:hover {
                    background: #d93d1a;
                    transform: scale(1.1);
                }

                .booking-table-card {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 20px;
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
                    font-size: 13px;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    padding: 20px;
                }

                .table tbody td {
                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                    padding: 20px;
                    vertical-align: middle;
                }

                .status-badge {
                    padding: 6px 12px;
                    border-radius: 8px;
                    font-size: 12px;
                    font-weight: 700;
                    text-transform: uppercase;
                }

                .status-pending {
                    background: rgba(245, 158, 11, 0.15);
                    color: #f59e0b;
                }

                .status-confirmed {
                    background: rgba(16, 185, 129, 0.15);
                    color: #10b981;
                }

                .status-cancelled {
                    background: rgba(239, 68, 68, 0.15);
                    color: #ef4444;
                }

                .btn-action {
                    width: 32px;
                    height: 32px;
                    border-radius: 8px;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    transition: all 0.2s;
                    border: none;
                    margin-right: 5px;
                }

                .btn-approve {
                    background: rgba(16, 185, 129, 0.1);
                    color: #10b981;
                }

                .btn-reject {
                    background: rgba(239, 68, 68, 0.1);
                    color: #ef4444;
                }

                .btn-action:hover {
                    transform: scale(1.1);
                }
            </style>
        </head>

        <body class="yt-dark">
                <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="bookings" />
    </jsp:include>

    <div class="main-content">
                <div class="mobile-header">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" height="24">
                    <div class="menu-toggle" onclick="toggleSidebar()">
                        <i class="fa fa-bars"></i>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center mb-5">
                    <div>
                        <h1 style="font-weight: 800; font-size: 32px;">Manage Bookings</h1>
                        <p style="color: rgba(255,255,255,0.5);">Review and manage travel reservations.</p>
                    </div>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
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
                                        <div style="font-weight: 700;">${booking.customerName}</div>
                                        <div style="font-size: 12px; color: rgba(255,255,255,0.4);">
                                            ${booking.customerPhone}</div>
                                    </td>
                                    <td>
                                        <div style="font-weight: 600;">${booking.trip.title}</div>
                                        <div style="font-size: 12px; color: rgba(255,255,255,0.5);">
                                            ${booking.trip.destination}</div>
                                    </td>
                                    <td style="font-size: 14px; color: rgba(255,255,255,0.6);">
                                        ${booking.bookingDate}
                                    </td>
                                    <td style="font-weight: 700; color: #10b981;">
                                        ₹${booking.totalPrice}
                                    </td>
                                    <td>
                                        <span
                                            class="status-badge status-${booking.status.toLowerCase()}">${booking.status}</span>
                                    </td>
                                    <td>
                                        <a href="<c:url value='/vendor/booking/${booking.id}/chat'/>" class="btn-action" style="background: rgba(59, 130, 246, 0.1); color: #3b82f6;" title="Chat with Customer">
                                            <i class="fa fa-comment"></i>
                                        </a>
                                        <c:if test="${booking.status == 'Pending'}">
                                            <a href="<c:url value='/vendor/update-booking/${booking.id}/Confirmed'/>"
                                                class="btn-action btn-approve" title="Confirm Booking"><i
                                                    class="fa fa-check"></i></a>
                                            <a href="<c:url value='/vendor/update-booking/${booking.id}/Cancelled'/>"
                                                class="btn-action btn-reject" title="Cancel Booking"><i
                                                    class="fa fa-times"></i></a>
                                        </c:if>
                                        <c:if test="${booking.status == 'Confirmed'}">
                                            <a href="<c:url value='/vendor/update-booking/${booking.id}/Completed'/>"
                                                class="btn-action" style="background: rgba(139, 92, 246, 0.1); color: #8b5cf6;" title="Mark as Completed"><i
                                                    class="fa fa-flag-checkered"></i></a>
                                        </c:if>
                                        <c:if test="${booking.status != 'Pending' && booking.status != 'Confirmed'}">
                                            <span
                                                style="font-size: 12px; color: rgba(255,255,255,0.2); margin-left: 5px;">Processed</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty bookings}">
                                <tr>
                                    <td colspan="6"
                                        style="text-align: center; padding: 50px; color: rgba(255,255,255,0.3);">
                                        <i class="fa fa-calendar-o"
                                            style="font-size: 40px; display: block; margin-bottom: 20px;"></i>
                                        No bookings found yet.
                                    </td>
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