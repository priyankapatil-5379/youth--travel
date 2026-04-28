<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Tour Portfolio | Youth Travel</title>
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

                .page-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 30px;
                }

                .page-header h1 {
                    font-size: 32px;
                    font-weight: 800;
                    margin: 0;
                }

                .btn-add {
                    background: #f04c26;
                    color: #fff;
                    font-weight: 700;
                    border-radius: 12px;
                    padding: 10px 24px;
                    transition: all 0.2s;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    box-shadow: 0 10px 20px rgba(240, 76, 38, 0.2);
                }

                .btn-add:hover {
                    background: #d93d1a;
                    color: #fff;
                    transform: translateY(-2px);
                    box-shadow: 0 15px 30px rgba(240, 76, 38, 0.3);
                }

                .trip-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                    gap: 30px;
                    margin-top: 20px;
                }

                .trip-card {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 28px;
                    overflow: hidden;
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                    position: relative;
                    display: flex;
                    flex-direction: column;
                }

                .trip-card:hover {
                    transform: translateY(-10px);
                    background: rgba(255, 255, 255, 0.05);
                    border-color: rgba(240, 76, 38, 0.4);
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
                }

                .card-image-box {
                    position: relative;
                    height: 200px;
                    width: 100%;
                    overflow: hidden;
                }

                .card-image-box img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.6s ease;
                }

                .card-badge-price {
                    position: absolute;
                    top: 15px;
                    right: 15px;
                    background: rgba(0, 0, 0, 0.6);
                    backdrop-filter: blur(10px);
                    color: #fff;
                    padding: 8px 16px;
                    border-radius: 12px;
                    font-weight: 800;
                    font-size: 14px;
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    z-index: 2;
                }

                .card-tag {
                    position: absolute;
                    top: 15px;
                    left: 15px;
                    background: #f04c26;
                    color: #fff;
                    padding: 4px 12px;
                    border-radius: 8px;
                    font-size: 10px;
                    font-weight: 800;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .card-content {
                    padding: 24px;
                    flex-grow: 1;
                }

                .card-title {
                    font-size: 18px;
                    font-weight: 800;
                    color: #fff;
                    margin-bottom: 8px;
                }

                .card-meta {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 13px;
                    margin-bottom: 15px;
                }

                .card-category {
                    background: rgba(255, 255, 255, 0.05);
                    padding: 10px;
                    border-radius: 12px;
                    margin-bottom: 20px;
                }

                .category-label {
                    font-size: 10px;
                    color: #f04c26;
                    font-weight: 700;
                    text-transform: uppercase;
                    display: block;
                    margin-bottom: 4px;
                }

                .category-value {
                    font-size: 12px;
                    color: rgba(255, 255, 255, 0.8);
                    display: block;
                }

                .card-footer {
                    padding: 20px 24px;
                    border-top: 1px solid rgba(255, 255, 255, 0.05);
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .status-indicator {
                    display: flex;
                    align-items: center;
                    gap: 6px;
                    font-size: 12px;
                    font-weight: 700;
                    text-transform: uppercase;
                }

                .dot {
                    width: 8px;
                    height: 8px;
                    border-radius: 50%;
                }

                .dot-active {
                    background: #22c55e;
                    box-shadow: 0 0 10px #22c55e;
                }

                .dot-inactive {
                    background: #ef4444;
                    box-shadow: 0 0 10px #ef4444;
                }

                .action-group {
                    display: flex;
                    gap: 8px;
                }

                .mini-btn {
                    width: 32px;
                    height: 32px;
                    border-radius: 8px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #fff;
                    background: rgba(255, 255, 255, 0.08);
                    transition: all 0.2s;
                    text-decoration: none;
                }

                .mini-btn:hover {
                    background: #f04c26;
                    transform: scale(1.1);
                }

                .alert {
                    border-radius: 16px;
                    background: rgba(34, 197, 94, 0.1);
                    border: 1px solid rgba(34, 197, 94, 0.2);
                    color: #22c55e;
                    padding: 15px 25px;
                    margin-bottom: 30px;
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
                <c:if test="${not empty message}">
                    <div class="alert">
                        <i class="fa fa-check-circle"></i> ${message}
                    </div>
                </c:if>

                <div class="page-header">
                    <div>
                        <h1>Tour Portfolio</h1>
                        <p style="color: rgba(255,255,255,0.5); margin-top: 5px;">Manage your travel collection.</p>
                    </div>
                    <a href="<c:url value='/vendor/add-trip'/>" class="btn-add">
                        <i class="fa fa-plus"></i> Launch New Trip
                    </a>
                </div>

                <div class="trip-grid">
                    <c:forEach items="${trips}" var="trip">
                        <div class="trip-card" data-status="${trip.status}">
                            <div class="card-image-box">
                                <span class="card-tag">${trip.duration}</span>
                                <div class="card-badge-price">₹${trip.price}</div>
                                <c:choose>
                                    <c:when test="${not empty trip.imageUrl}">
                                        <img src="<c:url value='${trip.imageUrl}'/>" alt="Trip">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&q=80&w=600"
                                            alt="Trip">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="card-content">
                                <h3 class="card-title">${trip.title}</h3>
                                <div class="card-meta">
                                    <span><i class="fa fa-map-marker" style="color: #f04c26;"></i>
                                        ${trip.destination}</span>
                                </div>
                                <div class="card-category">
                                    <span class="category-label">Classification</span>
                                    <span class="category-value">${not empty trip.travelerCategory ?
                                        trip.travelerCategory : 'General'}</span>
                                    <span class="category-value"
                                        style="font-size: 11px; opacity: 0.6; margin-top: 4px;">
                                        ${not empty trip.travelerSubCategory ? trip.travelerSubCategory : ''}
                                    </span>
                                </div>
                            </div>

                            <div class="card-footer">
                                <div class="status-indicator"
                                    style="color: ${trip.status == 'ACTIVE' ? '#22c55e' : '#ef4444'}">
                                    <span class="dot ${trip.status == 'ACTIVE' ? 'dot-active' : 'dot-inactive'}"></span>
                                    ${trip.status}
                                </div>
                                <div class="action-group">
                                    <a href="<c:url value='/vendor/toggle-status/${trip.id}'/>" class="mini-btn"
                                        title="Toggle Status">
                                        <i class="fa fa-power-off"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/edit-trip/${trip.id}'/>" class="mini-btn"
                                        title="Edit">
                                        <i class="fa fa-edit"></i>
                                    </a>
                                    <a href="<c:url value='/vendor/delete-trip/${trip.id}'/>" class="mini-btn"
                                        title="Delete" onclick="return confirm('Delete this adventure?')"
                                        style="color: #ef4444;">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${empty trips}">
                    <div
                        style="text-align: center; padding: 100px 20px; background: rgba(255,255,255,0.02); border-radius: 30px; border: 2px dashed rgba(255,255,255,0.05); margin-top: 30px;">
                        <i class="fa fa-map-o"
                            style="font-size: 60px; color: rgba(255,255,255,0.1); margin-bottom: 20px;"></i>
                        <h2 style="color: rgba(255,255,255,0.4);">No Adventures Found</h2>
                        <p style="color: rgba(255,255,255,0.2);">Start by adding your first travel package.</p>
                        <a href="<c:url value='/vendor/add-trip'/>" class="btn-add"
                            style="display: inline-flex; margin-top: 20px;">
                            <i class="fa fa-plus"></i> Create Catalog
                        </a>
                    </div>
                </c:if>
            </div>
            <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
            <script>
                function toggleSidebar() {
                    $('.sidebar').toggleClass('show');
                    $('.sidebar-overlay').toggleClass('show');
                }

                $(document).ready(function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    const filter = urlParams.get('filter');

                    if (filter) {
                        const cards = document.querySelectorAll('.trip-card');
                        let count = 0;
                        cards.forEach(card => {
                            if (card.getAttribute('data-status') === filter) {
                                card.style.display = 'flex';
                                count++;
                            } else {
                                card.style.display = 'none';
                            }
                        });

                        // Update header title to reflect filter
                        const header = document.querySelector('.page-header h1');
                        header.innerText = filter.charAt(0) + filter.slice(1).toLowerCase() + ' Collections';

                        // Handle empty case
                        if (count === 0) {
                            $('.trip-grid').after('<div id="filter-empty" style="text-align:center; padding:50px; opacity:0.5;"><h3>No ' + filter.toLowerCase() + ' tours found.</h3></div>');
                        }
                    }
                });
            </script>
        </body>

        </html>