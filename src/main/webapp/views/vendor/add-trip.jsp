<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Add New Trip | Youth Travel</title>
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

                .inclusion-chip {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    padding: 8px 16px;
                    border-radius: 10px;
                    margin-right: 10px;
                    margin-bottom: 10px;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .inclusion-chip.active {
                    background: rgba(34, 197, 94, 0.1);
                    border-color: #22c55e;
                    color: #22c55e;
                }

                .exclusion-chip.active {
                    background: rgba(239, 68, 68, 0.1);
                    border-color: #ef4444;
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
        <jsp:param name="activePage" value="add-trip" />
    </jsp:include>

    <div class="main-content">
                <div class="mobile-header">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" height="24">
                    <div class="menu-toggle" onclick="toggleSidebar()">
                        <i class="fa fa-bars"></i>
                    </div>
                </div>
                <div style="margin-bottom: 35px;">
                    <h1 style="font-weight: 800; font-size: 32px;">Create New Adventure</h1>
                    <p style="color: rgba(255,255,255,0.5);">List your professional trip on the Youth Travel platform.
                    </p>
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

                <form action="<c:url value='/vendor/add-trip'/>" id="regForm" method="post"
                    enctype="multipart/form-data">
                    <div class="form-card">

                        <!-- STEP 1: BASIC INFO -->
                        <div class="form-step active" id="step1">
                            <div class="section-title"><span class="badge">01</span> CORE TRIP DETAILS</div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Trip Title <span class="text-danger">*</span></label>
                                        <input type="text" name="title" class="form-control"
                                            placeholder="e.g. Kedarkantha Winter Trek" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Destination <span class="text-danger">*</span></label>
                                        <input type="text" name="destination" class="form-control"
                                            placeholder="e.g. Uttarakhand, India" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Traveler Type (Audience)</label>
                                        <div class="dropdown">
                                            <button id="audienceBtn" class="form-control text-start select-custom"
                                                type="button" data-toggle="dropdown" aria-expanded="false"
                                                style="text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                Select Audience Types
                                            </button>
                                            <div class="dropdown-menu p-3 bg-dark border-secondary w-100"
                                                style="background: #1a1f2b; min-width: 250px; max-height: 300px; overflow-y: auto;">
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Solo"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Solo Travelers</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Group"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Group / Friends</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Corporate"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Corporate / Team</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Adventure"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Adventure</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Bike Riding"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Bike Riding</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Nature Exploration"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Nature Exploration</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Water Activities"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Water Activities</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Workation"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Workation / Digital Nomad</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Festivals"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Festivals & Events</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Volunteering"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Volunteering</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Nightlife"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Nightlife & Social</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Content Creation"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Content Creation</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Wellness"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
                                                    Wellness & Detox</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox"
                                                        name="travelerCategories" value="Budget Backpacking"
                                                        onchange="updateSubCategories()"><span class="checkmark"></span>
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
                                                placeholder="e.g., Senior Citizens, Solo Women...">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Sub-Categories (Specific Interest)</label>
                                        <div class="dropdown">
                                            <button id="subCategoryBtn" class="form-control text-start select-custom"
                                                type="button" data-toggle="dropdown"
                                                style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                Select Interests / Categories
                                            </button>
                                            <div id="subCategoryList">
                                                <p class="text-white-50 small mb-0">Select Audience first...</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="subOtherInputCont" style="display:none;" class="mt-2">
                                        <label class="small text-orange">Sub-Categories</label>
                                        <input type="text" name="travelerSubCategoryOther" class="form-control"
                                            placeholder="e.g., Photography, Yoga, Stargazing...">
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Short Summary</label>
                                        <textarea name="description" class="form-control" rows="3"
                                            placeholder="A brief, engaging overview..."></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="section-title mt-4"><span class="badge">02</span> MEDIA GALLERY</div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Add Trip Photos</label>
                                    <div onclick="document.getElementById('photoFiles').click()"
                                        class="p-4 border-2 border-dashed border-secondary rounded text-center cursor-pointer mb-2"
                                        style="border: 2px dashed rgba(240, 76, 38, 0.3); background: rgba(240, 76, 38, 0.05);">
                                        <i class="fa fa-picture-o fa-2x text-orange mb-2"></i>
                                        <div class="small">Click to Upload (Max 10)</div>
                                        <input type="file" id="photoFiles" name="photoFiles" accept="image/*" multiple
                                            class="d-none" onchange="previewMedia(this, 'photoPreview')">
                                    </div>
                                    <div id="photoPreview" class="d-flex flex-wrap gap-2"></div>
                                </div>
                                <div class="col-md-6">
                                    <label>Add Video Clip (Optional)</label>
                                    <div onclick="document.getElementById('videoFiles').click()"
                                        class="p-4 border-2 border-dashed border-secondary rounded text-center cursor-pointer mb-2"
                                        style="border: 2px dashed rgba(59, 130, 246, 0.3); background: rgba(59, 130, 246, 0.05);">
                                        <i class="fa fa-video-camera fa-2x text-primary mb-2"></i>
                                        <div class="small">Upload Highlights</div>
                                        <input type="file" id="videoFiles" name="videoFiles" accept="video/*"
                                            class="d-none" onchange="previewMedia(this, 'videoPreview')">
                                    </div>
                                    <div id="videoPreview" class="d-flex flex-wrap gap-2"></div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 2: ITINERARY & PRICING -->
                        <div class="form-step" id="step2">
                            <div class="section-title"><span class="badge">03</span> JOURNEY TIMELINE</div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Number of Days <span class="text-danger">*</span></label>
                                        <input type="number" name="days" id="tripDays" class="form-control" value="1"
                                            min="1" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Number of Nights</label>
                                        <input type="number" name="nights" class="form-control" value="0">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Duration Label</label>
                                        <input type="text" name="duration" class="form-control"
                                            placeholder="e.g. 3D / 2N">
                                    </div>
                                </div>
                            </div>

                            <div id="itineraryContainer" class="mb-3">
                                <div class="itinerary-day" data-day="1">
                                    <span class="day-number">Day 01</span>
                                    <div class="row">
                                        <div class="col-12 mb-3"><input type="text" class="form-control day-title"
                                                placeholder="Day Title (e.g. Arrival) *" required></div>
                                        <div class="col-12 mb-3"><textarea class="form-control day-activities" rows="2"
                                                placeholder="Activities..."></textarea></div>
                                        <div class="col-6"><input type="text" class="form-control day-stay"
                                                placeholder="Stay (e.g Tents)"></div>
                                        <div class="col-6"><input type="text" class="form-control day-meals"
                                                placeholder="Meals (e.g BK, L, D)"></div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" id="addDayBtn" class="btn btn-outline-orange w-100 mb-4"
                                style="border-style: dashed;"><i class="fa fa-plus-circle"></i> Add Next Day</button>
                            <input type="hidden" name="itinerary" id="itineraryJson">

                            <div class="section-title mt-4"><span class="badge">04</span> PRICING CONFIG</div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Price Model</label>
                                    <div class="d-flex gap-2 mb-3">
                                        <div class="pricing-toggle active w-100 text-center"
                                            onclick="setPricingType('perPerson', this)"><i class="fa fa-user"></i> Per
                                            Person</div>
                                        <div class="pricing-toggle w-100 text-center"
                                            onclick="setPricingType('perGroup', this)"><i class="fa fa-users"></i> Per
                                            Group</div>
                                        <input type="hidden" name="pricingType" id="pricingTypeInput" value="perPerson">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label id="mainPriceLabel">Adult Price (₹) <span
                                                class="text-danger">*</span></label>
                                        <input type="number" name="price" class="form-control" required>
                                        <input type="hidden" name="adultPrice" id="hiddenAdultPrice">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group"><label>Weekend Price (₹)</label><input type="number"
                                            name="weekendPrice" class="form-control"></div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group"><label>Group Discount (%)</label><input type="number"
                                            name="groupDiscount" class="form-control"></div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 3: SCHEDULING & LOGISTICS -->
                        <div class="form-step" id="step3">
                            <div class="section-title"><span class="badge">05</span> AVAILABILITY WINDOW</div>
                            <div class="d-flex gap-2 mb-4">
                                <div class="pricing-toggle active w-100 text-center"
                                    onclick="setScheduleMode('specific', this)"><i class="fa fa-calendar"></i> Specific
                                    Dates</div>
                                <div class="pricing-toggle w-100 text-center"
                                    onclick="setScheduleMode('recurring', this)">
                                    <i class="fa fa-refresh"></i> Weekly
                                    Recurring
                                </div>
                                <input type="hidden" name="scheduleMode" id="scheduleModeInput" value="specific">
                            </div>

                            <div id="specificDatesCont">
                                <div id="occurrenceContainer"></div>
                                <button type="button" onclick="addOccurrence()"
                                    class="btn btn-outline-orange w-100 mb-3"
                                    style="border-style: dashed; background: rgba(240, 76, 38, 0.05);"><i
                                        class="fa fa-plus-circle"></i> Add Departure Date</button>
                            </div>

                            <div id="recurringCont" style="display:none;"
                                class="p-4 bg-dark-subtle rounded-4 mb-4 border border-secondary border-opacity-10">
                                <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Select
                                    Departure
                                    Days</label>
                                <div class="day-chip-group mb-4">
                                    <label class="day-chip"><input type="checkbox" name="recurringDays"
                                            value="MONDAY"><span class="chip-label">Mon</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays"
                                            value="TUESDAY"><span class="chip-label">Tue</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays"
                                            value="WEDNESDAY"><span class="chip-label">Wed</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays"
                                            value="THURSDAY"><span class="chip-label">Thu</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays"
                                            value="FRIDAY"><span class="chip-label">Fri</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays"
                                            value="SATURDAY"><span class="chip-label">Sat</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays"
                                            value="SUNDAY"><span class="chip-label">Sun</span></label>
                                </div>
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label class="small text-white-50 mb-1">Valid Until</label>
                                        <input type="date" name="recEndDate" id="recEndDate" class="form-control">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="small text-white-50 mb-1">Start Time</label>
                                        <input type="time" name="recStartTime" class="form-control">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="small text-white-50 mb-1">Batch Size</label>
                                        <input type="number" name="recTotalSeats" class="form-control"
                                            placeholder="Seats (e.g. 20)">
                                    </div>
                                </div>
                            </div>

                            <div class="section-title mt-4"><span class="badge">06</span> PICKUP & LOGISTICS</div>
                            <div class="p-4 bg-dark-subtle rounded-4 mb-4 border border-secondary border-opacity-10">
                                <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Dynamic Pickup
                                    &
                                    Drop Points</label>

                                <div id="selectedPickupTimes" class="mb-3">
                                    <!-- Dynamic rows go here -->
                                </div>

                                <button type="button" onclick="addCustomPickup()" class="btn btn-outline-orange btn-sm"
                                    style="border-style: dashed; background: rgba(240, 76, 38, 0.05);">
                                    <i class="fa fa-plus-circle"></i> Add New Point
                                </button>
                                <input type="hidden" name="pickupPoints" id="pickupPointsJson">
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <label>Transport Category</label>
                                    <select name="transportCategory" id="transportCategory"
                                        class="form-control select-custom" onchange="updateTransportTypes()">
                                        <option value="">Select Category</option>
                                        <option value="Road">Road Transport 🛣️</option>
                                        <option value="Rail">Rail Transport 🚆</option>
                                        <option value="Air">Air Transport ✈️</option>
                                        <option value="Water">Water Transport 🚢</option>
                                        <option value="Adventure">Adventure & Terrain 🏔️</option>
                                        <option value="Cable">Cable & Lift 🚠</option>
                                        <option value="Eco">Eco-Friendly 🌱</option>
                                        <option value="Tourist">Tourist-Specific 🏝️</option>
                                        <option value="Group">Corporate / Group 🏢</option>
                                        <option value="Special">Special Services 🎯</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Transport Type</label>
                                    <select name="transportType" id="transportType" class="form-control select-custom">
                                        <option value="">Select Type</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-4">
                                    <label>Stay Category</label>
                                    <select name="stayCategory" id="stayCategory" class="form-control select-custom"
                                        onchange="updateStayTypes()">
                                        <option value="">Select Category</option>
                                        <option value="Hotels">🏢 Hotels</option>
                                        <option value="Resorts">🏝️ Resorts</option>
                                        <option value="Homestays">🧑‍🤝‍🧑 Homestays</option>
                                        <option value="Camping">🏕️ Camping</option>
                                        <option value="Unique">💎 Unique Stays</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label>Stay Type</label>
                                    <select name="stayType" id="stayType" class="form-control select-custom">
                                        <option value="">Select Type</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label>Stay Variant</label>
                                    <select name="stayVariant" id="stayVariant" class="form-control select-custom">
                                        <option value="Standard">Standard Room</option>
                                        <option value="Premium">Premium / Deluxe</option>
                                        <option value="Luxury">Luxury / Suite</option>
                                        <option value="Private">Private / Entire Place</option>
                                        <option value="Shared">Shared / Dormitory</option>
                                        <option value="Tent">Tent (Single/Double)</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label>Room Sharing</label>
                                    <select name="roomSharing" class="form-control select-custom">
                                        <option value="Not Applicable">N/A</option>
                                        <option value="2 sharing">2 sharing</option>
                                        <option value="3 sharing">3 sharing</option>
                                        <option value="Dormitory">Dormitory</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 4: POLICIES & FINAL -->
                        <div class="form-step" id="step4">
                            <div class="section-title"><span class="badge">07</span> SAFETY & AMENITIES</div>

                            <div class="row g-4 mb-4">
                                <!-- CORE SAFETY -->
                                <div class="col-md-12">
                                    <div
                                        class="p-4 bg-dark-subtle rounded-4 border border-secondary border-opacity-10 h-100">
                                        <h6 class="text-orange mb-3"><i class="fa fa-shield"></i> Core Safety</h6>
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
                            <input type="hidden" name="stayAmenities" id="stayAmenitiesJson">

                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <label>Difficulty</label>
                                    <select name="difficulty" class="form-control select-custom">
                                        <option value="Easy">Easy</option>
                                        <option value="Moderate">Moderate</option>
                                        <option value="Hard">Hard</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Age/Fitness Limit</label>
                                    <input type="text" name="safetyRequirements" class="form-control"
                                        placeholder="e.g. basic fitness">
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <label>Target Age Group</label>
                                    <select name="ageGroup" class="form-control select-custom">
                                        <option value="All Youths">All Youths (18-35)</option>
                                        <option value="18-24">Early Youth (18-24)</option>
                                        <option value="25-35">Mid Youth (25-35)</option>
                                        <option value="30+">Mature Youth (30+)</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Student Benefits</label>
                                    <div class="form-group p-2 border border-secondary border-opacity-10 rounded">
                                        <label class="custom-checkbox small mb-0">
                                            <input type="checkbox" name="studentDiscountAvailable" value="true">
                                            <span class="checkmark"></span> Extra Student Discount Available
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="section-title mt-4"><span class="badge">08</span> TERMS & POLICIES</div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Cancellation Policy</label>
                                    <select name="cancellationPolicy" class="form-control select-custom"
                                        onchange="toggleCustomPolicy(this.value)">
                                        <option value="Flexible">Flexible (24h before)</option>
                                        <option value="Moderate">Moderate (5d before)</option>
                                        <option value="Strict">Strict (7d before)</option>
                                        <option value="Custom">Custom Policy</option>
                                    </select>
                                    <div id="customPolicyCont" style="display:none;" class="mt-2">
                                        <textarea name="customCancellation" class="form-control" rows="2"></textarea>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Booking Cut-off (Hours)</label>
                                        <input type="number" name="bookingCutoffHours" class="form-control" value="24">
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Min Travelers <span class="text-danger">*</span></label>
                                        <input type="number" name="minTravelers" class="form-control" value="1"
                                            required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Batch Capacity <span class="text-danger">*</span></label>
                                        <input type="number" name="maxTravelers" class="form-control" value="20"
                                            required>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="p-3 border border-warning rounded"
                                        style="background: rgba(255,193,7,0.05);">
                                        <label class="custom-checkbox"><input type="checkbox" name="customizable"
                                                value="true"><span class="checkmark"></span> Allow travelers to request
                                            customization for this trip.</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- HIDDEN DATA CAPTURE -->
                        <input type="hidden" name="itinerary" id="itineraryJson">
                        <input type="hidden" name="pickupPoints" id="pickupPointsJson">
                        <input type="hidden" name="stayAmenities" id="stayAmenitiesJson">
                        <input type="hidden" name="mealsConfig" id="mealsConfigJson">
                        <input type="hidden" name="schedulesJson" id="schedulesJson">

                        <!-- WIZARD FOOTER -->
                        <div class="d-flex justify-content-between mt-5 pt-4 border-top border-secondary">
                            <button type="button" class="btn btn-prev" id="prevBtn"
                                onclick="nextPrev(-1)">Previous</button>
                            <div class="d-flex gap-2">
                                <button type="button" class="btn-submit" id="nextBtn" onclick="nextPrev(1)">Next
                                    Step</button>
                                <button type="submit" class="btn-submit d-none" id="launchBtn">Launch Adventure</button>
                            </div>
                        </div>

                    </div>
                </form>
            </div>

            <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
            <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
            <script>
                // Multi-step Wizard Logic
                let currentStep = 0;
                const todayStr = new Date().toISOString().split('T')[0];
                document.getElementById('recEndDate')?.setAttribute('min', todayStr);
                showStep(currentStep);

                function showStep(n) {
                    const steps = document.getElementsByClassName("form-step");
                    steps[n].classList.add("active");

                    // Buttons
                    document.getElementById("prevBtn").style.display = (n == 0) ? "none" : "inline";
                    if (n == (steps.length - 1)) {
                        document.getElementById("nextBtn").classList.add("d-none");
                        document.getElementById("launchBtn").classList.remove("d-none");
                    } else {
                        document.getElementById("nextBtn").classList.remove("d-none");
                        document.getElementById("launchBtn").classList.add("d-none");
                    }

                    // Indicators
                    updateIndicators(n);
                }

                function nextPrev(n) {
                    const steps = document.getElementsByClassName("form-step");

                    // Validation (Basic)
                    if (n == 1 && !validateStep()) return false;

                    steps[currentStep].classList.remove("active");
                    currentStep += n;

                    showStep(currentStep);
                    window.scrollTo(0, 0);
                }

                function updateIndicators(n) {
                    const indicators = document.getElementsByClassName("step-item");
                    for (let i = 0; i < indicators.length; i++) {
                        indicators[i].classList.remove("active", "completed");
                        if (i < n) indicators[i].classList.add("completed");
                        if (i == n) indicators[i].classList.add("active");
                    }
                }

                function validateStep() {
                    const activeStep = document.getElementsByClassName("form-step")[currentStep];
                    const inputs = activeStep.querySelectorAll("input[required]");
                    for (let input of inputs) {
                        if (!input.value) {
                            input.classList.add("is-invalid");
                            alert("Please fill in all required fields marked with *");
                            return false;
                        }
                        input.classList.remove("is-invalid");
                    }
                    return true;
                }

                // Sub-categories Mapping
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

                const transportData = {
                    'Road': ['Hatchback Car', 'Sedan Car', 'SUV / MUV', 'Luxury Car', 'Self-Drive Car', 'Chauffeur-driven Car', 'Bike / Motorcycle', 'Scooter', 'Auto Rickshaw', 'Taxi / Cab', 'Mini Bus', 'Bus (Non-AC/AC/Sleeper)', 'Tempo Traveller', 'Caravan / Camper Van'],
                    'Rail': ['Passenger Train', 'Express Train', 'Superfast Train', 'Metro Rail', 'Monorail', 'Tram', 'Luxury Train'],
                    'Air': ['Economy Class Flight', 'Business Class Flight', 'First Class Flight', 'Domestic Flight', 'International Flight', 'Charter Flight', 'Private Jet', 'Helicopter Transfer', 'Seaplane'],
                    'Water': ['Ferry', 'Cruise (Budget / Luxury)', 'River Cruise', 'Houseboat', 'Yacht', 'Speed Boat', 'Catamaran', 'Canoe / Kayak'],
                    'Adventure': ['4x4 Off-road Jeep', 'ATV (All-Terrain Vehicle)', 'Snowmobile', 'Dog Sled', 'Camel Safari', 'Horse Riding', 'Elephant Safari', 'Sand Dune Buggy'],
                    'Cable': ['Cable Car', 'Ropeway', 'Gondola Lift', 'Chair Lift', 'Funicular Railway'],
                    'Eco': ['Bicycle', 'E-Bike', 'Electric Scooter', 'Electric Car', 'Solar Boat'],
                    'Tourist': ['Hop-On Hop-Off Bus', 'Sightseeing Coach', 'Tourist Mini Train', 'Golf Cart', 'Airport Shuttle', 'Hotel Transfer'],
                    'Group': ['Staff Bus', 'Conference Shuttle', 'Luxury Coach', 'Group Van'],
                    'Special': ['Ambulance Transport', 'VIP Convoy', 'Wedding Transport', 'Event Shuttle', 'Luggage Transport']
                };

                const stayData = {
                    'Hotels': ['Budget Hotel', 'Standard Hotel', 'Premium Hotel', 'Luxury Hotel (4★/5★)', 'Boutique Hotel', 'Business Hotel', 'Airport Hotel', 'Extended Stay Hotel', 'Heritage Hotel', 'Capsule Hotel', 'Pod Hotel', 'Day Use Hotel', 'Transit Hotel', 'Railway Retiring Room'],
                    'Resorts': ['Beach Resort', 'Hill Resort', 'Island Resort', 'Jungle Resort', 'Spa Resort', 'Golf Resort', 'Ski Resort', 'Desert Resort', 'Spa & Wellness Resort', 'Eco-Resort'],
                    'Homestays': ['Entire Apartment', 'Serviced Apartment', 'Studio Apartment', 'Villa (Private/Shared)', 'Bungalow', 'Holiday Home', 'Farmhouse', 'Homestay (Hosted)', 'Homestay (Unhosted)', 'Paying Guest (PG)', 'Cultural Stay', 'Rural Stay', 'Hostel', 'Backpacker Hostel', 'Dormitory', 'Guest House', 'Lodge', 'Dharamshala'],
                    'Camping': ['Tent Camping', 'Glamping (Luxury Tent)', 'Desert Camp', 'Riverside Camp', 'Mountain Camp', 'Base Camp (Trekking)', 'Forest Camp'],
                    'Unique': ['Palace Stay', 'Castle Stay', 'Houseboat', 'Yacht Stay', 'Overwater Villa', 'Igloo / Ice Hotel', 'Floating Hotel', 'Glass Dome Stay', 'Sky Villa', 'Eco Lodge', 'Treehouse', 'Bamboo Hut', 'Mud House', 'Cave Stay', 'Mountain Hut', 'Alpine Lodge', 'Ski Chalet', 'Remote Cabin', 'Off-grid Stay', 'Yoga Retreat', 'Meditation Retreat', 'Ayurveda Resort', 'Spiritual Ashram']
                };

                function updateStayTypes() {
                    const cat = document.getElementById('stayCategory').value;
                    const typeSelect = document.getElementById('stayType');
                    typeSelect.innerHTML = '<option value="">Select Type</option>';
                    if (cat && stayData[cat]) {
                        stayData[cat].forEach(t => {
                            const opt = document.createElement('option');
                            opt.value = t;
                            opt.innerText = t;
                            typeSelect.appendChild(opt);
                        });
                    }
                }

                function updateTransportTypes() {
                    const cat = document.getElementById('transportCategory').value;
                    const typeSelect = document.getElementById('transportType');
                    typeSelect.innerHTML = '<option value="">Select Type</option>';
                    if (cat && transportData[cat]) {
                        transportData[cat].forEach(t => {
                            const opt = document.createElement('option');
                            opt.value = t;
                            opt.innerText = t;
                            typeSelect.appendChild(opt);
                        });
                    }
                }

                function updateSubCategories() {
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
                        list.innerHTML = '<p class="text-white-50 small mb-0">Select Audience type first...</p>';
                        // Reset sub-category button too
                        document.getElementById('subCategoryBtn').innerText = 'Select Interests / Categories';
                        document.getElementById('subOtherInputCont').style.display = 'none';
                        return;
                    }

                    let allSubs = new Set();
                    checked.forEach(c => subCategories[c]?.forEach(s => allSubs.add(s)));

                    let html = '';
                    allSubs.forEach(s => {
                        html += `
                            <label class="custom-checkbox"><input type="checkbox" name="travelerSubCategories" value="\${s}" onchange="checkSubOther()"><span class="checkmark"></span> \${s}</label>
                        `;
                    });
                    list.innerHTML = html;

                    // AUTO-SHOW Sub-Category Other if Audience Category 'Others' is picked
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

                function toggleOtherInput(checkId, contId) {
                    const check = document.getElementById(checkId);
                    document.getElementById(contId).style.display = check.checked ? 'block' : 'none';
                }

                // Media Preview
                function previewMedia(input, previewId) {
                    const preview = document.getElementById(previewId);
                    preview.innerHTML = '';
                    if (input.files) {
                        [...input.files].forEach(file => {
                            const reader = new FileReader();
                            reader.onload = e => {
                                const div = document.createElement('div');
                                div.style = "width: 50px; height: 50px; border-radius: 8px; overflow: hidden; border: 1px solid rgba(255,255,255,0.1);";
                                if (file.type.startsWith('image/')) {
                                    div.innerHTML = `<img src="\${e.target.result}" style="width:100%; height:100%; object-fit:cover;">`;
                                } else {
                                    div.innerHTML = `<div style="width:100%; height:100%; background:#000; display:flex; align-items:center; justify-content:center;"><i class="fa fa-play text-primary"></i></div>`;
                                }
                                preview.appendChild(div);
                            }
                            reader.readAsDataURL(file);
                        });
                    }
                }

                // Itinerary Logic
                let dayCount = 1;
                document.getElementById('addDayBtn').addEventListener('click', () => {
                    const max = parseInt(document.getElementById('tripDays').value) || 0;
                    const current = document.querySelectorAll('.itinerary-day').length;
                    if (current >= max) { alert("Reached max days based on trip duration."); return; }

                    dayCount++;
                    const div = document.createElement('div');
                    div.className = 'itinerary-day';
                    div.innerHTML = `
                        <span class="day-number">Day \${dayCount < 10 ? '0' + dayCount : dayCount}</span>
                        <div class="remove-day" onclick="this.parentElement.remove(); updateDayNumbers();"><i class="fa fa-trash"></i></div>
                        <div class="row">
                            <div class="col-12 mb-3"><input type="text" class="form-control day-title" placeholder="Day Title" required></div>
                            <div class="col-12 mb-3"><textarea class="form-control day-activities" rows="2" placeholder="Activities..."></textarea></div>
                            <div class="col-6"><input type="text" class="form-control day-stay"></div>
                            <div class="col-6"><input type="text" class="form-control day-meals"></div>
                        </div>
                    `;
                    document.getElementById('itineraryContainer').appendChild(div);
                });

                function updateDayNumbers() {
                    const days = document.querySelectorAll('.itinerary-day');
                    dayCount = days.length;
                    days.forEach((d, i) => { d.querySelector('.day-number').innerText = 'Day ' + (i + 1 < 10 ? '0' + (i + 1) : i + 1); });
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

                // Pricing & Modes
                function setPricingType(val, el) {
                    $('.pricing-toggle').removeClass('active');
                    $(el).addClass('active');
                    $('#pricingTypeInput').val(val);
                    $('#mainPriceLabel').text((val === 'perGroup') ? 'Group Price (₹)' : 'Adult Price (₹)');
                    if (val === 'perGroup') $('#childPriceCont').fadeOut(); else $('#childPriceCont').fadeIn();
                }
                function syncMainPrice(v) { $('#hiddenAdultPrice').val(v); }
                $(document).ready(function () {
                    $('input[name="price"]').on('input', function () { syncMainPrice($(this).val()); });
                });
                function setScheduleMode(m, el) {
                    $('.pricing-toggle').removeClass('active'); $(el).addClass('active');
                    $('#scheduleModeInput').val(m);
                    if (m === 'recurring') { $('#recurringCont').show(); $('#specificDatesCont').hide(); }
                    else { $('#recurringCont').hide(); $('#specificDatesCont').show(); }
                }
                function addOccurrence() {
                    const today = new Date().toISOString().split('T')[0];
                    const id = Date.now();
                    const html = `<div class="occ-card animate__animated animate__fadeInUp" id="occ_\${id}">
                                    <div class="row g-3 align-items-end">
                                        <div class="col-md-4">
                                            <label class="small text-white-50 mb-1">Departure Date <span class="text-danger">*</span></label>
                                            <div class="input-group input-group-sm">
                                                <span class="input-group-text bg-dark border-secondary border-opacity-10 text-white-50"><i class="fa fa-calendar"></i></span>
                                                <input type="date" class="form-control occ-date" min="\${today}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="small text-white-50 mb-1">Time</label>
                                            <div class="input-group input-group-sm">
                                                <span class="input-group-text bg-dark border-secondary border-opacity-10 text-white-50"><i class="fa fa-clock-o"></i></span>
                                                <input type="time" class="form-control occ-time">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="small text-white-50 mb-1">Capacity</label>
                                            <div class="input-group input-group-sm">
                                                <span class="input-group-text bg-dark border-secondary border-opacity-10 text-white-50"><i class="fa fa-users"></i></span>
                                                <input type="number" class="form-control occ-seats" placeholder="Seats" value="20">
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

                // Final Data Capture
                document.getElementById('regForm').addEventListener('submit', function (e) {
                    // Itinerary
                    const days = [];
                    document.querySelectorAll('.itinerary-day').forEach(d => {
                        days.push({
                            day: d.querySelector('.day-number').innerText,
                            title: d.querySelector('.day-title').value,
                            activities: d.querySelector('.day-activities').value,
                            stay: d.querySelector('.day-stay').value,
                            meals: d.querySelector('.day-meals').value
                        });
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

                    // Other Lists
                    const getChecked = (cls) => JSON.stringify(Array.from(document.querySelectorAll(cls + ':checked')).map(c => c.value));
                    document.getElementById('stayAmenitiesJson').value = getChecked('.stay-amenity');
                    document.getElementById('mealsConfigJson').value = getChecked('.meal-check');

                    // Schedules
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

                function updateTransportTypes() {
                    const category = document.getElementById('transportCategory').value;
                    const typeSelect = document.getElementById('transportType');
                    const types = {
                        'Road': ['Hatchback Car', 'Sedan Car', 'SUV / MUV', 'Luxury Car', 'Self-Drive Car', 'Chauffeur-driven Car', 'Bike / Motorcycle', 'Scooter', 'Auto Rickshaw', 'Taxi / Cab', 'Mini Bus', 'Bus (Non-AC / AC / Sleeper / Volvo)', 'Tempo Traveller', 'Caravan / Camper Van'],
                        'Rail': ['Passenger Train', 'Express Train', 'Superfast Train', 'Metro Rail', 'Monorail', 'Tram', 'Luxury Train'],
                        'Air': ['Economy Class Flight', 'Business Class Flight', 'First Class Flight', 'Domestic Flight', 'International Flight', 'Charter Flight', 'Private Jet', 'Helicopter Transfer', 'Seaplane'],
                        'Water': ['Ferry', 'Cruise (Budget / Luxury)', 'River Cruise', 'Houseboat', 'Yacht', 'Speed Boat', 'Catamaran', 'Canoe / Kayak'],
                        'Adventure': ['4x4 Off-road Jeep', 'ATV (All-Terrain Vehicle)', 'Snowmobile', 'Dog Sled', 'Camel Safari', 'Horse Riding', 'Elephant Safari', 'Sand Dune Buggy'],
                        'Cable': ['Cable Car', 'Ropeway', 'Chairlift', 'Gondola Lift', 'Ski Lift'],
                        'Eco': ['Bicycle', 'Electric Scooter', 'Walking / Trekking', 'Animal-drawn Carriage'],
                        'Tourist': ['Hop-on Hop-off Bus', 'Shikara Ride', 'Rickshaw Safari', 'Vintage Car'],
                        'Group': ['Private Charter Bus', 'Corporate Shuttle', 'Mini-Van'],
                        'Special': ['Ambulance / Medical', 'Emergency Evacuation', 'Para-Transit']
                    };

                    const options = types[category] || [];
                    typeSelect.innerHTML = '<option value="">Select Type</option>';
                    options.forEach(t => {
                        const opt = document.createElement('option');
                        opt.value = t;
                        opt.textContent = t;
                        typeSelect.appendChild(opt);
                    });
                }

                function updateStayTypes() {
                    const category = document.getElementById('stayCategory').value;
                    const typeSelect = document.getElementById('stayType');
                    const types = {
                        'Hotels': ['Budget Hotel', 'Standard Hotel', 'Premium Hotel', 'Luxury Hotel (4★ / 5★)', 'Boutique Hotel', 'Business Hotel', 'Airport Hotel', 'Extended Stay Hotel', 'Heritage Hotel'],
                        'Resorts': ['Beach Resort', 'Hill Resort', 'Island Resort', 'Jungle Resort', 'Spa Resort', 'Golf Resort', 'Ski Resort', 'Desert Resort'],
                        'Homestays': ['Homestay (Hosted)', 'Homestay (Unhosted)', 'Paying Guest (PG)', 'Cultural Stay', 'Rural Stay'],
                        'Camping': ['Tented Camp', 'Glamping (Luxury Camping)', 'Alpine / High Altitude Camp', 'Riverside Camp', 'Desert Camp', 'Forest Camp', 'Survival / Bushcraft Camp'],
                        'Unique': ['Treehouse', 'Bamboo Hut', 'Mud House', 'Igloo', 'Houseboat', 'Cave Stay', 'Capsule Hotel', 'Overwater Bungalow', 'Lighthouse Stay']
                    };

                    const options = types[category] || [];
                    typeSelect.innerHTML = '<option value="">Select Type</option>';
                    options.forEach(t => {
                        const opt = document.createElement('option');
                        opt.value = t;
                        opt.textContent = t;
                        typeSelect.appendChild(opt);
                    });
                }

                function toggleSidebar() { $('.sidebar').toggleClass('show'); $('.sidebar-overlay').toggleClass('show'); }
                function toggleCustomPolicy(v) { document.getElementById('customPolicyCont').style.display = (v === 'Custom') ? 'block' : 'none'; }
            </script>
        </body>

        </html>