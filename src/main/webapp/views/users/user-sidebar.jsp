<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <style>
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
                color: white;
            }

            .sidebar::-webkit-scrollbar {
                width: 0px;
                background: transparent;
            }

            .sidebar-logo {
                margin-bottom: 30px;
                padding: 0 12px;
                text-align: left;
            }

            .sidebar-logo img {
                height: 32px;
                filter: brightness(0) invert(1);
            }

            .user-profile-mini {
                padding: 15px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                margin: 0 12px 30px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .user-profile-mini img {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                border: 2px solid rgba(255, 255, 255, 0.2);
            }

            .user-profile-mini .info {
                overflow: hidden;
            }

            .user-profile-mini .label {
                font-size: 10px;
                text-transform: uppercase;
                letter-spacing: 1px;
                opacity: 0.7;
                display: block;
            }

            .user-profile-mini .name {
                font-size: 13px;
                font-weight: 600;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                display: block;
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

            @media (max-width: 991px) {
                .sidebar {
                    transform: translateX(-100%);
                }

                .sidebar.active {
                    transform: translateX(0);
                }
            }
        </style>

        <div class="sidebar">
            <div class="sidebar-logo">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>

            <div class="user-profile-mini">
                <c:set var="defaultAvatar"
                    value="https://ui-avatars.com/api/?name=${user.name}&background=fff&color=008080" />
                <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" alt="Profile">
                <div class="info">
                    <span class="label">Explorer</span>
                    <span class="name">${user.name}</span>
                </div>
            </div>

            <ul class="nav-sidebar">
                <li><a href="<c:url value='/user/dashboard'/>"
                        class="${param.activePage == 'dashboard' ? 'active' : ''}"><i class="fa fa-th-large"></i>
                        Dashboard</a></li>
                <li><a href="<c:url value='/user/explore'/>" class="${param.activePage == 'explore' ? 'active' : ''}"><i
                            class="fa fa-compass"></i> Explore</a></li>
                <li><a href="<c:url value='/user/my-bookings'/>"
                        class="${param.activePage == 'bookings' ? 'active' : ''}"><i class="fa fa-calendar-check-o"></i>
                        My Bookings</a></li>
                <li><a href="<c:url value='/user/saved-trips'/>"
                        class="${param.activePage == 'saved' ? 'active' : ''}"><i class="fa fa-heart-o"></i> Saved
                        Trips</a></li>
                <li><a href="<c:url value='/user/my-reviews'/>"
                        class="${param.activePage == 'reviews' ? 'active' : ''}"><i class="fa fa-star-o"></i> My
                        Reviews</a></li>
                <li><a href="<c:url value='/user/payments'/>"
                        class="${param.activePage == 'payments' ? 'active' : ''}"><i class="fa fa-credit-card"></i>
                        Payments</a></li>
                <li><a href="<c:url value='/user/messages'/>"
                        class="${param.activePage == 'messages' ? 'active' : ''}"><i class="fa fa-envelope-o"></i>
                        Messages</a></li>
                <li style="margin: 20px 0; border-top: 1px solid rgba(255,255,255,0.1);"></li>
                <li><a href="<c:url value='/profile'/>" class="${param.activePage == 'profile' ? 'active' : ''}"><i
                            class="fa fa-user-circle-o"></i> Profile</a></li>
                <li><a href="<c:url value='/user/logout'/>" style="color: #ff9999;"><i class="fa fa-sign-out"></i>
                        Logout</a></li>
            </ul>
        </div>


        <div class="sidebar-overlay" onclick="toggleMainSidebar()"
            style="position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 899; display: none;"></div>

        <script>
            function toggleMainSidebar() {
                document.querySelector('.sidebar').classList.toggle('active');
                const overlay = document.querySelector('.sidebar-overlay');
                overlay.style.display = overlay.style.display === 'block' ? 'none' : 'block';
            }
        </script>