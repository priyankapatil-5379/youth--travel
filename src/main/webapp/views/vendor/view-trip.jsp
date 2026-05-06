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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --sidebar-width: 260px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 40px;
            min-height: 100vh;
            transition: 0.3s;
        }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; padding: 20px; }
        }

        .details-container { padding-bottom: 60px; }

        .hero-banner {
            height: 440px;
            border-radius: 24px;
            overflow: hidden;
            position: relative;
            margin-bottom: 32px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .hero-banner img { width: 100%; height: 100%; object-fit: cover; }

        .hero-overlay {
            position: absolute;
            bottom: 0; left: 0; right: 0;
            padding: 40px;
            background: linear-gradient(to top, rgba(15, 23, 42, 0.9), transparent);
            color: #ffffff;
        }

        .section-card {
            background: var(--bg-card);
            border-radius: 20px;
            padding: 32px;
            margin-bottom: 32px;
            border: 1px solid var(--border-color);
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        .section-title {
            font-size: 18px;
            font-weight: 800;
            margin-bottom: 24px;
            color: var(--text-main);
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
            background: #f8fafc;
            padding: 16px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }

        .info-label { 
            font-size: 11px; 
            color: var(--text-muted); 
            margin-bottom: 4px; 
            text-transform: uppercase; 
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .info-value { font-size: 15px; font-weight: 700; color: var(--text-main); }
        
        .itinerary-item {
            position: relative;
            padding-left: 36px;
            padding-bottom: 32px;
            border-left: 2px solid var(--border-color);
        }

        .itinerary-item:last-child { border-left: none; padding-bottom: 0; }

        .itinerary-dot {
            position: absolute;
            left: -9px; top: 0;
            width: 16px; height: 16px;
            background: var(--primary);
            border: 3px solid #ffffff;
            border-radius: 50%;
            box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1);
        }

        .day-title { font-weight: 800; color: var(--text-main); margin-bottom: 8px; font-size: 17px; }
        .day-content { color: var(--text-muted); line-height: 1.6; font-size: 14px; }
        
        .tag {
            background: #f1f5f9;
            color: var(--text-main);
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
            bottom: 40px;
            right: 40px;
            background: var(--accent-red);
            color: #ffffff;
            width: 60px; height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 25px rgba(230, 57, 70, 0.3);
            transition: 0.3s;
            z-index: 1000;
            text-decoration: none;
        }

        .btn-edit-float:hover { transform: scale(1.1); color: #ffffff; background: #d62828; }

        .status-pill {
            background: #dcfce7;
            color: #166534;
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        .logistics-item {
            padding-bottom: 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .logistics-item:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="tours" />
    </jsp:include>

    <div class="main-content">
        <div class="details-container">
            <!-- HEADER -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="<c:url value='/vendor/tours'/>" class="btn btn-link text-muted text-decoration-none p-0 fw-bold">
                    <i class="fa fa-arrow-left me-2"></i> Back to Portfolio
                </a>
                <div class="status-badge">
                    <span class="status-pill ${trip.status == 'ACTIVE' ? '' : 'status-inactive'}">${trip.status}</span>
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
                <div class="hero-overlay">
                    <h1 class="fw-bolder mb-3" style="font-size: 38px; letter-spacing: -1px;">${trip.title}</h1>
                    <div class="d-flex align-items-center gap-4 fw-bold" style="font-size: 15px;">
                        <span><i class="fa fa-map-marker me-2" style="color: var(--primary);"></i> ${trip.destination}, ${trip.state}</span>
                        <span><i class="fa fa-clock-o me-2" style="color: var(--primary);"></i> ${trip.duration}</span>
                        <span><i class="fa fa-users me-2" style="color: var(--primary);"></i> ${trip.ageGroup}</span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-8">
                    <!-- OVERVIEW -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-info-circle"></i> Package Overview</div>
                        <p class="text-muted mb-4" style="font-size: 15px; line-height: 1.8;">${not empty trip.description ? trip.description : 'No description provided.'}</p>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="info-label">Covering Places</label>
                                <div class="info-value" style="color: var(--primary);">${not empty trip.coveringPlaces ? trip.coveringPlaces : 'N/A'}</div>
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

                        <div class="info-grid mt-4">
                            <div class="info-item">
                                <div class="info-label">Base Price</div>
                                <div class="info-value" style="color: var(--primary);">₹${trip.price}</div>
                                <div style="font-size: 11px; color: var(--text-muted); font-weight: 600;">${trip.pricingType == 'perGroup' ? 'Per Group' : 'Per Person'}</div>
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

                    <!-- GALLERY -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-camera"></i> Package Gallery</div>
                        <div class="d-flex flex-wrap gap-3">
                            <c:if test="${not empty trip.mediaUrls}">
                                <c:forEach var="url" items="${fn:split(trip.mediaUrls, ',')}">
                                    <c:if test="${!fn:contains(url, 'stay_')}">
                                        <div style="width: 140px; height: 90px; border-radius: 12px; overflow: hidden; border: 1px solid var(--border-color); cursor: pointer;" onclick="window.open('<c:url value='${url}'/>', '_blank')">
                                            <img src="<c:url value='${url}'/>" style="width: 100%; height: 100%; object-fit: cover;">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty trip.mediaUrls}">
                                <p class="text-muted small">No gallery images uploaded.</p>
                            </c:if>
                        </div>
                    </div>

                    <!-- ITINERARY -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-map-signs"></i> Detailed Itinerary</div>
                        <div id="itineraryContent" class="mt-4">
                            <div class="text-center py-4 text-muted">
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
                                        <c:otherwise><p class="text-muted small">No inclusions specified.</p></c:otherwise>
                                    </c:choose>
                                    <c:if test="${not empty trip.inclusionsOther}">
                                        <div class="mt-2 pt-2 border-top border-light text-muted small">
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
                                                    <i class="fa fa-info-circle text-warning mt-1"></i> 
                                                    <span class="small fw-600">${fn:trim(item)}</span>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise><p class="text-muted small">No essentials specified.</p></c:otherwise>
                                    </c:choose>
                                    <c:if test="${not empty trip.essentialsOther}">
                                        <div class="mt-2 pt-2 border-top border-light text-muted small">
                                            <i class="fa fa-plus-circle me-1"></i> ${trip.essentialsOther}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <!-- LOGISTICS -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-shield"></i> Logistics & Comfort</div>
                        
                        <!-- STAY -->
                        <div class="logistics-item">
                            <label class="info-label">Accommodation</label>
                            <div class="info-value mb-1">${not empty trip.stayName ? trip.stayName : 'Not Specified'}</div>
                            <div class="small fw-700 text-muted mb-2">${trip.stayCategory} | ${trip.stayType}</div>
                            
                            <c:if test="${not empty trip.stayDescription}">
                                <p class="small text-muted mb-3">${trip.stayDescription}</p>
                            </c:if>
                            
                            <!-- STAY PHOTOS -->
                            <div class="d-flex flex-wrap gap-2">
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
                        <div class="logistics-item">
                            <label class="info-label">Transportation</label>
                            <div class="info-value mb-1">${not empty trip.vehicleName ? trip.vehicleName : 'Standard Transport'}</div>
                            <div class="small fw-700 text-muted">${trip.transportCategory} | ${trip.transportType}</div>
                            <div class="badge bg-light text-muted border border-light mt-2 px-2 py-1">${not empty trip.acType ? trip.acType : 'Non-AC'}</div>
                        </div>

                        <!-- MEALS -->
                        <div class="logistics-item">
                            <label class="info-label">Meal Plan</label>
                            <div class="info-value mb-1">${not empty trip.mealPlan ? trip.mealPlan : 'Not Specified'}</div>
                            <div class="small fw-700 text-muted">${not empty trip.dietType ? trip.dietType : 'All Diet Types'}</div>
                        </div>

                        <!-- AMENITIES -->
                        <div>
                            <label class="info-label">Amenities</label>
                            <div id="amenitiesList" class="mt-2">
                                <p class="text-muted small">No amenities listed</p>
                            </div>
                        </div>
                    </div>

                    <!-- PICKUP POINTS -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-map-marker"></i> Pickup Points</div>
                        <div id="pickupList">
                            <p class="text-muted small">No pickup points added</p>
                        </div>
                    </div>

                    <!-- BATCHES -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa fa-calendar"></i> Batch Schedules</div>
                        <div class="batches-list">
                            <c:forEach items="${schedules}" var="s">
                                <div class="p-3 mb-3 rounded-4" style="background: #f8fafc; border: 1px solid var(--border-color);">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-bold" style="color: var(--text-main);">${s.startDate}</span>
                                        <span class="badge bg-white text-primary border border-light">${s.startTime}</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center small">
                                        <span class="text-muted fw-600">Availability</span>
                                        <span class="${s.availableSeats < 5 ? 'text-danger' : 'text-success'} fw-bold">${s.availableSeats} / ${s.totalSeats} Slots</span>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty schedules}">
                                <div class="text-center py-3 text-muted small">
                                    <i class="fa fa-calendar-times-o mb-2"></i>
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
                                    photosHtml += `<div style="width:110px; height:75px; flex-shrink:0; border-radius:10px; overflow:hidden; border:1px solid var(--border-color); cursor:pointer;" onclick="window.open('\${p}', '_blank')">
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
                                        <p class="mb-2">\${day.activities || 'No activities listed.'}</p>
                                        <div class="d-flex gap-3 mt-3">
                                            <div class="small fw-700 text-muted"><i class="fa fa-bed me-1" style="color: var(--primary);"></i> Stay: \${day.stay || 'N/A'}</div>
                                            <div class="small fw-700 text-muted"><i class="fa fa-cutlery me-1" style="color: var(--primary);"></i> Meals: \${day.meals || 'N/A'}</div>
                                        </div>
                                        \${photosHtml}
                                    </div>
                                </div>
                            `;
                        });
                        $('#itineraryContent').html(html);
                    } else {
                        $('#itineraryContent').html('<p class="text-muted small">No itinerary added yet.</p>');
                    }
                } else {
                    $('#itineraryContent').html('<p class="text-muted small">No itinerary details available.</p>');
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
                                <div class="mb-3 p-3 rounded-4" style="background: #f8fafc; border: 1px solid var(--border-color);">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold" style="font-size: 14px;">\${p.name || 'Location'}</div>
                                            <small class="text-muted fw-600" style="font-size: 10px; text-transform: uppercase;">\${p.type || 'Standard'}</small>
                                        </div>
                                        <div class="badge bg-white text-primary border border-light" style="font-size: 11px;">\${p.time || '--:--'}</div>
                                    </div>
                                </div>
                            `;
                        });
                        $('#pickupList').html(html);
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
                        let html = '<div class="d-flex flex-wrap gap-2 mt-2">';
                        amenities.forEach(a => {
                            if(a) html += `<span class="tag tag-accent">\${a}</span>`;
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
