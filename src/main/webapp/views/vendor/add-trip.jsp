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
            <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
            <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
            <style>
                body.yt-dark {
                    background: transparent;
                    color: #fff;
                    font-family: 'Dosis', sans-serif;
                }

                .form-card {
                    background: rgba(0,0,0,0.3);
                    backdrop-filter: blur(15px);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 24px;
                    padding: 40px;
                    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
                }

                .section-title {
                    font-size: 24px;
                    font-weight: 800;
                    color: #fff;
                    margin-bottom: 35px;
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    text-shadow: 0 4px 15px rgba(0,0,0,0.8);
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
                    color: #fff;
                    font-weight: 700;
                    font-size: 15px;
                    margin-bottom: 12px;
                    display: block;
                    text-shadow: 0 2px 5px rgba(0,0,0,0.8);
                }

                .form-control {
                    background: rgba(0,0,0,0.4);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 12px;
                    color: #fff;
                    height: 50px;
                    padding: 0 16px;
                    transition: all 0.2s;
                    backdrop-filter: blur(5px);
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
                    padding-left: 35px;
                    margin-bottom: 12px;
                    cursor: pointer;
                    font-size: 14px;
                    font-weight: 600;
                    color: #ffffff !important;
                    user-select: none;
                    display: block;
                    transition: all 0.2s;
                    line-height: 20px;
                    text-shadow: 0 1px 2px rgba(0,0,0,0.5);
                }

                .custom-checkbox input {
                    position: absolute;
                    opacity: 0;
                    cursor: pointer;
                    height: 0;
                    width: 0;
                }

                .checkmark {
                    position: absolute;
                    top: 0;
                    left: 0;
                    height: 20px;
                    width: 20px;
                    background-color: rgba(255, 255, 255, 0.1);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 6px;
                    transition: all 0.2s;
                }

                .custom-checkbox:hover .checkmark {
                    background-color: rgba(255, 255, 255, 0.2);
                    border-color: #f04c26;
                }

                .custom-checkbox input:checked ~ .checkmark {
                    background-color: #f04c26;
                    border-color: #f04c26;
                    box-shadow: 0 0 10px rgba(240, 76, 38, 0.3);
                }

                .checkmark:after {
                    content: "";
                    position: absolute;
                    display: none;
                }

                .custom-checkbox input:checked ~ .checkmark:after {
                    display: block;
                }

                .custom-checkbox .checkmark:after {
                    left: 7px;
                    top: 3px;
                    width: 5px;
                    height: 10px;
                    border: solid white;
                    border-width: 0 2px 2px 0;
                    transform: rotate(45deg);
                }

                .dropdown-menu {
                    background: #1a1f2b !important;
                    border: 1px solid rgba(255,255,255,0.1) !important;
                    box-shadow: 0 15px 35px rgba(0,0,0,0.5) !important;
                    padding: 15px !important;
                }

                .dropdown-menu label:hover {
                    color: #f04c26 !important;
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
                    background: rgba(0,0,0,0.3);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 16px;
                    padding: 30px;
                    margin-bottom: 25px;
                    position: relative;
                    animation: slideDown 0.3s ease-out;
                    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
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

        <body class="yt-dark premium-theme">
        <div class="sun-rays-container">
            <div class="ray ray-1"></div>
            <div class="ray ray-2"></div>
            <div class="ray ray-3"></div>
            <div class="ray ray-4"></div>
        </div>
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
                <style>
                    .step-item { cursor: pointer; transition: all 0.3s ease; opacity: 0.7; }
                    .step-item:hover { opacity: 1; transform: translateY(-2px); }
                    .step-item.active { opacity: 1; }
                    .step-label { 
                        color: #ffffff !important; 
                        font-weight: 600; 
                        text-shadow: 0 2px 4px rgba(0,0,0,0.8); 
                        font-size: 11px;
                        margin-top: 5px;
                    }
                    .step-dot {
                        background: rgba(30, 39, 46, 0.9);
                        border: 2px solid rgba(255,255,255,0.2);
                        color: white;
                        transition: all 0.3s ease;
                    }
                    .step-item.active .step-dot {
                        background: #f04c26;
                        border-color: #f04c26;
                        box-shadow: 0 0 15px rgba(240, 76, 38, 0.5);
                    }
                    .step-item.completed .step-dot {
                        background: #2ed573;
                        border-color: #2ed573;
                    }
                    .day-image-upload {
                        border: 2px dashed rgba(255,255,255,0.1);
                        border-radius: 12px;
                        height: 100px;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        transition: 0.3s;
                        background: rgba(255,255,255,0.02);
                        color: rgba(255,255,255,0.5);
                    }
                    .day-image-upload:hover {
                        border-color: #f04c26;
                        background: rgba(240, 76, 38, 0.05);
                        color: #f04c26;
                    }
                    .day-image-preview img {
                        width: 80px;
                        height: 80px;
                        border-radius: 8px;
                        object-fit: cover;
                        border: 2px solid rgba(255,255,255,0.1);
                    }
                    .occ-card {
                        background: rgba(255,255,255,0.03);
                        border: 1px solid rgba(255,255,255,0.1);
                        border-radius: 16px;
                        padding: 20px;
                        margin-bottom: 15px;
                        transition: 0.3s;
                    }
                    .occ-card:hover {
                        border-color: rgba(240, 76, 38, 0.4);
                        background: rgba(255,255,255,0.05);
                        transform: translateX(5px);
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
                    .day-chip input { display: none; }
                    .chip-label {
                        display: block;
                        padding: 10px 18px;
                        background: rgba(255,255,255,0.05);
                        border: 1px solid rgba(255,255,255,0.1);
                        border-radius: 12px;
                        color: white;
                        font-weight: 600;
                        transition: 0.3s;
                        font-size: 13px;
                    }
                    .day-chip input:checked + .chip-label {
                        background: #f04c26;
                        border-color: #f04c26;
                        box-shadow: 0 4px 12px rgba(240, 76, 38, 0.3);
                    }
                    .occ-icon {
                        width: 35px;
                        height: 35px;
                        background: rgba(240, 76, 38, 0.1);
                        color: #f04c26;
                        border-radius: 10px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin-bottom: 10px;
                    }
                </style>
                <div class="step-indicator-container" style="overflow-x: auto; padding-bottom: 20px; margin-bottom: 30px; background: rgba(0,0,0,0.2); border-radius: 15px; padding-top: 15px;">
                    <div class="step-indicator" style="min-width: 900px; display: flex; justify-content: space-between; padding: 0 20px;">
                        <div class="step-item active" id="stepIndicator1" onclick="jumpToStep(0)"><div class="step-dot">1</div><div class="step-label">Basic</div></div>
                        <div class="step-item" id="stepIndicator2" onclick="jumpToStep(1)"><div class="step-dot">2</div><div class="step-label">Dest</div></div>
                        <div class="step-item" id="stepIndicator3" onclick="jumpToStep(2)"><div class="step-dot">3</div><div class="step-label">Time</div></div>
                        <div class="step-item" id="stepIndicator4" onclick="jumpToStep(3)"><div class="step-dot">4</div><div class="step-label">Price</div></div>
                        <div class="step-item" id="stepIndicator5" onclick="jumpToStep(4)"><div class="step-dot">5</div><div class="step-label">Stay</div></div>
                        <div class="step-item" id="stepIndicator6" onclick="jumpToStep(5)"><div class="step-dot">6</div><div class="step-label">Trans</div></div>
                        <div class="step-item" id="stepIndicator7" onclick="jumpToStep(6)"><div class="step-dot">7</div><div class="step-label">Meals</div></div>
                        <div class="step-item" id="stepIndicator8" onclick="jumpToStep(7)"><div class="step-dot">8</div><div class="step-label">Plan</div></div>
                        <div class="step-item" id="stepIndicator9" onclick="jumpToStep(8)"><div class="step-dot">9</div><div class="step-label">Media</div></div>
                        <div class="step-item" id="stepIndicator10" onclick="jumpToStep(9)"><div class="step-dot">10</div><div class="step-label">Dates</div></div>
                        <div class="step-item" id="stepIndicator11" onclick="jumpToStep(10)"><div class="step-dot">11</div><div class="step-label">Terms</div></div>
                        <div class="step-item" id="stepIndicator12" onclick="jumpToStep(11)"><div class="step-dot">12</div><div class="step-label">Review</div></div>
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
                                        <label>Traveler Type (Audience)</label>
                                        <div class="dropdown">
                                            <button id="audienceBtn" class="form-control text-start select-custom"
                                                type="button" data-toggle="dropdown" aria-expanded="false"
                                                style="text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                Select Audience Types
                                            </button>
                                            <div class="dropdown-menu p-3 bg-dark border-secondary w-100"
                                                style="background: #1a1f2b; min-width: 250px; max-height: 300px; overflow-y: auto;">
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Solo" onchange="updateSubCategories()"><span class="checkmark"></span> Solo Travelers</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Group" onchange="updateSubCategories()"><span class="checkmark"></span> Group / Friends</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Corporate" onchange="updateSubCategories()"><span class="checkmark"></span> Corporate / Team</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Adventure" onchange="updateSubCategories()"><span class="checkmark"></span> Adventure</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Bike Riding" onchange="updateSubCategories()"><span class="checkmark"></span> Bike Riding</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Nature Exploration" onchange="updateSubCategories()"><span class="checkmark"></span> Nature Exploration</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Water Activities" onchange="updateSubCategories()"><span class="checkmark"></span> Water Activities</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Workation" onchange="updateSubCategories()"><span class="checkmark"></span> Workation / Nomad</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Festivals" onchange="updateSubCategories()"><span class="checkmark"></span> Festivals & Events</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Volunteering" onchange="updateSubCategories()"><span class="checkmark"></span> Volunteering</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Nightlife" onchange="updateSubCategories()"><span class="checkmark"></span> Nightlife & Social</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Content Creation" onchange="updateSubCategories()"><span class="checkmark"></span> Content Creation</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Wellness" onchange="updateSubCategories()"><span class="checkmark"></span> Wellness & Detox</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" name="travelerCategories" value="Budget Backpacking" onchange="updateSubCategories()"><span class="checkmark"></span> Budget Backpacking</label>
                                                <label class="custom-checkbox mb-2 d-flex"><input type="checkbox" id="catOthersCheck" name="travelerCategories" value="Others" onchange="toggleOtherInput('catOthersCheck', 'catOtherInputCont'); updateSubCategories();"><span class="checkmark"></span> Others</label>
                                            </div>
                                        </div>
                                        <div id="catOtherInputCont" style="display:none;" class="mt-2">
                                            <label class="small text-orange mb-1">Custom Audience Type</label>
                                            <input type="text" name="travelerCategoryOther" class="form-control" placeholder="e.g. Senior Citizens, School Groups...">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Sub-Categories</label>
                                        <div class="dropdown">
                                            <button id="subCategoryBtn" class="form-control text-start select-custom" type="button" data-toggle="dropdown">Select Interests</button>
                                            <div id="subCategoryList" class="dropdown-menu p-3 bg-dark border-secondary w-100" style="background: #1a1f2b; max-height: 250px; overflow-y: auto;">
                                                <p class="text-white-50 small mb-0">Select Audience first...</p>
                                            </div>
                                        </div>
                                        <div id="subOtherInputCont" style="display:none;" class="mt-2">
                                            <label class="small text-orange mb-1">Custom Interest / Sub-Category</label>
                                            <input type="text" name="travelerSubCategoryOther" class="form-control" placeholder="e.g. Photography, Yoga, Stargazing...">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Short Summary</label>
                                        <textarea name="description" class="form-control" rows="3" placeholder="A brief, engaging overview..."></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 2: DESTINATION -->
                        <div class="form-step" id="step2">
                            <div class="section-title"><span class="badge">02</span> DESTINATION DETAILS</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Destination City <span class="text-danger">*</span></label>
                                        <input type="text" name="destination" class="form-control" placeholder="e.g., Manali" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>State <span class="text-danger">*</span></label>
                                        <input type="text" name="state" class="form-control" placeholder="e.g., Himachal Pradesh" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Country</label>
                                        <input type="text" name="country" class="form-control" value="India">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Origin City</label>
                                        <input type="text" name="originCity" class="form-control" placeholder="e.g., Delhi">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Origin State</label>
                                        <input type="text" name="originState" class="form-control" placeholder="e.g., Delhi">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Region</label>
                                        <select name="region" class="form-control select-custom">
                                            <option value="">Select region</option>
                                            <optgroup label="Domestic (India)">
                                                <option value="North India">North India</option>
                                                <option value="South India">South India</option>
                                                <option value="East India">East India</option>
                                                <option value="West India">West India</option>
                                                <option value="Central India">Central India</option>
                                                <option value="Northeast India">Northeast India</option>
                                            </optgroup>
                                            <optgroup label="International">
                                                <option value="Southeast Asia">Southeast Asia</option>
                                                <option value="Middle East">Middle East</option>
                                                <option value="Europe">Europe</option>
                                                <option value="North America">North America</option>
                                                <option value="South America">South America</option>
                                                <option value="Africa">Africa</option>
                                                <option value="Australia / Oceania">Australia / Oceania</option>
                                                <option value="Central Asia">Central Asia</option>
                                                <option value="East Asia">East Asia</option>
                                            </optgroup>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Covering Places (comma-separated)</label>
                                        <input type="text" name="coveringPlaces" class="form-control" placeholder="e.g., Delhi, Agra, Jaipur, Varanasi">
                                    </div>
                                </div>
                            </div>
                            <div class="p-4 bg-dark-subtle rounded-4 mb-4 mt-4 border border-secondary border-opacity-10">
                                <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Pickup & Drop Points</label>
                                <div id="selectedPickupTimes" class="mb-3"></div>
                                <button type="button" onclick="addCustomPickup()" class="btn btn-outline-orange btn-sm" style="border-style: dashed;"><i class="fa fa-plus-circle"></i> Add Point</button>
                            </div>
                        </div>

                        <!-- STEP 3: DURATION -->
                        <div class="form-step" id="step3">
                            <div class="section-title"><span class="badge">03</span> TRIP DURATION</div>
                            
                            <!-- Duration Presets -->
                            <div class="mb-4">
                                <label class="small text-white-50 d-block mb-2">Quick Select Presets</label>
                                <div class="d-flex flex-wrap gap-2">
                                    <style>
                                        .duration-preset {
                                            background: rgba(255,255,255,0.1);
                                            border: 1px solid rgba(255,255,255,0.2);
                                            color: white !important;
                                            font-weight: 500;
                                            transition: all 0.2s ease;
                                        }
                                        .duration-preset:hover {
                                            background: #f04c26;
                                            border-color: #f04c26;
                                            transform: translateY(-2px);
                                        }
                                    </style>
                                    <button type="button" class="btn btn-sm duration-preset px-3" onclick="setDuration(1, 0)">1 Day (Day Trip)</button>
                                    <button type="button" class="btn btn-sm duration-preset px-3" onclick="setDuration(2, 1)">2D/1N (Weekend)</button>
                                    <button type="button" class="btn btn-sm duration-preset px-3" onclick="setDuration(3, 2)">3D/2N</button>
                                    <button type="button" class="btn btn-sm duration-preset px-3" onclick="setDuration(5, 4)">5D/4N</button>
                                    <button type="button" class="btn btn-sm duration-preset px-3" onclick="setDuration(7, 6)">1 Week</button>
                                    <button type="button" class="btn btn-sm duration-preset px-3" onclick="setDuration(10, 9)">10 Days</button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Days <span class="text-danger">*</span></label>
                                        <input type="number" name="days" id="tripDays" class="form-control" value="1" min="1" required oninput="if(this.value < 1) this.value = 1; syncNights(this.value)">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Nights</label>
                                        <input type="number" name="nights" id="tripNights" class="form-control" value="0" min="0" oninput="if(this.value < 0) this.value = 0; updateDurationLabel()">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Duration Label</label>
                                        <input type="text" name="duration" id="durationLabel" class="form-control" placeholder="e.g. 3D / 2N">
                                        <small class="text-white-50 mt-1 d-block">Auto-generated, but you can edit.</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 4: PRICING -->
                        <div class="form-step" id="step4">
                            <div class="section-title"><span class="badge">04</span> PRICING & BOOKING OPTIONS</div>
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <label class="small text-white-50 mb-2">Price Model</label>
                                    <div class="d-flex gap-2 mb-3">
                                        <div class="pricing-toggle active w-100 text-center" onclick="setPricingType('perPerson', this)"><i class="fa fa-user"></i> Per Person</div>
                                        <div class="pricing-toggle w-100 text-center" onclick="setPricingType('perGroup', this)"><i class="fa fa-users"></i> Per Group</div>
                                        <input type="hidden" name="pricingType" id="pricingTypeInput" value="perPerson">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label id="mainPriceLabel">Base Price (₹) <span class="text-danger">*</span></label>
                                        <input type="number" name="price" class="form-control" placeholder="e.g. 5000" required>
                                        <input type="hidden" name="adultPrice" id="hiddenAdultPrice">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group" id="childPriceCont">
                                        <label>Child Price (₹)</label>
                                        <input type="number" name="childPrice" class="form-control" placeholder="Optional">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Booking Amount (₹)</label>
                                        <input type="number" name="bookingAmount" class="form-control" placeholder="Token to block seat">
                                        <small class="text-white-50">Set 0 for full payment</small>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Weekend Surcharge (Extra ₹)</label>
                                        <input type="number" name="weekendPrice" class="form-control" placeholder="e.g. 500 (Add-on)">
                                        <small class="text-white-50">Extra amount added to base price for weekend dates.</small>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Discount (%)</label>
                                        <input type="number" name="discount" class="form-control" placeholder="e.g. 10">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>GST / Taxes</label>
                                        <select name="taxStatus" class="form-control select-custom">
                                            <option value="Inclusive">Inclusive of GST</option>
                                            <option value="Exclusive">Exclusive of GST</option>
                                            <option value="NotApplicable">No GST Applicable</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="p-3 border border-secondary border-opacity-10 rounded-4 mt-2">
                                        <label class="custom-checkbox small mb-0 d-flex align-items-center">
                                            <input type="checkbox" name="studentDiscountAvailable" value="true">
                                            <span class="checkmark"></span> 
                                            <span class="ms-2">Extra Student Discount Available (Requires Valid ID)</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 5: ACCOMMODATION -->
                        <div class="form-step" id="step5">
                            <div class="section-title"><span class="badge">05</span> STAY DETAILS</div>
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Stay / Hotel Name</label>
                                        <input type="text" name="stayName" class="form-control" placeholder="e.g. Grand Orchid Resort / Multiple Stays">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label>Stay Category</label>
                                    <select name="stayCategory" id="stayCategory" class="form-control select-custom" onchange="updateStayTypes()">
                                        <option value="">Select Category</option>
                                        <option value="Hotels">🏢 Hotels</option>
                                        <option value="Resorts">🏝️ Resorts</option>
                                        <option value="Homestays">🧑‍🤝‍🧑 Homestays</option>
                                        <option value="Camping">🏕️ Camping</option>
                                        <option value="Unique">💎 Unique Stays</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Stay Type</label>
                                    <select name="stayType" id="stayType" class="form-control select-custom"><option value="">Select Type</option></select>
                                </div>
                                <div class="col-md-6">
                                    <label>Stay Variant</label>
                                    <select name="stayVariant" class="form-control select-custom">
                                        <option value="Budget">Budget</option>
                                        <option value="Standard" selected>Standard</option>
                                        <option value="Premium">Premium</option>
                                        <option value="Luxury">Luxury</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Room Sharing</label>
                                    <select name="roomSharing" class="form-control select-custom">
                                        <option value="N/A">N/A</option>
                                        <option value="Single Occupancy">Single Occupancy</option>
                                        <option value="2 sharing (Double)">2 sharing (Double)</option>
                                        <option value="3 sharing (Triple)">3 sharing (Triple)</option>
                                        <option value="4 sharing (Quad)">4 sharing (Quad)</option>
                                        <option value="Dormitory">Dormitory</option>
                                        <option value="Tent Sharing">Tent Sharing</option>
                                    </select>
                                </div>
                                <div class="col-md-12 mt-3">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Stay Amenities</label>
                                    <div class="p-4 bg-dark-subtle rounded-4 border border-secondary border-opacity-10">
                                        <div class="row g-3">
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="WiFi"><span class="checkmark"></span> WiFi</label></div>
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="Air Conditioning"><span class="checkmark"></span> AC</label></div>
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="Heater"><span class="checkmark"></span> Heater</label></div>
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="Attached Washroom"><span class="checkmark"></span> Attached Washroom</label></div>
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="Geyser / Hot Water"><span class="checkmark"></span> Geyser</label></div>
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="Swimming Pool"><span class="checkmark"></span> Pool</label></div>
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="Parking"><span class="checkmark"></span> Parking</label></div>
                                            <div class="col-md-3"><label class="custom-checkbox"><input type="checkbox" class="stay-amenity" value="CCTV Security"><span class="checkmark"></span> Security</label></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Hotel Link (Website / Google Maps)</label>
                                        <input type="url" name="stayLink" class="form-control" placeholder="https://example.com or Google Maps link">
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Additional Stay Details</label>
                                        <textarea name="stayDescription" class="form-control" rows="3" placeholder="Describe the property, view, location, or any specific rules..."></textarea>
                                    </div>
                                </div>
                                <div class="col-md-12 mt-3">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Stay Photos (Multiple)</label>
                                    <div onclick="document.getElementById('stayPhotos').click()" class="p-4 border-2 border-dashed rounded text-center cursor-pointer" style="border: 2px dashed rgba(240, 76, 38, 0.3); background: rgba(240, 76, 38, 0.02);">
                                        <i class="fa fa-university fa-2x text-orange mb-2"></i>
                                        <div class="small">Upload Stay/Hotel Photos</div>
                                        <input type="file" id="stayPhotos" name="stayPhotos" accept="image/*" multiple class="d-none" onchange="previewStayImage(this)">
                                    </div>
                                    <div id="stayPhotoPreview" class="d-flex flex-wrap gap-2 mt-2"></div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 6: TRANSPORT -->
                        <div class="form-step" id="step6">
                            <div class="section-title"><span class="badge">06</span> TRANSPORTATION</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label>Transport Category</label>
                                    <select name="transportCategory" id="transportCategory" class="form-control select-custom" onchange="updateTransportTypes()">
                                        <option value="">Select Category</option>
                                        <option value="Road">Road 🛣️</option>
                                        <option value="Rail">Rail 🚆</option>
                                        <option value="Air">Air ✈️</option>
                                        <option value="Water">Water 🚢</option>
                                        <option value="Adventure">Adventure 🚙</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Transport Type</label>
                                    <select name="transportType" id="transportType" class="form-control select-custom"><option value="">Select Type</option></select>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Vehicle Name / Model</label>
                                        <input type="text" name="vehicleName" class="form-control" placeholder="e.g. Urbania / Tempo Traveller / Force Traveler">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label>Comfort Level</label>
                                    <div class="d-flex gap-2">
                                        <label class="custom-checkbox"><input type="radio" name="acType" value="AC" checked><span class="checkmark"></span> AC</label>
                                        <label class="custom-checkbox"><input type="radio" name="acType" value="Non-AC"><span class="checkmark"></span> Non-AC</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label>Transfer Type</label>
                                    <div class="d-flex gap-2">
                                        <label class="custom-checkbox"><input type="radio" name="transferType" value="Shared" checked><span class="checkmark"></span> Shared</label>
                                        <label class="custom-checkbox"><input type="radio" name="transferType" value="Private"><span class="checkmark"></span> Private</label>
                                    </div>
                                </div>
                                <div class="col-md-12 mt-3">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Transport Inclusions</label>
                                    <div class="p-4 bg-dark-subtle rounded-4 border border-secondary border-opacity-10">
                                        <div class="row g-3">
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" name="transportInclusions" value="Fuel Charges"><span class="checkmark"></span> Fuel Charges</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" name="transportInclusions" value="Driver Allowance"><span class="checkmark"></span> Driver Allowance</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" name="transportInclusions" value="Tolls & Parking"><span class="checkmark"></span> Tolls & Parking</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" name="transportInclusions" value="State Tax"><span class="checkmark"></span> State Tax</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" name="transportInclusions" value="Airport Pickup"><span class="checkmark"></span> Airport Pickup</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" name="transportInclusions" value="Local Sightseeing"><span class="checkmark"></span> Local Sightseeing</label></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 7: MEALS & DIETARY -->
                        <div class="form-step" id="step7">
                            <div class="section-title"><span class="badge">07</span> MEALS & DIETARY</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label>Standard Meal Plan</label>
                                    <select name="mealPlan" class="form-control select-custom">
                                        <option value="EP">EP (Room Only - No Meals)</option>
                                        <option value="CP" selected>CP (Continental Plan - Breakfast Only)</option>
                                        <option value="MAP">MAP (Modified American Plan - Breakfast + Dinner)</option>
                                        <option value="AP">AP (American Plan - All Meals)</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Dietary Availability</label>
                                    <div class="d-flex gap-3 mt-2">
                                        <label class="custom-checkbox"><input type="checkbox" name="dietType" value="Veg" checked><span class="checkmark"></span> Veg</label>
                                        <label class="custom-checkbox"><input type="checkbox" name="dietType" value="Non-Veg"><span class="checkmark"></span> Non-Veg</label>
                                        <label class="custom-checkbox"><input type="checkbox" name="dietType" value="Jain"><span class="checkmark"></span> Jain</label>
                                    </div>
                                </div>
                                <div class="col-md-12 mt-3">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Inclusions & Refreshments</label>
                                    <div class="p-4 bg-dark-subtle rounded-4 border border-secondary border-opacity-10">
                                        <div class="row g-3">
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" class="meal-check" value="Breakfast" checked><span class="checkmark"></span> Breakfast</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" class="meal-check" value="Lunch"><span class="checkmark"></span> Lunch</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" class="meal-check" value="Dinner"><span class="checkmark"></span> Dinner</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" class="meal-check" value="Welcome Drink"><span class="checkmark"></span> Welcome Drink</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" class="meal-check" value="Evening Snacks"><span class="checkmark"></span> Evening Snacks</label></div>
                                            <div class="col-md-4"><label class="custom-checkbox"><input type="checkbox" class="meal-check" value="Tea / Coffee"><span class="checkmark"></span> Tea / Coffee</label></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Specific Meal Notes</label>
                                        <input type="text" name="mealNotes" class="form-control" placeholder="e.g. Local Himachali cuisine included, Buffet style...">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 8: ITINERARY -->
                        <div class="form-step" id="step8">
                            <div class="section-title"><span class="badge">08</span> ITINERARY PLAN</div>
                            <div id="itineraryContainer" class="mb-3">
                                <div class="itinerary-day" data-day="1">
                                    <span class="day-number">Day 01</span>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <div class="col-12 mb-3"><input type="text" class="form-control day-title" placeholder="Day Title (e.g. Arrival at Manali) *" required></div>
                                                <div class="col-12 mb-3"><textarea class="form-control day-activities" rows="2" placeholder="Describe activities, sightseeing, etc."></textarea></div>
                                                <div class="col-6"><div class="form-group"><label class="small text-white-50">Day Stay</label><input type="text" class="form-control day-stay" placeholder="e.g. Hotel / Camp"></div></div>
                                                <div class="col-6"><div class="form-group"><label class="small text-white-50">Day Meals</label><input type="text" class="form-control day-meals" placeholder="e.g. B + D"></div></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="small text-white-50">Day Photos (Multiple)</label>
                                            <div class="day-image-upload" onclick="this.querySelector('input').click()">
                                                <i class="fa fa-camera"></i>
                                                <span>Add Photos</span>
                                                <input type="file" class="day-photo-input d-none" accept="image/*" multiple onchange="previewDayImage(this)">
                                            </div>
                                            <div class="day-image-preview mt-2 d-flex flex-wrap gap-2"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" id="addDayBtn" class="btn btn-outline-orange w-100 mb-4" style="border-style: dashed;"><i class="fa fa-plus-circle"></i> Add Next Day</button>
                        </div>

                        <!-- STEP 9: MEDIA -->
                        <div class="form-step" id="step9">
                            <div class="section-title"><span class="badge">09</span> MEDIA GALLERY</div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Add Photos</label>
                                    <div onclick="document.getElementById('photoFiles').click()" class="p-4 border-2 border-dashed rounded text-center cursor-pointer" style="border: 2px dashed rgba(240, 76, 38, 0.3);">
                                        <i class="fa fa-picture-o fa-2x text-orange mb-2"></i>
                                        <div class="small">Upload Photos</div>
                                        <input type="file" id="photoFiles" name="photoFiles" accept="image/*" multiple class="d-none" onchange="previewMedia(this, 'photoPreview')">
                                    </div>
                                    <div id="photoPreview" class="d-flex flex-wrap gap-2 mt-2"></div>
                                </div>
                                <div class="col-md-6">
                                    <label>Add Videos</label>
                                    <div onclick="document.getElementById('videoFiles').click()" class="p-4 border-2 border-dashed rounded text-center cursor-pointer" style="border: 2px dashed rgba(59, 130, 246, 0.3);">
                                        <i class="fa fa-video-camera fa-2x text-primary mb-2"></i>
                                        <div class="small">Upload Videos</div>
                                        <input type="file" id="videoFiles" name="videoFiles" accept="video/*" multiple class="d-none" onchange="previewMedia(this, 'videoPreview')">
                                    </div>
                                    <div id="videoPreview" class="d-flex flex-wrap gap-2 mt-2"></div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 10: DEPARTURES -->
                        <div class="form-step" id="step10">
                            <div class="section-title"><span class="badge">10</span> DEPARTURE DATES</div>
                            <div class="d-flex gap-2 mb-4">
                                <div class="pricing-toggle active w-100 text-center" onclick="setScheduleMode('specific', this)"><i class="fa fa-calendar"></i> Specific</div>
                                <div class="pricing-toggle w-100 text-center" onclick="setScheduleMode('recurring', this)"><i class="fa fa-refresh"></i> Weekly</div>
                                <input type="hidden" name="scheduleMode" id="scheduleModeInput" value="specific">
                            </div>
                            <div id="specificDatesCont">
                                <div id="occurrenceContainer"></div>
                                <button type="button" onclick="addOccurrence()" class="btn btn-outline-orange w-100 mb-3" style="border-style: dashed;"><i class="fa fa-plus-circle"></i> Add Date</button>
                            </div>
                            <div id="recurringCont" style="display:none;" class="p-4 bg-dark-subtle rounded-4 mb-4 border border-secondary border-opacity-10">
                                <div class="day-chip-group mb-4">
                                    <label class="day-chip"><input type="checkbox" name="recurringDays" value="MONDAY"><span class="chip-label">Mon</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays" value="TUESDAY"><span class="chip-label">Tue</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays" value="WEDNESDAY"><span class="chip-label">Wed</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays" value="THURSDAY"><span class="chip-label">Thu</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays" value="FRIDAY"><span class="chip-label">Fri</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays" value="SATURDAY"><span class="chip-label">Sat</span></label>
                                    <label class="day-chip"><input type="checkbox" name="recurringDays" value="SUNDAY"><span class="chip-label">Sun</span></label>
                                </div>
                                <div class="row">
                                    <div class="col-md-6"><label>Until</label><input type="date" name="recEndDate" id="recEndDate" class="form-control"></div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Booking Cut-off (Hrs)</label>
                                            <input type="number" name="bookingCutoff" class="form-control" placeholder="e.g. 24" value="24">
                                            <small class="text-white-50">Stop bookings X hours before trip.</small>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Min Batch Size</label>
                                            <input type="number" name="minBatchSize" class="form-control" placeholder="e.g. 5" value="1">
                                            <small class="text-white-50">Minimum people to run the trip.</small>
                                        </div>
                                    </div>
                                    <div class="col-md-6"><label>Capacity</label><input type="number" name="recTotalSeats" class="form-control" placeholder="Seats"></div>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 11: POLICIES & PREPARATION -->
                        <div class="form-step" id="step11">
                            <div class="section-title"><span class="badge">11</span> POLICIES & PREPARATION</div>
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <label>Cancellation Policy <span class="text-danger">*</span></label>
                                    <textarea name="cancellationPolicy" class="form-control" rows="4" placeholder="Describe your cancellation tiers (e.g., 100% refund before 10 days, 50% refund before 5 days...)" required></textarea>
                                </div>
                                <div class="col-md-6">
                                    <label>Batch Capacity (Max travelers)</label>
                                    <input type="number" name="maxTravelers" class="form-control" value="20" required>
                                </div>
                                
                                <div class="col-md-6 mt-3">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">What's Included</label>
                                    <div class="p-3 bg-dark-subtle rounded-4 border border-secondary border-opacity-10">
                                        <div class="row g-2">
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="inclusions" value="Entry Fees" checked><span class="checkmark"></span> Entry Fees / Permits</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="inclusions" value="Tour Guide" checked><span class="checkmark"></span> Certified Tour Guide</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="inclusions" value="Equipment"><span class="checkmark"></span> Trekking Equipment</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="inclusions" value="Insurance"><span class="checkmark"></span> Travel Insurance</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" id="inclOthers" onchange="toggleOtherInput('inclOthers', 'inclOtherInput')"><span class="checkmark"></span> Others</label></div>
                                            <div class="col-12 mt-2" id="inclOtherInput" style="display:none;">
                                                <input type="text" name="inclusionsOther" class="form-control form-control-sm" placeholder="Specify other inclusions...">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mt-3">
                                    <label class="small text-white-50 mb-3 d-block uppercase tracking-wider">Things to Carry</label>
                                    <div class="p-3 bg-dark-subtle rounded-4 border border-secondary border-opacity-10">
                                        <div class="row g-2">
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="essentials" value="Powerbank"><span class="checkmark"></span> Powerbank & Charger</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="essentials" value="Shoes"><span class="checkmark"></span> Trekking Shoes</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="essentials" value="Raincoat"><span class="checkmark"></span> Raincoat / Poncho</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" name="essentials" value="ID Proof"><span class="checkmark"></span> Original ID Proof</label></div>
                                            <div class="col-12"><label class="custom-checkbox"><input type="checkbox" id="essOthers" onchange="toggleOtherInput('essOthers', 'essOtherInput')"><span class="checkmark"></span> Others</label></div>
                                            <div class="col-12 mt-2" id="essOtherInput" style="display:none;">
                                                <input type="text" name="essentialsOther" class="form-control form-control-sm" placeholder="Specify other essentials...">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12 mt-3">
                                    <label>Trip Rules & Instructions</label>
                                    <textarea name="tripRules" class="form-control" rows="3" placeholder="e.g. No smoking during trek, respect local culture..."></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- STEP 12: REVIEW -->
                        <div class="form-step" id="step12">
                            <div class="section-title"><span class="badge">12</span> FINAL REVIEW</div>
                            <div class="p-4 bg-dark rounded-4 border border-secondary border-opacity-20" id="reviewSummary">
                                <p class="text-white-50 mb-4">Please review all your details before launching.</p>
                                <div class="review-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 25px;">
                                    <div class="rev-item"><small class="text-orange d-block">Trip Title</small><span id="rev_title" class="fw-bold">-</span></div>
                                    <div class="rev-item"><small class="text-orange d-block">Price</small><span id="rev_price" class="fw-bold">-</span></div>
                                    <div class="rev-item"><small class="text-orange d-block">Destination</small><span id="rev_dest" class="fw-bold">-</span></div>
                                    <div class="rev-item"><small class="text-orange d-block">Duration</small><span id="rev_duration" class="fw-bold">-</span></div>
                                    
                                    <div class="rev-item"><small class="text-orange d-block">Audience</small><span id="rev_audience" class="fw-bold">-</span></div>
                                    <div class="rev-item"><small class="text-orange d-block">Categories</small><span id="rev_subs" class="fw-bold">-</span></div>
                                    
                                    <div class="rev-item"><small class="text-orange d-block">Stay</small><span id="rev_stay" class="fw-bold">-</span></div>
                                    <div class="rev-item"><small class="text-orange d-block">Transport</small><span id="rev_trans" class="fw-bold">-</span></div>
                                    <div class="rev-item"><small class="text-orange d-block">Meal Plan</small><span id="rev_meals" class="fw-bold">-</span></div>
                                    
                                    <div class="rev-item"><small class="text-orange d-block">Departure Mode</small><span id="rev_mode" class="fw-bold">-</span></div>
                                    <div class="rev-item"><small class="text-orange d-block">Min Batch</small><span id="rev_batch" class="fw-bold">-</span></div>
                                    
                                    <div class="rev-item" style="grid-column: 1 / -1;"><small class="text-orange d-block">Inclusions</small><span id="rev_inclusions" class="small text-white-50">-</span></div>
                                    <div class="rev-item" style="grid-column: 1 / -1;"><small class="text-orange d-block">Stay Photos Preview</small><div id="rev_stayPhotos" class="d-flex flex-wrap gap-2 mt-1"></div></div>
                                    <div class="rev-item" style="grid-column: 1 / -1;"><small class="text-orange d-block">Itinerary Photos Preview</small><div id="rev_itinPhotos" class="d-flex flex-wrap gap-2 mt-1"></div></div>
                                    <div class="rev-item" style="grid-column: 1 / -1;"><small class="text-orange d-block">Things to Carry</small><span id="rev_carry" class="small text-white-50">-</span></div>
                                    <div class="rev-item" style="grid-column: 1 / -1;"><small class="text-orange d-block">Cancellation Policy</small><span id="rev_policy" class="small text-white-50">-</span></div>
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
                    if (!steps[n]) return;
                    
                    steps[n].classList.add("active");

                    // Buttons
                    document.getElementById("prevBtn").style.display = (n == 0) ? "none" : "inline";
                    
                    if (n == (steps.length - 1)) {
                        document.getElementById("nextBtn").classList.add("d-none");
                        document.getElementById("launchBtn").classList.remove("d-none");
                        populateReview();
                    } else {
                        document.getElementById("nextBtn").classList.remove("d-none");
                        document.getElementById("launchBtn").classList.add("d-none");
                    }

                    // Indicators
                    updateIndicators(n);
                    
                    // Scroll indicator into view on mobile
                    const activeIndicator = document.getElementById("stepIndicator" + (n + 1));
                    if (activeIndicator) {
                        activeIndicator.scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' });
                    }
                }

                function nextPrev(n) {
                    const steps = document.getElementsByClassName("form-step");

                    // Validation
                    if (n == 1 && !validateStep()) return false;

                    steps[currentStep].classList.remove("active");
                    currentStep += n;

                    showStep(currentStep);
                    window.scrollTo(0, 0);
                }

                function jumpToStep(n) {
                    const steps = document.getElementsByClassName("form-step");
                    
                    // Allow jumping back freely. Jumping forward requires validation of current step.
                    if (n > currentStep) {
                        if (!validateStep()) return;
                    }

                    steps[currentStep].classList.remove("active");
                    currentStep = n;
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

                // Duration Helpers
                function setDuration(d, n) {
                    document.getElementById('tripDays').value = d;
                    document.getElementById('tripNights').value = n;
                    updateDurationLabel();
                }
                function syncNights(d) {
                    const n = Math.max(0, d - 1);
                    document.getElementById('tripNights').value = n;
                    updateDurationLabel();
                }
                function updateDurationLabel() {
                    const d = document.getElementById('tripDays').value;
                    const n = document.getElementById('tripNights').value;
                    document.getElementById('durationLabel').value = d + 'D / ' + n + 'N';
                }

                function toggleCustomPolicy(val) {
                    const cont = document.getElementById('customPolicyCont');
                    if (val === 'Custom') {
                        cont.style.display = 'block';
                    } else {
                        cont.style.display = 'none';
                    }
                }

                function populateReview() {
                    const getVal = (name) => document.querySelector(`[name="\${name}"]`)?.value || 'N/A';
                    const getChecked = (name) => Array.from(document.querySelectorAll(`input[name="\${name}"]:checked`)).map(cb => cb.value).join(', ') || 'None';

                    document.getElementById('rev_title').innerText = getVal('title');
                    document.getElementById('rev_price').innerText = '₹' + getVal('price');
                    document.getElementById('rev_dest').innerText = getVal('destination');
                    document.getElementById('rev_duration').innerText = getVal('days') + ' Days / ' + getVal('nights') + ' Nights';
                    
                    document.getElementById('rev_audience').innerText = getChecked('travelerType');
                    document.getElementById('rev_subs').innerText = getChecked('travelerSubCategories');
                    
                    document.getElementById('rev_stay').innerText = getVal('stayName') + ' (' + getVal('stayCategory') + ')';
                    document.getElementById('rev_trans').innerText = getVal('vehicleName') + ' (' + getVal('transportCategory') + ')';
                    document.getElementById('rev_meals').innerText = getVal('mealPlan');
                    
                    document.getElementById('rev_mode').innerText = getVal('scheduleMode');
                    document.getElementById('rev_batch').innerText = getVal('minBatchSize') + ' People';
                    
                    document.getElementById('rev_inclusions').innerText = getChecked('inclusions') + (getVal('inclusionsOther') !== 'N/A' ? ', ' + getVal('inclusionsOther') : '');
                    document.getElementById('rev_carry').innerText = getChecked('essentials') + (getVal('essentialsOther') !== 'N/A' ? ', ' + getVal('essentialsOther') : '');
                    document.getElementById('rev_policy').innerText = getVal('cancellationPolicy');

                    // Populate Stay Photos Preview in Review
                    const stayRev = document.getElementById('rev_stayPhotos');
                    stayRev.innerHTML = '';
                    const stayOriginals = document.querySelectorAll('#stayPhotoPreview img');
                    stayOriginals.forEach(img => {
                        const clone = img.cloneNode(true);
                        clone.style.width = '50px';
                        clone.style.height = '50px';
                        stayRev.appendChild(clone);
                    });

                    // Populate Itinerary Photos Preview in Review
                    const itinRev = document.getElementById('rev_itinPhotos');
                    itinRev.innerHTML = '';
                    const itinOriginals = document.querySelectorAll('.day-image-preview img');
                    itinOriginals.forEach(img => {
                        const clone = img.cloneNode(true);
                        clone.style.width = '50px';
                        clone.style.height = '50px';
                        clone.style.marginRight = '5px';
                        itinRev.appendChild(clone);
                    });
                }

                function validateStep() {
                    const activeStep = document.getElementsByClassName("form-step")[currentStep];
                    if (!activeStep) return true;

                    const inputs = activeStep.querySelectorAll("input[required], select[required], textarea[required]");
                    for (let input of inputs) {
                        if (!input.value) {
                            input.classList.add("is-invalid");
                            alert("Please fill in all required fields marked with *");
                            return false;
                        }
                        input.classList.remove("is-invalid");
                    }
                    
                    // Specific logic for scheduling if on that step
                    if (activeStep.id === 'step10') {
                        const mode = document.getElementById('scheduleModeInput').value;
                        if (mode === 'specific' && document.querySelectorAll('.occ-card').length === 0) {
                            alert("Please add at least one departure date.");
                            return false;
                        }
                    }
                    
                    return true;
                }

                // Sub-categories Mapping
                const subCategories = {
                    'Solo': ['Backpacker', 'Digital Nomad', 'Spiritual Search', 'Solo Women Trips', 'Solo Men Trips', 'Quiet Retreats', 'Other'],
                    'Group': ['Friends Trip', 'College Group', 'Bikers Club', 'Bachelor/Bachelorette', 'Family Reunion', 'Other'],
                    'Corporate': ['Team Building', 'Leadership Retreat', 'Conference/MICE', 'Incentive Tours', 'Other'],
                    'Adventure': ['Trekking', 'Hiking', 'Camping', 'Rock climbing', 'Paragliding', 'Bungee Jumping', 'Skiing / Snowboarding', 'Scuba Diving', 'Rafting', 'Other'],
                    'Bike Riding': ['Road Trips', 'Off-road', 'Weekend Rides', 'Cross-Country', 'Mountain Biking', 'Other'],
                    'Nature Exploration': ['Wildlife Safari', 'Forest Walk', 'Bird Watching', 'Waterfall Exploration', 'National Park Visit', 'Botanical Tours', 'Star Gazing', 'Eco-Tours'],
                    'Water Activities': ['Scuba Diving', 'Snorkeling', 'Jet Ski', 'Parasailing', 'Kayaking', 'River Rafting', 'Surfing', 'Cruise Highlights', 'Other'],
                    'Workation': ['Co-working Friendly', 'High-Speed WiFi', 'Networking Events', 'Monthly Stays', 'Hillside Workation', 'Beachside Office', 'Other'],
                    'Festivals': ['Music Festivals', 'Comic-con / Pop Culture', 'Sporting Events', 'Cultural Carnivals', 'Food & Wine Festivals', 'Other'],
                    'Volunteering': ['Animal Rescue', 'Rural Teaching', 'Beach Cleanup', 'Environmental Projects', 'Social Service', 'Other'],
                    'Nightlife': ['Pub Crawls', 'Clubbing Destinations', 'Social Hostel Hopping', 'Beach Parties', 'Casino Tours', 'Other'],
                    'Content Creation': ['Drone Photography Spots', 'Aesthetic Stays', 'Portrait Tours', 'Hidden Gems', 'Vlogging Trails', 'Instagrammable Spots', 'Other'],
                    'Wellness': ['Yoga Retreats', 'Digital Detox', 'Meditation Camps', 'Spa & Healing', 'Ayurveda Centers', 'Mental Health Retreats', 'Other'],
                    'Budget Backpacking': ['Hitchhiking Tours', 'Shared Dorm Stays', 'Street Food Crawls', 'Free Walking Tours', 'Other'],
                    'Others': ['Specify in "Other" box']
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
                        html += '<label class="custom-checkbox"><input type="checkbox" name="travelerSubCategories" value="' + s + '" onchange="checkSubOther()"><span class="checkmark"></span> <span class="checkbox-text">' + s + '</span></label>';
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
                        <div class="remove-day" onclick="this.parentElement.remove(); updateDayNumbers();" style="position: absolute; right: 10px; top: 10px; cursor: pointer; color: #ff4757;"><i class="fa fa-trash"></i></div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="row">
                                    <div class="col-12 mb-3"><input type="text" class="form-control day-title" placeholder="Day Title" required></div>
                                    <div class="col-12 mb-3"><textarea class="form-control day-activities" rows="2" placeholder="Activities..."></textarea></div>
                                    <div class="col-6"><input type="text" class="form-control day-stay" placeholder="Stay"></div>
                                    <div class="col-6"><input type="text" class="form-control day-meals" placeholder="Meals"></div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="small text-white-50">Day Photos (Multiple)</label>
                                <div class="day-image-upload" onclick="this.querySelector('input').click()">
                                    <i class="fa fa-camera"></i>
                                    <span>Add Photos</span>
                                    <input type="file" class="day-photo-input d-none" accept="image/*" multiple onchange="previewDayImage(this)">
                                </div>
                                <div class="day-image-preview mt-2 d-flex flex-wrap gap-2"></div>
                            </div>
                        </div>
                    `;
                    document.getElementById('itineraryContainer').appendChild(div);
                });

                function previewStayImage(input) {
                    const preview = document.getElementById('stayPhotoPreview');
                    const files = input.files;
                    
                    if (!input.dataset.dt) {
                        input.dataset.dtId = 'dt_stay_' + Math.random().toString(36).substr(2, 9);
                        window[input.dataset.dtId] = new DataTransfer();
                    }
                    const dt = window[input.dataset.dtId];

                    for (let i = 0; i < files.length; i++) {
                        dt.items.add(files[i]);
                    }
                    
                    input.files = dt.files;
                    renderStayPreviews(input, preview, dt);
                }

                function renderStayPreviews(input, preview, dt) {
                    preview.innerHTML = '';
                    Array.from(dt.files).forEach((file, index) => {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const container = document.createElement('div');
                            container.style.position = 'relative';
                            
                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.style = "width:80px; height:80px; object-fit:cover; border-radius:10px; border:1px solid rgba(255,255,255,0.1);";
                            
                            const removeBtn = document.createElement('div');
                            removeBtn.innerHTML = '×';
                            removeBtn.style = "position:absolute; top:-5px; right:-5px; background:#ff4757; color:white; width:20px; height:20px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:12px; cursor:pointer; border:1px solid white; z-index:10;";
                            removeBtn.onclick = (event) => {
                                event.stopPropagation();
                                dt.items.remove(index);
                                input.files = dt.files;
                                renderStayPreviews(input, preview, dt);
                            };
                            
                            container.appendChild(img);
                            container.appendChild(removeBtn);
                            preview.appendChild(container);
                        }
                        reader.readAsDataURL(file);
                    });
                }

                function previewDayImage(input) {
                    const preview = input.parentElement.nextElementSibling;
                    const files = input.files;
                    
                    // Initialize or get the DataTransfer object for this specific input
                    if (!input.dataset.dt) {
                        input.dataset.dtId = 'dt_' + Math.random().toString(36).substr(2, 9);
                        window[input.dataset.dtId] = new DataTransfer();
                    }
                    const dt = window[input.dataset.dtId];

                    // Add new files to the DataTransfer object
                    for (let i = 0; i < files.length; i++) {
                        dt.items.add(files[i]);
                    }
                    
                    // Sync the input files with our accumulated DataTransfer
                    input.files = dt.files;
                    
                    renderDayPreviews(input, preview, dt);
                }

                function renderDayPreviews(input, preview, dt) {
                    preview.innerHTML = '';
                    Array.from(dt.files).forEach((file, index) => {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const container = document.createElement('div');
                            container.style.position = 'relative';
                            
                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.className = 'day-preview-item';
                            img.style.width = '60px';
                            img.style.height = '60px';
                            img.style.objectFit = 'cover';
                            img.style.borderRadius = '8px';
                            img.style.border = '1px solid rgba(255,255,255,0.1)';
                            
                            const removeBtn = document.createElement('div');
                            removeBtn.innerHTML = '×';
                            removeBtn.style = "position:absolute; top:-5px; right:-5px; background:#ff4757; color:white; width:18px; height:18px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:12px; cursor:pointer; border:1px solid white;";
                            removeBtn.onclick = (event) => {
                                event.stopPropagation();
                                dt.items.remove(index);
                                input.files = dt.files;
                                renderDayPreviews(input, preview, dt);
                            };
                            
                            container.appendChild(img);
                            container.appendChild(removeBtn);
                            preview.appendChild(container);
                        }
                        reader.readAsDataURL(file);
                    });
                }

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
                    if (m === 'recurring') { 
                        $('#recurringCont').show(); 
                        $('#specificDatesCont').hide();
                        // Remove required from specific dates to avoid conflicts
                        $('.occ-date').prop('required', false);
                    } else { 
                        $('#recurringCont').hide(); 
                        $('#specificDatesCont').show();
                        // Ensure added specific dates are required
                        $('.occ-date').prop('required', true);
                    }
                }
                function addOccurrence() {
                    const today = new Date().toISOString().split('T')[0];
                    const id = Date.now();
                    const html = `<div class="occ-card animate__animated animate__fadeInUp" id="occ_\${id}">
                                    <div class="row g-3 align-items-center">
                                        <div class="col-md-4">
                                            <div class="occ-icon"><i class="fa fa-calendar-check-o"></i></div>
                                            <label class="small text-white-50 mb-1 d-block">Departure Date <span class="text-danger">*</span></label>
                                            <div class="input-group input-group-sm">
                                                <input type="date" class="form-control occ-date" min="\${today}" required style="background: rgba(0,0,0,0.2); border-color: rgba(255,255,255,0.1); color: white;">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="occ-icon" style="background: rgba(59, 130, 246, 0.1); color: #3b82f6;"><i class="fa fa-clock-o"></i></div>
                                            <label class="small text-white-50 mb-1 d-block">Time</label>
                                            <div class="input-group input-group-sm">
                                                <input type="time" class="form-control occ-time" style="background: rgba(0,0,0,0.2); border-color: rgba(255,255,255,0.1); color: white;">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="occ-icon" style="background: rgba(46, 213, 115, 0.1); color: #2ed573;"><i class="fa fa-users"></i></div>
                                            <label class="small text-white-50 mb-1 d-block">Batch Size</label>
                                            <div class="input-group input-group-sm">
                                                <input type="number" class="form-control occ-seats" placeholder="Seats" value="20" style="background: rgba(0,0,0,0.2); border-color: rgba(255,255,255,0.1); color: white;">
                                            </div>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <button type="button" class="btn btn-sm btn-outline-danger border-0 mt-4" onclick="$('#occ_\${id}').remove()">
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