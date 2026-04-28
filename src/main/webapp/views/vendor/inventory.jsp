<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>Inventory Management | Youth Travel</title>
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

                .inventory-card {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 20px;
                    padding: 25px;
                    margin-bottom: 25px;
                }

                .status-badge {
                    padding: 5px 12px;
                    border-radius: 20px;
                    font-size: 12px;
                    font-weight: 700;
                }

                .status-active {
                    background: rgba(16, 185, 129, 0.1);
                    color: #10b981;
                }

                .status-full {
                    background: rgba(239, 68, 68, 0.1);
                    color: #ef4444;
                }

                .btn-action {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    color: #fff;
                    border-radius: 8px;
                    padding: 6px 12px;
                    font-size: 13px;
                    transition: 0.2s;
                }

                .btn-action:hover {
                    background: #f04c26;
                    border-color: #f04c26;
                }
            </style>
        </head>

        <body class="yt-dark">
                <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="inventory" />
    </jsp:include>

    <div class="main-content">
                <h2 style="font-weight: 800; margin-bottom: 30px;">Live Slot & Inventory Management</h2>

                <c:forEach var="trip" items="${trips}">
                    <c:set var="occupied" value="${occupiedMap[trip.id] != null ? occupiedMap[trip.id] : 0}" />
                    <c:set var="total"
                        value="${trip.maxTravelers != null && trip.maxTravelers > 0 ? trip.maxTravelers : 20}" />
                    <c:set var="seatsLeft" value="${total - occupied}" />
                    <c:set var="occupancy" value="${(occupied * 100) / total}" />

                    <div class="inventory-card">
                        <div class="row align-items-center">
                            <div class="col-md-4">
                                <h4 style="margin: 0; font-weight: 700;">${trip.title}</h4>
                                <p style="color: rgba(255,255,255,0.5); font-size: 14px; margin-top: 5px;">
                                    ${trip.destination}</p>
                            </div>
                            <div class="col-md-3">
                                <div style="font-size: 13px; color: rgba(255,255,255,0.5);">Total Occupancy</div>
                                <div style="font-size: 20px; font-weight: 800;">
                                    <fmt:formatNumber value="${occupancy}" maxFractionDigits="0" />%
                                </div>
                            </div>
                            <div class="col-md-3 text-center">
                                <c:choose>
                                    <c:when test="${seatsLeft <= 0}">
                                        <span class="status-badge status-full">FULLY BOOKED</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-active">ACTIVE SELLING</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-md-2 text-end">
                                <button class="btn-action">Adjust Slots</button>
                            </div>
                        </div>

                        <hr style="border-color: rgba(255,255,255,0.05); margin: 20px 0;">

                        <div class="row">
                            <div class="col-md-12">
                                <p class="small text-muted">Availability Overview:</p>
                                <div class="d-flex gap-3">
                                    <div
                                        style="background: rgba(255,255,255,0.05); padding: 10px 15px; border-radius: 12px; min-width: 120px;">
                                        <div class="small">Confirmed Bookings</div>
                                        <div class="fw-bold">${occupied}</div>
                                    </div>
                                    <div
                                        style="background: rgba(255,255,255,0.05); padding: 10px 15px; border-radius: 12px; min-width: 120px;">
                                        <div class="small">Remaining Slots</div>
                                        <div class="fw-bold <c:if test='${seatsLeft <= 5}'>text-danger</c:if>">
                                            ${seatsLeft > 0 ? seatsLeft : '0'} ${seatsLeft > 0 ? 'Seats Left' : 'SOLD
                                            OUT'}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </body>

        </html>