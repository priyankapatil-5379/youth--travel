<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Share Travel Wisdom | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        :root {
            --bg-deep: #0b0f18;
            --accent-orange: #ff9f43;
            --glass-card: rgba(20, 25, 35, 0.7);
            --glass-border: rgba(255, 255, 255, 0.08);
            --text-light: #f8fafc;
            --text-dim: #94a3b8;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-light);
            margin: 0; padding: 0;
            background: radial-gradient(circle at 50% 0%, #162121, #0b0f18);
            min-height: 100vh;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: 240px; padding: 120px 60px 60px; }

        .form-card {
            background: var(--glass-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 30px;
            padding: 50px;
            max-width: 900px;
            margin: 0 auto;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
        }

        .page-header { margin-bottom: 40px; }
        .page-title { font-size: 36px; font-weight: 900; color: #fff; margin-bottom: 10px; }
        .page-subtitle { color: var(--text-dim); font-size: 16px; }

        .form-label {
            font-weight: 700; color: var(--accent-orange);
            text-transform: uppercase; font-size: 11px;
            letter-spacing: 1px; margin-bottom: 12px; display: block;
        }

        .form-control, .form-select {
            background: rgba(255,255,255,0.03);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            color: #fff;
            padding: 15px 20px;
            font-size: 15px;
            transition: 0.3s;
        }
        .form-control:focus, .form-select:focus {
            background: rgba(255,255,255,0.06);
            border-color: var(--accent-orange);
            box-shadow: 0 0 15px rgba(255, 159, 67, 0.2);
            color: #fff;
        }

        .btn-submit {
            background: var(--accent-orange);
            border: none;
            padding: 18px 40px;
            border-radius: 15px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #fff;
            width: 100%;
            margin-top: 30px;
            transition: 0.3s;
            box-shadow: 0 10px 20px rgba(255, 159, 67, 0.3);
        }
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(255, 159, 67, 0.4);
        }

        .trip-brief {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 40px;
            padding: 20px;
            background: rgba(255,255,255,0.02);
            border-radius: 20px;
            border: 1px solid var(--glass-border);
        }
        .trip-img { width: 80px; height: 80px; border-radius: 15px; object-fit: cover; }
        .trip-info h4 { margin: 0; font-weight: 800; color: #fff; }
        .trip-info p { margin: 5px 0 0; color: var(--text-dim); font-size: 13px; }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 100px 20px 40px; }
            .form-card { padding: 30px; }
        }
    </style>
</head>
<body>

    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="bookings" />
        </jsp:include>

        <main class="main-content">
            <div class="form-card">
                <div class="page-header">
                    <h1 class="page-title">Archive Your Wisdom</h1>
                    <p class="page-subtitle">Help fellow travelers by sharing your unique insights and experiences from your recent journey.</p>
                </div>

                <div class="trip-brief">
                    <img src="${not empty booking.trip.mediaUrls ? booking.trip.mediaUrls.split(',')[0] : 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800'}" class="trip-img">
                    <div class="trip-info">
                        <h4>${booking.trip.title}</h4>
                        <p><i class="fa fa-calendar-check-o"></i> Completed on ${booking.selectedDate}</p>
                    </div>
                </div>

                <form id="adviceForm">
                    <input type="hidden" id="adviceBookingId" value="${booking.id}">
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Catchy Title</label>
                            <input type="text" class="form-control" id="adviceTitle" value="My journey to ${booking.trip.destination}" required>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Best Suited For</label>
                            <select class="form-select" id="adviceCategory">
                                <option value="Solo Travel" ${booking.trip.category eq 'Solo Travel' ? 'selected' : ''}>Solo Travel</option>
                                <option value="Adventure Trip" ${booking.trip.category eq 'Adventure Trip' ? 'selected' : ''}>Adventure Trip</option>
                                <option value="Budget Travel" ${booking.trip.category eq 'Budget Travel' ? 'selected' : ''}>Budget Travel</option>
                                <option value="Luxury Escape" ${booking.trip.category eq 'Luxury Escape' ? 'selected' : ''}>Luxury Escape</option>
                                <option value="Food & Culture" ${booking.trip.category eq 'Food & Culture' ? 'selected' : ''}>Food & Culture</option>
                                <option value="Road Trip" ${booking.trip.category eq 'Road Trip' ? 'selected' : ''}>Road Trip</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Your Story & Key Insights</label>
                        <textarea class="form-control" id="adviceContent" rows="5" placeholder="What made this trip special? Any hidden gems you found?" required></textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label class="form-label">When to Visit</label>
                            <textarea class="form-control" id="adviceBestTime" rows="2" placeholder="Specific months or seasons..."></textarea>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label class="form-label">What to Pack</label>
                            <textarea class="form-control" id="advicePack" rows="2" placeholder="Essential gear or clothing..."></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Safety First</label>
                            <textarea class="form-control" id="adviceSafety" rows="2" placeholder="Tips for staying safe and healthy..."></textarea>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Money Saving Tips</label>
                            <textarea class="form-control" id="adviceBudget" rows="2" placeholder="How to manage expenses..."></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Stay & Food Advice</label>
                            <textarea class="form-control" id="adviceStayFood" rows="2" placeholder="Best places to sleep and eat..."></textarea>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Transport Tips</label>
                            <textarea class="form-control" id="adviceTransport" rows="2" placeholder="How to get around easily..."></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Network & Connectivity</label>
                            <textarea class="form-control" id="adviceNetwork" rows="2" placeholder="SIM cards, WiFi availability..."></textarea>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Local Rules & Etiquette</label>
                            <textarea class="form-control" id="adviceRules" rows="2" placeholder="Do's and don'ts..."></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Eco-Friendly Tips</label>
                            <textarea class="form-control" id="adviceEco" rows="2" placeholder="How to travel sustainably..."></textarea>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Secret Pro Tips</label>
                            <textarea class="form-control" id="advicePro" rows="2" placeholder="Hidden gems and hacks..."></textarea>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">Publish Wisdom</button>
                </form>
            </div>
        </main>
    </div>

    <script>
        document.getElementById('adviceForm').onsubmit = (e) => {
            e.preventDefault();
            const bookingId = '${booking.id}';
            if (!bookingId || bookingId === '') {
                alert('Error: Booking ID is missing. Please refresh the page.');
                return;
            }

            const payload = {
                title: document.getElementById('adviceTitle').value,
                categories: document.getElementById('adviceCategory').value,
                content: document.getElementById('adviceContent').value,
                bestTimeToVisit: document.getElementById('adviceBestTime').value,
                whatToPack: document.getElementById('advicePack').value,
                safetyTips: document.getElementById('adviceSafety').value,
                budgetTips: document.getElementById('adviceBudget').value,
                stayFoodAdvice: document.getElementById('adviceStayFood').value,
                transportTips: document.getElementById('adviceTransport').value,
                connectivityTips: document.getElementById('adviceNetwork').value,
                localRules: document.getElementById('adviceRules').value,
                environmentalTips: document.getElementById('adviceEco').value,
                proTips: document.getElementById('advicePro').value
            };

            console.log('Submitting wisdom to current URL...');

            fetch(window.location.href, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            }).then(res => {
                if (res.ok) {
                    alert('Successfully Submitted! Your wisdom is now part of your profile.');
                    window.location.href = '/user/profile?tab=advice';
                } else {
                    res.text().then(text => {
                        alert('Submission failed: ' + text);
                    });
                }
            });
        };
    </script>

</body>
</html>
