<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful | Youth Travel</title>
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
        .success-container { max-width: 500px; margin: 100px auto; padding: 20px; text-align: center; }

        .card { background: var(--card-bg); border-radius: 24px; padding: 50px 30px; border: 1px solid var(--border); box-shadow: 0 20px 60px rgba(0,0,0,0.5); }
        
        .check-circle { width: 100px; height: 100px; background: #22c55e; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 50px; color: #fff; margin: 0 auto 30px; box-shadow: 0 10px 20px rgba(34, 197, 94, 0.3); }

        .title { font-size: 24px; font-weight: 800; margin-bottom: 15px; }
        .subtitle { font-size: 14px; color: var(--text-muted); margin-bottom: 40px; line-height: 1.6; }

        .info-box { background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 16px; padding: 20px; margin-bottom: 30px; }
        .info-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .info-row:last-child { margin-bottom: 0; }
        .info-label { font-size: 13px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; }
        .info-value { font-size: 15px; font-weight: 800; color: #fff; }

        .btn-view { width: 100%; background: var(--accent-red); color: #fff; border: none; padding: 18px; border-radius: 16px; font-weight: 800; font-size: 16px; cursor: pointer; transition: 0.3s; text-transform: uppercase; margin-bottom: 20px; }
        .btn-view:hover { transform: translateY(-3px); box-shadow: 0 10px 25px rgba(225, 29, 72, 0.4); }

        .back-home { color: var(--text-muted); text-decoration: none; font-size: 13px; font-weight: 700; }
    </style>
</head>
<body>

    <div class="success-container">
        <div class="card">
            <div class="check-circle">
                <i class="fa fa-check"></i>
            </div>

            <h1 class="title">Payment Successful!</h1>
            <p class="subtitle">Your trip has been booked successfully. Get ready for an amazing adventure!</p>

            <div class="info-box">
                <div class="info-row">
                    <span class="info-label">Booking ID</span>
                    <span class="info-value" id="bookingId">${bookingId} <i class="fa fa-copy" style="margin-left: 10px; cursor: pointer;"></i></span>
                </div>
                <div class="info-row" style="margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--border);">
                    <span class="info-label" style="font-size: 16px; color: #fff;">Total Paid</span>
                    <span class="info-value" style="font-size: 20px; color: #fff;">₹${amount}</span>
                </div>
            </div>

            <button class="btn-view" onclick="window.location.href='/user/my-bookings'">VIEW MY BOOKINGS</button>
            <a href="/user/dashboard" class="back-home">Back to Home</a>
        </div>
    </div>

</body>
</html>
