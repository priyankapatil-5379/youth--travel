<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>Guest Manifest | Youth Travel</title>
            <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
            <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
            <style>
                body.yt-dark {
                    background: #0b0f18;
                    color: #fff;
                    font-family: 'Dosis', sans-serif;
                }

                .manifest-table {
                    background: rgba(255, 255, 255, 0.03);
                    border-radius: 20px;
                    overflow: hidden;
                    border: 1px solid rgba(255, 255, 255, 0.08);
                }

                .manifest-table th {
                    background: rgba(255, 255, 255, 0.05);
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 13px;
                    text-transform: uppercase;
                    padding: 15px 20px;
                    border: none;
                }

                .manifest-table td {
                    padding: 15px 20px;
                    vertical-align: middle;
                    border-color: rgba(255, 255, 255, 0.05);
                }
            </style>
        </head>

        <body class="yt-dark">
                <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="guest-list" />
    </jsp:include>

    <div class="main-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 style="font-weight: 800; margin: 0;">Guest Manifest (Automated List)</h2>
                    <button class="btn btn-primary"
                        style="background: #f04c26; border: none; border-radius: 10px; padding: 10px 20px; font-weight: 700;">
                        <i class="fa fa-download"></i> Download Export (CSV/PDF)
                    </button>
                </div>

                <div class="manifest-table">
                    <table class="table table-dark mb-0">
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
                                            <span>${booking.customerName}</span>
                                        </div>
                                    </td>
                                    <td>${booking.customerPhone}</td>
                                    <td>${booking.trip.title} <br><small class="text-muted">Batch: 24 May</small></td>
                                    <td>Not Provided</td>
                                    <td>
                                        <span class="badge"
                                            style="background: rgba(16, 185, 129, 0.1); color: #10b981;">CONFIRMED</span>
                                    </td>
                                    <td>
                                        <a href="<c:url value='/vendor/booking/${booking.id}/chat'/>" class="btn btn-sm" style="background: var(--primary-blue); color: #fff; border-radius: 8px;">
                                            <i class="fa fa-comments"></i> Chat
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty bookings}">
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">No confirmed guests found for
                                        upcoming trips.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </body>

        </html>