<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="sidebar">
    <ul class="nav-menu">
        <li class="nav-item ${param.activePage == 'dashboard' ? 'active' : ''}">
            <a href="<c:url value='/user/dashboard'/>"><i class="fa fa-th-large"></i> <span class="nav-text">Dashboard</span></a>
        </li>
        <li class="nav-item ${param.activePage == 'explore' ? 'active' : ''}">
            <a href="<c:url value='/user/explore'/>"><i class="fa fa-users"></i> <span class="nav-text">Explore Users</span></a>
        </li>
        <li class="nav-item ${param.activePage == 'bookings' ? 'active' : ''}">
            <a href="<c:url value='/user/my-bookings'/>"><i class="fa fa-calendar-check-o"></i> <span class="nav-text">My Bookings</span></a>
        </li>
        <li class="nav-item ${param.activePage == 'saved' ? 'active' : ''}">
            <a href="<c:url value='/user/saved-trips'/>"><i class="fa fa-heart-o"></i> <span class="nav-text">Saved Trips</span></a>
        </li>
        <li class="nav-item ${param.activePage == 'reviews' ? 'active' : ''}">
            <a href="<c:url value='/user/my-reviews'/>"><i class="fa fa-star-o"></i> <span class="nav-text">My Reviews</span></a>
        </li>
        <li class="nav-item ${param.activePage == 'payments' ? 'active' : ''}">
            <a href="<c:url value='/user/payments'/>"><i class="fa fa-credit-card"></i> <span class="nav-text">Payments</span></a>
        </li>
        <li class="nav-item ${param.activePage == 'messages' ? 'active' : ''}">
            <a href="<c:url value='/user/messages'/>"><i class="fa fa-envelope-o"></i> <span class="nav-text">Messages</span></a>
        </li>
        <li style="margin: 20px 0; border-top: 1px solid rgba(255,255,255,0.1);"></li>
        <li class="nav-item ${param.activePage == 'profile' ? 'active' : ''}">
            <a href="<c:url value='/profile'/>"><i class="fa fa-cog"></i> <span class="nav-text">Profile Settings</span></a>
        </li>
        <li class="nav-item">
            <a href="<c:url value='/user/logout'/>"><i class="fa fa-sign-out"></i> <span class="nav-text">Logout</span></a>
        </li>
    </ul>
</aside>

<style>
    .sidebar {
        width: 240px;
        background: rgba(0, 0, 0, 0.3);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        padding-top: 80px;
        position: fixed;
        height: 100vh;
        border-right: 1px solid rgba(255, 255, 255, 0.1);
        z-index: 900;
        transition: 0.3s;
    }

    .nav-menu {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .nav-item a {
        display: flex;
        align-items: center;
        padding: 12px 25px;
        color: rgba(255, 255, 255, 0.6);
        text-decoration: none;
        font-weight: 500;
        transition: 0.3s ease;
        gap: 15px;
        font-size: 15px;
        border-radius: 12px;
        margin: 4px 15px;
    }

    .nav-item.active a {
        background: rgba(230, 57, 70, 0.2);
        color: #e63946;
        border: 1px solid rgba(230, 57, 70, 0.3);
    }

    .nav-item a:hover:not(.active) {
        color: #fff;
        background: rgba(255, 255, 255, 0.05);
    }

    @media (max-width: 991px) {
        .sidebar {
            width: 70px;
        }
        .sidebar .nav-item a .nav-text { display: none; }
        .sidebar .nav-item a { padding: 12px; justify-content: center; margin: 4px 10px; }
        .sidebar .nav-item a i { margin: 0; font-size: 18px; }
    }
</style>
