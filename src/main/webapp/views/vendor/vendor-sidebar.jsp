<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    :root {
        --primary-color: #f04c26;
        --primary-gradient: linear-gradient(135deg, #f04c26 0%, #d84422 100%);
        --card-border: rgba(255, 255, 255, 0.05);
        --text-muted: rgba(255, 255, 255, 0.6);
        --danger: #ef4444;
    }

    .sidebar {
        background: rgba(11, 15, 24, 0.95);
        backdrop-filter: blur(20px);
        border-right: 1px solid var(--card-border);
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        width: 260px;
        padding: 40px 25px;
        z-index: 1000;
        transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        overflow-y: auto;
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
        color: var(--text-muted);
        display: flex;
        align-items: center;
        padding: 14px 20px;
        border-radius: 14px;
        font-weight: 600;
        font-size: 15px;
        transition: all 0.3s ease;
        text-decoration: none;
        position: relative;
        overflow: hidden;
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
        box-shadow: 0 10px 20px rgba(240, 76, 38, 0.2);
    }
    
    .nav-sidebar a.active::before { opacity: 1; }

    .main-content {
        margin-left: 260px;
        position: relative;
        min-height: 100vh;
        padding: 40px;
    }
</style>

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
