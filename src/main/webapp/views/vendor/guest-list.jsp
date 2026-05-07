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
            <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
            <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
            <style>
                body.yt-dark {
                    background: transparent;
                    color: #fff;
                    font-family: 'Dosis', sans-serif;
                }

                .manifest-table {
                    background: rgba(0,0,0,0.4);
                    backdrop-filter: blur(15px);
                    border-radius: 24px;
                    overflow: hidden;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    box-shadow: 0 8px 32px 0 rgba(0,0,0,0.3);
                }

                .manifest-table th {
                    background: rgba(0,0,0,0.3);
                    color: #fff;
                    font-size: 13px;
                    font-weight: 800;
                    text-transform: uppercase;
                    letter-spacing: 1.5px;
                    padding: 20px;
                    border: none;
                    text-shadow: 0 2px 4px rgba(0,0,0,0.8);
                }

                .manifest-table td {
                    padding: 20px;
                    vertical-align: middle;
                    border-color: rgba(255, 255, 255, 0.05);
                    color: #fff;
                    font-weight: 600;
                    text-shadow: 0 1px 3px rgba(0,0,0,0.5);
                }
                @media (max-width: 991px) {
                    .main-content { 
                        margin-left: 0 !important; 
                        padding: 20px !important; 
                        padding-top: 85px !important; 
                    }
                    .d-flex.justify-content-between.align-items-center.mb-5 {
                        flex-direction: column !important;
                        align-items: stretch !important;
                        gap: 15px;
                    }
                    h2 {
                        font-size: 24px !important;
                    }
                    .btn-primary {
                        width: 100% !important;
                        text-align: center;
                    }
                }
            </style>
        </head>

        <body class="yt-dark premium-theme">
        <div class="sun-rays-container">
            <div class="ray ray-1"></div>
            <div class="ray ray-2"></div>
            <div class="ray ray-3"></div>
            <div class="ray ray-4"></div>
        </div>
                <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="guest-list" />
    </jsp:include>

    <div class="main-content">
                <div class="d-flex justify-content-between align-items-center mb-5">
                    <h2 style="font-weight: 800; margin: 0; font-size: 36px; color: #fff; text-shadow: 0 4px 15px rgba(0,0,0,0.8);">Guest Manifest (Automated List)</h2>
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