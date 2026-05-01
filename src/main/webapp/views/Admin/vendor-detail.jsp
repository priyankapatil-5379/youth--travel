<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vendor Details - Youth Travel Admin</title>
    
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    
    <style>
        body { font-family: 'Dosis', sans-serif; background-color: #0f1015; color: #fff; }
        .admin-layout { display: flex; min-height: 100vh; }
        .admin-sidebar { width: 260px; background: #000; color: #fff; flex-shrink: 0; box-shadow: 4px 0 15px rgba(0,0,0,0.5); border-right: 1px solid #222; }
        .sidebar-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid #222; }
        .sidebar-header img { max-width: 150px; filter: brightness(0) invert(1); }
        .admin-nav { padding: 20px 0; }
        .admin-nav-item { padding: 12px 25px; display: flex; align-items: center; color: #888; text-decoration: none; transition: 0.3s; font-size: 16px; font-weight: 500; }
        .admin-nav-item i { margin-right: 15px; width: 20px; text-align: center; }
        .admin-nav-item:hover, .admin-nav-item.active { background: #1a1a1a; color: #fff; text-decoration: none; }
        .admin-nav-item.active { border-left: 4px solid #ff4d4d; background: rgba(255,77,77,0.1); }
        .admin-main { flex-grow: 1; padding: 40px; overflow-y: auto; }
        .admin-header { margin-bottom: 40px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header h1 { font-weight: 700; color: #fff; margin: 0; font-size: 28px; text-transform: uppercase; }
        .admin-section { background: #1e1e26; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); border: 1px solid #2a2a35; margin-bottom: 30px; }
        .detail-row { display: flex; margin-bottom: 15px; border-bottom: 1px solid #2a2a35; padding-bottom: 10px; }
        .detail-label { width: 200px; color: #888; font-weight: 600; text-transform: uppercase; font-size: 14px; }
        .detail-value { flex-grow: 1; color: #ddd; }
        .doc-card { background: #2a2a35; padding: 15px; border-radius: 8px; text-align: center; margin-bottom: 20px; }
        .doc-card img { max-width: 100%; height: auto; border-radius: 5px; margin-bottom: 10px; max-height: 150px; object-fit: cover; }
        .doc-card a { color: #fff; text-decoration: none; background: #007bff; padding: 5px 15px; border-radius: 5px; font-size: 14px; display: inline-block; }
    </style>

</head>

<body>
    <div class="admin-layout">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel"></a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item"><i class="fa fa-motorcycle"></i> Manage Trips</a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item"><i class="fa fa-users"></i> User Accounts</a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item active"><i class="fa fa-handshake-o"></i> Vendor Requests</a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item"><i class="fa fa-envelope"></i> Inquiries</a>
                <div style="margin-top: 50px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item"><i class="fa fa-sign-out"></i> Back to Site</a>
                </div>
            </nav>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1>Vendor Detail</h1>
                <a href="<c:url value='/admin/vendors'/>" class="btn btn-secondary" style="background:#333; border:none; color:white; padding: 10px 20px; border-radius: 5px; text-decoration: none;">&larr; Back to List</a>
            </header>

            <c:if test="${empty vendor}">
                <div class="alert alert-danger">Vendor not found.</div>
            </c:if>

            <c:if test="${not empty vendor}">
                <div class="row">
                    <div class="col-md-6">
                        <div class="admin-section">
                            <h3>Basic Information</h3>
                            <div style="margin-top: 20px;">
                                <div class="detail-row">
                                    <div class="detail-label">Status</div>
                                    <div class="detail-value">
                                        <span style="padding: 5px 10px; border-radius: 3px; font-size: 14px; font-weight: bold;
                                            ${vendor.status == 'APPROVED' ? 'background: rgba(40,167,69,0.2); color: #28a745;' : ''}
                                            ${vendor.status == 'REJECTED' ? 'background: rgba(220,53,69,0.2); color: #dc3545;' : ''}
                                            ${vendor.status == 'PENDING' ? 'background: rgba(255,193,7,0.2); color: #ffc107;' : ''}
                                        ">
                                            ${vendor.status}
                                        </span>
                                    </div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Business Name</div>
                                    <div class="detail-value">${vendor.businessName}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Owner Name</div>
                                    <div class="detail-value">${vendor.ownerName}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Email</div>
                                    <div class="detail-value">${vendor.emailId}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Phone</div>
                                    <div class="detail-value">${vendor.phoneNumber}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Registration ID</div>
                                    <div class="detail-value">${vendor.registrationId != null ? vendor.registrationId : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">About</div>
                                    <div class="detail-value">${vendor.about != null ? vendor.about : 'N/A'}</div>
                                </div>
                            </div>
                        </div>

                        <div class="admin-section">
                            <h3>Branding & Presence</h3>
                            <div style="margin-top: 20px;">
                                <div class="detail-row">
                                    <div class="detail-label">Brand Name</div>
                                    <div class="detail-value">${vendor.brandName != null ? vendor.brandName : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">WhatsApp</div>
                                    <div class="detail-value">${vendor.whatsappNumber != null ? vendor.whatsappNumber : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Address</div>
                                    <div class="detail-value">${vendor.companyAddress != null ? vendor.companyAddress : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">City, State, Country</div>
                                    <div class="detail-value">${vendor.city != null ? vendor.city : 'N/A'}, ${vendor.state != null ? vendor.state : 'N/A'}, ${vendor.country != null ? vendor.country : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Website</div>
                                    <div class="detail-value">${vendor.websiteUrl != null ? vendor.websiteUrl : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Social Media</div>
                                    <div class="detail-value">
                                        Insta: ${vendor.instagramUrl != null ? vendor.instagramUrl : 'N/A'}<br>
                                        FB: ${vendor.facebookUrl != null ? vendor.facebookUrl : 'N/A'}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="admin-section">
                            <h3>Service Details</h3>
                            <div style="margin-top: 20px;">
                                <div class="detail-row">
                                    <div class="detail-label">Experience</div>
                                    <div class="detail-value">${vendor.experienceYears != null ? vendor.experienceYears : '0'} Years</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Languages</div>
                                    <div class="detail-value">${vendor.languages != null ? vendor.languages : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Target Audience</div>
                                    <div class="detail-value">${vendor.targetAudience != null ? vendor.targetAudience : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Service Areas</div>
                                    <div class="detail-value">${vendor.serviceAreas != null ? vendor.serviceAreas : 'N/A'}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="admin-section">
                            <h3>Legal & Verification</h3>
                            <div style="margin-top: 20px;">
                                <div class="detail-row">
                                    <div class="detail-label">Business Type</div>
                                    <div class="detail-value">${vendor.businessType != null ? vendor.businessType : 'Not specified'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">GST Number</div>
                                    <div class="detail-value">${vendor.gstNumber != null ? vendor.gstNumber : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">PAN Number</div>
                                    <div class="detail-value">${vendor.panNumber != null ? vendor.panNumber : 'N/A'}</div>
                                </div>
                                <div class="detail-row">
                                    <div class="detail-label">Terms Accepted</div>
                                    <div class="detail-value">${vendor.termsAccepted ? 'Yes' : 'No'}</div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="admin-section">
                    <h3>Uploaded Media & Documents</h3>
                    <div style="margin-top: 20px; display: flex; flex-wrap: wrap; gap: 20px;">
                        <div class="doc-card" style="width: 250px;">
                            <h5>Logo</h5>
                            <c:choose>
                                <c:when test="${not empty vendor.logoPath}">
                                    <a href="<c:url value='/${vendor.logoPath}'/>" target="_blank">View Logo</a>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #888; font-size: 14px;">Not Provided</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="doc-card" style="width: 250px;">
                            <h5>Banner</h5>
                            <c:choose>
                                <c:when test="${not empty vendor.bannerPath}">
                                    <a href="<c:url value='/${vendor.bannerPath}'/>" target="_blank">View Banner</a>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #888; font-size: 14px;">Not Provided</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="doc-card" style="width: 250px;">
                            <h5>ID Proof</h5>
                            <c:choose>
                                <c:when test="${not empty vendor.idProofPath}">
                                    <a href="<c:url value='/${vendor.idProofPath}'/>" target="_blank">View Document</a>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #888; font-size: 14px;">Not Provided</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="doc-card" style="width: 250px;">
                            <h5>Business Details / License</h5>
                            <c:choose>
                                <c:when test="${not empty vendor.licensePath}">
                                    <a href="<c:url value='/${vendor.licensePath}'/>" target="_blank">View Document</a>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #888; font-size: 14px;">Not Provided</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="doc-card" style="width: 250px;">
                            <h5>Insurance Document</h5>
                            <c:choose>
                                <c:when test="${not empty vendor.insurancePath}">
                                    <a href="<c:url value='/${vendor.insurancePath}'/>" target="_blank">View Document</a>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #888; font-size: 14px;">Not Provided</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>

                <div class="admin-section">
                    <h3>Actions</h3>
                    <div style="margin-top: 20px; display: flex; gap: 15px;">
                        <form action="<c:url value='/admin/vendors/${vendor.id}/approve'/>" method="post">
                            <button type="submit" class="btn" style="background: #28a745; color: white; padding: 10px 30px; border-radius: 5px; border: none; font-weight: bold; cursor: pointer;" ${vendor.status == 'APPROVED' ? 'disabled' : ''}>
                                Approve Vendor
                            </button>
                        </form>
                        <form action="<c:url value='/admin/vendors/${vendor.id}/reject'/>" method="post">
                            <button type="submit" class="btn" style="background: #dc3545; color: white; padding: 10px 30px; border-radius: 5px; border: none; font-weight: bold; cursor: pointer;" ${vendor.status == 'REJECTED' ? 'disabled' : ''}>
                                Reject Vendor
                            </button>
                        </form>
                    </div>
                </div>
            </c:if>

        </main>
    </div>
</body>
</html>
