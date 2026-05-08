<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trip Details | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">

    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body.yt-dark::before, body.premium-theme::before { display: none !important; }
        .text-teal { color: #008080 !important; }
        .bg-teal { background-color: #008080 !important; }
        :root { --primary: #008080; --bg-body: #f1f5f9; --bg-card: #ffffff; --border-color: #e2e8f0; --text-main: #0f172a; --text-muted: #64748b; }
        body.yt-dark { background: var(--bg-body) !important; background-image: none !important; color: var(--text-main); font-family: 'Inter', sans-serif; }
        .details-container { padding-bottom: 50px; }

        .hero-banner {
            height: 440px;
            border-radius: 24px;
            overflow: hidden;
            position: relative;

            margin-bottom: 30px;
            border: 1px solid var(--border-color);

        }

        .hero-banner img { width: 100%; height: 100%; object-fit: cover; }

        .hero-overlay {
            position: absolute;
            bottom: 0; left: 0; right: 0;
            padding: 40px;

            background: linear-gradient(to top, rgba(0,0,0,0.9), transparent);
            color: #ffffff !important;
        }
        .hero-overlay h1, .hero-overlay span, .hero-overlay i {
            color: #ffffff !important;

        }

        .section-card {
            background: var(--bg-card);

            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            border: 1px solid var(--border-color);
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);

        }

        .section-title {
            font-size: 18px;
            font-weight: 800;
            margin-bottom: 25px;
            color: #008080;
            text-transform: uppercase;
            letter-spacing: 1px;

            display: flex;
            align-items: center;
            gap: 12px;
            letter-spacing: -0.5px;
        }

        .section-title i { color: var(--primary); }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 16px;
        }

        .info-item {

            background: var(--bg-body);
            padding: 20px;
            border-radius: 16px;
            border: 1px solid var(--border-color);
        }
        .info-label { font-size: 12px; color: var(--text-muted); margin-bottom: 5px; text-transform: uppercase; }
        .info-value { font-size: 16px; font-weight: 700; color: var(--text-main); }
        
        .itinerary-item {
            position: relative;
            padding-left: 40px;
            padding-bottom: 30px;
            border-left: 2px dashed rgba(0, 128, 128, 0.3);

        }

        .itinerary-item:last-child { border-left: none; padding-bottom: 0; }

        .itinerary-dot {
            position: absolute;
            left: -9px; top: 0;
            width: 16px; height: 16px;

            background: #008080;
            border-radius: 50%;
            box-shadow: 0 0 10px rgba(0, 128, 128, 0.5);
        }
        .day-title { font-weight: 800; color: var(--text-main); margin-bottom: 10px; font-size: 18px; }
        .day-content { color: var(--text-muted); line-height: 1.6; }
        
        .tag {
            background: rgba(0, 128, 128, 0.1);
            color: #008080;

            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            margin-right: 8px;
            margin-bottom: 8px;
            display: inline-block;
            border: 1px solid var(--border-color);
        }

        .tag-accent {
            background: #e0f2f2;
            color: var(--primary);
            border-color: #b2dfdf;
        }

        .btn-edit-float {
            position: fixed;

            bottom: 30px;
            right: 30px;
            background: #008080;
            color: var(--text-main);

            width: 60px; height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;

            box-shadow: 0 10px 25px rgba(0, 128, 128, 0.4);

            transition: 0.3s;
            z-index: 1000;
            text-decoration: none;
        }
		
		.status-badge{
			font-size: 20px;
			           font-weight: 800;
			           margin-bottom: 25px;
			           color: #008080;
			           text-transform: uppercase;
			           letter-spacing: 1px;

			           display: flex;
			           align-items: center;
			           gap: 12px;
			           letter-spacing: -0.5px;
		}

        .btn-edit-float:hover { transform: scale(1.1) rotate(15deg); color: var(--text-main); }
        .main-content { margin-left: 260px; padding: 40px; }
        @media (max-width: 991px) { .main-content { margin-left: 0; padding: 20px; } }
    </style>
</head>
<body class="yt-dark" style="background: #f1f5f9 !important; background-image: none !important;">

    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="tours" />
    </jsp:include>

    <div class="main-content">
        <div class="details-container">
            <!-- HEADER -->
            <div class="d-flex justify-content-between align-items-center mb-4">

                <div class="status-badge">
                    <span class="status-pill ${trip.status == 'ACTIVE' ? '' : 'status-inactive'}">${trip.status}</span>
                </div>
				<div style="display: flex; justify-content: flex-end; margin-bottom: 15px;">
				    <a href="<c:url value='/vendor/tours'/>" 
				       class="btn"
				       style="background: #ef4444; color: #ffffff; border-radius: 12px; padding: 10px 22px; font-weight: 700; display: inline-flex; align-items: center; gap: 8px; box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2); transition: all 0.2s; text-decoration: none;">
				        
				        <i class="fa fa-arrow-left"></i> Back
				    </a>
				</div>
            </div>

            <!-- HERO -->
            <div class="hero-banner">
                <c:choose>
                    <c:when test="${not empty trip.imageUrl}">
                        <img src="<c:url value='${trip.imageUrl}'/>" alt="Trip">
                    </c:when>
                    <c:otherwise>
                        <img src="https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&q=80&w=1200" alt="Trip">
                    </c:otherwise>
                </c:choose>

                <div class="hero-overlay text-white">
                    <h1 class="fw-bolder mb-2 text-white" style="font-size: 42px;">${trip.title}</h1>
                    <div class="d-flex align-items-center gap-4 text-white">
                        <span><i class="fa fa-map-marker" style="color: #008080;"></i> ${trip.destination}, ${trip.state}</span>
                        <span><i class="fa fa-clock-o" style="color: #008080;"></i> ${trip.duration}</span>
                        <span><i class="fa fa-users" style="color: #008080;"></i> ${trip.ageGroup}</span>

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-8">
                    <!-- OVERVIEW -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-info-circle"></i> Package Overview</div>

                        <p class="text-dark lead" style="font-size: 1.1rem; line-height: 1.8;">${not empty trip.description ? trip.description : 'No description provided.'}</p>

                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="info-label">Covering Places</label>

                                <div class="info-value text-dark">${not empty trip.coveringPlaces ? trip.coveringPlaces : 'N/A'}</div>

                            </div>
                            <div class="col-md-3">
                                <label class="info-label">Origin City</label>
                                <div class="info-value">${not empty trip.originCity ? trip.originCity : 'N/A'}</div>
                            </div>
                            <div class="col-md-3">
                                <label class="info-label">Region</label>
                                <div class="info-value">${not empty trip.region ? trip.region : 'N/A'}, ${not empty trip.country ? trip.country : 'India'}</div>
                            </div>
                        </div>


                        <hr class="border-secondary  my-4">
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">Base Price</div>
                                <div class="info-value">₹${trip.price}</div>
                                <small class="text-muted">${trip.pricingType == 'perGroup' ? 'Per Group' : 'Per Person'}</small>

                            </div>
                            <div class="info-item">
                                <div class="info-label">Duration</div>
                                <div class="info-value">${not empty trip.duration ? trip.duration : 'N/A'}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Difficulty</div>
                                <div class="info-value">${not empty trip.difficulty ? trip.difficulty : 'Easy'}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Batch Size</div>
                                <div class="info-value">${trip.minTravelers != null ? trip.minTravelers : '1'} - ${trip.maxTravelers != null ? trip.maxTravelers : '20'}</div>
                            </div>
                        </div>
                    </div>


                    <!-- LOGISTICS BOX -->
                    <div class="section-card mb-4">
                        <div class="section-title"><i class="fa fa-shield"></i> Logistics & Comfort</div>
                        
                        <!-- STAY -->
                        <div class="mb-4 pb-4 border-bottom border-secondary border-">
                            <label class="info-label">Accommodation</label>
                            <div class="info-value fw-bold text-dark fs-5">${not empty trip.stayName ? trip.stayName : 'Not Specified'}</div>
                            
                            <div class="d-flex flex-wrap gap-2 mt-2 mb-3">
                                <c:if test="${not empty trip.stayCategory}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.stayCategory}</span></c:if>
                                <c:if test="${not empty trip.stayType}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.stayType}</span></c:if>
                                <c:if test="${not empty trip.stayVariant}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.stayVariant}</span></c:if>
                                <c:if test="${not empty trip.roomSharing}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.roomSharing}</span></c:if>
                            </div>
                            
                            <c:if test="${not empty trip.stayDescription}">
                                <p class="small text-muted mb-3 ">${trip.stayDescription}</p>
                            </c:if>
                            
                            <c:if test="${not empty trip.stayLink}">
                                <a href="${trip.stayLink}" target="_blank" class="btn btn-sm py-1 px-3 mb-3" style="font-size: 11px; border-radius: 20px; color: #008080; border: 1px solid #008080; background: transparent; font-weight: 600;">
                                    <i class="fa fa-external-link me-1"></i> View Hotel Site
                                </a>
                            </c:if>

                            <!-- STAY PHOTOS -->
                            <div class="d-flex flex-wrap gap-2 mt-2">
                                <c:if test="${not empty trip.mediaUrls}">
                                    <c:forEach var="url" items="${fn:split(trip.mediaUrls, ',')}">
                                        <c:if test="${fn:contains(url, 'stay_')}">
                                            <div style="width: 70px; height: 50px; border-radius: 8px; overflow: hidden; border: 1px solid var(--border-color); cursor: pointer;" onclick="window.open('<c:url value='${url}'/>', '_blank')">
                                                <img src="<c:url value='${url}'/>" style="width: 100%; height: 100%; object-fit: cover;">
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>

                        <!-- TRANSPORT -->
                        <div class="mb-4 pb-4 border-bottom border-secondary border-">
                            <label class="info-label">Transportation</label>
                            <div class="info-value fw-bold text-dark fs-5">${not empty trip.vehicleName ? trip.vehicleName : 'Standard Transport'}</div>
                            
                            <div class="d-flex flex-wrap gap-2 mt-2 mb-3">
                                <c:if test="${not empty trip.transportCategory}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.transportCategory}</span></c:if>
                                <c:if test="${not empty trip.transportType}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.transportType}</span></c:if>
                                <c:if test="${not empty trip.transferType}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.transferType}</span></c:if>
                                <c:if test="${not empty trip.acType}"><span class="badge" style="background-color: #ffffff !important; color: var(--text-main) !important; border: 1px solid var(--border-color) !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.acType}</span></c:if>
                            </div>
                            
                            <c:if test="${not empty trip.transportInclusions}">
                                <div class="mt-2 small text-muted ">
                                    <i class="fa fa-check me-1"></i> ${trip.transportInclusions}
                                </div>
                            </c:if>
                        </div>

                        <!-- MEALS -->
                        <div class="mb-4 pb-4 border-bottom border-secondary border-">
                            <label class="info-label">Meal Plan</label>
                            <div class="info-value fw-bold text-dark fs-5">${not empty trip.mealPlan ? trip.mealPlan : 'Not Specified'}</div>
                            
                            <div class="d-flex flex-wrap gap-2 mt-2 mb-3">
                                <c:if test="${not empty trip.dietType}"><span class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${trip.dietType}</span></c:if>
                            </div>
                            <c:if test="${not empty trip.mealNotes}">
                                <p class="small text-muted ">${trip.mealNotes}</p>
                            </c:if>
                        </div>

                        <!-- AMENITIES -->
                        <div>
                            <label class="info-label">Stay Amenities</label>
                            <div id="amenitiesList" class="mt-2">
                                <p class=" small">No amenities listed</p>
                            </div>
                        </div>
                    </div>

                    <!-- MEDIA GALLERY (Package Photos) -->

                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-camera"></i> Package Gallery</div>
                        <div class="d-flex flex-wrap gap-3">
                            <c:if test="${not empty trip.mediaUrls}">
                                <c:forEach var="url" items="${fn:split(trip.mediaUrls, ',')}">
                                    <c:if test="${!fn:contains(url, 'stay_')}">

                                        <div class="gallery-item" style="width: 150px; height: 100px; border-radius: 12px; overflow: hidden; border: 1px solid var(--border-color); cursor: pointer; transition: 0.3s;" onclick="window.open('<c:url value='${url}'/>', '_blank')">

                                            <img src="<c:url value='${url}'/>" style="width: 100%; height: 100%; object-fit: cover;">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty trip.mediaUrls}">

                                <p class="">No gallery images uploaded.</p>

                            </c:if>
                        </div>
                    </div>

                    <!-- ITINERARY -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-map-signs"></i> Detailed Itinerary</div>
                        <div id="itineraryContent" class="mt-4">

                            <div class="text-center py-4 ">

                                <i class="fa fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading itinerary...</p>
                            </div>
                        </div>
                    </div>

                    <!-- INCLUSIONS & ESSENTIALS -->
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="section-card h-100">
                                <div class="section-title"><i class="fa fa-check-circle"></i> Inclusions</div>
                                <div id="inclusionsList">
                                    <c:choose>
                                        <c:when test="${not empty trip.inclusions}">
                                            <c:forEach items="${fn:split(trip.inclusions, ',')}" var="item">
                                                <div class="mb-3 d-flex align-items-start gap-2">
                                                    <i class="fa fa-check-circle text-success mt-1"></i> 
                                                    <span class="small fw-600">${fn:trim(item)}</span>
                                                </div>
                                            </c:forEach>
                                        </c:when>

                                        <c:otherwise><p class="">No inclusions specified.</p></c:otherwise>
                                    </c:choose>
                                    <c:if test="${not empty trip.inclusionsOther}">
                                        <div class="mt-2 pt-2 border-top border-secondary  small">

                                            <i class="fa fa-plus-circle me-1"></i> ${trip.inclusionsOther}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="section-card h-100">
                                <div class="section-title"><i class="fa fa-suitcase"></i> Things to Carry</div>
                                <div id="essentialsList">
                                    <c:choose>
                                        <c:when test="${not empty trip.essentials}">
                                            <c:forEach items="${fn:split(trip.essentials, ',')}" var="item">
                                                <div class="mb-3 d-flex align-items-start gap-2">

                                                    <i class="fa fa-info-circle text-teal mt-1"></i> 
                                                    <span>${fn:trim(item)}</span>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise><p class="">No essentials specified.</p></c:otherwise>
                                    </c:choose>
                                    <c:if test="${not empty trip.essentialsOther}">
                                        <div class="mt-2 pt-2 border-top border-secondary  small">

                                            <i class="fa fa-plus-circle me-1"></i> ${trip.essentialsOther}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- SAFETY & RULES -->
                    <div class="section-card mt-4">
                        <div class="section-title"><i class="fa fa-lock"></i> Safety & Guidelines</div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="info-label">Safety Requirements</label>
                                <p class="small text-muted">${not empty trip.safetyRequirements ? trip.safetyRequirements : 'General safety rules apply.'}</p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="info-label">Trip Rules</label>
                                <p class="small text-muted">${not empty trip.tripRules ? trip.tripRules : 'Standard behavior guidelines.'}</p>
                            </div>
                        </div>
                        <c:if test="${not empty trip.safetyGuidelines}">
                            <div class="mt-2">
                                <label class="info-label">Safety Guidelines</label>
                                <p class="small text-muted">${trip.safetyGuidelines}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty trip.whatToCarry}">
                            <div class="mt-2">
                                <label class="info-label">Preparation Advice</label>
                                <p class="small text-muted">${trip.whatToCarry}</p>
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="col-lg-4">
                    

                    <!-- PICKUP POINTS -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-map-marker"></i> Pickup Points</div>
                        <div id="pickupList">

                            <p class=" small">No pickup points added</p>
                        </div>
                    </div>

                    <!-- POLICIES -->
                    <div class="section-card mb-4">
                        <div class="section-title"><i class="fa fa-file-text-o"></i> Policies & Reschedule</div>
                        <div class="mb-3">
                            <label class="info-label">Cancellation</label>
                            <p class="small text-muted">${not empty trip.cancellationPolicy ? trip.cancellationPolicy : 'Standard cancellation policy applies.'}</p>
                        </div>
                        <c:if test="${not empty trip.refundPolicy}">
                            <div class="mb-3">
                                <label class="info-label">Refund Policy</label>
                                <p class="small text-muted">${trip.refundPolicy}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty trip.reschedulePolicy}">
                            <div class="mb-3">
                                <label class="info-label">Reschedule Policy</label>
                                <p class="small text-muted">${trip.reschedulePolicy}</p>
                            </div>
                        </c:if>
                    </div>

                    <!-- UPCOMING BATCHES -->

                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-calendar"></i> Batch Schedules</div>
                        <div class="batches-list">
                            <c:forEach items="${schedules}" var="s">

                                <div class="p-3 mb-3 rounded-4" style="background: var(--bg-body); border: 1px solid var(--border-color);">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold" style="font-size: 1.1rem;">${s.startDate}</span>
                                        <span class="badge" style="background-color: #ffffff !important; color: var(--text-main) !important; border: 1px solid var(--border-color) !important; font-weight: 600; font-size: 11px; padding: 6px 12px;">${s.startTime}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2 small">
                                        <span class="">Availability</span>

                                        <span class="${s.availableSeats < 5 ? 'text-danger' : 'text-success'} fw-bold">${s.availableSeats} / ${s.totalSeats} Slots</span>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty schedules}">

                                <div class="text-center py-4 ">
                                    <i class="fa fa-calendar-times-o fa-2x mb-2"></i>

                                    <p class="mb-0">No active batches</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Floating Action -->
    <a href="<c:url value='/vendor/edit-trip/${trip.id}'/>" class="btn-edit-float" title="Edit Package">
        <i class="fa fa-pencil fa-lg"></i>
    </a>

    <!-- HIDDEN DATA -->
    <input type="hidden" id="itineraryRaw" value='${trip.itinerary}'>
    <input type="hidden" id="pickupRaw" value='${trip.pickupPoints}'>
    <input type="hidden" id="amenitiesRaw" value='${trip.stayAmenities}'>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script>
        $(document).ready(function() {
            // Render Itinerary
            try {
                const itineraryJson = $('#itineraryRaw').val();
                if(itineraryJson && itineraryJson !== 'null' && itineraryJson !== '[]') {
                    const itinerary = JSON.parse(itineraryJson);
                    if(Array.isArray(itinerary) && itinerary.length > 0) {
                        let html = '';
                        itinerary.forEach(day => {
                            let photosHtml = '';
                            if(day.photos && day.photos.length > 0) {
                                photosHtml = '<div class="d-flex gap-2 mt-3 overflow-auto pb-2">';
                                day.photos.forEach(p => {

                                    photosHtml += `<div style="width:120px; height:80px; flex-shrink:0; border-radius:12px; overflow:hidden; border:1px solid var(--border-color); cursor:pointer;" onclick="window.open('\${p}', '_blank')">

                                                     <img src="\${p}" style="width:100%; height:100%; object-fit:cover;">
                                                   </div>`;
                                });
                                photosHtml += '</div>';
                            }

                            html += `
                                <div class="itinerary-item">
                                    <div class="itinerary-dot"></div>
                                    <div class="day-title">\${day.day || 'Day'}: \${day.title || 'TBD'}</div>
                                    <div class="day-content">

                                        <p class="mb-2 text-muted">\${day.activities || 'No activities listed for this day.'}</p>
                                        <div class="d-flex gap-4 mt-3">
                                            <div class="small"><i class="fa fa-bed text-teal me-1"></i> <strong>Stay:</strong> \${day.stay || 'N/A'}</div>
                                            <div class="small"><i class="fa fa-cutlery text-teal me-1"></i> <strong>Meals:</strong> \${day.meals || 'N/A'}</div>

                                        </div>
                                        \${photosHtml}
                                    </div>
                                </div>
                            `;
                        });
                        $('#itineraryContent').html(html);
                    } else {

                        $('#itineraryContent').html('<p class="">Itinerary details have not been added yet.</p>');
                    }
                } else {
                    $('#itineraryContent').html('<p class="">No itinerary planned for this trip.</p>');

                }
            } catch(e) { $('#itineraryContent').html('<p class="text-danger small">Error loading itinerary.</p>'); }

            // Render Pickups
            try {
                const pickupJson = $('#pickupRaw').val();
                if(pickupJson && pickupJson !== 'null' && pickupJson !== '[]') {
                    const pickups = JSON.parse(pickupJson);
                    if(Array.isArray(pickups) && pickups.length > 0) {
                        let html = '';
                        pickups.forEach(p => {
                            html += `

                                <div class="mb-3 p-3 rounded-4" style="background: var(--bg-body); border: 1px solid var(--border-color);">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold" style="color: var(--text-main);">\${p.name || 'Unknown Location'}</div>
                                            <small class=" text-uppercase" style="font-size: 10px; letter-spacing: 0.5px;">Type: \${p.type || 'Standard'}</small>
                                        </div>
                                        <div class="badge bg-teal text-dark" style="font-size: 11px;">\${p.time || '--:--'}</div>

                                    </div>
                                </div>
                            `;
                        });
                        $('#pickupList').html(html);

                    } else {
                        $('#pickupList').html('<p class=" small text-center py-3">No pickup points added</p>');

                    }
                }
            } catch(e) {}

            // Render Amenities
            try {
                const amenitiesJson = $('#amenitiesRaw').val();
                if(amenitiesJson && amenitiesJson !== 'null' && amenitiesJson !== '[]') {
                    let amenities = [];
                    if(amenitiesJson.startsWith('[')) { amenities = JSON.parse(amenitiesJson); }
                    else { amenities = amenitiesJson.split(',').map(s => s.trim()); }
                    
                    if(Array.isArray(amenities) && amenities.length > 0) {
                        let html = '<div class="d-flex flex-wrap gap-2 mt-2 mb-2">';
                        amenities.forEach(a => {

                            if(a) html += `<span class="badge rounded-pill" style="font-size: 12px; font-weight: 500; padding: 6px 14px; background: #ffffff; color: var(--text-main); border: 1px solid var(--border-color); box-shadow: 0 1px 2px rgba(0,0,0,0.05);">\${a}</span>`;

                        });
                        html += '</div>';
                        $('#amenitiesList').html(html);
                    }
                }
            } catch(e) {}
        });
    </script>
</body>
</html>
