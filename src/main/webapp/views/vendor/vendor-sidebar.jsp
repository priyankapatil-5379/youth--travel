<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

    :root {
        --primary-teal: #008080;
        --secondary-teal: #077378;
        --accent-red: #e63946;
        --sidebar-bg-gradient: linear-gradient(to bottom, #008080, #077378);
        --sidebar-text: rgba(255, 255, 255, 0.7);
        --sidebar-text-active: #ffffff;
        --sidebar-hover-bg: rgba(255, 255, 255, 0.1);
        --danger: #e63946;
    }

    .sidebar {

        background:linear-gradient(to bottom, #81A6C6,darkcyan);
        backdrop-filter: blur(25px);
        border-right: 1px solid rgba(255,255,255,0.1);

        background: var(--sidebar-bg-gradient);
        border-right: 1px solid rgba(255, 255, 255, 0.1);

        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        width: 260px;
        padding: 32px 16px;
        z-index: 1000;
        transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        overflow-y: auto;
        font-family: 'Inter', sans-serif;
        color: white;
    }

    /* Hide scrollbar for sidebar */
    .sidebar::-webkit-scrollbar {
        width: 0px;
        background: transparent;
    }

    .sidebar-logo {
        margin-bottom: 40px;
        padding: 0 12px;
        text-align: left;
    }

    .sidebar-logo img {
        height: 32px;
        filter: brightness(0) invert(1); /* Ensure logo is visible on dark */
    }

    .nav-sidebar {
        padding: 0;
        list-style: none;
    }

    .nav-sidebar li {
        margin-bottom: 4px;
    }

    .nav-sidebar a {
        color: var(--sidebar-text);
        display: flex;
        align-items: center;
        padding: 12px 16px;
        border-radius: 10px;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.2s ease;
        text-decoration: none;
        position: relative;
    }

    .nav-sidebar a i {
        width: 20px;
        font-size: 16px;
        margin-right: 12px;
        text-align: center;
    }

    .nav-sidebar a:hover {
        color: var(--sidebar-text-active);
        background: var(--sidebar-hover-bg);
    }

    .nav-sidebar a.active {
        color: var(--sidebar-text-active);
        background: var(--accent-red);
        font-weight: 600;
        box-shadow: 0 10px 15px -3px rgba(230, 57, 70, 0.3);
    }
    
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
            box-shadow: 20px 0 25px -5px rgba(0, 0, 0, 0.1);
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
            width: 40px;
            height: 40px;
            background: var(--primary-teal);
            border-radius: 8px;
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
            z-index: 9999;
        }
    }

    .sidebar-overlay {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(15, 23, 42, 0.7);
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
        <li><a href="<c:url value='/vendor/dashboard'/>" class="${param.activePage == 'dashboard' ? 'active' : ''}"><i class="fa fa-th-large"></i> Dashboard</a></li>
        <li><a href="<c:url value='/vendor/tours'/>" class="${param.activePage == 'tours' ? 'active' : ''}"><i class="fa fa-map"></i> Manage Tours</a></li>
        <li><a href="<c:url value='/vendor/add-trip'/>" class="${param.activePage == 'add-trip' ? 'active' : ''}"><i class="fa fa-plus-circle"></i> Create Trip</a></li>
        <li><a href="<c:url value='/vendor/inventory'/>" class="${param.activePage == 'inventory' ? 'active' : ''}"><i class="fa fa-tasks"></i> Inventory & Slots</a></li>
        <li><a href="<c:url value='/vendor/bookings'/>" class="${param.activePage == 'bookings' ? 'active' : ''}"><i class="fa fa-calendar"></i> Bookings</a></li>
        <li><a href="<c:url value='/vendor/messages'/>" class="${param.activePage == 'messages' ? 'active' : ''}"><i class="fa fa-envelope"></i> Messages</a></li>
        <li><a href="<c:url value='/vendor/reviews'/>" class="${param.activePage == 'reviews' ? 'active' : ''}"><i class="fa fa-star"></i> Reviews</a></li>
        <li><a href="<c:url value='/vendor/earnings'/>" class="${param.activePage == 'earnings' ? 'active' : ''}"><i class="fa fa-line-chart"></i> Financials</a></li>
        <li><a href="<c:url value='/vendor/profile'/>" class="${param.activePage == 'profile' ? 'active' : ''}"><i class="fa fa-user"></i> Settings</a></li>
        <li style="margin-top: 40px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.05);">
            <a href="<c:url value='/vendor/logout'/>" class="logout-link" style="color: var(--danger);">
                <i class="fa fa-sign-out"></i> Logout
            </a>
        </li>
    </ul>
</div>
