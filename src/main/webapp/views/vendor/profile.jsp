<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Vendor Profile | Youth Travel</title>
            <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
            <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
            <style>
                body.yt-dark {
                    background: #0b0f18;
                    color: #fff;
                    font-family: 'Dosis', sans-serif;
                    margin: 0;
                }

                .profile-card {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 24px;
                    padding: 40px;
                    min-height: 500px;
                }

                .nav-tabs {
                    border: none;
                    margin-bottom: 20px;
                    gap: 8px;
                    display: flex;
                    flex-wrap: wrap;
                }

                .nav-tabs .nav-link {
                    border: none;
                    background: rgba(255, 255, 255, 0.05);
                    color: rgba(255, 255, 255, 0.5);
                    padding: 10px 20px;
                    border-radius: 10px;
                    font-weight: 700;
                    font-size: 13px;
                    transition: all 0.2s;
                }

                .nav-tabs .nav-link.active,
                .nav-tabs .nav-link:focus,
                .nav-tabs .nav-link:hover {
                    background: #f04c26 !important;
                    color: #fff !important;
                    box-shadow: 0 8px 15px rgba(240, 76, 38, 0.2);
                    outline: none;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    color: rgba(255, 255, 255, 0.6);
                    font-weight: 600;
                    font-size: 13px;
                    margin-bottom: 8px;
                    display: block;
                }

                .form-control {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 10px;
                    color: #fff;
                    height: 45px;
                    padding: 0 15px;
                }

                .form-control:focus {
                    background: rgba(255, 255, 255, 0.08);
                    border-color: #f04c26;
                    outline: none;
                }

                .form-control option {
                    background: #1a1f2b;
                    color: #fff;
                }

                .form-control[readonly] {
                    background: rgba(255, 255, 255, 0.03);
                    color: rgba(255, 255, 255, 0.4);
                    cursor: not-allowed;
                }

                .section-subtitle {
                    font-size: 16px;
                    font-weight: 800;
                    color: #fff;
                    margin-bottom: 15px;
                    border-left: 3px solid #f04c26;
                    padding-left: 12px;
                }

                .upload-box {
                    border: 2px dashed rgba(255, 255, 255, 0.1);
                    border-radius: 12px;
                    padding: 20px;
                    text-align: center;
                    background: rgba(255, 255, 255, 0.02);
                    cursor: pointer;
                }

                .upload-box i {
                    font-size: 24px;
                    color: #f04c26;
                    margin-bottom: 8px;
                }

                .btn-save {
                    background: #f04c26;
                    color: #fff;
                    font-weight: 800;
                    border: none;
                    border-radius: 12px;
                    padding: 12px 35px;
                    font-size: 15px;
                    transition: all 0.2s;
                }
            </style>
        </head>

        <body class="yt-dark">
                <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="profile" />
    </jsp:include>

    <div class="main-content">
                <div class="mobile-header">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" height="24">
                    <div class="menu-toggle" onclick="toggleSidebar()">
                        <i class="fa fa-bars"></i>
                    </div>
                </div>
                <div style="margin-bottom: 25px;">
                    <h1 style="font-weight: 800; font-size: 28px; margin:0;">Business Profile</h1>
                    <p style="color: rgba(255,255,255,0.5); font-size: 14px;">Update branding, legal and banking
                        details.</p>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <form action="<c:url value='/vendor/update-profile'/>" method="post" enctype="multipart/form-data">
                    <div class="profile-card">
                        <ul class="nav nav-tabs" id="profileTabs" role="tablist">
                            <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#general">1.
                                    BRANDING</a></li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#location">2. LOCATION</a>
                            </li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#legal">3. LEGAL</a></li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#banking">4. BANKING</a>
                            </li>
                        </ul>

                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane active" id="general" role="tabpanel">
                                <div class="section-subtitle">Identity & Branding</div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Business Name</label><input type="text"
                                                name="businessName" class="form-control"
                                                value="${loggedInVendor.businessName}" required></div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Contact Person</label><input type="text"
                                                name="ownerName" class="form-control"
                                                value="${loggedInVendor.ownerName}" required></div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group"><label>About the Vendor (Description)</label>
                                            <textarea name="about" class="form-control" rows="4"
                                                placeholder="Describe your travel services...">${loggedInVendor.about}</textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Business Logo</label>
                                            <div class="upload-box"
                                                onclick="document.getElementById('logoFile').click()">
                                                <i class="fa fa-cloud-upload"></i>
                                                <p style="font-size:12px;">${not empty loggedInVendor.logoPath ? 'Logo
                                                    Uploaded' : 'Upload Logo'}</p>
                                                <input type="file" id="logoFile" name="logoFile" accept="image/*"
                                                    style="display:none;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Cover Banner</label>
                                            <div class="upload-box"
                                                onclick="document.getElementById('bannerFile').click()">
                                                <i class="fa fa-picture-o"></i>
                                                <p style="font-size:12px;">${not empty loggedInVendor.bannerPath ?
                                                    'Banner Uploaded' : 'Upload Banner'}</p>
                                                <input type="file" id="bannerFile" name="bannerFile" accept="image/*"
                                                    style="display:none;">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="section-subtitle" style="margin-top:10px;">Expertise & Reach</div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group"><label>Years of Experience</label>
                                            <input type="number" name="experienceYears" class="form-control"
                                                value="${loggedInVendor.experienceYears}">
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group"><label>Languages Spoken</label>
                                            <input type="text" name="languages" class="form-control"
                                                value="${loggedInVendor.languages}" placeholder="English, Hindi, etc.">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Target Audience</label>
                                            <input type="text" name="targetAudience" class="form-control"
                                                value="${loggedInVendor.targetAudience}"
                                                placeholder="Youth, Families, etc.">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Service Areas</label>
                                            <input type="text" name="serviceAreas" class="form-control"
                                                value="${loggedInVendor.serviceAreas}"
                                                placeholder="Bali, Himachal, etc.">
                                        </div>
                                    </div>
                                </div>

                                <div class="section-subtitle" style="margin-top:10px;">Contact & Social</div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group"><label>Phone</label><input type="text"
                                                name="phoneNumber" class="form-control"
                                                value="${loggedInVendor.phoneNumber}" required></div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group"><label>WhatsApp</label><input type="text"
                                                name="whatsappNumber" class="form-control"
                                                value="${loggedInVendor.whatsappNumber}"></div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group"><label>Website</label><input type="text"
                                                name="websiteUrl" class="form-control"
                                                value="${loggedInVendor.websiteUrl}"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane" id="location" role="tabpanel">
                                <div class="section-subtitle">Office Address</div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group"><label>Full Address</label><textarea
                                                name="companyAddress" class="form-control" rows="2"
                                                required>${loggedInVendor.companyAddress}</textarea></div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group"><label>City</label><input type="text" name="city"
                                                class="form-control" value="${loggedInVendor.city}"></div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group"><label>Google Maps Link</label>
                                            <input type="url" name="mapsLink" class="form-control"
                                                value="${loggedInVendor.mapsLink}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane" id="legal" role="tabpanel">
                                <div class="section-subtitle">Verification Documents</div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Reg. ID</label><input type="text"
                                                name="registrationId" class="form-control"
                                                value="${loggedInVendor.registrationId}" required></div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>GST Number</label><input type="text"
                                                name="gstNumber" class="form-control"
                                                value="${loggedInVendor.gstNumber}"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>ID Proof</label>
                                            <div class="upload-box"
                                                onclick="document.getElementById('idProof').click()">
                                                <i class="fa fa-id-card-o"></i>
                                                <p style="font-size:12px;">${not empty loggedInVendor.idProofPath ?
                                                    'Uploaded' : 'Upload ID'}</p>
                                                <input type="file" id="idProof" name="idProof" style="display:none;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Business License</label>
                                            <div class="upload-box"
                                                onclick="document.getElementById('licenseFile').click()">
                                                <i class="fa fa-file-text-o"></i>
                                                <p style="font-size:12px;">${not empty loggedInVendor.licensePath ?
                                                    'Uploaded' : 'Upload License'}</p>
                                                <input type="file" id="licenseFile" name="licenseFile"
                                                    style="display:none;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Insurance Docs</label>
                                            <div class="upload-box"
                                                onclick="document.getElementById('insuranceFile').click()">
                                                <i class="fa fa-shield"></i>
                                                <p style="font-size:12px;">${not empty loggedInVendor.insurancePath ?
                                                    'Uploaded' : 'Upload Insurance'}</p>
                                                <input type="file" id="insuranceFile" name="insuranceFile"
                                                    style="display:none;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane" id="banking" role="tabpanel">
                                <div class="section-subtitle">Banking</div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Acc Holder</label><input type="text"
                                                name="bankAccountHolderName" class="form-control"
                                                value="${loggedInVendor.bankAccountHolderName}"></div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>Acc Number</label><input type="text"
                                                name="bankAccountNumber" class="form-control"
                                                value="${loggedInVendor.bankAccountNumber}"></div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>IFSC</label><input type="text"
                                                name="bankIfscCode" class="form-control"
                                                value="${loggedInVendor.bankIfscCode}"></div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group"><label>UPI ID</label><input type="text" name="upiId"
                                                class="form-control" value="${loggedInVendor.upiId}"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div
                            style="text-align:center; margin-top:30px; border-top:1px solid rgba(255,255,255,0.08); padding-top:20px;">
                            <button type="submit" class="btn-save">Save Profile</button>
                        </div>
                    </div>
                </form>
            </div>

            <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
            <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
            <script>
                $('input[type="file"]').change(function (e) {
                    var n = e.target.files[0].name;
                    $(this).parent().find('p').text(n).css('color', '#f04c26');
                });
            </script>
            <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
            <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
            <script>
                function toggleSidebar() {
                    $('.sidebar').toggleClass('show');
                    $('.sidebar-overlay').toggleClass('show');
                }
            </script>
        </body>

        </html>

        </html>