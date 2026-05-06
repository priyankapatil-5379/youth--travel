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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        :root {
            --bg-deep: #000a12;
            --accent-red: #e63946;
            --glass-card: rgba(20, 25, 35, 0.6);
            --glass-border: rgba(255, 255, 255, 0.08);
            --text-light: #f8fafc;
            --text-dim: #94a3b8;
            --accent-glow: rgba(230, 57, 70, 0.5);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-light);
            margin: 0; padding: 0;
            overflow-x: hidden;
        }

        /* Immersive Background System */
        .ocean-bg { position: fixed; inset: 0; background: radial-gradient(circle at 50% 0%, #001f3f, #000a12); z-index: -2; }
        .sun-rays { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; pointer-events: none; opacity: 0.3; }
        .ray { position: absolute; top: -20%; width: 100px; height: 150%; background: linear-gradient(180deg, rgba(255,255,255,0.1) 0%, transparent 80%); filter: blur(50px); transform-origin: top center; animation: ray-swing 10s ease-in-out infinite alternate; }
        @keyframes ray-swing { 0% { transform: rotate(-8deg) scaleX(1); opacity: 0.3; } 100% { transform: rotate(8deg) scaleX(0.8); opacity: 0.6; } }

        .wrapper { display: flex; min-height: 100vh; position: relative; z-index: 1; }

        .header { 
            position: fixed; top: 0; left: 0; right: 0; height: 75px; 
            background: rgba(0, 0, 0, 0.4); 
            backdrop-filter: blur(15px); 
            -webkit-backdrop-filter: blur(15px);
            display: flex; align-items: center; justify-content: space-between; 
            padding: 0 40px; z-index: 1000; 
            border-bottom: 1px solid rgba(255, 255, 255, 0.08); 
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
        }

        .main-content { flex: 1; margin-left: 240px; padding: 40px 40px 60px; }

        .page-title { font-size: 42px; font-weight: 950; margin-bottom: 40px; text-transform: uppercase; letter-spacing: -1px; text-shadow: 0 10px 30px rgba(0,0,0,0.5); }

        .tabs-container { display: flex; gap: 40px; border-bottom: 1px solid var(--glass-border); margin-bottom: 40px; }
        .tab-item { padding-bottom: 15px; font-weight: 900; font-size: 14px; color: var(--text-dim); cursor: pointer; position: relative; text-transform: uppercase; letter-spacing: 2px; }
        .tab-item.active { color: #fff; }
        .tab-item.active::after { content: ''; position: absolute; bottom: -1px; left: 0; right: 0; height: 3px; background: var(--accent-red); box-shadow: 0 0 15px var(--accent-red); }

        .booking-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 30px; }
        .booking-card { 
            background: var(--glass-card); backdrop-filter: blur(20px); border: 1px solid var(--glass-border); 
            border-radius: 24px; overflow: hidden; transition: 0.4s; position: relative;
        }
        .booking-card:hover { transform: translateY(-10px); border-color: var(--accent-red); box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
        
        .card-image { width: 100%; aspect-ratio: 16 / 10; position: relative; overflow: hidden; }
        .card-image img { width: 100%; height: 100%; object-fit: cover; transition: 0.5s; }
        .booking-card:hover .card-image img { transform: scale(1.1); }
        
        .status-badge { 
            position: absolute; top: 20px; right: 20px; 
            background: var(--accent-red); color: #fff; 
            padding: 6px 15px; border-radius: 100px; 
            font-size: 10px; font-weight: 950; 
            text-transform: uppercase; letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(230, 57, 70, 0.4);
            z-index: 10;
        }

        .card-body { padding: 25px; }
        .card-title { font-size: 20px; font-weight: 900; margin-bottom: 15px; color: #fff; height: 52px; overflow: hidden; }
        .info-item { display: flex; align-items: center; gap: 10px; font-size: 13px; font-weight: 700; color: var(--text-dim); margin-bottom: 10px; }
        .info-item i { color: var(--accent-red); width: 15px; }

        .card-footer { margin-top: 20px; display: flex; justify-content: space-between; align-items: center; padding-top: 20px; border-top: 1px solid var(--glass-border); }
        .card-price { font-size: 24px; font-weight: 950; color: #fff; }
        .btn-view { 
            display: inline-block;
            background: rgba(255,255,255,0.05); 
            color: #fff; 
            border: 1px solid rgba(255,255,255,0.1); 
            padding: 12px 24px; 
            border-radius: 12px; 
            font-weight: 800; 
            font-size: 13px; 
            text-decoration: none; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            transition: 0.3s;
            cursor: pointer; 
            position: relative; 
            z-index: 20;
            text-align: center;
        }
        .booking-card:hover .btn-view { background: var(--accent-red); border-color: transparent; box-shadow: 0 5px 15px rgba(230, 57, 70, 0.3); }
        /* Prevent hover override for special buttons */
        .btn-view[style*="background: rgba(0, 122, 255"] { background: rgba(0, 122, 255, 0.2) !important; }

        @media (max-width: 991px) { .main-content { margin-left: 0; padding: 100px 20px 40px; } }
    </style>
</head>
<body>

    <div class="ocean-bg"></div>
    <div class="sun-rays">
        <div class="ray" style="left: 10%; animation-delay: 0s;"></div>
        <div class="ray" style="left: 35%; animation-delay: 2s;"></div>
        <div class="ray" style="left: 65%; animation-delay: 1s;"></div>
        <div class="ray" style="left: 85%; animation-delay: 3s;"></div>
    </div>


    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="bookings" />
        </jsp:include>

        <main class="main-content">
            <h1 class="page-title">My Journeys</h1>

            <div class="tabs-container">
                <div class="tab-item active" onclick="filterBookings('upcoming', this)">Upcoming</div>
                <div class="tab-item" onclick="filterBookings('pending', this)">Pending</div>
                <div class="tab-item" onclick="filterBookings('completed', this)">Completed</div>
            </div>

            <c:choose>
                <c:when test="${not empty bookings}">
                    <div class="booking-grid" id="bookingGrid">
                        <c:forEach var="booking" items="${bookings}">
                            <div class="booking-card" data-date="${booking.selectedDate}" data-status="${booking.status}">
                                <div class="card-image">
                                    <img src="${not empty booking.trip.mediaUrls ? booking.trip.mediaUrls.split(',')[0] : 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800'}" alt="Trip">
                                    <span class="status-badge">${booking.status}</span>
                                </div>
                                <div class="card-body">
                                    <h2 class="card-title">${booking.trip.title}</h2>
                                    <div class="info-item"><i class="fa fa-map-marker"></i> ${booking.trip.destination}</div>
                                    <div class="info-item"><i class="fa fa-calendar"></i> ${booking.selectedDate}</div>
                                    <div class="info-item"><i class="fa fa-users"></i> ${booking.numberOfTravelers} Travelers</div>
                                    
                                    <div class="card-footer" style="display: flex; gap: 10px;">
                                        <div class="card-price">₹${booking.totalPrice}</div>
                                        <c:choose>
                                            <c:when test="${booking.reviewed}">
                                                 <button onclick="event.stopPropagation(); openReviewModal('${booking.id}', true)" class="btn-view" style="flex: 1; background: rgba(34, 197, 94, 0.1); border-color: rgba(34, 197, 94, 0.2); color: #22c55e;">Reflection</button>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="btn-group-reflection" style="display: flex; gap: 8px; flex: 1; justify-content: flex-end; position: relative; z-index: 25;">
                                                    <a href="/user/package/${booking.trip.id}" class="btn-view" data-booking-id="${booking.id}" data-trip-title="${booking.trip.title}">Details</a>
                                                    <script>
                                                        {
                                                            const tripDate = new Date('${booking.selectedDate}');
                                                            tripDate.setHours(0,0,0,0);
                                                            const today = new Date();
                                                            today.setHours(0,0,0,0);
                                                            const status = '${booking.status}'.toLowerCase();
                                                            
                                                            if (tripDate < today || status === 'completed') {
                                                                const parent = document.currentScript.parentElement;
                                                                const detailsBtn = parent.querySelector('.btn-view');
                                                                if (detailsBtn) detailsBtn.style.display = "none";
                                                                
                                                                parent.innerHTML = `
                                                                    <button type="button" onclick="event.stopPropagation(); openReviewModal('${booking.id}', false)" class="btn-view" style="background: var(--accent-red); padding: 8px 12px; font-size: 11px; cursor: pointer; position: relative; z-index: 30;">Review</button>
                                                                    <a href="/user/booking/${booking.id}/advice" class="btn-view" style="background: rgba(0, 122, 255, 0.2); border-color: rgba(0, 122, 255, 0.3); color: #007aff; padding: 8px 12px; font-size: 11px; cursor: pointer; position: relative; z-index: 30; text-decoration: none; display: inline-block;">Advice</a>
                                                                `;
                                                            }
                                                        }
                                                    </script>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div id="noBookingsMsg" style="display: none; text-align: center; padding: 100px 0; background: rgba(255,255,255,0.03); border-radius: 30px; border: 1px dotted rgba(255,255,255,0.1);">
                        <i class="fa fa-calendar-times-o" style="font-size: 60px; color: rgba(255,255,255,0.05); margin-bottom: 20px;"></i>
                        <h3 style="font-weight: 700; color: rgba(255,255,255,0.3);">No Journeys Found</h3>
                    </div>
                    <div id="noBookingsMsg" style="display: none; text-align: center; padding: 100px 0; background: rgba(255,255,255,0.03); border-radius: 30px; border: 1px dotted rgba(255,255,255,0.1);">
                        <i class="fa fa-calendar-times-o" style="font-size: 60px; color: rgba(255,255,255,0.05); margin-bottom: 20px;"></i>
                        <h3 style="font-weight: 700; color: rgba(255,255,255,0.3);">No Journeys Found</h3>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 100px 0; background: rgba(255,255,255,0.03); border-radius: 30px; border: 1px dotted rgba(255,255,255,0.1);">
                        <i class="fa fa-calendar-times-o" style="font-size: 60px; color: rgba(255,255,255,0.05); margin-bottom: 20px;"></i>
                        <h3 style="font-weight: 700; color: rgba(255,255,255,0.3);">No Bookings Found</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>

    <!-- Review Modal -->
    <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="background: #0b0f18; border: 1px solid var(--glass-border); border-radius: 30px; box-shadow: 0 25px 50px rgba(0,0,0,0.8); color: #fff; overflow: hidden;">
                <div class="modal-header" style="border-bottom: 1px solid var(--glass-border); padding: 25px; background: rgba(255,255,255,0.02);">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: #fff; opacity: 1; font-size: 28px; margin-top: -5px;"><span aria-hidden="true">&times;</span></button>
                    <h5 class="modal-title" style="font-weight: 900; text-transform: uppercase; letter-spacing: 2px; color: var(--accent-red);" id="reviewModalTitle">Review Experience</h5>
                </div>
                <div class="modal-body" style="padding: 40px;">
                    <div id="reviewDisplay" style="display: none; text-align: center;">
                        <div id="reviewStarsDisplay" style="font-size: 32px; color: #fbbf24; margin-bottom: 25px; filter: drop-shadow(0 0 10px rgba(251, 191, 36, 0.3));"></div>
                        <div style="background: rgba(255,255,255,0.03); padding: 25px; border-radius: 20px; border: 1px solid var(--glass-border);">
                            <p id="reviewTextDisplay" style="font-size: 17px; line-height: 1.8; color: var(--text-light); margin: 0; font-style: italic;"></p>
                        </div>
                    </div>
                    <form id="reviewForm">
                        <input type="hidden" id="reviewBookingId">
                        <div class="text-center mb-5">
                            <label class="form-label" style="font-weight: 800; color: var(--accent-red); text-transform: uppercase; font-size: 11px; letter-spacing: 2px; margin-bottom: 20px; display: block;">How was your journey?</label>
                            <div class="star-rating" style="display: flex; justify-content: center; gap: 15px; font-size: 40px; color: rgba(255,255,255,0.05);">
                                <i class="fa fa-star star-item" data-value="1" style="cursor: pointer; transition: 0.3s;"></i>
                                <i class="fa fa-star star-item" data-value="2" style="cursor: pointer; transition: 0.3s;"></i>
                                <i class="fa fa-star star-item" data-value="3" style="cursor: pointer; transition: 0.3s;"></i>
                                <i class="fa fa-star star-item" data-value="4" style="cursor: pointer; transition: 0.3s;"></i>
                                <i class="fa fa-star star-item" data-value="5" style="cursor: pointer; transition: 0.3s;"></i>
                            </div>
                            <input type="hidden" id="reviewRatingValue" value="5">
                        </div>
                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 800; color: var(--text-dim); text-transform: uppercase; font-size: 11px; letter-spacing: 1.5px; margin-bottom: 12px; display: block;">Detailed Feedback</label>
                            <textarea class="form-control" id="reviewText" rows="5" style="background: rgba(255,255,255,0.02); border: 1px solid var(--glass-border); border-radius: 20px; color: #fff; padding: 20px; font-size: 15px; resize: none; transition: 0.3s;" placeholder="Describe your highlights, challenges, and overall feedback..."></textarea>
                        </div>
                        <button type="submit" class="btn-submit-reflection" style="width: 100%; background: var(--accent-red); border: none; padding: 18px; border-radius: 20px; font-weight: 900; text-transform: uppercase; letter-spacing: 2px; color: #fff; box-shadow: 0 15px 30px rgba(230, 57, 70, 0.3); transition: 0.3s; margin-top: 10px;">Submit Reflection</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Advice Modal -->
    <div class="modal fade" id="adviceModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="background: #162121; border: 1px solid rgba(255,255,255,0.1); border-radius: 20px; box-shadow: 0 25px 50px rgba(0,0,0,0.8); color: #fff;">
                <div class="modal-header" style="border-bottom: 1px solid rgba(255,255,255,0.05); padding: 25px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: #fff; opacity: 1;"><span aria-hidden="true">&times;</span></button>
                    <h5 class="modal-title" style="font-weight: 800; font-size: 24px;">Share Travel Wisdom</h5>
                </div>
                <div class="modal-body" style="padding: 30px; max-height: 70vh; overflow-y: auto;">
                    <form id="adviceForm">
                        <input type="hidden" id="adviceBookingId">
                        
                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: #ff9f43; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 8px;">Trip Title</label>
                            <input type="text" class="form-control" id="adviceTitle" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: #fff; padding: 12px;" placeholder="e.g. Hiking in Manali" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: #ff9f43; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 8px;">Trip Category</label>
                            <select class="form-select" id="adviceCategory" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: #fff; padding: 12px;">
                                <option value="Solo Travel" selected>Solo Travel</option>
                                <option value="Adventure Trip">Adventure Trip</option>
                                <option value="Budget Travel">Budget Travel</option>
                                <option value="Luxury Escape">Luxury Escape</option>
                                <option value="Food & Culture">Food & Culture</option>
                                <option value="Road Trip">Road Trip</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: #ff9f43; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 8px;">Your Review / Experience</label>
                            <textarea class="form-control" id="adviceContent" rows="3" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: #fff; padding: 12px;" placeholder="Share your experience and tips..." required></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: #ff9f43; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 8px;">Best Time to Visit</label>
                            <textarea class="form-control" id="adviceBestTime" rows="2" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: #fff; padding: 12px;" placeholder="When should people visit?"></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: #ff9f43; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 8px;">What to Pack</label>
                            <textarea class="form-control" id="advicePack" rows="2" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: #fff; padding: 12px;" placeholder="Essential items to carry..."></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: #ff9f43; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 8px;">Safety Tips</label>
                            <textarea class="form-control" id="adviceSafety" rows="2" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: #fff; padding: 12px;" placeholder="How to stay safe..."></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: #ff9f43; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 8px;">Money & Budget Tips</label>
                            <textarea class="form-control" id="adviceBudget" rows="2" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: #fff; padding: 12px;" placeholder="Cost estimates and saving tips..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%; background: #ff9f43; border: none; padding: 15px; border-radius: 12px; font-weight: 900; text-transform: uppercase; letter-spacing: 1px; color: #fff; box-shadow: 0 10px 20px rgba(255, 159, 67, 0.2);">Archive Wisdom</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function filterBookings(type, element) {
            document.querySelectorAll('.tab-item').forEach(tab => tab.classList.remove('active'));
            element.classList.add('active');

            const today = new Date();
            today.setHours(0, 0, 0, 0);

            const cards = document.querySelectorAll('.booking-card');
            let visibleCount = 0;

            cards.forEach(card => {
                const dateStr = card.getAttribute('data-date');
                const status = card.getAttribute('data-status');
                
                // Ensure date parsing is robust
                const tripDate = new Date(dateStr);
                tripDate.setHours(0, 0, 0, 0);

                let show = false;
                const lowerStatus = (status || "").toLowerCase();
                if (type === 'upcoming') {
                    // Show only confirmed future trips in Upcoming
                    show = tripDate >= today && lowerStatus === 'confirmed';
                } else if (type === 'pending') {
                    // Show only pending trips in Pending
                    show = lowerStatus === 'pending';
                } else {
                    // Show past trips or explicitly completed/cancelled trips
                    show = (tripDate < today && lowerStatus !== 'pending') || lowerStatus === 'completed' || lowerStatus === 'cancelled';
                }

                if (show) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            const noMsg = document.getElementById('noBookingsMsg');
            if (noMsg) {
                noMsg.style.display = (visibleCount === 0) ? 'block' : 'none';
                if (visibleCount === 0) {
                    if (type === 'completed') noMsg.querySelector('h3').innerText = "No Completed Journeys Yet";
                    else if (type === 'pending') noMsg.querySelector('h3').innerText = "No Pending Bookings";
                    else noMsg.querySelector('h3').innerText = "No Upcoming Adventures Found";
                }
            }
        }

        function openReviewModal(bookingId, hasReviewed) {
            document.getElementById('reviewModalTitle').innerText = hasReviewed ? 'Your Reflection' : 'Review Experience';
            document.getElementById('reviewBookingId').value = bookingId;
            
            if (hasReviewed) {
                document.getElementById('reviewForm').style.display = 'none';
                document.getElementById('reviewDisplay').style.display = 'block';
                document.getElementById('reviewTextDisplay').innerText = 'Loading your memories...';
                document.getElementById('reviewStarsDisplay').innerHTML = '';

                fetch(`/user/booking/${bookingId}/review/data`)
                    .then(res => res.json())
                    .then(data => {
                        document.getElementById('reviewTextDisplay').innerText = data.reviewText;
                        let starsHtml = '';
                        for(let i=0; i<5; i++) {
                            starsHtml += `<i class="fa fa-star ${i < data.rating ? '' : 'text-muted'}" style="margin-right: 5px; color: ${i < data.rating ? '#fbbf24' : 'rgba(255,255,255,0.1)'}"></i>`;
                        }
                        document.getElementById('reviewStarsDisplay').innerHTML = starsHtml;
                    });
            } else {
                document.getElementById('reviewForm').style.display = 'block';
                document.getElementById('reviewDisplay').style.display = 'none';
                document.getElementById('reviewForm').reset();
                resetStars();
            }
            $('#reviewModal').modal('show');
        }

        function openAdviceModal(bookingId) {
            document.getElementById('adviceBookingId').value = bookingId;
            document.getElementById('adviceForm').reset();
            $('#adviceModal').modal('show');
        }

        // Star Rating Logic
        const starItems = document.querySelectorAll('.star-item');
        starItems.forEach(star => {
            star.onmouseover = () => {
                const val = star.getAttribute('data-value');
                starItems.forEach(s => {
                    s.style.color = (s.getAttribute('data-value') <= val) ? '#fbbf24' : 'rgba(255,255,255,0.1)';
                });
            };
            star.onmouseout = () => {
                const currentVal = document.getElementById('reviewRatingValue').value;
                starItems.forEach(s => {
                    s.style.color = (s.getAttribute('data-value') <= currentVal) ? '#fbbf24' : 'rgba(255,255,255,0.1)';
                });
            };
            star.onclick = () => {
                const val = star.getAttribute('data-value');
                document.getElementById('reviewRatingValue').value = val;
            };
        });

        function resetStars() {
            const val = 5;
            document.getElementById('reviewRatingValue').value = val;
            starItems.forEach(s => {
                s.style.color = (s.getAttribute('data-value') <= val) ? '#fbbf24' : 'rgba(255,255,255,0.1)';
            });
        }

        document.getElementById('reviewForm').onsubmit = (e) => {
            e.preventDefault();
            const bookingId = document.getElementById('reviewBookingId').value;
            const rating = document.getElementById('reviewRatingValue').value;
            const text = document.getElementById('reviewText').value;

            fetch(`/user/booking/${bookingId}/review`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ rating: rating, reviewText: text })
            }).then(res => {
                if (res.ok) {
                    location.reload();
                } else {
                    alert('Submission failed. Please try again.');
                }
            });
        };

        document.getElementById('adviceForm').onsubmit = (e) => {
            e.preventDefault();
            const bookingId = document.getElementById('adviceBookingId').value;
            const payload = {
                title: document.getElementById('adviceTitle').value,
                categories: document.getElementById('adviceCategory').value,
                content: document.getElementById('adviceContent').value,
                bestTimeToVisit: document.getElementById('adviceBestTime').value,
                whatToPack: document.getElementById('advicePack').value,
                safetyTips: document.getElementById('adviceSafety').value,
                budgetTips: document.getElementById('adviceBudget').value
            };

            fetch(`/user/booking/${bookingId}/advice`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            }).then(res => {
                if (res.ok) {
                    alert('Wisdom Archived Successfully!');
                    $('#adviceModal').modal('hide');
                } else {
                    alert('Submission failed. Please try again.');
                }
            });
        };

        window.onload = () => {
            const upcomingTab = document.querySelector('.tab-item');
            if (upcomingTab) filterBookings('upcoming', upcomingTab);
        };
    </script>

</body>
</html>
