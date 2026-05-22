<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vendor Registration | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.css" />
    <style>
        :root {
            --primary-teal: #0F7C7C;
            --primary-teal-dark: #085a5a;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --bg-light: #f8fafc;
            --card-bg: #ffffff;
            --input-bg: #ffffff;
            --border: #e2e8f0;
            --teal-glow: rgba(15, 124, 124, 0.1);
        }

        body.yt-vendor-reg {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 80px 20px;
            margin: 0;
        }

        .reg-container {
            width: 100%;
            max-width: 950px;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .reg-card {
            background: var(--card-bg);
            border-radius: 40px;
            padding: 60px;
            box-shadow: 0 40px 100px -20px rgba(15, 124, 124, 0.08);
            border: 1px solid var(--border);
        }

        .reg-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .reg-header img {
            height: 45px;
            margin-bottom: 30px;
        }

        .reg-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 900;
            color: var(--text-dark);
            margin-bottom: 12px;
        }

        .reg-header p {
            color: var(--text-muted);
            font-size: 17px;
            font-weight: 500;
        }

        /* Stepper Styles */
        .stepper {
            display: flex;
            justify-content: space-between;
            margin-bottom: 60px;
            position: relative;
            max-width: 650px;
            margin-left: auto;
            margin-right: auto;
        }

        .stepper::before {
            content: "";
            position: absolute;
            top: 22px;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--border);
            z-index: 1;
        }

        .step {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
            flex: 1;
            cursor: pointer;
        }

        .step-circle {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-weight: 700;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .step.active .step-circle {
            background: var(--primary-teal);
            border-color: var(--primary-teal);
            color: #fff;
            box-shadow: 0 0 20px var(--teal-glow);
            transform: scale(1.1);
        }

        .step.completed .step-circle {
            background: #10b981;
            border-color: #10b981;
            color: #fff;
        }

        .step-label {
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--text-muted);
            transition: color 0.3s;
        }

        .step.active .step-label {
            color: var(--primary-teal);
        }

        /* Form Controls */
        .form-step {
            display: none;
            animation: fadeInStep 0.5s ease-out;
        }

        .form-step.active {
            display: block;
        }

        @keyframes fadeInStep {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .section-header {
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border);
        }

        .section-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 8px;
        }

        .section-header p {
            color: var(--text-muted);
            font-size: 15px;
        }

        .form-group {
            margin-bottom: 28px;
        }

        .form-group label {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 14px;
            margin-bottom: 10px;
            display: block;
        }

        .form-control {
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            height: 56px;
            color: var(--text-dark);
            padding: 0 20px;
            font-size: 15px;
            font-weight: 500;
            transition: 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary-teal);
            box-shadow: 0 4px 15px var(--teal-glow);
            outline: none;
        }

        textarea.form-control {
            height: auto;
            padding-top: 18px;
        }

        .file-upload-wrapper {
            background: #f8fafc;
            border: 2px dashed var(--border);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            position: relative;
        }

        .file-upload-wrapper:hover {
            border-color: var(--primary-teal);
            background: #f0f9f9;
        }

        .file-upload-wrapper i {
            font-size: 28px;
            color: var(--primary-teal);
            margin-bottom: 12px;
        }

        .file-upload-wrapper input[type="file"] {
            position: absolute;
            inset: 0;
            opacity: 0;
            cursor: pointer;
        }

        /* Buttons */
        .btn-nav {
            border: none;
            height: 60px;
            border-radius: 18px;
            font-weight: 800;
            font-size: 16px;
            padding: 0 40px;
            transition: all 0.4s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .btn-next {
            background: linear-gradient(135deg, var(--primary-teal), var(--primary-teal-dark));
            color: #fff;
            box-shadow: 0 10px 25px rgba(15, 124, 124, 0.25);
            width: 100%;
        }

        .btn-next:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(15, 124, 124, 0.4);
            color: #fff;
        }

        .btn-prev {
            background: #f1f5f9;
            color: var(--text-dark);
            border: 1px solid var(--border);
            margin-right: 15px;
        }

        .btn-prev:hover {
            background: #e2e8f0;
        }

        .audience-chips {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .audience-chip {
            background: #f1f5f9;
            border: 1px solid var(--border);
            border-radius: 100px;
            padding: 10px 24px;
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .audience-chip:hover {
            border-color: var(--primary-teal);
            color: var(--primary-teal);
        }

        .audience-chip.active {
            background: var(--primary-teal);
            border-color: var(--primary-teal);
            color: #fff;
            box-shadow: 0 4px 12px var(--teal-glow);
        }

        #map {
            height: 300px;
            border-radius: 20px;
            margin-top: 15px;
            border: 1px solid var(--border);
        }

        .btn-search-map {
            background: var(--primary-teal);
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 0 25px;
            font-weight: 700;
        }

        .reg-footer {
            text-align: center;
            margin-top: 40px;
            font-size: 15px;
            color: var(--text-muted);
        }

        .reg-footer a {
            color: var(--primary-teal);
            font-weight: 800;
            text-decoration: none;
        }

        .is-invalid {
            border-color: #ef4444 !important;
        }

        .invalid-feedback {
            color: #ef4444;
            font-size: 12px;
            font-weight: 600;
            margin-top: 6px;
        }

        @media (max-width: 768px) {
            .reg-card { padding: 40px 24px; }
            .reg-header h1 { font-size: 32px; }
            .stepper { gap: 10px; }
            .step-label { display: none; }
            .reg-container { padding: 0; }
            body.yt-vendor-reg { padding: 40px 15px; }
        }
    </style>
</head>

<body class="yt-vendor-reg">
    <div class="reg-container">
        <div class="reg-card">
            <div class="reg-header">
                <h1>Vendor Register</h1>
                <p>Register your business to start your travel partnership.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" style="border-radius: 16px; background: #fef2f2; border: 1px solid #fee2e2; color: #991b1b; margin-bottom: 30px;">
                    <i class="fa fa-exclamation-circle mr-2"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success" style="border-radius: 16px; background: #f0fdf4; border: 1px solid #dcfce7; color: #166534; margin-bottom: 30px;">
                    <i class="fa fa-check-circle mr-2"></i> ${message}
                </div>
            </c:if>

            <!-- Stepper -->
            <div class="stepper">
                <div class="step active" id="stepIndicator1" onclick="nextStep(1)">
                    <div class="step-circle">1</div>
                    <div class="step-label">Business</div>
                </div>
                <div class="step" id="stepIndicator2" onclick="nextStep(2)">
                    <div class="step-circle">2</div>
                    <div class="step-label">Brand & Profile</div>
                </div>
                <div class="step" id="stepIndicator3" onclick="nextStep(3)">
                    <div class="step-circle">3</div>
                    <div class="step-label">Verification</div>
                </div>
            </div>

            <form id="vendorRegForm" action="<c:url value='/vendor/register'/>" method="post" enctype="multipart/form-data">

                <!-- Step 1: Business Details -->
                <div class="form-step active" id="step1">
                    <div class="section-header">
                        <h3>Business Information</h3>
                        <p>Tell us about your registered travel adventure business</p>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>Business Name</label>
                            <input type="text" name="businessName" id="businessName" class="form-control" placeholder="Adventure Co. Ltd">
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Contact Person Name</label>
                            <input type="text" name="ownerName" id="ownerName" class="form-control" placeholder="John Doe" oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>Email Address</label>
                            <input type="email" name="emailId" class="form-control" placeholder="contact@company.com">
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phoneNumber" id="phoneNumber" class="form-control" placeholder="10-digit Mobile Number" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>Business Type & Registration Number</label>
                            <div class="d-flex" style="gap: 12px;">
                                <select id="companyType" class="form-control" style="width: 40%;">
                                    <option value="CIN">Company (CIN)</option>
                                    <option value="LLPIN">LLP (LLPIN)</option>
                                </select>
                                <input type="text" name="registrationId" id="registrationId" class="form-control" placeholder="L12345KA2020PLC123456" style="width: 60%;" oninput="this.value = this.value.toUpperCase()">
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>GST Number (for India)</label>
                            <input type="text" name="gstNumber" id="gstNumber" class="form-control" placeholder="29ABCDE1234F1Z5" maxlength="15" oninput="this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '')">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Business Address</label>
                        <textarea name="companyAddress" id="companyAddress" class="form-control" rows="2" placeholder="Full registered office address"></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label>Website Link</label>
                            <input type="url" name="websiteUrl" id="websiteUrl" class="form-control" placeholder="https://adventure.com">
                        </div>
                        <div class="col-md-4 form-group">
                            <label>WhatsApp Number</label>
                            <input type="text" name="whatsappNumber" id="whatsappNumber" class="form-control" placeholder="10-digit WhatsApp Number" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                        </div>
                        <div class="col-md-4 form-group">
                            <label>Instagram/FB Link</label>
                            <input type="url" name="instagramUrl" id="instagramUrl" class="form-control" placeholder="https://instagram.com/profile">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>Set Password</label>
                            <input type="password" name="password" id="password" class="form-control" autocomplete="new-password">
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Confirm Password</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" autocomplete="new-password">
                        </div>
                    </div>
                    <div class="mt-4">
                        <button type="button" class="btn-nav btn-next" onclick="nextStep(2)">
                            Continue to Brand Profile <i class="fa fa-arrow-right"></i>
                        </button>
                    </div>
                </div>

                <!-- Step 2: Profile & Branding -->
                <div class="form-step" id="step2">
                    <div class="section-header">
                        <h3>Brand & Location</h3>
                        <p>Visual and descriptive details for your public profile</p>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>Business Logo (JPG/PNG, Max 2MB)</label>
                            <div class="file-upload-wrapper">
                                <i class="fa fa-cloud-upload"></i>
                                <p class="m-0 text-muted">Upload Logo</p>
                                <input type="file" name="logoFile" accept=".jpg,.jpeg,.png">
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Cover Image / Banner (JPG/PNG, Max 5MB)</label>
                            <div class="file-upload-wrapper">
                                <i class="fa fa-picture-o"></i>
                                <p class="m-0 text-muted">Upload Banner</p>
                                <input type="file" name="bannerFile" accept=".jpg,.jpeg,.png">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>About the Vendor (Description)</label>
                        <textarea name="about" class="form-control" rows="4" placeholder="Describe your travel services (Min 10 chars)..."></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label>Years of Experience</label>
                            <input type="number" name="experienceYears" class="form-control" placeholder="e.g. 5" min="0" max="50">
                        </div>
                        <div class="col-md-8 form-group">
                            <label>Languages Spoken</label>
                            <input type="hidden" name="languages" id="languagesInput">
                            <div class="audience-chips" id="languageChips">
                                <div class="audience-chip" onclick="toggleLanguage(this, 'English')">English</div>
                                <div class="audience-chip" onclick="toggleLanguage(this, 'Hindi')">Hindi</div>
                                <div class="audience-chip" onclick="toggleLanguage(this, 'Kannada')">Kannada</div>
                                <div class="audience-chip" onclick="toggleLanguage(this, 'Tamil')">Tamil</div>
                                <div class="audience-chip" onclick="toggleLanguage(this, 'Telugu')">Telugu</div>
                                <div class="audience-chip" onclick="toggleLanguage(this, 'Malayalam')">Malayalam</div>
                                <div class="audience-chip" onclick="toggleLanguage(this, 'French')">French</div>
                                <div class="audience-chip" onclick="toggleLanguage(this, 'Spanish')">Spanish</div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Target Audience</label>
                        <input type="hidden" name="targetAudience" id="targetAudienceInput">
                        <div class="audience-chips">
                            <div class="audience-chip" onclick="toggleAudience(this, 'Youth')">Youth</div>
                            <div class="audience-chip" onclick="toggleAudience(this, 'Families')">Families</div>
                            <div class="audience-chip" onclick="toggleAudience(this, 'Solo Travelers')">Solo Travelers</div>
                            <div class="audience-chip" onclick="toggleAudience(this, 'Couples')">Couples</div>
                            <div class="audience-chip" onclick="toggleAudience(this, 'Corporate')">Corporate</div>
                            <div class="audience-chip" onclick="toggleAudience(this, 'Adventure')">Adventure</div>
                            <div class="audience-chip" onclick="toggleAudience(this, 'Bike Riding')">Bike Riding</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>Base City</label>
                            <select name="city" class="form-control">
                                <option value="">Select City</option>
                                <option value="Bengaluru">Bengaluru</option>
                                <option value="Mumbai">Mumbai</option>
                                <option value="Delhi">Delhi</option>
                                <option value="Chennai">Chennai</option>
                                <option value="Hyderabad">Hyderabad</option>
                                <option value="Kolkata">Kolkata</option>
                                <option value="Pune">Pune</option>
                                <option value="Goa">Goa</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-md-12 form-group">
                            <label>Business Location (Search or Pick on Map)</label>
                            <div class="input-group mb-3">
                                <input type="text" id="mapSearch" class="form-control" placeholder="Search address or city...">
                                <button class="btn-search-map px-4" type="button" onclick="searchLocation()">Search</button>
                            </div>
                            <div id="map"></div>
                            <input type="hidden" name="mapsLink" id="mapsLink">
                            <small class="text-muted mt-2 d-block" id="coordsDisplay">Selected: None</small>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Service Areas / Destinations (Comma separated)</label>
                        <input type="text" name="serviceAreas" class="form-control" placeholder="Western Ghats, Bali, Himachal, etc.">
                    </div>
                    <div class="d-flex gap-3 mt-4">
                        <button type="button" class="btn-nav btn-prev flex-grow-1" onclick="nextStep(1)">Back</button>
                        <button type="button" class="btn-nav btn-next flex-grow-2" onclick="nextStep(3)">Continue to Verification <i class="fa fa-arrow-right"></i></button>
                    </div>
                </div>

                <!-- Step 3: Verification -->
                <div class="form-step" id="step3">
                    <div class="section-header">
                        <h3>Verification & Trust</h3>
                        <p>Upload documents to verify your business and build traveler trust</p>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>ID Proof (PDF/JPG/PNG, Max 5MB)</label>
                            <div class="file-upload-wrapper">
                                <i class="fa fa-id-card-o"></i>
                                <p class="m-0 text-muted">Upload ID Proof</p>
                                <input type="file" name="idProofFile" accept=".pdf,.jpg,.jpeg,.png">
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Business License</label>
                            <div class="file-upload-wrapper">
                                <i class="fa fa-file-text-o"></i>
                                <p class="m-0 text-muted">Upload License</p>
                                <input type="file" name="licenseFile">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Insurance Details</label>
                        <div class="file-upload-wrapper">
                            <i class="fa fa-shield"></i>
                            <p class="m-0 text-muted">Upload Insurance Doc</p>
                            <input type="file" name="insuranceFile">
                        </div>
                    </div>

                    <div class="form-group mt-4">
                        <label class="d-flex align-items-center gap-3 cursor-pointer">
                            <input type="checkbox" id="termsCheck" name="termsAccepted" value="true" required style="width: 20px; height: 20px; accent-color: var(--primary-teal);">
                            <span class="text-muted small">I accept the Vendor Agreement and Terms of Service.</span>
                        </label>
                    </div>

                    <div class="d-flex gap-3 mt-5">
                        <button type="button" class="btn-nav btn-prev flex-grow-1" onclick="nextStep(2)">Back</button>
                        <button type="submit" class="btn-nav btn-next flex-grow-2">Complete Registration <i class="fa fa-check"></i></button>
                    </div>
                </div>
            </form>

            <div class="reg-footer">
                Already have an account? <a href="<c:url value='/vendor/login'/>">Sign In</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.js"></script>
    <script>
        // Map Logic
        let map = L.map('map').setView([12.9716, 77.5946], 10);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
        let marker;

        // Prevent Enter key from submitting the form prematurely
        $(window).keydown(function(event) {
            if (event.keyCode == 13 && event.target.nodeName !== 'TEXTAREA') {
                event.preventDefault();
                return false;
            }
        });

        map.on('click', function (e) {
            setMarker(e.latlng);
        });

        function setMarker(latlng) {
            if (marker) map.removeLayer(marker);
            marker = L.marker(latlng).addTo(map);
            const coords = latlng.lat.toFixed(6) + ", " + latlng.lng.toFixed(6);
            $('#mapsLink').val(coords);
            $('#coordsDisplay').text("Selected: " + coords).css('color', '#0F7C7C');
        }

        function searchLocation() {
            const query = $('#mapSearch').val();
            if (!query) return;
            fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(query))
                .then(res => res.json())
                .then(data => {
                    if (data.length > 0) {
                        const latlng = { lat: parseFloat(data[0].lat), lng: parseFloat(data[0].lon) };
                        map.setView(latlng, 15);
                        setMarker(latlng);
                    }
                });
        }

        function showError($input, msg) {
            $input.addClass('is-invalid');
            if($input.next('.invalid-feedback').length === 0) {
                $input.after('<div class="invalid-feedback">' + msg + '</div>');
            } else {
                $input.next('.invalid-feedback').text(msg).show();
            }
        }

        function clearError($input) {
            $input.removeClass('is-invalid');
            $input.next('.invalid-feedback').hide();
        }

        function validateStep(step) {
            let isValid = true;
            $('#step' + step + ' .is-invalid').removeClass('is-invalid');
            $('#step' + step + ' .invalid-feedback').hide();

            if (step === 1) {
                const bName = $('[name="businessName"]');
                if (!/^[A-Za-z][A-Za-z0-9\s]*$/.test(bName.val().trim())) {
                    isValid = false; showError(bName, 'Required, must start with alphabet.');
                }
                const phone = $('[name="phoneNumber"]');
                if (!/^\d{10}$/.test(phone.val().trim())) {
                    isValid = false; showError(phone, 'Must be 10 digits.');
                }
                const pass = $('[name="password"]');
                const passConf = $('[name="confirmPassword"]');
                if (pass.val().length < 8) {
                    isValid = false; showError(pass, 'Min 8 characters.');
                }
                if (pass.val() !== passConf.val()) {
                    isValid = false; showError(passConf, 'Passwords do not match.');
                }
            } else if (step === 2) {
                const about = $('[name="about"]');
                if (about.val().trim().length < 10) {
                    isValid = false; showError(about, 'Required, min 10 chars.');
                }
            } else if (step === 3) {
                const termsChecked = $('#termsCheck').is(':checked');
                if (!termsChecked) { isValid = false; alert('Please accept the terms.'); }
            }
            return isValid;
        }

        function nextStep(step) {
            const activeStepElem = document.querySelector('.form-step.active');
            const currentStep = activeStepElem ? parseInt(activeStepElem.id.replace('step', '')) : 1;

            if (step > currentStep && !validateStep(currentStep)) return;

            $('.form-step').removeClass('active');
            $('.step').removeClass('active');
            $('.step').removeClass('completed');

            $('#step' + step).addClass('active');
            $('#stepIndicator' + step).addClass('active');
            
            if (step === 2) {
                setTimeout(() => {
                    if(typeof map !== 'undefined') map.invalidateSize();
                }, 100);
            }

            for (let i = 1; i < step; i++) {
                $('#stepIndicator' + i).addClass('completed');
            }

            $('html, body').animate({
                scrollTop: $(".reg-card").offset().top - 50
            }, 500);
        }

        let audiences = [];
        function toggleAudience(element, value) {
            $(element).toggleClass('active');
            if ($(element).hasClass('active')) {
                audiences.push(value);
            } else {
                audiences = audiences.filter(a => a !== value);
            }
            $('#targetAudienceInput').val(audiences.join(', '));
        }

        let selectedLanguages = [];
        function toggleLanguage(element, value) {
            $(element).toggleClass('active');
            if ($(element).hasClass('active')) {
                selectedLanguages.push(value);
            } else {
                selectedLanguages = selectedLanguages.filter(a => a !== value);
            }
            $('#languagesInput').val(selectedLanguages.join(', '));
        }

        $(document).on('change', 'input[type="file"]', function () {
            const fileName = this.files[0] ? this.files[0].name : "Select File";
            const $wrapper = $(this).closest('.file-upload-wrapper');
            $wrapper.find('p').text(fileName).css('color', '#10b981');
            $wrapper.find('i').css('color', '#10b981');
            $wrapper.css('background', '#f0fdf4').css('border-color', '#10b981');
        });
    </script>
</body>
</html>