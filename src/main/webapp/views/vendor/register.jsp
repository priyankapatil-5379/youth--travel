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
            <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
            <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
            <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
            <style>
                #map {
                    height: 250px;
                    border-radius: 12px;
                    margin-top: 10px;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                }

                .leaflet-control-geocoder {
                    background: #1a1f2b;
                    color: #fff;
                }

                body.yt-vendor-reg {
                    background: #0b0f18 url('<c:url value="/views/assets/images/hero.png"/>') no-repeat center center fixed;
                    background-size: cover;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    position: relative;
                    padding: 80px 0;
                }

                body.yt-vendor-reg::before {
                    content: "";
                    position: absolute;
                    inset: 0;
                    background: linear-gradient(135deg, rgba(9, 11, 18, 0.98) 0%, rgba(9, 11, 18, 0.85) 100%);
                    z-index: 1;
                }

                .reg-container {
                    position: relative;
                    z-index: 2;
                    width: 100%;
                    max-width: 950px;
                    padding: 20px;
                }

                .reg-card {
                    background: rgba(255, 255, 255, 0.03);
                    backdrop-filter: blur(25px);
                    -webkit-backdrop-filter: blur(25px);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 32px;
                    padding: 50px;
                    box-shadow: 0 40px 100px -20px rgba(0, 0, 0, 0.7);
                }

                /* Stepper Styles */
                .stepper {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 50px;
                    position: relative;
                    max-width: 600px;
                    margin-left: auto;
                    margin-right: auto;
                }

                .stepper::before {
                    content: "";
                    position: absolute;
                    top: 20px;
                    left: 0;
                    right: 0;
                    height: 2px;
                    background: rgba(255, 255, 255, 0.1);
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
                }

                .step-circle {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    background: #1a1f2e;
                    border: 2px solid rgba(255, 255, 255, 0.1);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: rgba(255, 255, 255, 0.5);
                    font-weight: 700;
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .step.active .step-circle {
                    background: #f04c26;
                    border-color: #f04c26;
                    color: #fff;
                    box-shadow: 0 0 20px rgba(240, 76, 38, 0.4);
                    transform: scale(1.1);
                }

                .step.completed .step-circle {
                    background: #10b981;
                    border-color: #10b981;
                    color: #fff;
                }

                .step-label {
                    font-size: 11px;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    color: rgba(255, 255, 255, 0.4);
                    transition: color 0.3s;
                }

                .step.active .step-label {
                    color: #f04c26;
                }

                /* Form Section Styles */
                .form-step {
                    display: none;
                    animation: fadeInSlide 0.6s ease-out forwards;
                }

                .form-step.active {
                    display: block;
                }

                @keyframes fadeInSlide {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .section-header {
                    margin-bottom: 35px;
                }

                .section-header h3 {
                    color: #fff;
                    font-size: 24px;
                    font-weight: 800;
                    margin-bottom: 8px;
                }

                .section-header p {
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 15px;
                }

                .form-group {
                    margin-bottom: 24px;
                }

                .form-group label {
                    color: rgba(255, 255, 255, 0.8);
                    font-weight: 600;
                    font-size: 13px;
                    margin-bottom: 10px;
                    display: block;
                }

                .form-control {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 14px;
                    height: 52px;
                    color: #fff;
                    padding: 0 18px;
                    transition: all 0.3s;
                }

                .form-control:focus {
                    background: rgba(255, 255, 255, 0.08);
                    border-color: #f04c26;
                    box-shadow: 0 0 0 4px rgba(240, 76, 38, 0.15);
                }

                textarea.form-control {
                    height: auto;
                    padding-top: 15px;
                }

                .file-upload-wrapper {
                    background: rgba(255, 255, 255, 0.03);
                    border: 2px dashed rgba(255, 255, 255, 0.1);
                    border-radius: 16px;
                    padding: 25px;
                    text-align: center;
                    transition: all 0.3s;
                    cursor: pointer;
                    position: relative;
                }

                .file-upload-wrapper:hover {
                    border-color: #f04c26;
                    background: rgba(255, 255, 255, 0.05);
                }

                .file-upload-wrapper i {
                    font-size: 24px;
                    color: #f04c26;
                    margin-bottom: 10px;
                }

                .file-upload-wrapper input[type="file"] {
                    position: absolute;
                    inset: 0;
                    opacity: 0;
                    cursor: pointer;
                }

                .btn-nav {
                    border: none;
                    height: 56px;
                    border-radius: 14px;
                    font-weight: 800;
                    font-size: 16px;
                    padding: 0 35px;
                    transition: all 0.3s;
                }

                .btn-next {
                    background: #f04c26;
                    color: #fff;
                    box-shadow: 0 10px 20px rgba(240, 76, 38, 0.2);
                }

                .btn-next:hover {
                    background: #d93d1a;
                    transform: translateY(-2px);
                }

                .btn-prev {
                    background: rgba(255, 255, 255, 0.05);
                    color: #fff;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    margin-right: 15px;
                }

                .btn-prev:hover {
                    background: rgba(255, 255, 255, 0.1);
                }

                .reg-header {
                    text-align: center;
                    margin-bottom: 50px;
                }

                .reg-header img {
                    height: 45px;
                    margin-bottom: 25px;
                }

                .audience-chips {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 10px;
                }

                .audience-chip {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 100px;
                    padding: 8px 18px;
                    color: rgba(255, 255, 255, 0.7);
                    font-size: 13px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.3s;
                }

                .audience-chip.active {
                    background: rgba(240, 76, 38, 0.1);
                    border-color: #f04c26;
                    color: #f04c26;
                }
            </style>
        </head>

        <body class="yt-vendor-reg">
            <div class="reg-container">
                <div class="reg-card">
                    <div class="reg-header">
                        <a href="<c:url value='/'/>">
                            <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                        </a>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger"
                            style="border-radius: 12px; background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.2); color: #f87171; margin-bottom: 30px; font-weight: 600;">
                            <i class="fa fa-exclamation-circle mr-2"></i> ${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success"
                            style="border-radius: 12px; background: rgba(16, 185, 129, 0.1); border: 1px solid rgba(16, 185, 129, 0.2); color: #34d399; margin-bottom: 30px; font-weight: 600;">
                            <i class="fa fa-check-circle mr-2"></i> ${message}
                        </div>
                    </c:if>

                    <!-- Stepper -->
                    <div class="stepper">
                        <div class="step active" id="stepIndicator1">
                            <div class="step-circle">1</div>
                            <div class="step-label">Business</div>
                        </div>
                        <div class="step" id="stepIndicator2">
                            <div class="step-circle">2</div>
                            <div class="step-label">Brand & Profile</div>
                        </div>
                        <div class="step" id="stepIndicator3">
                            <div class="step-circle">3</div>
                            <div class="step-label">Verification</div>
                        </div>
                    </div>

                    <form id="vendorRegForm" action="<c:url value='/vendor/register'/>" method="post"
                        enctype="multipart/form-data">

                        <!-- Step 1: Business Details -->
                        <div class="form-step active" id="step1">
                            <div class="section-header">
                                <h3>Business Information</h3>
                                <p>Tell us about your registered travel adventure business</p>
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Business Name</label>
                                    <input type="text" name="businessName" class="form-control"
                                        placeholder="Adventure Co. Ltd">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Contact Person Name</label>
                                    <input type="text" name="ownerName" class="form-control" placeholder="John Doe">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Email Address</label>
                                    <input type="email" name="emailId" class="form-control"
                                        placeholder="contact@company.com">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Phone Number</label>
                                    <input type="text" name="phoneNumber" class="form-control"
                                        placeholder="10-digit Mobile Number" maxlength="10"
                                        title="Please enter exactly 10 digits">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Company Registration Number (Optional)</label>
                                    <input type="text" name="registrationId" class="form-control"
                                        placeholder="REG-12345678">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>GST Number (for India)</label>
                                    <input type="text" name="gstNumber" class="form-control"
                                        placeholder="22AAAAA0000A1Z5">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Business Address</label>
                                <textarea name="companyAddress" class="form-control" rows="2"
                                    placeholder="Full registered office address"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-4 form-group">
                                    <label>Website Link</label>
                                    <input type="url" name="websiteUrl" class="form-control"
                                        placeholder="https://adventure.com">
                                </div>
                                <div class="col-md-4 form-group">
                                    <label>WhatsApp Number</label>
                                    <input type="text" name="whatsappNumber" class="form-control"
                                        placeholder="10-digit WhatsApp Number">
                                </div>
                                <div class="col-md-4 form-group">
                                    <label>Instagram/FB Link</label>
                                    <input type="url" name="instagramUrl" class="form-control"
                                        placeholder="https://instagram.com/profile">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Set Password</label>
                                <input type="password" name="password" class="form-control" autocomplete="new-password">
                            </div>
                            <div class="d-flex justify-content-end mt-4">
                                <button type="button" class="btn btn-nav btn-next" onclick="nextStep(2)">Next: Brand
                                    Profile</button>
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
                                        <p class="m-0 text-white-50">Upload Logo</p>
                                        <input type="file" name="logoFile" accept=".jpg,.jpeg,.png">
                                    </div>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Cover Image / Banner (JPG/PNG, Max 5MB)</label>
                                    <div class="file-upload-wrapper">
                                        <i class="fa fa-picture-o"></i>
                                        <p class="m-0 text-white-50">Upload Banner</p>
                                        <input type="file" name="bannerFile" accept=".jpg,.jpeg,.png">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>About the Vendor (Description)</label>
                                <textarea name="about" class="form-control" rows="4"
                                    placeholder="Describe your travel services (Min 10 chars)..."></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-4 form-group">
                                    <label>Years of Experience</label>
                                    <input type="number" name="experienceYears" class="form-control"
                                        placeholder="e.g. 5" min="0" max="50">
                                </div>
                                <div class="col-md-8 form-group">
                                    <label>Languages Spoken</label>
                                    <select name="languages" class="form-control" multiple
                                        style="height: auto; background: #1a1f2b; color: #fff;">
                                        <option value="English">English</option>
                                        <option value="Hindi">Hindi</option>
                                        <option value="Kannada">Kannada</option>
                                        <option value="Tamil">Tamil</option>
                                        <option value="Telugu">Telugu</option>
                                        <option value="Malayalam">Malayalam</option>
                                        <option value="French">French</option>
                                        <option value="Spanish">Spanish</option>
                                    </select>
                                    <small class="text-white-50">Hold Ctrl/Cmd to select multiple</small>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Target Audience</label>
                                <input type="hidden" name="targetAudience" id="targetAudienceInput">
                                <div class="audience-chips">
                                    <div class="audience-chip" onclick="toggleAudience(this, 'Youth')">Youth</div>
                                    <div class="audience-chip" onclick="toggleAudience(this, 'Families')">Families</div>
                                    <div class="audience-chip" onclick="toggleAudience(this, 'Solo Travelers')">Solo
                                        Travelers</div>
                                    <div class="audience-chip" onclick="toggleAudience(this, 'Couples')">Couples</div>
                                    <div class="audience-chip" onclick="toggleAudience(this, 'Corporate')">Corporate
                                    </div>
                                    <div class="audience-chip" onclick="toggleAudience(this, 'Adventure')">Adventure
                                    </div>
                                    <div class="audience-chip" onclick="toggleAudience(this, 'Bike Riding')">Bike Riding
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Base City</label>
                                    <select name="city" class="form-control" style="background: #1a1f2b; color: #fff;">
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
                                    <label>Business Location (Search or Click on Map to pick Coordinates)</label>
                                    <div class="input-group mb-2">
                                        <input type="text" id="mapSearch" class="form-control"
                                            placeholder="Search address or city...">
                                        <button class="btn btn-outline-orange" type="button"
                                            onclick="searchLocation()">Search</button>
                                    </div>
                                    <div id="map"></div>
                                    <input type="hidden" name="mapsLink" id="mapsLink">
                                    <small class="text-white-50 mt-1 d-block" id="coordsDisplay">Selected: None</small>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Service Areas / Destinations (Comma separated)</label>
                                <input type="text" name="serviceAreas" class="form-control"
                                    placeholder="Western Ghats, Bali, Himachal, etc.">
                            </div>
                            <div class="d-flex justify-content-end mt-4">
                                <button type="button" class="btn btn-nav btn-prev" onclick="nextStep(1)">Back</button>
                                <button type="button" class="btn btn-nav btn-next" onclick="nextStep(3)">Next:
                                    Verification</button>
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
                                        <p class="m-0 text-white-50">Upload ID Proof</p>
                                        <input type="file" name="idProofFile" accept=".pdf,.jpg,.jpeg,.png">
                                    </div>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Business License</label>
                                    <div class="file-upload-wrapper">
                                        <i class="fa fa-file-text-o"></i>
                                        <p class="m-0 text-white-50">Upload License</p>
                                        <input type="file" name="licenseFile">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Insurance Details (if applicable)</label>
                                <div class="file-upload-wrapper">
                                    <i class="fa fa-shield"></i>
                                    <p class="m-0 text-white-50">Upload Insurance Doc</p>
                                    <input type="file" name="insuranceFile">
                                </div>
                            </div>

                            <div class="form-group mt-4">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="termsCheck"
                                        name="termsAccepted" value="true">
                                    <label class="custom-control-label text-white-50" for="termsCheck">
                                        I accept the Vendor Agreement and Terms of Service.
                                    </label>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end mt-5">
                                <button type="submit" class="btn btn-nav btn-next">Submit</button>
                            </div>
                        </div>
                    </form>

                    <div class="reg-footer text-center mt-4">
                        <p class="mb-0 text-white-50">Already have an account? <a href="<c:url value='/vendor/login'/>"
                                class="text-orange fw-bold">Sign In</a></p>
                    </div>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
            <script>
                // Map Logic
                let map = L.map('map').setView([12.9716, 77.5946], 10);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
                let marker;

                map.on('click', function (e) {
                    setMarker(e.latlng);
                });

                function setMarker(latlng) {
                    if (marker) map.removeLayer(marker);
                    marker = L.marker(latlng).addTo(map);
                    const coords = latlng.lat.toFixed(6) + ", " + latlng.lng.toFixed(6);
                    $('#mapsLink').val(coords);
                    $('#coordsDisplay').text("Selected: " + coords).css('color', '#f04c26');
                }

                function searchLocation() {
                    const query = $('#mapSearch').val();
                    if (!query) return;
                    fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${query}`)
                        .then(res => res.json())
                        .then(data => {
                            if (data.length > 0) {
                                const latlng = { lat: parseFloat(data[0].lat), lng: parseFloat(data[0].lon) };
                                map.setView(latlng, 15);
                                setMarker(latlng);
                            }
                        });
                }
                function validateStep(step) {
                    return true; // BYPASS ALL VALIDATION
                }

                function nextStep(step) {
                    const currentStep = step > 1 ? step - 1 : 1;

                    // Only validate when going FORWARD
                    if (step > currentStep && !validateStep(currentStep)) {
                        // Alert for user feedback if needed
                        return;
                    }

                    // Remove active class from all steps and indicators
                    $('.form-step').removeClass('active');
                    $('.step').removeClass('active');

                    // Add active class to current step and indicator
                    $('#step' + step).addClass('active');
                    $('#stepIndicator' + step).addClass('active');

                    // Mark previous steps as completed
                    for (let i = 1; i < step; i++) {
                        $('#stepIndicator' + i).addClass('completed');
                    }

                    // Scroll to top of card
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

                $(document).on('change', 'input[type="file"]', function () {
                    const fileName = this.files[0] ? this.files[0].name : "Select File";
                    const $wrapper = $(this).closest('.file-upload-wrapper');
                    $wrapper.find('p').text(fileName).css('color', '#10b981');
                    $wrapper.find('i').css('color', '#10b981');
                    $wrapper.css('background', 'rgba(16, 185, 129, 0.05)').css('border-color', '#10b981');
                });

                $(document).on('input change', '[required]', function () {
                    if ($(this).val()) {
                        $(this).removeClass('is-invalid');
                        $(this).next('.invalid-feedback').remove();
                    }
                });
            </script>
        </body>

        </html>