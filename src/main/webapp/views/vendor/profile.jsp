<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vendor Profile | Youth Travel</title>
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

        .page-header {
            margin-bottom: 32px;
        }

        .page-header h1 {
            font-weight: 800;
            font-size: 32px;
            margin: 0;
            letter-spacing: -1px;
            color: var(--text-main);
        }

        .page-header p {
            color: var(--text-muted);
            font-size: 16px;
            margin-top: 8px;
        }

        .profile-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        .nav-tabs {
            border: none;
            margin-bottom: 32px;
            display: flex;
            gap: 12px;
            background: #f1f5f9;
            padding: 8px;
            border-radius: 16px;
            width: fit-content;
        }

        .nav-tabs .nav-link {
            border: none;
            background: transparent;
            color: var(--text-muted);
            padding: 10px 24px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 13px;
            transition: 0.2s;
        }

        .nav-tabs .nav-link.active {
            background: #ffffff !important;
            color: var(--primary) !important;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            color: var(--text-main);
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            color: var(--text-main);
            height: 48px;
            padding: 0 16px;
            font-size: 14px;
            transition: 0.2s;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1);
            outline: none;
        }

        textarea.form-control {
            height: auto;
            padding: 12px 16px;
        }

        .section-subtitle {
            font-size: 18px;
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 24px;
            margin-top: 16px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-subtitle::before {
            content: '';
            width: 4px;
            height: 24px;
            background: var(--primary);
            border-radius: 4px;
        }

        .upload-box {
            border: 2px dashed var(--border-color);
            border-radius: 16px;
            padding: 24px;
            text-align: center;
            background: #f8fafc;
            cursor: pointer;
            transition: 0.2s;
        }

        .upload-box:hover {
            border-color: var(--primary);
            background: #f0f9f9;
        }

        .upload-box i {
            font-size: 28px;
            color: var(--primary);
            margin-bottom: 12px;
        }

        .upload-box p {
            font-size: 13px;
            font-weight: 600;
            color: var(--text-muted);
            margin: 0;
        }

        .btn-save {
            background: var(--accent-red);
            color: #ffffff;
            font-weight: 700;
            border: none;
            border-radius: 12px;
            padding: 14px 48px;
            font-size: 16px;
            transition: 0.2s;
            box-shadow: 0 4px 12px rgba(230, 57, 70, 0.2);
        }

        .btn-save:hover {
            transform: translateY(-2px);
            background: #d62828;
            box-shadow: 0 8px 20px rgba(230, 57, 70, 0.3);
        }

        .alert-custom {
            background-color: #dcfce7;
            border: 1px solid #bbf7d0;
            color: #166534;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 32px;
            font-weight: 500;
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="profile" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <h1>Business Profile</h1>
            <p>Manage your professional identity, legal documents, and financial settings.</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert-custom">
                <i class="fa fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <form action="<c:url value='/vendor/update-profile'/>" method="post" enctype="multipart/form-data">
            <div class="profile-card">
                <ul class="nav nav-tabs" id="profileTabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#general">1. BRANDING</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#location">2. LOCATION</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#legal">3. LEGAL</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#banking">4. BANKING</a>
                    </li>
                </ul>

                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane active" id="general" role="tabpanel">
                        <div class="section-subtitle">Identity & Branding</div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Business Name</label>
                                    <input type="text" name="businessName" class="form-control" value="${loggedInVendor.businessName}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Contact Person</label>
                                    <input type="text" name="ownerName" class="form-control" value="${loggedInVendor.ownerName}" required>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>About the Vendor (Description)</label>
                                    <textarea name="about" class="form-control" rows="4" placeholder="Describe your travel services...">${loggedInVendor.about}</textarea>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Business Logo</label>
                                    <div class="upload-box" onclick="document.getElementById('logoFile').click()">
                                        <i class="fa fa-cloud-upload"></i>
                                        <p>${not empty loggedInVendor.logoPath ? 'Logo Uploaded' : 'Upload Business Logo'}</p>
                                        <input type="file" id="logoFile" name="logoFile" accept="image/*" style="display:none;">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Cover Banner</label>
                                    <div class="upload-box" onclick="document.getElementById('bannerFile').click()">
                                        <i class="fa fa-picture-o"></i>
                                        <p>${not empty loggedInVendor.bannerPath ? 'Banner Uploaded' : 'Upload Cover Banner'}</p>
                                        <input type="file" id="bannerFile" name="bannerFile" accept="image/*" style="display:none;">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="section-subtitle">Expertise & Reach</div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Years of Experience</label>
                                    <input type="number" name="experienceYears" class="form-control" value="${loggedInVendor.experienceYears}">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label>Languages Spoken</label>
                                    <input type="text" name="languages" class="form-control" value="${loggedInVendor.languages}" placeholder="English, Hindi, etc.">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Target Audience</label>
                                    <input type="text" name="targetAudience" class="form-control" value="${loggedInVendor.targetAudience}" placeholder="Youth, Families, etc.">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Service Areas</label>
                                    <input type="text" name="serviceAreas" class="form-control" value="${loggedInVendor.serviceAreas}" placeholder="Bali, Himachal, etc.">
                                </div>
                            </div>
                        </div>

                        <div class="section-subtitle">Contact & Social</div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Phone</label>
                                    <input type="text" name="phoneNumber" class="form-control" value="${loggedInVendor.phoneNumber}" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>WhatsApp</label>
                                    <input type="text" name="whatsappNumber" class="form-control" value="${loggedInVendor.whatsappNumber}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Website</label>
                                    <input type="text" name="websiteUrl" class="form-control" value="${loggedInVendor.websiteUrl}">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="location" role="tabpanel">
                        <div class="section-subtitle">Office Address</div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Full Address</label>
                                    <textarea name="companyAddress" class="form-control" rows="3" required>${loggedInVendor.companyAddress}</textarea>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>City</label>
                                    <input type="text" name="city" class="form-control" value="${loggedInVendor.city}">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label>Google Maps Link</label>
                                    <input type="url" name="mapsLink" class="form-control" value="${loggedInVendor.mapsLink}">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="legal" role="tabpanel">
                        <div class="section-subtitle">Verification Documents</div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Reg. ID</label>
                                    <input type="text" name="registrationId" class="form-control" value="${loggedInVendor.registrationId}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>GST Number</label>
                                    <input type="text" name="gstNumber" class="form-control" value="${loggedInVendor.gstNumber}">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>ID Proof</label>
                                    <div class="upload-box" onclick="document.getElementById('idProof').click()">
                                        <i class="fa fa-id-card-o"></i>
                                        <p>${not empty loggedInVendor.idProofPath ? 'Uploaded' : 'Upload ID'}</p>
                                        <input type="file" id="idProof" name="idProof" style="display:none;">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Business License</label>
                                    <div class="upload-box" onclick="document.getElementById('licenseFile').click()">
                                        <i class="fa fa-file-text-o"></i>
                                        <p>${not empty loggedInVendor.licensePath ? 'Uploaded' : 'Upload License'}</p>
                                        <input type="file" id="licenseFile" name="licenseFile" style="display:none;">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Insurance Docs</label>
                                    <div class="upload-box" onclick="document.getElementById('insuranceFile').click()">
                                        <i class="fa fa-shield"></i>
                                        <p>${not empty loggedInVendor.insurancePath ? 'Uploaded' : 'Upload Insurance'}</p>
                                        <input type="file" id="insuranceFile" name="insuranceFile" style="display:none;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="banking" role="tabpanel">
                        <div class="section-subtitle">Banking Details</div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Acc Holder Name</label>
                                    <input type="text" name="bankAccountHolderName" class="form-control" value="${loggedInVendor.bankAccountHolderName}">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Acc Number</label>
                                    <input type="text" name="bankAccountNumber" class="form-control" value="${loggedInVendor.bankAccountNumber}">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>IFSC Code</label>
                                    <input type="text" name="bankIfscCode" class="form-control" value="${loggedInVendor.bankIfscCode}">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>UPI ID</label>
                                    <input type="text" name="upiId" class="form-control" value="${loggedInVendor.upiId}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="text-align:center; margin-top:32px; border-top:1px solid var(--border-color); padding-top:32px;">
                    <button type="submit" class="btn-save">Save Profile Changes</button>
                </div>
            </div>
        </form>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script>
        // Update upload text when file is selected
        $('input[type="file"]').change(function (e) {
            var fileName = e.target.files[0].name;
            $(this).parent().find('p').text(fileName).css('color', 'var(--primary)');
        });
    </script>
</body>
</html>