<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-dark: #020617;
            --card-bg: #0f172a;
            --accent-red: #e11d48;
            --text-light: #f8fafc;
            --text-muted: #94a3b8;
            --border: rgba(255, 255, 255, 0.1);
        }

        body { font-family: 'Outfit', sans-serif; background-color: var(--bg-dark); color: var(--text-light); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 40px; }

        .back-link { color: var(--text-muted); text-decoration: none; font-size: 14px; font-weight: 600; display: flex; align-items: center; gap: 8px; margin-bottom: 25px; }

        .page-title { font-size: 28px; font-weight: 800; margin-bottom: 30px; }

        .tabs-container { display: flex; gap: 40px; border-bottom: 1px solid var(--border); margin-bottom: 40px; }
        .tab-item { padding-bottom: 15px; font-weight: 700; font-size: 15px; color: var(--text-muted); cursor: pointer; position: relative; }
        .tab-item.active { color: #fff; }
        .tab-item.active::after { content: ''; position: absolute; bottom: -1px; left: 0; right: 0; height: 3px; background: var(--accent-red); }

        .booking-card { background: var(--card-bg); border-radius: 20px; overflow: hidden; border: 1px solid var(--border); margin-bottom: 30px; display: flex; max-width: 900px; }
        .card-image { width: 300px; position: relative; }
        .card-image img { width: 100%; height: 100%; object-fit: cover; }
        .upcoming-badge { position: absolute; top: 15px; right: 15px; background: var(--accent-red); padding: 4px 10px; border-radius: 4px; font-size: 10px; font-weight: 800; letter-spacing: 0.5px; }

        .card-body { padding: 30px; flex-grow: 1; display: flex; flex-direction: column; }
        .card-title { font-size: 20px; font-weight: 800; margin-bottom: 15px; }
        .card-info { display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px; }
        .info-item { display: flex; align-items: center; gap: 8px; font-size: 13px; font-weight: 600; color: var(--text-muted); }
        .info-item i { color: var(--accent-red); }

        .card-footer { margin-top: auto; display: flex; justify-content: space-between; align-items: center; padding-top: 20px; border-top: 1px solid var(--border); }
        .card-price { font-size: 20px; font-weight: 800; }
        .btn-view { background: var(--accent-red); color: #fff; border: none; padding: 10px 25px; border-radius: 10px; font-weight: 800; font-size: 13px; cursor: pointer; text-transform: uppercase; }

        @media (max-width: 768px) { .booking-card { flex-direction: column; } .card-image { width: 100%; height: 200px; } }
    </style>
</head>
<body>

    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="bookings" />
        </jsp:include>

        <main class="main-content">
            <a href="/user/dashboard" class="back-link"><i class="fa fa-arrow-left"></i> Back</a>
            <h1 class="page-title">My Bookings</h1>

            <div class="tabs-container">
                <div class="tab-item active">Upcoming</div>
                <div class="tab-item">Completed</div>
            </div>

            <c:choose>
                <c:when test="${not empty bookings}">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card">
                            <div class="card-image">
                                <img src="${not empty booking.trip.mediaUrls ? booking.trip.mediaUrls.split(',')[0] : 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800'}" alt="Trip">
                                <span class="upcoming-badge">${booking.status.toUpperCase()}</span>
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">${booking.trip.title}</h2>
                                <div class="card-info">
                                    <div class="info-item"><i class="fa fa-map-marker"></i> ${booking.trip.destination}</div>
                                    <div class="info-item"><i class="fa fa-calendar"></i> ${booking.selectedDate}</div>
                                    <div class="info-item"><i class="fa fa-users"></i> ${booking.numberOfTravelers} Adults</div>
                                </div>
                                <div style="font-size: 11px; color: var(--text-muted); font-weight: 600;">Booking ID: TRIP-2026-${booking.id}</div>
                                <div class="card-footer">
                                    <div class="card-price">₹${booking.totalPrice}</div>
                                    <a href="/user/package/${booking.trip.id}" class="btn-view">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 100px 0;">
                        <i class="fa fa-calendar-times-o" style="font-size: 60px; color: var(--border); margin-bottom: 20px;"></i>
                        <h3 style="font-weight: 700;">No Bookings Found</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>

</body>
</html>
