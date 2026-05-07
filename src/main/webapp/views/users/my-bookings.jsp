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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f1f5f9;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0; padding: 0;
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; }

        .page-title { 
            font-size: 28px; 
            font-weight: 800; 
            margin-bottom: 32px; 
            color: var(--text-main); 
            letter-spacing: -0.5px; 
        }

        /* Modern Tabs */
        .tabs-container { 
            display: flex; 
            gap: 8px; 
            background: #e2e8f0; 
            padding: 4px; 
            border-radius: 12px; 
            margin-bottom: 32px; 
            width: fit-content;
        }
        .tab-item { 
            padding: 10px 24px; 
            font-weight: 600; 
            font-size: 14px; 
            color: var(--text-muted); 
            cursor: pointer; 
            border-radius: 100px;
            transition: var(--transition);
        }
        .tab-item.active { 
            background: #ffffff; 
            color: var(--primary); 
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }

        /* Booking Cards */
        .booking-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 24px; }
        .booking-card { 
            background: var(--bg-card); 
            border: 1px solid var(--border-color); 
            border-radius: 16px; 
            overflow: hidden; 
            transition: var(--transition); 
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
        }
        .booking-card:hover { transform: translateY(-4px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); border-color: var(--primary); }
        
        .card-image { width: 100%; aspect-ratio: 16 / 9; position: relative; overflow: hidden; background: #f1f5f9; }
        .card-image img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .booking-card:hover .card-image img { transform: scale(1.05); }
        
        .status-badge { 
            position: absolute; top: 16px; right: 16px; 
            background: var(--primary); 
            color: #ffffff; 
            padding: 6px 14px; 
            border-radius: 100px; 
            font-size: 11px; 
            font-weight: 700; 
            text-transform: uppercase; 
            letter-spacing: 0.5px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            z-index: 10;
        }

        .card-body { padding: 24px; }
        .card-title { font-size: 18px; font-weight: 700; margin-bottom: 16px; color: var(--text-main); line-height: 1.4; }
        .info-item { display: flex; align-items: center; gap: 12px; font-size: 13px; font-weight: 600; color: var(--text-muted); margin-bottom: 12px; }
        .info-item i { color: var(--primary); width: 16px; font-size: 14px; }

        .card-footer { 
            margin-top: 20px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            padding-top: 20px; 
            border-top: 1px solid var(--border-color); 
        }
        .card-price { font-size: 22px; font-weight: 800; color: var(--text-main); }
        
        .btn-view { 
            background: var(--bg-body); 
            color: var(--text-main); 
            border: 1px solid var(--border-color); 
            padding: 10px 20px; 
            border-radius: 10px; 
            font-weight: 700; 
            font-size: 12px; 
            text-decoration: none !important; 
            text-transform: uppercase; 
            letter-spacing: 0.5px; 
            transition: var(--transition);
            cursor: pointer;
        }
        .btn-view:hover { background: var(--primary); color: #ffffff; border-color: var(--primary); transform: translateY(-1px); }

        /* Modal Customization */
        .modal-content { 
            background: #ffffff !important; 
            border: 1px solid var(--border-color) !important; 
            border-radius: 20px !important; 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25) !important; 
            color: var(--text-main) !important; 
        }
        .modal-header { border-bottom: 1px solid var(--border-color) !important; padding: 24px !important; }
        .modal-title { font-weight: 800 !important; color: var(--text-main) !important; font-size: 20px !important; }
        .modal-header .close { color: var(--text-main) !important; opacity: 0.5 !important; font-size: 24px !important; }
        
        .form-label { font-weight: 700; color: var(--text-main); font-size: 12px; text-transform: uppercase; margin-bottom: 8px; display: block; }
        .form-control, .form-select { 
            background: #f8fafc !important; 
            border: 1px solid var(--border-color) !important; 
            border-radius: 12px !important; 
            color: var(--text-main) !important; 
            padding: 12px 16px !important; 
            font-weight: 500 !important;
            width: 100%;
        }
        .form-control:focus { border-color: var(--primary) !important; box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1) !important; }

        .btn-primary { 
            background: var(--primary) !important; 
            border: none !important; 
            padding: 14px !important; 
            border-radius: 12px !important; 
            font-weight: 700 !important; 
            text-transform: uppercase !important; 
            letter-spacing: 1px !important; 
            color: #ffffff !important;
            width: 100%;
        }
        .btn-primary:hover { background: var(--primary-hover) !important; transform: translateY(-1px); }

        .star-rating i { cursor: pointer; transition: 0.2s; }
        .star-rating i:hover { transform: scale(1.1); }

        @media (max-width: 991px) { .main-content { margin-left: 0; padding: 80px 20px 40px !important; } }
    </style>
