<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inventory Management | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
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
            --success: #10b981;
            --warning: #f59e0b;
            --info: #3b82f6;
            --danger: #e63946;
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

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h2 {
            font-weight: 800;
            font-size: 28px;
            color: var(--text-main);
            margin: 0;
            letter-spacing: -1px;
        }

        .inventory-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* Flexbox grid container to enforce equal height cards */
        .inventory-grid {
            display: flex !important;
            flex-wrap: wrap !important;
        }
        .inventory-grid > div {
            display: flex !important;
            flex-direction: column !important;
        }

        .inventory-card:hover {
            border-color: var(--primary);
            box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.08);
            transform: translateY(-2px);
        }

        .trip-title {
            font-weight: 700;
            font-size: 16px;
            color: var(--text-main);
            line-height: 1.3;
            min-height: 44px; /* Ensure 2 lines of title align perfectly across columns */
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .trip-meta {
            font-size: 12px;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 6px;
            min-height: 32px; /* Ensure 2 lines of description align perfectly across columns */
        }

        .trip-meta i {
            color: var(--primary);
        }

        .occupancy-label {
            font-size: 10px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .occupancy-value {
            font-size: 16px;
            font-weight: 800;
            color: var(--primary);
        }

        .status-badge {
            padding: 4px 10px;
            border-radius: 30px;
            font-size: 9px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .status-active {
            background: #e0f2f1;
            color: var(--primary);
        }

        .status-full {
            background: #fee2e2;
            color: var(--danger);
        }

        .btn-action {
            background: #f1f5f9;
            border: 1px solid var(--border-color);
            color: var(--text-main);
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 12px;
            font-weight: 600;
            transition: 0.2s;
            cursor: pointer;
        }

        .btn-action:hover {
            background: var(--primary);
            border-color: var(--primary);
            color: #ffffff;
        }

        .stat-box {
            background: #f8fafc;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            text-align: center;
        }

        .stat-label {
            font-size: 10px;
            font-weight: 600;
            color: var(--text-muted);
            margin-bottom: 2px;
        }

        .stat-value {
            font-size: 15px;
            font-weight: 700;
            color: var(--text-main);
        }

        .text-danger-custom {
            color: var(--danger);
        }
        
        .text-teal {
            color: var(--primary);
        }
        .text-teal:hover {
            color: var(--primary-hover);
        }

        /* Chevron Animation on Expand */
        .card-header-toggle {
            display: block;
            text-decoration: none !important;
            color: inherit !important;
        }
        .card-header-toggle.collapsed .collapse-indicator {
            transform: rotate(0deg);
        }
        .card-header-toggle:not(.collapsed) .collapse-indicator {
            transform: rotate(180deg);
        }

        /* Custom Scrollbar for batch subtable inside card */
        .batch-scroll-container::-webkit-scrollbar {
            width: 5px;
        }
        .batch-scroll-container::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 10px;
        }
        .batch-scroll-container::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="inventory" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <h2>Live Slot & Inventory Management</h2>
            <p style="color: var(--text-muted); font-size: 14px; margin-top: 5px;">Manage your tour portfolios in a beautiful interactive grid. Click on any card below to expand live stats & batch schedules.</p>
        </div>

        <div class="row inventory-grid">
            <c:forEach var="trip" items="${trips}">
                <c:set var="occupied" value="${occupiedMap[trip.id] != null ? occupiedMap[trip.id] : 0}" />
                <c:set var="total" value="${trip.maxTravelers != null && trip.maxTravelers > 0 ? trip.maxTravelers : 20}" />
                <c:set var="seatsLeft" value="${total - occupied}" />
                <c:set var="occupancy" value="${(occupied * 100) / total}" />

                <div class="col-sm-6 col-md-6 col-lg-4" style="margin-bottom: 24px;">
                    <div class="inventory-card">
                        <!-- Click-to-Expand Card Header Block -->
                        <div class="card-header-toggle collapsed" data-toggle="collapse" href="#collapseCard-${trip.id}" role="button" aria-expanded="false" aria-controls="collapseCard-${trip.id}" style="cursor: pointer; user-select: none;">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px; gap: 8px;">
                                <div>
                                    <div class="trip-title" style="display: flex; align-items: center; gap: 6px;">
                                        ${trip.title} 
                                        <i class="fa fa-chevron-down text-muted collapse-indicator" style="font-size: 11px; transition: transform 0.3s ease;"></i>
                                    </div>
                                    <div class="trip-meta" style="margin-top: 4px;">
                                        <i class="fa fa-map-marker"></i> ${trip.destination}
                                    </div>
                                </div>
                                <div style="flex-shrink: 0;">
                                    <c:choose>
                                        <c:when test="${seatsLeft <= 0}">
                                            <span class="status-badge status-full">FULL</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-active">ACTIVE</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Integrated Progress Bar inside Card Header -->
                            <div style="background: #f8fafc; padding: 12px; border-radius: 12px; border: 1px solid var(--border-color); margin-bottom: 4px;">
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                                    <span class="occupancy-label">Total Occupancy</span>
                                    <span class="occupancy-value">
                                        <fmt:formatNumber value="${occupancy}" maxFractionDigits="0" />%
                                    </span>
                                </div>
                                <div class="progress" style="height: 6px; border-radius: 10px; background-color: #e2e8f0; overflow: hidden; margin: 0; border: none; box-shadow: none;">
                                    <div class="progress-bar" role="progressbar" style="width: ${occupancy}%; background-color: ${occupancy >= 90 ? 'var(--danger)' : occupancy >= 70 ? 'var(--warning)' : 'var(--success)'}; transition: width 0.6s ease; height: 100%; border: none; box-shadow: none;" aria-valuenow="${occupancy}" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>

                        <!-- Card Collapsible Body (Opens seamlessly on click) -->
                        <div class="collapse" id="collapseCard-${trip.id}" style="margin-top: 15px;">
                            <div style="border-top: 1px solid var(--border-color); padding-top: 15px;">
                                
                                <!-- Mini Stat Blocks -->
                                <div style="display: flex; gap: 10px; margin-bottom: 15px;">
                                    <div class="stat-box" style="flex: 1;">
                                        <div class="stat-label">Bookings</div>
                                        <div class="stat-value">${occupied}</div>
                                    </div>
                                    <div class="stat-box" style="flex: 1;">
                                        <div class="stat-label">Remaining</div>
                                        <div class="stat-value ${seatsLeft <= 5 ? 'text-danger-custom' : ''}">
                                            ${seatsLeft > 0 ? seatsLeft : '0'} Left
                                        </div>
                                    </div>
                                </div>

                                <!-- Adjust Button inside Card -->
                                <div style="margin-bottom: 15px;">
                                    <button class="btn btn-block btn-action adjust-btn" 
                                            data-trip-id="${trip.id}" 
                                            data-title="${trip.title}" 
                                            data-capacity="${total}"
                                            style="width: 100%; background-color: var(--primary); color: white; border-color: var(--primary); padding: 8px; font-weight: 700; border-radius: 8px;">
                                        <i class="fa fa-sliders"></i> Adjust Overall Slots
                                    </button>
                                </div>

                                <!-- Batch Schedules Breakdown inside Card -->
                                <div style="background: #f8fafc; border: 1px solid var(--border-color); border-radius: 10px; padding: 12px;">
                                    <div style="font-weight: 700; font-size: 11px; margin-bottom: 10px; color: var(--text-main); display: flex; align-items: center; gap: 4px;">
                                        <i class="fa fa-calendar text-teal"></i> Batch Schedules (${schedulesMap[trip.id] != null ? schedulesMap[trip.id].size() : 0})
                                    </div>
                                    <c:choose>
                                        <c:when test="${not empty schedulesMap[trip.id]}">
                                            <div class="batch-scroll-container" style="max-height: 140px; overflow-y: auto; padding-right: 4px;">
                                                <c:forEach var="sched" items="${schedulesMap[trip.id]}">
                                                    <c:set var="schedOccupied" value="${scheduleOccupiedMap[sched.id] != null ? scheduleOccupiedMap[sched.id] : 0}" />
                                                    <c:set var="schedLeft" value="${sched.totalSeats - schedOccupied}" />
                                                    <div style="display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #f1f5f9; font-size: 11px; gap: 8px;">
                                                        <div>
                                                            <div style="font-weight: 700; color: var(--text-main);">${sched.startDate}</div>
                                                            <div style="font-size: 10px; color: var(--text-muted);">${schedLeft > 0 ? schedLeft : '0'} of ${sched.totalSeats} seats left (${schedOccupied} booked)</div>
                                                        </div>
                                                        <button class="btn btn-xs btn-default adjust-btn" 
                                                                data-trip-id="${trip.id}" 
                                                                data-schedule-id="${sched.id}" 
                                                                data-title="${trip.title} (Batch: ${sched.startDate})" 
                                                                data-capacity="${sched.totalSeats}"
                                                                style="font-size: 10px; padding: 2px 6px; border-radius: 4px; cursor: pointer; font-weight: 600;">
                                                            Adjust
                                                        </button>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-muted small text-center" style="font-size: 10px; padding: 5px 0;">No batches set. Uses base slots.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty trips}">
            <div style="text-align: center; padding: 60px; background: white; border-radius: 16px; border: 1px solid var(--border-color);">
                <i class="fa fa-list-alt" style="font-size: 48px; color: var(--border-color); margin-bottom: 20px;"></i>
                <h3 style="color: var(--text-muted);">No Active Trips for Inventory</h3>
                <p style="color: var(--text-muted);">Create a trip to start managing live slots.</p>
            </div>
        </c:if>
    </div>

    <!-- ADJUST CAPACITY MODAL (BOOTSTRAP 3) -->
    <div class="modal fade" id="adjustModal" tabindex="-1" role="dialog" aria-labelledby="adjustModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content" style="border-radius: 16px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.15);">
          <div class="modal-header" style="border-bottom: 1px solid var(--border-color); padding: 20px;">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="font-size: 24px; cursor: pointer;"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="adjustModalLabel" style="font-weight: 700; color: var(--text-main);">Adjust Capacity</h4>
          </div>
          <div class="modal-body" style="padding: 24px;">
            <form id="adjustForm">
              <input type="hidden" id="modalTripId" name="tripId">
              <input type="hidden" id="modalScheduleId" name="scheduleId">
              <div class="form-group" style="margin-bottom: 20px;">
                <label style="font-weight: 600; color: var(--text-muted); margin-bottom: 8px; display: block;">Trip / Batch</label>
                <div id="modalTripTitle" class="fw-bold" style="font-size: 16px; color: var(--text-main); font-weight: 700;">Trip Title Here</div>
              </div>
              <div class="form-group" style="margin-bottom: 20px;">
                <label for="newCapacity" style="font-weight: 600; color: var(--text-muted); margin-bottom: 8px; display: block;">New Total Slot Capacity</label>
                <input type="number" class="form-control" id="newCapacity" name="newCapacity" required min="1" style="border-radius: 10px; padding: 12px; border: 1px solid var(--border-color); font-size: 14px; height: auto;">
              </div>
              <div id="modalAlert" class="alert alert-danger" style="display: none; border-radius: 10px; margin-top: 15px; padding: 12px;"></div>
              <div class="text-end" style="margin-top: 24px; text-align: right;">
                <button type="button" class="btn btn-default" data-dismiss="modal" style="border-radius: 10px; padding: 10px 20px; font-weight: 600; margin-right: 8px; cursor: pointer;">Cancel</button>
                <button type="submit" id="saveBtn" class="btn btn-primary" style="background-color: var(--primary); border-color: var(--primary); border-radius: 10px; padding: 10px 24px; font-weight: 600; color: white; cursor: pointer;">Save Changes</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script>
        $(document).ready(function() {
            // Open modal and load details
            $(document).on('click', '.adjust-btn', function(e) {
                e.preventDefault();
                e.stopPropagation(); // Stop parent collapse toggle from firing when clicking buttons
                var tripId = $(this).data('trip-id');
                var scheduleId = $(this).data('schedule-id') || "";
                var title = $(this).data('title');
                var capacity = $(this).data('capacity');

                $('#modalTripId').val(tripId);
                $('#modalScheduleId').val(scheduleId);
                $('#modalTripTitle').text(title);
                $('#newCapacity').val(capacity);
                $('#modalAlert').hide();
                
                $('#adjustModal').modal('show');
            });

            // Submit capacity adjustment via AJAX
            $('#adjustForm').on('submit', function(e) {
                e.preventDefault();
                var $btn = $('#saveBtn');
                var originalText = $btn.text();
                $btn.prop('disabled', true).text('Saving...');

                $.ajax({
                    url: '${pageContext.request.contextPath}/vendor/inventory/adjust-slots',
                    type: 'POST',
                    data: $(this).serialize(),
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#adjustModal').modal('hide');
                            window.location.reload(); // Reload to reflect newly calculated occupied counts, seats left, etc.
                        } else {
                            $('#modalAlert').text(response.message).fadeIn();
                            $btn.prop('disabled', false).text(originalText);
                        }
                    },
                    error: function(xhr, status, error) {
                        $('#modalAlert').text('Failed to process request: Server error.').fadeIn();
                        $btn.prop('disabled', false).text(originalText);
                    }
                });
            });
        });
    </script>
</body>
</html>