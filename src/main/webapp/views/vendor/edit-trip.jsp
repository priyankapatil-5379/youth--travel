<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Edit Trip | Youth Travel</title>
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

                    .form-card {
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.08);
                        border-radius: 24px;
                        padding: 40px;
                    }

                    .section-title {
                        font-size: 20px;
                        font-weight: 800;
                        color: #f04c26;
                        margin-bottom: 35px;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .section-title .badge {
                        background: rgba(240, 76, 38, 0.15);
                        color: #f04c26;
                        padding: 6px 12px;
                        border-radius: 8px;
                        font-size: 12px;
                    }

                    .form-group {
                        margin-bottom: 32px;
                    }

                    .form-group label {
                        color: rgba(255, 255, 255, 0.6);
                        font-weight: 600;
                        font-size: 14px;
                        margin-bottom: 10px;
                        display: block;
                    }

                    .form-control {
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 12px;
                        color: #fff;
                        height: 50px;
                        padding: 0 16px;
                        transition: all 0.2s;
                    }

                    .form-control:focus {
                        background: rgba(255, 255, 255, 0.08);
                        border-color: #f04c26;
                        box-shadow: 0 0 0 4px rgba(240, 76, 38, 0.15);
                        outline: none;
                    }

                    textarea.form-control {
                        height: auto;
                        padding-top: 15px;
                    }

                    .select-custom {
                        cursor: pointer;
                        -webkit-appearance: none;
                        -moz-appearance: none;
                        appearance: none;
                        background-image: url('data:image/svg+xml;utf8,<svg fill="white" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
                        background-repeat: no-repeat;
                        background-position: right 12px center;
                    }

                    .form-control option {
                        background: #1a1f2b;
                        color: #fff;
                        padding: 10px;
                    }

                    .checkbox-group {
                        display: flex;
                        gap: 20px;
                        flex-wrap: wrap;
                        margin-top: 10px;
                    }

                    .custom-checkbox {
                        position: relative;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        cursor: pointer;
                        user-select: none;
                    }

                    .custom-checkbox input {
                        position: absolute;
                        opacity: 0;
                        cursor: pointer;
                        height: 0;
                        width: 0;
                    }

                    .checkmark {
                        height: 20px;
                        width: 20px;
                        background-color: rgba(255, 255, 255, 0.08);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 6px;
                    }

                    .custom-checkbox:hover input~.checkmark {
                        background-color: rgba(255, 255, 255, 0.12);
                    }

                    .custom-checkbox input:checked~.checkmark {
                        background-color: #f04c26;
                        border-color: #f04c26;
                    }

                    .checkmark:after {
                        content: "";
                        position: absolute;
                        display: none;
                        left: 7px;
                        top: 3px;
                        width: 6px;
                        height: 11px;
                        border: solid white;
                        border-width: 0 2px 2px 0;
                        transform: rotate(45deg);
                    }

                    .custom-checkbox input:checked~.checkmark:after {
                        display: block;
                    }

                    .btn-submit {
                        background: #f04c26;
                        color: #fff;
                        font-weight: 800;
                        border: none;
                        border-radius: 12px;
                        padding: 15px 30px;
                        font-size: 16px;
                        margin-top: 20px;
                        transition: all 0.2s;
                        box-shadow: 0 10px 20px rgba(240, 76, 38, 0.2);
                    }

                    .btn-submit:hover {
                        background: #d93d1a;
                        transform: translateY(-2px);
                        box-shadow: 0 15px 30px rgba(240, 76, 38, 0.3);
                    }

                    .btn-prev {
                        background: rgba(255, 255, 255, 0.05);
                        color: #fff;
                        font-weight: 700;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 12px;
                        padding: 15px 30px;
                    }

                    .itinerary-day {
                        background: rgba(255, 255, 255, 0.02);
                        border: 1px solid rgba(255, 255, 255, 0.05);
                        border-radius: 16px;
                        padding: 25px;
                        margin-bottom: 20px;
                        position: relative;
                        animation: slideDown 0.3s ease-out;
                    }

                    /* Utility Classes */
                    .d-none {
                        display: none !important;
                    }

                    .d-flex {
                        display: flex !important;
                    }

                    .flex-wrap {
                        flex-wrap: wrap !important;
                    }

                    .gap-2 {
                        gap: 10px !important;
                    }

                    .w-100 {
                        width: 100% !important;
                    }

                    .text-start {
                        text-align: left !important;
                    }

                    .p-3 {
                        padding: 15px !important;
                    }

                    .mb-0 {
                        margin-bottom: 0 !important;
                    }

                    .mt-2 {
                        margin-top: 10px !important;
                    }

                    .day-number {
                        position: absolute;
                        top: -12px;
                        left: 20px;
                        background: #f04c26;
                        color: #fff;
                        padding: 4px 15px;
                        border-radius: 20px;
                        font-weight: 800;
                        font-size: 12px;
                        box-shadow: 0 4px 10px rgba(240, 76, 38, 0.3);
                    }

                    .remove-day {
                        position: absolute;
                        top: 15px;
                        right: 15px;
                        color: rgba(255, 255, 255, 0.3);
                        cursor: pointer;
                        transition: all 0.2s;
                    }

                    .remove-day:hover {
                        color: #ef4444;
                    }

                    /* Wizard Styles */
                    .form-step {
                        display: none;
                        animation: fadeIn 0.4s ease-out;
                    }

                    .form-step.active {
                        display: block;
                    }

                    .step-indicator {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 40px;
                        position: relative;
                    }

                    .step-indicator::before {
                        content: '';
                        position: absolute;
                        top: 15px;
                        left: 0;
                        right: 0;
                        height: 2px;
                        background: rgba(255, 255, 255, 0.05);
                        z-index: 1;
                    }

                    .step-item {
                        position: relative;
                        z-index: 2;
                        text-align: center;
                        width: 25%;
                    }

                    .step-dot {
                        width: 32px;
                        height: 32px;
                        background: #1a1f2b;
                        border: 2px solid rgba(255, 255, 255, 0.1);
                        border-radius: 50%;
                        margin: 0 auto 10px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-weight: 800;
                        font-size: 14px;
                        color: rgba(255, 255, 255, 0.3);
                        transition: all 0.3s;
                    }

                    .step-item.active .step-dot {
                        border-color: #f04c26;
                        color: #fff;
                        background: #f04c26;
                        box-shadow: 0 0 15px rgba(240, 76, 38, 0.4);
                    }

                    .step-item.completed .step-dot {
                        background: #22c55e;
                        border-color: #22c55e;
                        color: #fff;
                    }

                    .step-label {
                        font-size: 13px;
                        font-weight: 700;
                        color: rgba(255, 255, 255, 0.3);
                        transition: all 0.3s;
                    }

                    .step-item.active .step-label {
                        color: #f04c26;
                    }

                    @media (max-width: 768px) {
                        .step-indicator {
                            margin-bottom: 30px;
                        }

                        .step-label {
                            font-size: 11px;
                        }

                        .step-dot {
                            width: 28px;
                            height: 28px;
                            font-size: 12px;
                            margin-bottom: 5px;
                        }

                        .step-indicator::before {
                            top: 13px;
                        }
                    }

                    @media (max-width: 480px) {
                        .step-label {
                            font-size: 10px;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            white-space: nowrap;
                            max-width: 100%;
                        }

                        .step-dot {
                            width: 24px;
                            height: 24px;
                            font-size: 11px;
                        }

                        .step-indicator::before {
                            top: 11px;
                        }
                    }

                    @media (max-width: 768px) {
                        .glass-card {
                            padding: 20px !important;
                        }

                        .section-title {
                            font-size: 1.1rem;
                        }

                        .btn-submit,
                        .btn-prev {
                            padding: 10px 20px;
                            font-size: 14px;
                        }

                        .form-control {
                            font-size: 14px;
                            padding: 10px 15px;
                        }
                    }

                    @media (max-width: 480px) {
                        .glass-card {
                            padding: 15px !important;
                        }

                        .section-title {
                            font-size: 1rem;
                        }

                        .badge {
                            padding: 4px 8px;
                            font-size: 10px;
                        }
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    @keyframes slideDown {
                        from {
                            opacity: 0;
                            transform: translateY(-10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .pricing-toggle {
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.08);
                        padding: 15px 25px;
                        border-radius: 16px;
                        cursor: pointer;
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                        font-weight: 700;
                        color: rgba(255, 255, 255, 0.4);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 10px;
                    }

                    .pricing-toggle i {
                        font-size: 18px;
                    }

                    .pricing-toggle.active {
                        background: linear-gradient(135deg, rgba(240, 76, 38, 0.15), rgba(240, 76, 38, 0.05));
                        border-color: #f04c26;
                        color: #fff;
                        box-shadow: 0 8px 20px rgba(240, 76, 38, 0.15);
                    }

                    .occ-card {
                        background: rgba(255, 255, 255, 0.02);
                        border: 1px solid rgba(255, 255, 255, 0.06);
                        border-radius: 16px;
                        padding: 20px;
                        margin-bottom: 15px;
                        transition: all 0.2s;
                    }

                    .occ-card:hover {
                        border-color: rgba(240, 76, 38, 0.3);
                        background: rgba(255, 255, 255, 0.04);
                    }

                    .day-chip-group {
                        display: flex;
                        gap: 10px;
                        flex-wrap: wrap;
                    }

                    .day-chip {
                        cursor: pointer;
                        user-select: none;
                    }

                    .day-chip input {
                        display: none;
                    }

                    .day-chip .chip-label {
                        display: inline-block;
                        padding: 10px 18px;
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.08);
                        border-radius: 12px;
                        font-weight: 700;
                        font-size: 13px;
                        color: rgba(255, 255, 255, 0.5);
                        transition: all 0.2s;
                    }

                    .day-chip input:checked+.chip-label {
                        background: #f04c26;
                        color: #fff;
                        border-color: #f04c26;
                        box-shadow: 0 4px 12px rgba(240, 76, 38, 0.2);
                    }
                </style>
            </head>

            <body class="yt-dark">
                    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="tours" />
    </jsp:include>

    <div class="main-content">
                    <div class="mobile-header">
                        <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" height="24">
                        <div class="menu-toggle" onclick="toggleSidebar()">
                            <i class="fa fa-bars"></i>
                        </div>
                    </div>
                    <div style="margin-bottom: 35px;">
                        <h1 style="font-weight: 800; font-size: 32px;">Edit Adventure</h1>
                        <p style="color: rgba(255,255,255,0.5);">Updating details for <strong>${trip.title}</strong></p>
                    </div>

                    <!-- Wizard Progress -->
                    <div class="step-indicator">
                        <div class="step-item active" id="stepIndicator1">
                            <div class="step-dot">1</div>
                            <div class="step-label">Basic Info</div>
                        </div>
                        <div class="step-item" id="stepIndicator2">
                            <div class="step-dot">2</div>
                            <div class="step-label">Journey</div>
                        </div>
                        <div class="step-item" id="stepIndicator3">
                            <div class="step-dot">3</div>
                            <div class="step-label">Logistics</div>
                        </div>
                        <div class="step-item" id="stepIndicator4">
                            <div class="step-dot">4</div>
                            <div class="step-label">Policies</div>
                        </div>
                    </div>

                    <form action="<c:url value='/vendor/edit-trip'/>" id="regForm" method="post"
                        enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${trip.id}">

                        <div class="form-card">

                            <!-- STEP 1: BASIC INFO -->
                            <div class="form-step active" id="step1">
                                <div class="section-title"><span class="badge">01</span> CORE TRIP DETAILS</div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Trip Title <span class="text-danger">*</span></label>
                                            <input type="text" name="title" class="form-control" value="${trip.title}"
                                                required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Destination <span class="text-danger">*</span></label>
                                            <input type="text" name="destination" class="form-control"
                                                value="${trip.destination}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Traveler Type (Audience)</label>
                                            <div class="dropdown">
                                                <button id="audienceBtn" class="form-control text-start select-custom"
                                                    type="button" data-toggle="dropdown"
                                                    style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                    Select Audience Types
                                                </button>
                                                <div class="dropdown-menu p-3 bg-dark border-secondary w-100"
                                                    style="background: #1a1f2b; min-width: 250px;">
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Solo"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Solo Travelers</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Group"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Group / Friends</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Corporate"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Corporate / Team</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Adventure"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Adventure</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Bike Riding"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Bike Riding</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Nature Exploration"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Nature Exploration</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Water Activities"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Water Activities</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Workation"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Workation / Digital Nomad</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Festivals"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Festivals & Events</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Volunteering"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Volunteering</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Nightlife"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Nightlife & Social</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Content Creation"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Content Creation</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Wellness"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Wellness & Detox</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            name="travelerCategories" value="Budget Backpacking"
                                                            onchange="updateSubCategories()"><span
                                                            class="checkmark"></span>
                                                        Budget Backpacking</label>
                                                    <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                            id="catOthersCheck" name="travelerCategories" value="Others"
                                                            onchange="toggleOtherInput('catOthersCheck', 'catOtherInputCont'); updateSubCategories();"><span
                                                            class="checkmark"></span> Others</label>
                                                </div>
                                            </div>
                                            <div id="catOtherInputCont" style="display:none;" class="mt-2">
                                                <label class="small text-orange">Specify Other Audience</label>
                                                <input type="text" name="travelerCategoryOther" class="form-control"
                                                    value="${trip.travelerCategoryOther != null ? trip.travelerCategoryOther : ''}"
                                                    placeholder="Specify other...">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mt-4">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Sub-Categories (Specific Interest)</label>
                                            <div class="dropdown">
                                                <button id="subCategoryBtn"
                                                    class="form-control text-start select-custom" type="button"
                                                    data-toggle="dropdown"
                                                    style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                    Select Interests / Categories
                                                </button>
                                                <div class="dropdown-menu p-3 bg-dark border-secondary w-100"
                                                    style="background: #1a1f2b; min-width: 250px; max-height: 300px; overflow-y: auto;">
                                                    <div id="subCategoryList">
                                                        <p class="text-white-50 small mb-0">Select Audience first...</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="subOtherInputCont" style="display:none;" class="mt-2">
                                                <label class="small text-orange">Sub-Categories</label>
                                                <input type="text" name="travelerSubCategoryOther" class="form-control"
                                                    value="${trip.travelerSubCategoryOther != null ? trip.travelerSubCategoryOther : ''}"
                                                    placeholder="Specify sub-category...">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Short Summary</label>
                                            <textarea name="description" class="form-control"
                                                rows="3">${trip.description}</textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="section-title mt-4"><span class="badge">02</span> MEDIA GALLERY</div>
                                <c:if test="${not empty trip.mediaUrls}">
                                    <div class="d-flex flex-wrap gap-2 mb-3 p-3 bg-dark-subtle rounded">
                                        <c:forEach items="${trip.mediaUrls.split(',')}" var="url">
                                            <img src="<c:url value='${url}'/>"
                                                style="width: 50px; height: 50px; object-fit: cover; border-radius: 6px;">
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div onclick="document.getElementById('photoFiles').click()"
                                            class="p-4 border-2 border-dashed border-secondary rounded text-center cursor-pointer mb-2"
                                            style="border: 2px dashed rgba(240, 76, 38, 0.3); background: rgba(240, 76, 38, 0.05);">
                                            <i class="fa fa-picture-o fa-2x text-orange mb-2"></i>
                                            <div class="small">Replace / Add New Media (Images/Video)</div>
                                            <input type="file" id="photoFiles" name="photoFiles"
                                                accept="image/*,video/*" multiple class="d-none"
                                                onchange="previewMedia(this, 'photoPreview')">
                                        </div>
                                        <div id="photoPreview" class="d-flex flex-wrap gap-2"></div>
                                    </div>
                                </div>
                            </div>

                            <!-- STEP 2: ITINERARY & PRICING -->
                            <div class="form-step" id="step2">
                                <div class="section-title"><span class="badge">03</span> JOURNEY TIMELINE</div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group"><label>Days <span
                                                    class="text-danger">*</span></label><input type="number" name="days"
                                                id="tripDays" class="form-control" value="${trip.days}" required></div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group"><label>Nights</label><input type="number" name="nights"
                                                class="form-control" value="${trip.nights}"></div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group"><label>Label (e.g. 3D/2N)</label><input type="text"
                                                name="duration" class="form-control" value="${trip.duration}"></div>
                                    </div>
                                </div>

                                <div id="itineraryContainer" class="mb-3"></div>
                                <button type="button" id="addDayBtn" class="btn btn-outline-orange w-100 mb-4"
                                    style="border-style: dashed;"><i class="fa fa-plus-circle"></i> Add Next
                                    Day</button>
                                <input type="hidden" name="itinerary" id="itineraryJson"
                                    value='<c:out value="${trip.itinerary}"/>'>

                                <div class="section-title mt-4"><span class="badge">04</span> PRICING CONFIG</div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Price Model</label>
                                            <div class="d-flex gap-2 mb-3">
                                                <div class="pricing-toggle ${trip.pricingType == 'perPerson' ? 'active' : ''} w-100 text-center"
                                                    onclick="setPricingType('perPerson', this)">Per Person</div>
                                                <div class="pricing-toggle ${trip.pricingType == 'perGroup' ? 'active' : ''} w-100 text-center"
                                                    onclick="setPricingType('perGroup', this)">Per Group</div>
                                                <input type="hidden" name="pricingType" id="pricingTypeInput"
                                                    value="${trip.pricingType}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label id="mainPriceLabel">Current Price (₹) <span
                                                    class="text-danger">*</span></label>
                                            <input type="number" name="adultPrice" class="form-control"
                                                value="${trip.adultPrice}" required>
                                            <input type="hidden" name="price" id="hiddenMainPrice"
                                                value="${trip.price}">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Weekend Price (₹)</label><input type="number"
                                                name="weekendPrice" class="form-control" value="${trip.weekendPrice}">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Group Discount (%)</label><input type="number"
                                                name="groupDiscount" class="form-control" value="${trip.groupDiscount}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- STEP 3: SCHEDULING & LOGISTICS -->
                            <div class="form-step" id="step3">
                                <div class="section-title"><span class="badge">05</span> AVAILABILITY WINDOW</div>
                                <div class="d-flex gap-2 mb-4">
                                    <div class="pricing-toggle ${trip.scheduleMode == 'specific' ? 'active' : ''} w-100 text-center"
                                        onclick="setScheduleMode('specific', this)"><i class="fa fa-calendar"></i>
                                        Specific
                                        Dates</div>
                                    <div class="pricing-toggle ${trip.scheduleMode == 'recurring' ? 'active' : ''} w-100 text-center"
                                        onclick="setScheduleMode('recurring', this)"><i class="fa fa-refresh"></i>
                                        Weekly
                                        Recurring</div>
                                    <input type="hidden" name="scheduleMode" id="scheduleModeInput"
                                        value="${trip.scheduleMode}">
                                </div>

                                <div id="specificDatesCont"
                                    style="${trip.scheduleMode == 'specific' ? '' : 'display:none;'}">
                                    <div id="occurrenceContainer"></div>
                                    <button type="button" onclick="addOccurrence()"
                                        class="btn btn-outline-orange w-100 mb-3"
                                        style="border-style: dashed; background: rgba(240, 76, 38, 0.05); text-decoration: none;"><i
                                            class="fa fa-plus-circle"></i> Add Departure Date</button>
                                </div>

                                <div id="recurringCont"
                                    style="${trip.scheduleMode == 'recurring' ? '' : 'display:none;'}"
                                    class="p-4 bg-dark-subtle rounded-4 mb-4 border border-secondary border-opacity-10">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Select
                                        Departure Days</label>
                                    <div class="day-chip-group mb-4">
                                        <label class="day-chip"><input type="checkbox" name="recurringDays"
                                                value="MONDAY" ${not empty trip.travelerTypes and
                                                fn:contains(trip.travelerTypes, 'MONDAY' ) ? 'checked' : '' }><span
                                                class="chip-label">Mon</span></label>
                                        <label class="day-chip"><input type="checkbox" name="recurringDays"
                                                value="TUESDAY" ${not empty trip.travelerTypes and
                                                fn:contains(trip.travelerTypes, 'TUESDAY' ) ? 'checked' : '' }><span
                                                class="chip-label">Tue</span></label>
                                        <label class="day-chip"><input type="checkbox" name="recurringDays"
                                                value="WEDNESDAY" ${not empty trip.travelerTypes and
                                                fn:contains(trip.travelerTypes, 'WEDNESDAY' ) ? 'checked' : '' }><span
                                                class="chip-label">Wed</span></label>
                                        <label class="day-chip"><input type="checkbox" name="recurringDays"
                                                value="THURSDAY" ${not empty trip.travelerTypes and
                                                fn:contains(trip.travelerTypes, 'THURSDAY' ) ? 'checked' : '' }><span
                                                class="chip-label">Thu</span></label>
                                        <label class="day-chip"><input type="checkbox" name="recurringDays"
                                                value="FRIDAY" ${not empty trip.travelerTypes and
                                                fn:contains(trip.travelerTypes, 'FRIDAY' ) ? 'checked' : '' }><span
                                                class="chip-label">Fri</span></label>
                                        <label class="day-chip"><input type="checkbox" name="recurringDays"
                                                value="SATURDAY" ${not empty trip.travelerTypes and
                                                fn:contains(trip.travelerTypes, 'SATURDAY' ) ? 'checked' : '' }><span
                                                class="chip-label">Sat</span></label>
                                        <label class="day-chip"><input type="checkbox" name="recurringDays"
                                                value="SUNDAY" ${not empty trip.travelerTypes and
                                                fn:contains(trip.travelerTypes, 'SUNDAY' ) ? 'checked' : '' }><span
                                                class="chip-label">Sun</span></label>
                                    </div>
                                    <div class="row mt-4">
                                        <div class="col-md-4">
                                            <label class="small text-white-50 mb-1">Valid Until</label>
                                            <input type="date" name="recEndDate" id="recEndDate" class="form-control"
                                                value="${trip.recEndDate}">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="small text-white-50 mb-1">Start Time</label>
                                            <input type="time" name="recStartTime" class="form-control"
                                                value="${trip.recStartTime}">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="small text-white-50 mb-1">Batch Size</label>
                                            <input type="number" name="recTotalSeats" class="form-control"
                                                value="${trip.recTotalSeats}">
                                        </div>
                                    </div>
                                </div>

                                <input type="hidden" name="schedulesJson" id="schedulesJson"
                                    value='<c:out value="${trip.schedulesJson}"/>'>
                                <input type="hidden" name="mealsConfig" id="mealsConfigJson">

                                <div class="section-title mt-4"><span class="badge">06</span> PICKUP & LOGISTICS
                                </div>
                                <div
                                    class="p-4 bg-dark-subtle rounded-4 mb-4 border border-secondary border-opacity-10">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Dynamic
                                        Pickup
                                        & Drop Points</label>

                                    <div id="selectedPickupTimes" class="mb-3">
                                        <!-- Dynamic rows go here -->
                                    </div>

                                    <button type="button" onclick="addCustomPickup()"
                                        class="btn btn-outline-orange btn-sm"
                                        style="border-style: dashed; background: rgba(240, 76, 38, 0.05);">
                                        <i class="fa fa-plus-circle"></i> Add New Point
                                    </button>
                                    <input type="hidden" name="pickupPoints" id="pickupPointsJson"
                                        value='<c:out value="${trip.pickupPoints}"/>'>
                                </div>
                            </div>

                            <!-- STEP 4: POLICIES & FINAL -->
                            <div class="form-step" id="step4">
                                <div class="section-title"><span class="badge">07</span> SAFETY & AMENITIES</div>

                                <!-- SAFETY FEATURES -->
                                <div class="row g-4 mb-4">
                                    <div class="col-md-12">
                                        <div
                                            class="p-4 bg-dark-subtle rounded-4 border border-secondary border-opacity-10 h-100">
                                            <h6 class="text-orange mb-3"><i class="fa fa-shield"></i> Core Safety
                                            </h6>
                                            <div class="row g-2">
                                                <div class="col-6">
                                                    <label class="custom-checkbox small mb-2"><input type="checkbox"
                                                            class="stay-amenity" value="24/7 Security"><span
                                                            class="checkmark"></span> 24/7 Security</label>
                                                    <label class="custom-checkbox small mb-2"><input type="checkbox"
                                                            class="stay-amenity" value="CCTV Surveillance"><span
                                                            class="checkmark"></span> CCTV</label>
                                                    <label class="custom-checkbox small mb-2"><input type="checkbox"
                                                            class="stay-amenity" value="First Aid Kit"><span
                                                            class="checkmark"></span> First Aid Kit</label>
                                                </div>
                                                <div class="col-6">
                                                    <label class="custom-checkbox small mb-2"><input type="checkbox"
                                                            class="stay-amenity" value="Fire Safety"><span
                                                            class="checkmark"></span> Fire Safety</label>
                                                    <label class="custom-checkbox small mb-2"><input type="checkbox"
                                                            class="stay-amenity" value="Women-Friendly"><span
                                                            class="checkmark"></span> Women-Friendly</label>
                                                    <label class="custom-checkbox small mb-2"><input type="checkbox"
                                                            class="stay-amenity" value="Family-Friendly"><span
                                                            class="checkmark"></span> Family-Friendly</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <input type="hidden" name="stayAmenities" id="stayAmenitiesJson"
                                    value='${trip.stayAmenities}'>

                                <div class="section-title mt-4"><span class="badge">08</span> POLICIES & TERMS</div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Transport Category</label>
                                        <select name="transportCategory" id="transportCategory"
                                            class="form-control select-custom" onchange="updateTransportTypes()">
                                            <option value="">Select Category</option>
                                            <option value="Road" ${trip.transportCategory=='Road' ? 'selected' : '' }>
                                                Road
                                                Transport 🛣️</option>
                                            <option value="Rail" ${trip.transportCategory=='Rail' ? 'selected' : '' }>
                                                Rail
                                                Transport 🚆</option>
                                            <option value="Air" ${trip.transportCategory=='Air' ? 'selected' : '' }>
                                                Air
                                                Transport ✈️</option>
                                            <option value="Water" ${trip.transportCategory=='Water' ? 'selected' : '' }>
                                                Water Transport 🚢</option>
                                            <option value="Adventure" ${trip.transportCategory=='Adventure' ? 'selected'
                                                : '' }>Adventure & Terrain 🏔️</option>
                                            <option value="Cable" ${trip.transportCategory=='Cable' ? 'selected' : '' }>
                                                Cable & Lift 🚠</option>
                                            <option value="Eco" ${trip.transportCategory=='Eco' ? 'selected' : '' }>
                                                Eco-Friendly 🌱</option>
                                            <option value="Tourist" ${trip.transportCategory=='Tourist' ? 'selected'
                                                : '' }>
                                                Tourist-Specific 🏝️</option>
                                            <option value="Group" ${trip.transportCategory=='Group' ? 'selected' : '' }>
                                                Corporate / Group 🏢</option>
                                            <option value="Special" ${trip.transportCategory=='Special' ? 'selected'
                                                : '' }>
                                                Special Services 🎯</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row g-4 mt-2">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Transport Type</label>
                                            <select name="transportType" id="transportType"
                                                class="form-control select-custom" data-saved="${trip.transportType}">
                                                <option value="">Select Type</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Stay Category</label>
                                            <select name="stayCategory" id="stayCategory"
                                                class="form-control select-custom" onchange="updateStayTypes()">
                                                <option value="">Select Category</option>
                                                <option value="Hotels" ${trip.stayCategory=='Hotels' ? 'selected' : ''
                                                    }>🏢 Hotels</option>
                                                <option value="Resorts" ${trip.stayCategory=='Resorts' ? 'selected' : ''
                                                    }>🏝️ Resorts</option>
                                                <option value="Homestays" ${trip.stayCategory=='Homestays' ? 'selected'
                                                    : '' }>🧑‍🤝‍🧑 Homestays</option>
                                                <option value="Camping" ${trip.stayCategory=='Camping' ? 'selected' : ''
                                                    }>🏕️ Camping</option>
                                                <option value="Unique" ${trip.stayCategory=='Unique' ? 'selected' : ''
                                                    }>💎 Unique Stays</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Stay Type</label>
                                            <select name="stayType" id="stayType" class="form-control select-custom"
                                                data-saved="${trip.stayType}">
                                                <option value="">Select Type</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Stay Variant</label>
                                            <select name="stayVariant" id="stayVariant"
                                                class="form-control select-custom">
                                                <option value="Standard" ${trip.stayVariant=='Standard' ? 'selected'
                                                    : '' }>Standard Room</option>
                                                <option value="Premium" ${trip.stayVariant=='Premium' ? 'selected' : ''
                                                    }>Premium / Deluxe</option>
                                                <option value="Luxury" ${trip.stayVariant=='Luxury' ? 'selected' : '' }>
                                                    Luxury / Suite</option>
                                                <option value="Private" ${trip.stayVariant=='Private' ? 'selected' : ''
                                                    }>Private / Entire Place</option>
                                                <option value="Shared" ${trip.stayVariant=='Shared' ? 'selected' : '' }>
                                                    Shared / Dormitory</option>
                                                <option value="Tent" ${trip.stayVariant=='Tent' ? 'selected' : '' }>
                                                    Tent
                                                    (Single/Double)</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-4 mt-2">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Difficulty</label>
                                            <select name="difficulty" class="form-control select-custom">
                                                <option value="Easy" ${trip.difficulty=='Easy' ? 'selected' : '' }>Easy
                                                </option>
                                                <option value="Moderate" ${trip.difficulty=='Moderate' ? 'selected' : ''
                                                    }>Moderate</option>
                                                <option value="Hard" ${trip.difficulty=='Hard' ? 'selected' : '' }>Hard
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Age/Fitness Limit</label>
                                            <input type="text" name="safetyRequirements" class="form-control"
                                                value="${trip.safetyRequirements}" placeholder="e.g. basic fitness">
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-4 mt-2">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Target Age Group</label>
                                            <select name="ageGroup" class="form-control select-custom">
                                                <option value="All Youths" ${trip.ageGroup=='All Youths' ? 'selected'
                                                    : '' }>All Youths (18-35)</option>
                                                <option value="18-24" ${trip.ageGroup=='18-24' ? 'selected' : '' }>Early
                                                    Youth (18-24)</option>
                                                <option value="25-35" ${trip.ageGroup=='25-35' ? 'selected' : '' }>Mid
                                                    Youth (25-35)</option>
                                                <option value="30+" ${trip.ageGroup=='30+' ? 'selected' : '' }>Mature
                                                    Youth (30+)</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Student Benefits</label>
                                            <div class="p-2 border border-secondary border-opacity-10 rounded">
                                                <label class="custom-checkbox small mb-0">
                                                    <input type="checkbox" name="studentDiscountAvailable" value="true"
                                                        ${trip.studentDiscountAvailable ? 'checked' : '' }>
                                                    <span class="checkmark"></span> Extra Student Discount Available
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Cancellation Policy</label>
                                            <select name="cancellationPolicy" class="form-control select-custom"
                                                onchange="toggleCustomPolicy(this.value)">
                                                <option value="Flexible" ${trip.cancellationPolicy=='Flexible'
                                                    ? 'selected' : '' }>Flexible</option>
                                                <option value="Moderate" ${trip.cancellationPolicy=='Moderate'
                                                    ? 'selected' : '' }>Moderate</option>
                                                <option value="Strict" ${trip.cancellationPolicy=='Strict' ? 'selected'
                                                    : '' }>Strict</option>
                                                <option value="Custom" ${trip.cancellationPolicy=='Custom' ? 'selected'
                                                    : '' }>Custom</option>
                                            </select>
                                            <div id="customPolicyCont"
                                                style="${trip.cancellationPolicy == 'Custom' ? '' : 'display:none;'}"
                                                class="mt-2">
                                                <textarea name="customCancellation" class="form-control" rows="2"
                                                    placeholder="Describe your custom policy...">${trip.customCancellation}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Booking Cut-off (Hrs)</label>
                                            <input type="number" name="bookingCutoffHours" class="form-control"
                                                value="${trip.bookingCutoffHours}">
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Min Travelers <span class="text-danger">*</span></label>
                                            <input type="number" name="minTravelers" class="form-control"
                                                value="${trip.minTravelers != null ? trip.minTravelers : 1}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Max Travelers <span class="text-danger">*</span></label>
                                            <input type="number" name="maxTravelers" class="form-control"
                                                value="${trip.maxTravelers != null ? trip.maxTravelers : 20}" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-2 mb-4 p-3 border border-warning rounded"
                                    style="background: rgba(255,193,7,0.05);">
                                    <label class="custom-checkbox mb-0">
                                        <input type="checkbox" name="customizable" value="true" ${trip.customizable
                                            ? 'checked' : '' }>
                                        <span class="checkmark"></span> Accept Customization Requests
                                    </label>
                                </div>
                            </div> <!-- END STEP 4 -->

                            <!-- WIZARD FOOTER -->
                            <div
                                class="d-flex justify-content-between mt-5 pt-4 border-top border-secondary border-opacity-10">
                                <button type="button" class="btn btn-prev" id="prevBtn"
                                    onclick="nextPrev(-1)">Previous</button>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn-submit" id="nextBtn" onclick="nextPrev(1)">Next
                                        Step</button>
                                    <button type="submit" class="btn-submit d-none" id="launchBtn">Update
                                        Adventure</button>
                                </div>
                            </div>
                        </div> <!-- END FORM CARD -->
                    </form>
                </div>

                <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
                <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
                <script>
                    // Sub-categories Data
                    const subCategories = {
                        'Solo': ['Backpacker', 'Digital Nomad', 'Spiritual Search', 'Other'],
                        'Group': ['Friends Trip', 'College Group', 'Bikers Club', 'Other'],
                        'Corporate': ['Team Building', 'Leadership Retreat', 'Other'],
                        'Adventure': ['Trekking', 'Hiking', 'Camping', 'Rock climbing', 'Other'],
                        'Bike Riding': ['Road Trips', 'Off-road', 'Weekend Rides', 'Other'],
                        'Nature Exploration': ['Wildlife Safari', 'Forest Walk / Jungle Trek', 'Bird Watching', 'Nature Trails / Hiking', 'Waterfall Exploration', 'National Park Visit', 'Botanical Garden Visit', 'River / Lake Exploration'],
                        'Water Activities': ['Scuba Diving', 'Snorkeling', 'Jet Ski', 'Parasailing', 'Banana Boat Ride', 'Kayaking', 'River Rafting', 'Surfing', 'Other'],
                        'Workation': ['Co-working Friendly', 'High-Speed WiFi', 'Networking Events', 'Monthly Stays', 'Other'],
                        'Festivals': ['Music Festivals', 'Comic-con / Pop Culture', 'Sporting Events', 'Cultural Carnivals', 'Other'],
                        'Volunteering': ['Animal Rescue', 'Rural Teaching', 'Beach Cleanup', 'Environmental Projects', 'Other'],
                        'Nightlife': ['Pub Crawls', 'Clubbing Destinations', 'Social Hostel Hopping', 'Beach Parties', 'Other'],
                        'Content Creation': ['Drone Photography Spots', 'Aesthetic Stays', 'Portrait Tours', 'Hidden Gems', 'Other'],
                        'Wellness': ['Yoga Retreats', 'Digital Detox', 'Meditation Camps', 'Spa & Healing', 'Other'],
                        'Budget Backpacking': ['Hitchhiking Tours', 'Shared Dorm Stays', 'Street Food Crawls', 'Other'],
                        'Others': ['Other']
                    };

                    // Multi-step Logic
                    let currentStep = 0;

                    document.addEventListener('DOMContentLoaded', function () {
                        initWizard();
                    });

                    function initWizard() {
                        console.log("Initializing Wizard...");
                        const steps = document.getElementsByClassName("form-step");
                        console.log("Total steps found:", steps.length);

                        const todayStr = new Date().toISOString().split('T')[0];
                        const recEndDate = document.getElementById('recEndDate');
                        if (recEndDate) recEndDate.setAttribute('min', todayStr);

                        showStep(0);
                    }

                    function showStep(n) {
                        const steps = document.getElementsByClassName("form-step");
                        console.log("Navigating to step index:", n);

                        if (!steps || steps.length === 0) {
                            console.error("No form steps found!");
                            return;
                        }

                        // Hide all steps
                        for (let i = 0; i < steps.length; i++) {
                            steps[i].classList.remove("active");
                            steps[i].style.display = "none";
                        }

                        // Show current step
                        if (steps[n]) {
                            steps[n].classList.add("active");
                            steps[n].style.display = "block";
                        }

                        // Update buttons
                        const prevBtn = document.getElementById("prevBtn");
                        const nextBtn = document.getElementById("nextBtn");
                        const launchBtn = document.getElementById("launchBtn");

                        if (prevBtn) prevBtn.style.setProperty('display', (n === 0) ? 'none' : 'block', 'important');

                        if (n === (steps.length - 1)) {
                            if (nextBtn) nextBtn.style.display = "none";
                            if (launchBtn) launchBtn.classList.remove("d-none");
                        } else {
                            if (nextBtn) nextBtn.style.display = "block";
                            if (launchBtn) launchBtn.classList.add("d-none");
                        }

                        updateIndicators(n);
                    }

                    function nextPrev(n) {
                        console.log("Button clicked, direction:", n);
                        const steps = document.getElementsByClassName("form-step");

                        if (n === 1 && !validateStep()) {
                            console.warn("Step validation failed");
                            return false;
                        }

                        currentStep += n;

                        if (currentStep >= steps.length) {
                            console.log("Submitting form...");
                            document.getElementById("regForm").submit();
                            return;
                        }

                        if (currentStep < 0) currentStep = 0;

                        showStep(currentStep);
                        window.scrollTo({ top: 0, behavior: 'smooth' });
                    }

                    function updateIndicators(n) {
                        const indicators = document.getElementsByClassName("step-item");
                        for (let i = 0; i < indicators.length; i++) {
                            indicators[i].classList.remove("active", "completed");
                            if (i < n) indicators[i].classList.add("completed");
                            if (i === n) indicators[i].classList.add("active");
                        }
                    }

                    function validateStep() {
                        const steps = document.getElementsByClassName("form-step");
                        const activeStep = steps[currentStep];
                        if (!activeStep) return true;

                        const requiredInputs = activeStep.querySelectorAll("input[required], select[required], textarea[required]");
                        console.log("Validating", requiredInputs.length, "required fields in current step");

                        for (let input of requiredInputs) {
                            if (!input.value || input.value.trim() === "") {
                                input.classList.add("is-invalid");
                                alert("Please fill in all required fields marked with *");
                                input.focus();
                                return false;
                            }
                            input.classList.remove("is-invalid");
                        }
                        return true;
                    }

                    // Re-hydration Logic
                    $(document).ready(function () {
                        // Itinerary
                        const itin = $('#itineraryJson').val();
                        if (itin) {
                            try {
                                const days = JSON.parse(itin);
                                days.forEach((d, i) => addDayItem(d, i + 1));
                            } catch (e) { addDayItem(); }
                        } else { addDayItem(); }

                        // Audience
                        const rawCats = '<c:out value="${trip.travelerCategory}" />';
                        const savedCats = rawCats ? rawCats.split(', ') : [];
                        savedCats.forEach(c => {
                            const cb = document.querySelector(`input[name="travelerCategories"][value="${c}"]`);
                            if (cb) cb.checked = true;
                        });
                        updateSubCategories(true);
                        toggleOtherInput('catOthersCheck', 'catOtherInputCont');

                        // Pickups
                        const pickups = $('#pickupPointsJson').val();
                        if (pickups) {
                            try {
                                JSON.parse(pickups).forEach(p => {
                                    addCustomPickup(p.name, p.time, p.type || 'Pickup');
                                });
                            } catch (e) { }
                        }

                        // Amenities Re-hydration
                        const amenities = $('#stayAmenitiesJson').val();
                        if (amenities) {
                            try {
                                const amList = JSON.parse(amenities);
                                document.querySelectorAll('.stay-amenity').forEach(cb => {
                                    if (amList.includes(cb.value)) cb.checked = true;
                                });
                            } catch (e) {
                                // Fallback for comma separated
                                const amList = amenities.split(', ');
                                document.querySelectorAll('.stay-amenity').forEach(cb => {
                                    if (amList.includes(cb.value)) cb.checked = true;
                                });
                            }
                        }

                        // Schedules
                        const scheds = $('#schedulesJson').val();
                        if (scheds) {
                            try { JSON.parse(scheds).forEach(s => addOccurrence(s)); } catch (e) { }
                        }

                        // Transport & Stay initial updates
                        updateTransportTypes();
                        updateStayTypes();
                    });

                    const stayDataCurated = {
                        'Hotels': ['Budget Hotel', 'Standard Hotel', 'Premium Hotel', 'Luxury Hotel (4★ / 5★)', 'Boutique Hotel', 'Business Hotel', 'Airport Hotel', 'Extended Stay Hotel', 'Heritage Hotel'],
                        'Resorts': ['Beach Resort', 'Hill Resort', 'Island Resort', 'Jungle Resort', 'Spa Resort', 'Golf Resort', 'Ski Resort', 'Desert Resort'],
                        'Homestays': ['Homestay (Hosted)', 'Homestay (Unhosted)', 'Paying Guest (PG)', 'Cultural Stay', 'Rural Stay'],
                        'Camping': ['Tented Camp', 'Glamping (Luxury Camping)', 'Alpine / High Altitude Camp', 'Riverside Camp', 'Desert Camp', 'Forest Camp', 'Survival / Bushcraft Camp'],
                        'Unique': ['Treehouse', 'Bamboo Hut', 'Mud House', 'Igloo', 'Houseboat', 'Cave Stay', 'Capsule Hotel', 'Overwater Bungalow', 'Lighthouse Stay']
                    };

                    function updateStayTypes() {
                        const cat = document.getElementById('stayCategory').value;
                        const typeSelect = document.getElementById('stayType');
                        const savedType = typeSelect.getAttribute('data-saved');
                        typeSelect.innerHTML = '<option value="">Select Type</option>';
                        if (cat && stayDataCurated[cat]) {
                            stayDataCurated[cat].forEach(t => {
                                const opt = document.createElement('option');
                                opt.value = t;
                                opt.innerText = t;
                                if (t === savedType) opt.selected = true;
                                typeSelect.appendChild(opt);
                            });
                        }
                    }

                    const transportDataCurated = {
                        'Road': ['Hatchback Car', 'Sedan Car', 'SUV / MUV', 'Luxury Car', 'Self-Drive Car', 'Chauffeur-driven Car', 'Bike / Motorcycle', 'Scooter', 'Auto Rickshaw', 'Taxi / Cab', 'Mini Bus', 'Bus (Non-AC / AC / Sleeper / Volvo)', 'Tempo Traveller', 'Caravan / Camper Van'],
                        'Rail': ['Passenger Train', 'Express Train', 'Superfast Train', 'Metro Rail', 'Monorail', 'Tram', 'Luxury Train'],
                        'Air': ['Economy Class Flight', 'Business Class Flight', 'First Class Flight', 'Domestic Flight', 'International Flight', 'Charter Flight', 'Private Jet', 'Helicopter Transfer', 'Seaplane'],
                        'Water': ['Ferry', 'Cruise (Budget / Luxury)', 'River Cruise', 'Houseboat', 'Yacht', 'Speed Boat', 'Catamaran', 'Canoe / Kayak'],
                        'Adventure': ['4x4 Off-road Jeep', 'ATV (All-Terrain Vehicle)', 'Snowmobile', 'Dog Sled', 'Camel Safari', 'Horse Riding', 'Elephant Safari', 'Sand Dune Buggy'],
                        'Cable': ['Cable Car', 'Ropeway', 'Chairlift', 'Gondola Lift', 'Ski Lift', 'Funicular Railway'],
                        'Eco': ['Bicycle', 'Electric Scooter', 'Walking / Trekking', 'Animal-drawn Carriage'],
                        'Tourist': ['Hop-on Hop-off Bus', 'Shikara Ride', 'Rickshaw Safari', 'Vintage Car'],
                        'Group': ['Private Charter Bus', 'Corporate Shuttle', 'Mini-Van'],
                        'Special': ['Ambulance / Medical', 'Emergency Evacuation', 'Para-Transit']
                    };

                    function updateTransportTypes() {
                        const cat = document.getElementById('transportCategory').value;
                        const typeSelect = document.getElementById('transportType');
                        const savedType = typeSelect.getAttribute('data-saved');
                        typeSelect.innerHTML = '<option value="">Select Type</option>';
                        if (cat && transportDataCurated[cat]) {
                            transportDataCurated[cat].forEach(t => {
                                const opt = document.createElement('option');
                                opt.value = t;
                                opt.innerText = t;
                                if (t === savedType) opt.selected = true;
                                typeSelect.appendChild(opt);
                            });
                        }
                    }

                    $(document).ready(function () {
                        updateStayTypes();
                        updateTransportTypes();
                        updateSubCategories(true);
                    });

                    function updateSubCategories(isFirst = false) {
                        const checked = Array.from(document.querySelectorAll('input[name="travelerCategories"]:checked')).map(cb => cb.value);

                        // Update button text
                        const btn = document.getElementById('audienceBtn');
                        if (checked.length > 0) {
                            btn.innerText = checked.join(', ');
                        } else {
                            btn.innerText = 'Select Audience Types';
                        }

                        const list = document.getElementById('subCategoryList');
                        if (checked.length === 0) {
                            list.innerHTML = '<p class="small mb-0">Select Audience first...</p>';
                            document.getElementById('subCategoryBtn').innerText = 'Select Interests / Categories';
                            document.getElementById('subOtherInputCont').style.display = 'none';
                            return;
                        }
                        if (!list) return;

                        let allSubs = new Set();
                        checked.forEach(c => subCategories[c]?.forEach(s => allSubs.add(s)));

                        let html = '';
                        const rawSubs = '<c:out value="${trip.travelerSubCategory}" />';
                        const savedSubs = rawSubs ? rawSubs.split(', ') : [];
                        allSubs.forEach(s => {
                            const isChecked = isFirst && savedSubs.includes(s) ? 'checked' : '';
                            html += `<label class="custom-checkbox"><input type="checkbox" name="travelerSubCategories" value="${s}" ${isChecked} onchange="checkSubOther()"><span class="checkmark"></span> ${s}</label>`;
                        });
                        list.innerHTML = html;

                        if (checked.includes('Others')) {
                            document.getElementById('subOtherInputCont').style.display = 'block';
                        } else {
                            checkSubOther();
                        }
                    }

                    function checkSubOther() {
                        const checked = Array.from(document.querySelectorAll('input[name="travelerSubCategories"]:checked')).map(cb => cb.value);

                        // Update button text
                        const btn = document.getElementById('subCategoryBtn');
                        if (checked.length > 0) {
                            btn.innerText = checked.join(', ');
                        } else {
                            btn.innerText = 'Select Interests / Categories';
                        }

                        document.getElementById('subOtherInputCont').style.display = (checked.includes('Other')) ? 'block' : 'none';
                    }

                    function addDayItem(data = null, num = 1) {
                        const div = document.createElement('div');
                        div.className = 'itinerary-day';
                        div.innerHTML = `
                        <span class="day-number">Day \${num < 10 ? '0'+num : num}</span>
                        <div class="remove-day" onclick="this.parentElement.remove(); updateDayNumbers();"><i class="fa fa-trash"></i></div>
                        <div class="row">
                            <div class="col-12 mb-2"><input type="text" class="form-control day-title" value="\${data ? data.title : ''}" placeholder="Day Title" required></div>
                            <div class="col-12 mb-2"><textarea class="form-control day-activities" rows="2" placeholder="Activities...">\${data ? data.activities : ''}</textarea></div>
                            <div class="col-6"><input type="text" class="form-control day-stay" value="\${data ? data.stay : ''}" placeholder="Stay"></div>
                            <div class="col-6"><input type="text" class="form-control day-meals" value="\${data ? data.meals : ''}" placeholder="Meals"></div>
                        </div>
                    `;
                        document.getElementById('itineraryContainer').appendChild(div);
                    }

                    document.getElementById('addDayBtn').addEventListener('click', () => {
                        const count = document.querySelectorAll('.itinerary-day').length + 1;
                        addDayItem(null, count);
                    });

                    function updateDayNumbers() {
                        document.querySelectorAll('.itinerary-day').forEach((d, i) => { d.querySelector('.day-number').innerText = 'Day ' + (i + 1 < 10 ? '0' + (i + 1) : i + 1); });
                    }

                    function addCustomPickup(savedName = '', savedTime = '', savedType = 'Pickup') {
                        const id = Date.now() + Math.random().toString(36).substr(2, 9);
                        const html = `
                        <div class="row g-2 align-items-center mb-3 p-3 bg-dark rounded-3 border border-secondary border-opacity-10 pickup-item" id="row_${id}">
                            <div class="col-md-5">
                                <label class="small text-white-50 d-block mb-1">Location Name</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-dark border-secondary border-opacity-20 text-orange"><i class="fa fa-map-marker"></i></span>
                                    <input type="text" class="form-control pickup-name" value="${savedName}" placeholder="e.g. Silk Board" required>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label class="small text-white-50 d-block mb-1">Time</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-dark border-secondary border-opacity-20 text-white-50"><i class="fa fa-clock-o"></i></span>
                                    <input type="time" class="form-control pickup-time" value="${savedTime}" required>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label class="small text-white-50 d-block mb-1">Point Type</label>
                                <select class="form-control form-control-sm pickup-type bg-dark border-secondary border-opacity-20 text-white">
                                    <option value="Pickup" \${savedType === 'Pickup' ? 'selected' : ''}>Pickup Point</option>
                                    <option value="Drop" \${savedType === 'Drop' ? 'selected' : ''}>Drop Point</option>
                                    <option value="Meeting" \${savedType === 'Meeting' ? 'selected' : ''}>Meeting Point</option>
                                </select>
                            </div>
                            <div class="col-md-1 text-end">
                                <button type="button" class="btn btn-link text-danger p-0 mt-3" onclick="$(this).closest('.row').remove()">
                                    <i class="fa fa-trash-o fa-lg"></i>
                                </button>
                            </div>
                        </div>`;
                        $('#selectedPickupTimes').append(html);
                    }

                    function setPricingType(val, el) {
                        $('.pricing-toggle').removeClass('active'); $(el).addClass('active');
                        $('#pricingTypeInput').val(val);
                    }
                    function setScheduleMode(m, el) {
                        $('.pricing-toggle').removeClass('active'); $(el).addClass('active');
                        $('#scheduleModeInput').val(m);
                        document.getElementById('specificDatesCont').style.display = (m === 'specific') ? 'block' : 'none';
                    }
                    function addOccurrence(data = null) {
                        const today = new Date().toISOString().split('T')[0];
                        const id = Date.now() + Math.random();
                        const html = `<div class="occ-card animate__animated animate__fadeInUp" id="occ_\${id}">
                                    <div class="row g-3 align-items-end">
                                        <div class="col-md-4">
                                            <label class="small text-white-50 mb-1">Departure Date <span class="text-danger">*</span></label>
                                            <div class="input-group input-group-sm">
                                                <span class="input-group-text bg-dark border-secondary border-opacity-10 text-white-50"><i class="fa fa-calendar"></i></span>
                                                <input type="date" class="form-control occ-date" value="\${data ? data.date : ''}" min="\${today}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="small text-white-50 mb-1">Time</label>
                                            <div class="input-group input-group-sm">
                                                <span class="input-group-text bg-dark border-secondary border-opacity-10 text-white-50"><i class="fa fa-clock-o"></i></span>
                                                <input type="time" class="form-control occ-time" value="\${data ? data.time : ''}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="small text-white-50 mb-1">Capacity</label>
                                            <div class="input-group input-group-sm">
                                                <span class="input-group-text bg-dark border-secondary border-opacity-10 text-white-50"><i class="fa fa-users"></i></span>
                                                <input type="number" class="form-control occ-seats" value="\${data ? data.seats : 20}">
                                            </div>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <button type="button" class="btn btn-sm btn-outline-danger border-0" onclick="$('#occ_\${id}').remove()">
                                                <i class="fa fa-trash-o fa-lg"></i>
                                            </button>
                                        </div>
                                    </div>
                                  </div>`;
                        $('#occurrenceContainer').append(html);
                    }

                    document.getElementById('regForm').addEventListener('submit', function (e) {
                        // Capture JSONs
                        const days = [];
                        document.querySelectorAll('.itinerary-day').forEach(d => {
                            days.push({ day: d.querySelector('.day-number').innerText, title: d.querySelector('.day-title').value, activities: d.querySelector('.day-activities').value, stay: d.querySelector('.day-stay').value, meals: d.querySelector('.day-meals').value });
                        });
                        document.getElementById('itineraryJson').value = JSON.stringify(days);

                        // Pickups
                        const pickups = [];
                        document.querySelectorAll('.pickup-item').forEach(p => {
                            pickups.push({
                                name: p.querySelector('.pickup-name').value,
                                time: p.querySelector('.pickup-time').value,
                                type: p.querySelector('.pickup-type').value
                            });
                        });
                        document.getElementById('pickupPointsJson').value = JSON.stringify(pickups);

                        // Amenities & Safety
                        const amenities = Array.from(document.querySelectorAll('.stay-amenity:checked')).map(c => c.value);
                        document.getElementById('stayAmenitiesJson').value = JSON.stringify(amenities);

                        if ($('#scheduleModeInput').val() === 'specific') {
                            const scheds = [];
                            document.querySelectorAll('.occ-card').forEach(o => {
                                scheds.push({ date: o.querySelector('.occ-date').value, time: o.querySelector('.occ-time').value, seats: o.querySelector('.occ-seats').value });
                            });
                            document.getElementById('schedulesJson').value = JSON.stringify(scheds);
                        }
                    });

                    // Prevent dropdown close on checkbox click
                    $(document).on('click', '.dropdown-menu', function (e) {
                        e.stopPropagation();
                    });

                    function toggleSidebar() { $('.sidebar').toggleClass('show'); $('.sidebar-overlay').toggleClass('show'); }
                    function toggleCustomPolicy(v) { document.getElementById('customPolicyCont').style.display = (v === 'Custom') ? 'block' : 'none'; }

                    function toggleOtherInput(checkId, contId) {
                        const check = document.getElementById(checkId);
                        if (check) document.getElementById(contId).style.display = check.checked ? 'block' : 'none';
                    }

                    function checkSubOther() {
                        const checked = Array.from(document.querySelectorAll('input[name="travelerSubCategories"]:checked')).map(cb => cb.value);
                        document.getElementById('subOtherInputCont').style.display = (checked.includes('Others')) ? 'block' : 'none';
                    }

                    function previewMedia(input, id) {
                        const preview = document.getElementById(id);
                        preview.innerHTML = '';
                        if (input.files) {
                            [...input.files].forEach(file => {
                                const reader = new FileReader();
                                reader.onload = e => {
                                    const div = document.createElement('div');
                                    div.style = "width: 50px; height: 50px; border-radius: 8px; overflow: hidden; border: 1px solid rgba(255,255,255,0.1);";
                                    if (file.type.startsWith('image/')) {
                                        div.innerHTML = `<img src="${e.target.result}" style="width:100%; height:100%; object-fit:cover;">`;
                                    } else {
                                        div.innerHTML = `<div style="width:100%; height:100%; background:#000; display:flex; align-items:center; justify-content:center;"><i class="fa fa-play text-primary"></i></div>`;
                                    }
                                    preview.appendChild(div);
                                }
                                reader.readAsDataURL(file);
                            });
                        }
                    }
                </script>
            </body>

            </html>