</head>
<body>


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
                            <div class="booking-card" data-date="${booking.selectedDate}">
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
                                                <div style="display: flex; gap: 8px; flex: 1; justify-content: flex-end;">
                                                    <button onclick="event.stopPropagation(); openReviewModal('${booking.id}', true)" class="btn-view" style="background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; padding: 8px 12px; font-size: 11px; border-radius: 8px; font-weight: 600;">Reviewed ✓</button>
                                                    <a href="/user/booking/${booking.id}/advice" class="btn-view" style="background: rgba(0, 122, 255, 0.08); border: 1px solid rgba(0, 122, 255, 0.15); color: #007aff; padding: 8px 12px; font-size: 11px; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; border-radius: 8px;">Advice</a>
                                                </div>
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
                                                            if (tripDate < today || '${booking.status}'.toUpperCase() === 'COMPLETED') {
                                                                const parent = document.currentScript.parentElement;
                                                                const detailsBtn = parent.querySelector('.btn-view');
                                                                if (detailsBtn) detailsBtn.style.display = "none";
                                                                
                                                                parent.innerHTML = `
                                                                    <a href="/user/booking/${booking.id}/review" class="btn-view" style="background: var(--accent-red); border: 1px solid var(--accent-red); color: #fff; padding: 8px 14px; font-size: 11px; cursor: pointer; position: relative; z-index: 30; border-radius: 8px; font-weight: 700; text-decoration: none; display: inline-flex; align-items: center; justify-content: center;">Write Review</a>
                                                                    <a href="/user/booking/${booking.id}/advice" class="btn-view" style="background: rgba(0, 122, 255, 0.08); border: 1px solid rgba(0, 122, 255, 0.15); color: #007aff; padding: 8px 14px; font-size: 11px; cursor: pointer; position: relative; z-index: 30; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; border-radius: 8px;">Advice</a>
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
                    <div id="noBookingsMsg" style="display: none; text-align: center; padding: 80px 20px; background: var(--bg-card); border-radius: 20px; border: 2px dashed var(--border-color);">
                        <i class="fa fa-calendar-times-o" style="font-size: 60px; color: #e2e8f0; margin-bottom: 20px;"></i>
                        <h3 style="font-weight: 800; color: var(--text-main);">No Journeys Found</h3>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 80px 20px; background: var(--bg-card); border-radius: 20px; border: 2px dashed var(--border-color);">
                        <i class="fa fa-calendar-times-o" style="font-size: 60px; color: #e2e8f0; margin-bottom: 20px;"></i>
                        <h3 style="font-weight: 800; color: var(--text-main);">No Bookings Found</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>

    <!-- Review Modal -->
    <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="background: #ffffff; border: 1px solid var(--border-color); border-radius: 24px; box-shadow: 0 20px 40px rgba(0,0,0,0.1); color: var(--text-main);">
                <div class="modal-header" style="border-bottom: 1px solid var(--border-color); padding: 25px;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: var(--text-main); opacity: 0.5;"><span aria-hidden="true">&times;</span></button>
                    <h5 class="modal-title" style="font-weight: 800; font-size: 20px; color: var(--text-main);" id="reviewModalTitle">Write Review</h5>
                </div>
                <div class="modal-body" style="padding: 30px;">
                    <form id="reviewForm">
                        <input type="hidden" id="reviewBookingId">
                        
                        <!-- 1. Star Rating First -->
                        <div class="mb-5 text-center">
                            <label class="form-label" style="font-weight: 700; color: var(--primary); text-transform: uppercase; font-size: 11px; letter-spacing: 1.5px; margin-bottom: 15px; display: block;">How was your journey?</label>
                            <div class="star-rating" style="display: flex; justify-content: center; gap: 12px; font-size: 36px; color: #e2e8f0;">
                                <i class="fa fa-star star-item" data-value="1" style="cursor: pointer; transition: 0.2s;"></i>
                                <i class="fa fa-star star-item" data-value="2" style="cursor: pointer; transition: 0.2s;"></i>
                                <i class="fa fa-star star-item" data-value="3" style="cursor: pointer; transition: 0.2s;"></i>
                                <i class="fa fa-star star-item" data-value="4" style="cursor: pointer; transition: 0.2s;"></i>
                                <i class="fa fa-star star-item" data-value="5" style="cursor: pointer; transition: 0.2s;"></i>
                            </div>
                            <input type="hidden" id="reviewRatingValue" value="5">
                        </div>

                        <!-- 2. Experience Text Second -->
                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: var(--text-muted); text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 10px; display: block;">Share your experience</label>
                            <textarea class="form-control" id="reviewText" rows="4" style="background: #f8fafc; border: 1px solid var(--border-color); border-radius: 12px; color: var(--text-main); padding: 15px; font-size: 14px; resize: none;" placeholder="What did you love? Any tips for other travelers?" required></textarea>
                        </div>

                        <!-- 3. Optional Photos Last -->
                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; color: var(--text-muted); text-transform: uppercase; font-size: 11px; letter-spacing: 1px; margin-bottom: 10px; display: block;">Photo Memories (Optional)</label>
                            <div style="border: 2px dashed #e2e8f0; border-radius: 12px; padding: 20px; text-align: center; background: #f8fafc;">
                                <i class="fa fa-camera" style="font-size: 24px; color: #cbd5e1; margin-bottom: 10px;"></i>
                                <input type="file" id="reviewPhotos" multiple accept="image/*" style="display: none;">
                                <label for="reviewPhotos" style="display: block; cursor: pointer; color: var(--primary); font-weight: 600; font-size: 13px;">Click to upload photos</label>
                                <span style="font-size: 11px; color: var(--text-muted);">Max 5 photos, up to 5MB each</span>
                            </div>
                        </div>

                        <button type="submit" id="reviewSubmitBtn" class="btn btn-primary" style="width: 100%; background: var(--accent-red); border: none; padding: 16px; border-radius: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #fff; box-shadow: 0 4px 12px rgba(230, 57, 70, 0.2); transition: 0.3s;">Submit Review</button>
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
                // Ensure date parsing is robust
                const tripDate = new Date(dateStr);
                tripDate.setHours(0, 0, 0, 0);

                const statusBadge = card.querySelector('.status-badge');
                const statusText = statusBadge ? statusBadge.innerText.trim().toUpperCase() : '';

                let show = false;
                if (type === 'upcoming') {
                    show = statusText === 'CONFIRMED';
                } else if (type === 'pending') {
                    show = statusText !== 'CONFIRMED' && statusText !== 'COMPLETED';
                } else {
                    show = statusText === 'COMPLETED';
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
                    else if (type === 'pending') noMsg.querySelector('h3').innerText = "No Pending Bookings Found";
                    else noMsg.querySelector('h3').innerText = "No Upcoming Adventures Found";
                }
            }
        }

        function openReviewModal(bookingId, hasReviewed) {
            document.getElementById('reviewModalTitle').innerText = hasReviewed ? 'Edit Reflection' : 'Write Review';
            document.getElementById('reviewSubmitBtn').innerText = hasReviewed ? 'Update Reflection' : 'Submit Review';
            document.getElementById('reviewBookingId').value = bookingId;
            
            if (hasReviewed) {
                // Fetch data to pre-fill
                fetch(`/user/booking/${bookingId}/review/data`)
                    .then(res => res.json())
                    .then(data => {
                        document.getElementById('reviewText').value = data.reviewText;
                        const rating = data.rating || 5;
                        document.getElementById('reviewRatingValue').value = rating;
                        updateStars(rating);
                    });
            } else {
                document.getElementById('reviewForm').reset();
                resetStars();
            }
            $('#reviewModal').modal('show');
        }

        function updateStars(val) {
            document.querySelectorAll('.star-item').forEach(s => {
                s.style.color = (s.getAttribute('data-value') <= val) ? '#fbbf24' : '#e2e8f0';
            });
        }

        function openAdviceModal(bookingId) {
            document.getElementById('adviceBookingId').value = bookingId;
            document.getElementById('adviceForm').reset();
            $('#adviceModal').modal('show');
        }

        // Star Rating Logic
        const starItems = document.querySelectorAll('.star-item');
        starItems.forEach(star => {
            star.onclick = () => {
                const val = star.getAttribute('data-value');
                document.getElementById('reviewRatingValue').value = val;
                starItems.forEach(s => {
                    s.style.color = (s.getAttribute('data-value') <= val) ? '#fbbf24' : '#e2e8f0';
                });
            };
        });

        function resetStars() {
            const val = 5;
            document.getElementById('reviewRatingValue').value = val;
            document.querySelectorAll('.star-item').forEach(s => {
                s.style.color = (s.getAttribute('data-value') <= val) ? '#fbbf24' : '#e2e8f0';
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
                    window.location.href = "/user/my-reviews";
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
