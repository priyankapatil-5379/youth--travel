<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    :root {
        --primary-color: #e63946;
        --primary-gradient: linear-gradient(135deg, #e63946 0%, #c1121f 100%);
        --card-border: rgba(255, 255, 255, 0.1);
        --text-muted: rgba(255, 255, 255, 0.6);
        --danger: #ef4444;
    }

    .sidebar {
        background: rgba(0,0,0,0.3);
        backdrop-filter: blur(25px);
        border-right: 1px solid rgba(255,255,255,0.1);
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        width: 260px;
        padding: 40px 25px;
        z-index: 1000;
        transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        overflow-y: auto;
        box-shadow: 10px 0 30px rgba(0,0,0,0.3);
    }

    /* Hide scrollbar for sidebar */
    .sidebar::-webkit-scrollbar {
        width: 0px;
        background: transparent;
    }

    .sidebar-logo {
        margin-bottom: 50px;
        text-align: center;
    }

    .sidebar-logo img {
        height: 36px;
        transition: transform 0.3s;
    }

    .sidebar-logo img:hover { transform: scale(1.05); }

    .nav-sidebar {
        padding: 0;
        list-style: none;
    }

    .nav-sidebar li {
        margin-bottom: 10px;
    }

    .nav-sidebar a {
        color: rgba(255,255,255,0.7);
        display: flex;
        align-items: center;
        padding: 14px 20px;
        border-radius: 14px;
        font-weight: 700;
        font-size: 15px;
        transition: all 0.3s ease;
        text-decoration: none;
        position: relative;
        overflow: hidden;
        text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    }

    .nav-sidebar a i {
        width: 24px;
        font-size: 18px;
        margin-right: 15px;
        text-align: center;
        z-index: 2;
    }

    .nav-sidebar a span { z-index: 2; }

    .nav-sidebar a::before {
        content: '';
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: var(--primary-gradient);
        opacity: 0;
        transition: 0.3s;
        z-index: 1;
    }

    .nav-sidebar a:hover {
        color: #fff;
        background: rgba(255,255,255,0.05);
        transform: translateX(5px);
    }

    .nav-sidebar a.active {
        color: #fff;
        box-shadow: 0 10px 20px rgba(240, 76, 38, 0.3);
        text-shadow: 0 2px 10px rgba(255,255,255,0.3);
    }
    
    .nav-sidebar a.active::before { opacity: 1; }

    .main-content {
        margin-left: 260px;
        position: relative;
        min-height: 100vh;
        padding: 40px;
    }

    .mobile-sidebar-toggle {
        display: none;
    }

    @media (max-width: 991px) {
        .sidebar {
            transform: translateX(-100%);
            box-shadow: 10px 0 30px rgba(0,0,0,0.5);
        }
        .sidebar.active {
            transform: translateX(0);
        }
        .main-content {
            margin-left: 0;
            padding: 80px 20px 40px;
        }
        .mobile-sidebar-toggle {
            display: flex;
            position: fixed;
            top: 15px;
            left: 15px;
            width: 45px;
            height: 45px;
            background: rgba(0,0,0,0.5);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 12px;
            border: 1px solid rgba(255,255,255,0.2);
            color: #fff;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            cursor: pointer;
            z-index: 9999;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }
    }

    .sidebar-overlay {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(0,0,0,0.6);
        backdrop-filter: blur(4px);
        z-index: 899;
        display: none;
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    .sidebar-overlay.active {
        display: block;
        opacity: 1;
    }
</style>

<div class="mobile-sidebar-toggle d-lg-none" onclick="toggleMainSidebar()">
    <i class="fa fa-bars"></i>
</div>

<div class="sidebar-overlay" onclick="toggleMainSidebar()"></div>

<script>
    function toggleMainSidebar() {
        document.querySelector('.sidebar').classList.toggle('active');
        document.querySelector('.sidebar-overlay').classList.toggle('active');
    }
</script>

<div class="sidebar">
    <div class="sidebar-logo">
        <a href="<c:url value='/'/>">
            <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
        </a>
    </div>
    <ul class="nav-sidebar">
        <li><a href="<c:url value='/vendor/dashboard'/>" class="${param.activePage == 'dashboard' ? 'active' : ''}"><span><i class="fa fa-th-large"></i> Dashboard</span></a></li>
        <li><a href="<c:url value='/vendor/tours'/>" class="${param.activePage == 'tours' ? 'active' : ''}"><span><i class="fa fa-map"></i> Manage Tours</span></a></li>
        <li><a href="<c:url value='/vendor/add-trip'/>" class="${param.activePage == 'add-trip' ? 'active' : ''}"><span><i class="fa fa-plus-circle"></i> Create Trip</span></a></li>
        <li><a href="<c:url value='/vendor/inventory'/>" class="${param.activePage == 'inventory' ? 'active' : ''}"><span><i class="fa fa-tasks"></i> Inventory & Slots</span></a></li>
        <li><a href="<c:url value='/vendor/bookings'/>" class="${param.activePage == 'bookings' ? 'active' : ''}"><span><i class="fa fa-calendar"></i> Bookings</span></a></li>
        <li><a href="<c:url value='/vendor/messages'/>" class="${param.activePage == 'messages' ? 'active' : ''}"><span><i class="fa fa-envelope"></i> Messages</span></a></li>
        <li><a href="<c:url value='/vendor/reviews'/>" class="${param.activePage == 'reviews' ? 'active' : ''}"><span><i class="fa fa-star"></i> Reviews</span></a></li>
        <li><a href="<c:url value='/vendor/earnings'/>" class="${param.activePage == 'earnings' ? 'active' : ''}"><span><i class="fa fa-line-chart"></i> Financials</span></a></li>
        <li><a href="<c:url value='/vendor/profile'/>" class="${param.activePage == 'profile' ? 'active' : ''}"><span><i class="fa fa-user"></i> Settings</span></a></li>
        <li style="margin-top: 50px;"><a href="<c:url value='/vendor/logout'/>" style="color: var(--danger);"><span><i class="fa fa-sign-out"></i> Logout</span></a></li>
    </ul>
</div>
