<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${trip.title} | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #f04c26;
            --text-muted: #7e8c9a;
            --transition: all 0.3s ease;
            --dark-bg: #0b0f18;
            --dark-card: #161c28;
            --border-color: rgba(255, 255, 255, 0.08);
        }

        body {
            font-family: 'Dosis', sans-serif;
            background-color: var(--dark-bg);
            color: rgba(255, 255, 255, 0.92);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* Hero Banner */
        .hero-banner {
            position: relative;
            width: 100%;
            height: 60vh;
            min-height: 400px;
            overflow: hidden;
        }
        
        .hero-bg {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.6);
        }
        
        .hero-content {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 60px 40px;
            background: linear-gradient(to top, rgba(11, 15, 24, 1) 0%, rgba(11, 15, 24, 0.8) 40%, rgba(11, 15, 24, 0) 100%);
        }
        
        .hero-title {
            font-size: 48px;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.5);
        }
        
        .hero-meta {
            display: flex;
            gap: 20px;
            font-size: 16px;
            font-weight: 600;
            color: rgba(255,255,255,0.8);
        }
        
        .hero-meta span { display: flex; align-items: center; gap: 8px; }

        /* Main Content Layout */
        .content-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 40px;
        }

        /* Left Column */
        .section-box {
            background: var(--dark-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 800;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #fff;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 15px;
        }
        
        .section-title i { color: var(--primary-blue); }

        .tag-cloud { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 15px; }
        .tag {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            color: rgba(255,255,255,0.8);
        }
        .tag i { color: var(--primary-blue); margin-right: 5px; }

        /* Itinerary Timeline */
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        .timeline::before {
            content: '';
            position: absolute;
            left: 0;
            top: 10px;
            bottom: 0;
            width: 2px;
            background: rgba(255,255,255,0.1);
        }
        .day-node {
            position: relative;
            margin-bottom: 30px;
        }
        .day-node::before {
            content: '';
            position: absolute;
            left: -35px;
            top: 5px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--primary-blue);
            border: 2px solid var(--dark-card);
            box-shadow: 0 0 0 2px rgba(240, 76, 38, 0.3);
        }
        .day-title { font-weight: 800; font-size: 18px; margin-bottom: 10px; }
        .day-desc { color: rgba(255,255,255,0.6); font-size: 15px; line-height: 1.6; }

        /* Right Column - Booking Widget */
        .booking-widget {
            background: var(--dark-card);
            border: 1px solid var(--primary-blue);
            border-radius: 20px;
            padding: 30px;
            position: sticky;
            top: 100px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.4);
        }

        .price-display {
            font-size: 36px;
            font-weight: 800;
            color: #fff;
            margin-bottom: 5px;
        }
        
        .price-display span {
            font-size: 14px;
            color: rgba(255,255,255,0.5);
            font-weight: 600;
        }

        .form-label {
            font-weight: 700;
            color: rgba(255,255,255,0.8);
            margin-bottom: 8px;
            display: block;
            margin-top: 20px;
        }

        .custom-select {
            width: 100%;
            background: rgba(0,0,0,0.3);
            border: 1px solid var(--border-color);
            color: #fff;
            padding: 12px 15px;
            border-radius: 12px;
            font-family: inherit;
            font-size: 15px;
            font-weight: 600;
            outline: none;
            cursor: pointer;
        }
        .custom-select option { background: var(--dark-card); color: #fff; }

        .btn-book {
            width: 100%;
            background: var(--primary-blue);
            color: #fff;
            border: none;
            padding: 15px;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 30px;
            transition: var(--transition);
            cursor: pointer;
        }
        
        .btn-book:hover {
            background: #d84422;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(240, 76, 38, 0.3);
        }

        .vendor-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }
        .vendor-avatar { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; }
        
        /* Nav */
        .top-nav {
            position: absolute;
            top: 20px;
            left: 40px;
            z-index: 10;
        }
        .btn-back {
            background: rgba(0,0,0,0.5);
            color: #fff;
            border: 1px solid rgba(255,255,255,0.2);
            padding: 10px 20px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 700;
            backdrop-filter: blur(10px);
            transition: var(--transition);
        }
        .btn-back:hover { background: rgba(255,255,255,0.1); color: #fff; }
    </style>
</head>
<body>

    <div class="top-nav">
        <a href="<c:url value='/user/dashboard'/>" class="btn-back"><i class="fa fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <!-- Hero Banner -->
    <div class="hero-banner">
        <img src="${not empty trip.imageUrl ? trip.imageUrl : 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1920&q=80'}" alt="Trip Banner" class="hero-bg">
        <div class="hero-content">
            <h1 class="hero-title">${trip.title}</h1>
            <div class="hero-meta">
                <span><i class="fa fa-map-marker" style="color: var(--primary-blue);"></i> ${trip.destination}</span>
                <span><i class="fa fa-clock-o" style="color: var(--primary-blue);"></i> ${trip.days} Days / ${trip.nights} Nights</span>
                <span><i class="fa fa-star" style="color: #f59e0b;"></i> ${trip.averageRating > 0 ? trip.averageRating : 'New'} Rating</span>
            </div>
        </div>
    </div>

    <!-- Main Layout -->
    <div class="content-container">
        
        <!-- Left Column: Details -->
        <div class="left-col">
            
            <div class="section-box">
                <h2 class="section-title"><i class="fa fa-info-circle"></i> About This Trip</h2>
                <p style="color: rgba(255,255,255,0.7); line-height: 1.8; font-size: 16px;">
                    ${trip.description != null ? trip.description : 'Join us for an unforgettable journey to ' += trip.destination += '. Experience the thrill of adventure and the beauty of nature.'}
                </p>
                <div class="tag-cloud">
                    <c:if test="${not empty trip.category}"><span class="tag"><i class="fa fa-tag"></i> ${trip.category}</span></c:if>
                    <c:if test="${not empty trip.difficulty}"><span class="tag"><i class="fa fa-free-code-camp"></i> ${trip.difficulty}</span></c:if>
                    <c:if test="${not empty trip.transportCategory}"><span class="tag"><i class="fa fa-bus"></i> ${trip.transportCategory}</span></c:if>
                    <c:if test="${not empty trip.stayCategory}"><span class="tag"><i class="fa fa-bed"></i> ${trip.stayCategory}</span></c:if>
                    <c:if test="${not empty trip.ageGroup}"><span class="tag"><i class="fa fa-users"></i> ${trip.ageGroup}</span></c:if>
                </div>
            </div>

            <!-- Pre-process Itinerary JSON in JS later if needed, for now just show a visual mock/raw -->
            <div class="section-box">
                <h2 class="section-title"><i class="fa fa-map"></i> Tour Itinerary</h2>
                <div class="timeline" id="itinerary-timeline">
                    <!-- We will render JS parsed itinerary here, but if empty show fallback -->
                    <c:if test="${empty trip.itinerary}">
                        <div class="day-node">
                            <div class="day-title">Day 1: Departure & Arrival</div>
                            <div class="day-desc">Assemble at the pickup point. Journey begins towards the destination. Reach your stay, check-in, and relax.</div>
                        </div>
                        <div class="day-node">
                            <div class="day-title">Day 2: Exploration & Adventure</div>
                            <div class="day-desc">Full day of sightseeing, activities, and creating memories. Evening campfire and group activities.</div>
                        </div>
                        <div class="day-node">
                            <div class="day-title">Day 3: Return Journey</div>
                            <div class="day-desc">Check out and begin the return journey. Drop-off at the original pickup points.</div>
                        </div>
                    </c:if>
                </div>
                <c:if test="${not empty trip.itinerary}">
                    <!-- Hidden div to hold json string for JS parsing -->
                    <div id="raw-itinerary" style="display:none;">${trip.itinerary}</div>
                </c:if>
            </div>

            <div class="section-box" style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                <div>
                    <h2 class="section-title"><i class="fa fa-check-circle" style="color: #28a745;"></i> What's Included</h2>
                    <div style="color: rgba(255,255,255,0.7); line-height: 1.8; font-size: 15px; white-space: pre-line;">
                        ${not empty trip.inclusions ? trip.inclusions : '✓ Transportation\n✓ Accommodation\n✓ Selected Meals\n✓ Guide/Trek Leader\n✓ First Aid'}
                    </div>
                </div>
                <div>
                    <h2 class="section-title"><i class="fa fa-times-circle" style="color: #dc3545;"></i> What's Excluded</h2>
                    <div style="color: rgba(255,255,255,0.7); line-height: 1.8; font-size: 15px; white-space: pre-line;">
                        ${not empty trip.exclusions ? trip.exclusions : '✗ Personal Expenses\n✗ Optional Activities\n✗ Anything not mentioned in inclusions'}
                    </div>
                </div>
            </div>

            <c:if test="${not empty trip.reviews}">
                <div class="section-box">
                    <h2 class="section-title"><i class="fa fa-star"></i> Traveler Reviews</h2>
                    <c:forEach var="review" items="${trip.reviews}">
                        <div style="border-bottom: 1px solid var(--border-color); padding-bottom: 15px; margin-bottom: 15px;">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div style="font-weight: 700; color: #fff;">${review.user.name}</div>
                                <div style="color: #f59e0b; font-size: 12px;">
                                    <c:forEach begin="1" end="${review.rating}"><i class="fa fa-star"></i></c:forEach>
                                </div>
                            </div>
                            <p style="color: rgba(255,255,255,0.6); font-size: 14px; margin-top: 5px; margin-bottom: 0;">"${review.reviewText}"</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            
        </div>

        <!-- Right Column: Booking Widget -->
        <div class="right-col">
            <div class="booking-widget">
                <div class="price-display">₹<fmt:formatNumber value="${trip.price}" pattern="#,##0"/> <span>/ person</span></div>
                
                <form action="<c:url value='/user/booking/create'/>" method="POST">
                    <input type="hidden" name="tripId" value="${trip.id}">
                    
                    <label class="form-label">Select Date & Schedule</label>
                    <select name="scheduleId" class="custom-select" required>
                        <option value="" disabled selected>Choose an available date...</option>
                        <c:forEach var="schedule" items="${schedules}">
                            <!-- Only show future dates logic could be here, but showing all for demo -->
                            <option value="${schedule.id}">
                                ${schedule.startDate} to ${schedule.endDate} 
                                (${schedule.availableSeats} seats left)
                            </option>
                        </c:forEach>
                        <c:if test="${empty schedules}">
                            <option value="" disabled>No upcoming schedules available</option>
                        </c:if>
                    </select>

                    <label class="form-label">Number of Travelers</label>
                    <select name="travelers" class="custom-select" required>
                        <option value="1">1 Traveler</option>
                        <option value="2">2 Travelers</option>
                        <option value="3">3 Travelers</option>
                        <option value="4">4 Travelers</option>
                        <option value="5">5+ Travelers</option>
                    </select>

                    <button type="submit" class="btn-book" ${empty schedules ? 'disabled style="background:gray;"' : ''}>
                        ${empty schedules ? 'Sold Out' : 'Book Now'}
                    </button>
                    
                    <div style="text-align: center; margin-top: 15px; font-size: 13px; color: var(--text-muted);">
                        <i class="fa fa-shield"></i> Secure Booking • Instant Confirmation
                    </div>
                </form>

                <!-- Vendor Profile snippet -->
                <div class="vendor-info">
                    <img src="${not empty trip.vendor.logoPath ? trip.vendor.logoPath : 'https://ui-avatars.com/api/?name=' += trip.vendor.businessName}" class="vendor-avatar">
                    <div>
                        <div style="font-weight: 700; font-size: 15px; color: #fff;">Operated by</div>
                        <div style="color: var(--primary-blue); font-weight: 800;">${trip.vendor.businessName}</div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- JS to parse Itinerary if it exists -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const rawEl = document.getElementById("raw-itinerary");
            if (rawEl) {
                try {
                    const data = JSON.parse(rawEl.innerText);
                    const timeline = document.getElementById("itinerary-timeline");
                    if (data && data.length > 0) {
                        timeline.innerHTML = '';
                        data.forEach((day, index) => {
                            const node = document.createElement("div");
                            node.className = "day-node";
                            node.innerHTML = `
                                <div class="day-title">Day \${index + 1}: \${day.title || 'Adventure'}</div>
                                <div class="day-desc">\${day.description || ''}</div>
                            `;
                            timeline.appendChild(node);
                        });
                    }
                } catch(e) {
                    console.error("Failed to parse itinerary JSON", e);
                }
            }
        });
    </script>
</body>
</html>
