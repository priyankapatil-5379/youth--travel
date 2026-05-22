<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Homepage Photos - Youth Travel Admin</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f1f5f9; color: #0f172a; }
        .admin-layout { display: flex; min-height: 100vh; }
        .admin-sidebar { width: 260px; background: rgba(0,0,0,0.4); backdrop-filter: blur(25px); border-right: 1px solid rgba(255,255,255,0.1); flex-shrink: 0; }
        .sidebar-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-header img { max-width: 150px; filter: brightness(0) invert(1); }
        .admin-nav { padding: 20px 0; }
        .admin-nav-item { padding: 12px 25px; display: flex; align-items: center; color: rgba(255,255,255,0.6); text-decoration: none; transition: 0.3s; font-size: 16px; }
        .admin-nav-item i { margin-right: 15px; width: 20px; text-align: center; }
        .admin-nav-item:hover, .admin-nav-item.active { background: rgba(230,57,70,0.15); color: #e63946; }
        .admin-nav-item.active { border-left: 4px solid #e63946; }
        .admin-main { flex-grow: 1; padding: 40px; overflow-y: auto; }
        .admin-header h1 { font-weight: 800; font-size: 32px; text-shadow: 0 4px 15px rgba(0,0,0,0.5); margin-bottom: 30px; }
        .upload-section { background: rgba(255,255,255,0.05); padding: 30px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.1); margin-bottom: 40px; }
        .image-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; }
        .image-card { background: rgba(255,255,255,0.03); border-radius: 15px; overflow: hidden; border: 1px solid rgba(255,255,255,0.05); position: relative; }
        .image-card img { width: 100%; height: 150px; object-fit: cover; }
        .image-card .info { padding: 10px; font-size: 13px; }
        .delete-btn { position: absolute; top: 10px; right: 10px; background: rgba(230,57,70,0.8); border: none; color: #fff; width: 30px; height: 30px; border-radius: 50%; cursor: pointer; transition: 0.3s; }
        .delete-btn:hover { background: #e63946; transform: scale(1.1); }
        .section-title { font-size: 20px; font-weight: 700; margin: 30px 0 20px; padding-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); color: #e63946; text-transform: uppercase; letter-spacing: 1px; }
        .edit-btn { position: absolute; top: 10px; right: 45px; background: rgba(255,255,255,0.2); border: none; color: #fff; width: 30px; height: 30px; border-radius: 50%; cursor: pointer; transition: 0.3s; display: flex; align-items: center; justify-content: center; }
        .edit-btn:hover { background: #007bff; transform: scale(1.1); }
        .modal-content { background: #1a1a1a; border: 1px solid rgba(255,255,255,0.1); color: #fff; border-radius: 20px; }
        .modal-header { border-bottom: 1px solid rgba(255,255,255,0.1); }
        .modal-footer { border-top: 1px solid rgba(255,255,255,0.1); }
        .form-control:focus { background: #222; border-color: #e63946; color: #fff; box-shadow: none; }
    </style>
<link rel="stylesheet" href="<c:url value='/views/assets/css/admin-light.css'/>">
</head>
<body class="admin-light-theme">
    <div class="admin-layout">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item ">
                    <i class="fa fa-th-large"></i> Dashboard
                </a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item ">
                    <i class="fa fa-motorcycle"></i> Manage Trips
                </a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item ">
                    <i class="fa fa-users"></i> User Accounts
                </a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item ">
                    <i class="fa fa-handshake-o"></i> Vendor Requests
                </a>
                <a href="<c:url value='/admin/payouts'/>" class="admin-nav-item ">
                    <i class="fa fa-money"></i> Payout Requests
                </a>
                <a href="<c:url value='/admin/home-images'/>" class="admin-nav-item active">
                    <i class="fa fa-image"></i> Homepage Photos
                </a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item ">
                    <i class="fa fa-envelope"></i> Inquiries
                </a>
                <div style="margin-top: 50px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item">
                        <i class="fa fa-sign-out"></i> Back to Site
                    </a>
                </div>
            </nav>
        </aside>

        <main class="admin-main">
            <h1>Dynamic Homepage Photos</h1>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="upload-section">
                <h4 style="margin-bottom: 20px; font-weight: 700;">Upload New Photo</h4>
                <form action="<c:url value='/admin/home-images/upload'/>" method="POST" enctype="multipart/form-data" class="row">
                    <div class="col-md-4">
                        <label>Select Section</label>
                        <select name="section" class="form-control">
                            <option value="GALLERY">Gallery Section</option>
                            <option value="MOMENTS">More Moments Section</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label>Image File</label>
                        <input type="file" name="file" class="form-control" required>
                    </div>
                    <div class="col-md-3">
                        <label>Caption (Optional)</label>
                        <input type="text" name="caption" class="form-control" placeholder="e.g. Scuba Diving Fun">
                    </div>
                    <div class="col-md-1">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-danger btn-block" style="background: #008080; border: none; font-weight: 700;">Upload</button>
                    </div>
                </form>
            </div>

            <h2 class="section-title">Gallery Photos</h2>
            <div class="image-grid">
                <c:forEach var="img" items="${galleryImages}">
                    <div class="image-card">
                        <div class="d-flex">
                            <button type="button" class="edit-btn" title="Edit Info" onclick="openEditModal('${img.id}', '${img.caption}', '${img.section}')">
                                <i class="fa fa-pencil"></i>
                            </button>
                            <form action="<c:url value='/admin/home-images/${img.id}/delete'/>" method="POST">
                                <button type="submit" class="delete-btn" title="Delete Image" onclick="return confirm('Are you sure?')">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </form>
                        </div>
                        <img src="<c:url value='${img.imageUrl}'/>" alt="Gallery">
                        <div class="info">
                            <span style="color: #eee; font-weight: 600; display: block; margin-bottom: 2px;">${img.section}</span>
                            <span style="color: #888;">${img.caption != null ? img.caption : 'No caption'}</span>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty galleryImages}">
                    <p style="color: #555;">No images in gallery section yet.</p>
                </c:if>
            </div>

            <h2 class="section-title">More Moments Photos</h2>
            <div class="image-grid">
                <c:forEach var="img" items="${momentImages}">
                    <div class="image-card">
                        <div class="d-flex">
                            <button type="button" class="edit-btn" title="Edit Info" onclick="openEditModal('${img.id}', '${img.caption}', '${img.section}')">
                                <i class="fa fa-pencil"></i>
                            </button>
                            <form action="<c:url value='/admin/home-images/${img.id}/delete'/>" method="POST">
                                <button type="submit" class="delete-btn" title="Delete Image" onclick="return confirm('Are you sure?')">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </form>
                        </div>
                        <img src="<c:url value='${img.imageUrl}'/>" alt="Moment">
                        <div class="info">
                            <span style="color: #eee; font-weight: 600; display: block; margin-bottom: 2px;">${img.section}</span>
                            <span style="color: #888;">${img.caption != null ? img.caption : 'No caption'}</span>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty momentImages}">
                    <p style="color: #555;">No images in moments section yet.</p>
                </c:if>
            </div>
        </main>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <form id="editForm" method="POST">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Photo Info</h5>
                        <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <label class="mb-1">Section</label>
                            <select name="section" id="editSection" class="form-control" style="background: #222; color: #fff; border: 1px solid #444;">
                                <option value="GALLERY">Gallery Section</option>
                                <option value="MOMENTS">More Moments Section</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="mb-1">Caption</label>
                            <input type="text" name="caption" id="editCaption" class="form-control" style="background: #222; color: #fff; border: 1px solid #444;">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger" style="background: #e63946; border: none;">Save Changes</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script>
        function openEditModal(id, caption, section) {
            const baseUrl = "<c:url value='/admin/home-images/'/>";
            document.getElementById('editForm').action = baseUrl + id + "/edit";
            document.getElementById('editCaption').value = caption;
            document.getElementById('editSection').value = section;
            $('#editModal').modal('show');
        }
    </script>
</body>
</html>
