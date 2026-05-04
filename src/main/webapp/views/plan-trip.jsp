<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Plan My Trip</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
</head>

<body class="yt-dark">
    <style>
        .yt-new-nav {
            position: relative;
            z-index: 999999;
            padding: 20px 0;
            background: rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }
        .nav-flex {
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
        }
        .nav-flex .logo { flex: 1; }
        .nav-flex .logo img { height: 40px; }
        .nav-links {
            display: flex;
            gap: 35px;
            align-items: center;
            justify-content: center;
            flex: 2;
        }
        .nav-links a {
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
        }
        .nav-links a:hover, .nav-links a.active { color: #e63946; }
        .nav-right {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 10px;
            flex: 1;
        }
        .nav-right .login-btn {
            background: #e63946;
            color: #fff;
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
            display: inline-block;
        }
        .nav-right .login-btn:hover { background: #c1121f; }
        .nav-mobile-toggle {
            display: none;
            color: #fff;
            font-size: 28px;
            cursor: pointer;
            z-index: 2000;
            transition: 0.3s;
        }
        @media (min-width: 992px) {
            .d-lg-none { display: none !important; }
            .d-lg-inline-block { display: inline-block !important; }
        }
        @media (max-width: 991px) {
            .d-none { display: none !important; }
            .nav-mobile-toggle { 
                display: flex !important; 
                position: fixed !important;
                top: 20px;
                right: 20px;
                z-index: 99999 !important; 
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                width: 50px;
                height: 50px;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                border: 1px solid rgba(255, 255, 255, 0.2);
                box-shadow: 0 8px 32px rgba(0,0,0,0.3);
                color: #fff;
            }
            .nav-links {
                display: flex !important;
                position: fixed !important;
                top: 0;
                right: -100%;
                width: 100%;
                height: 100vh;
                background: rgba(8, 12, 20, 1);
                backdrop-filter: blur(35px);
                -webkit-backdrop-filter: blur(35px);
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px;
                z-index: 999999 !important; 
                transition: 0.6s cubic-bezier(0.77, 0, 0.175, 1);
                gap: 20px;
                visibility: hidden;
            }
            .nav-links.active {
                right: 0;
                visibility: visible;
            }
            .nav-links a {
                padding: 15px 30px;
                width: 80%;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                font-size: 24px;
                font-weight: 700;
                letter-spacing: 3px;
                text-transform: uppercase;
                color: rgba(255, 255, 255, 0.9);
                opacity: 0;
                transform: translateY(30px);
                transition: 0.5s cubic-bezier(0.4, 0, 0.2, 1);
                text-decoration: none;
            }
            .nav-links.active a {
                opacity: 1;
                transform: translateY(0);
            }
            .nav-links.active a:nth-child(1) { transition-delay: 0.2s; }
            .nav-links.active a:nth-child(2) { transition-delay: 0.3s; }
            .nav-links.active a:nth-child(3) { transition-delay: 0.4s; }
            .nav-links.active a:nth-child(4) { transition-delay: 0.5s; }
            .nav-links.active a:nth-child(5) { transition-delay: 0.6s; }
            .nav-links.active .mobile-btn-wrap { opacity: 1; transform: translateY(0); transition-delay: 0.7s; }
            .nav-links .mobile-btn-wrap {
                margin-top: 30px;
                display: flex !important;
                flex-direction: column;
                align-items: center;
                gap: 15px;
                width: 100%;
                opacity: 0;
                transform: translateY(30px);
                transition: 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .nav-right .login-btn { display: none; }
        }
    </style>

    <div class="yt-new-nav">
        <div class="container">
            <div class="nav-flex">
                <div class="logo">
                    <a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel" /></a>
                </div>
                <div class="nav-links">
                    <a href="<c:url value='/'/>">Home</a>
                    <a href="<c:url value='/gallery'/>">Gallery</a>
                    <a href="<c:url value='/about'/>">About Us</a>
                    <a href="<c:url value='/contact'/>">Contact Us</a>
                    
                    <div class="mobile-btn-wrap d-lg-none">
                        <a href="<c:url value='/user/login'/>" class="login-btn">Login / Sign Up</a>
                    </div>
                </div>
                <div class="nav-right">
                    <a href="<c:url value='/user/login'/>" class="login-btn d-none d-lg-inline-block">Login / Sign Up</a>
                    <div class="nav-mobile-toggle" onclick="document.querySelector('.nav-links').classList.toggle('active')">
                        <i class="fa fa-bars"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

<main class="yt-plan-page" aria-label="Trip budget planner">
    <section class="yt-plan-hero">
        <div class="container">
            <div class="yt-plan-hero-inner">
                <h1>Plan My Trip</h1>
                <p>Tell your budget and vibe. Weâ€™ll suggest youth-friendly places that fit your pocket.</p>
            </div>

            <div class="yt-plan-card">
                <form id="ytPlanForm" class="yt-plan-form" autocomplete="off">
                    <div class="yt-plan-grid">
                        <label class="yt-plan-field">
                            <span>Budget (â‚¹) per person</span>
                            <input id="ytBudget" type="number" min="0" step="100" placeholder="Eg: 3000" required>
                        </label>
                        <label class="yt-plan-field">
                            <span>Days</span>
                            <select id="ytDays">
                                <option value="1">1 day</option>
                                <option value="2" selected>2 days</option>
                                <option value="3">3 days</option>
                                <option value="4">4 days</option>
                            </select>
                        </label>
                        <label class="yt-plan-field">
                            <span>Experience type</span>
                            <select id="ytType">
                                <option value="any" selected>Any</option>
                                <option value="rides">Bike rides</option>
                                <option value="trekking">Trekking</option>
                                <option value="camping">Camping</option>
                                <option value="dayouts">Day outs</option>
                            </select>
                        </label>
                        <div class="yt-plan-actions">
                            <button class="yt-btn yt-btn-primary yt-btn-block" type="submit">Show trips</button>
                            <a class="yt-btn yt-btn-outline yt-btn-block" href="<c:url value='/'/>">Back to home</a>
                        </div>
                    </div>
                </form>
            </div>

            <div id="ytPlanStatus" class="yt-plan-status" aria-live="polite"></div>

            <div id="ytPlanResults" class="row yt-plan-results" aria-label="Suggested trips"></div>
        </div>
    </section>
</main>

<script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
<script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
<script>
    (function() {
        const form = document.getElementById('ytPlanForm');
        const budgetEl = document.getElementById('ytBudget');
        const daysEl = document.getElementById('ytDays');
        const typeEl = document.getElementById('ytType');
        const statusEl = document.getElementById('ytPlanStatus');
        const resultsEl = document.getElementById('ytPlanResults');

        function escapeHtml(str) {
            return String(str)
                .replaceAll("&", "&amp;")
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll('"', "&quot;")
                .replaceAll("'", "&#039;");
        }

        function setStatus(text) {
            statusEl.textContent = text || "";
        }

        function renderResults(items) {
            resultsEl.innerHTML = "";
            if (!items || !items.length) {
                resultsEl.innerHTML = '<div class="col-sm-12"><div class="yt-plan-empty">No matching trips found. Try increasing budget or changing type.</div></div>';
                return;
            }

            resultsEl.innerHTML = items.map((it) => {
                const img = it && it.image ? String(it.image) : "";
                const name = escapeHtml(it && it.name ? it.name : "");
                const place = escapeHtml(it && it.place ? it.place : "");
                const days = escapeHtml(it && it.days != null ? it.days : "");
                const minBudget = escapeHtml(it && it.minBudget != null ? it.minBudget : "");
                const maxBudget = escapeHtml(it && it.maxBudget != null ? it.maxBudget : "");
                const tag = escapeHtml(it && it.tag ? it.tag : "");

                return ''
                    + '<div class="col-sm-6 col-md-4">'
                    + '  <article class="yt-plan-result-card">'
                    + '    <div class="yt-plan-result-img" style="background-image:url(\\'' + escapeHtml(img) + '\\')"></div>'
                    + '    <div class="yt-plan-result-body">'
                    + '      <div class="yt-plan-result-top">'
                    + '        <strong>' + name + '</strong>'
                    + '        <span class="yt-plan-pill">â‚¹' + minBudget + 'â€“â‚¹' + maxBudget + '</span>'
                    + '      </div>'
                    + '      <div class="yt-plan-result-meta">'
                    + '        <span><i class="fa fa-map-marker"></i> ' + place + '</span>'
                    + '        <span><i class="fa fa-calendar"></i> ' + days + ' day(s)</span>'
                    + '      </div>'
                    + '      <p>' + tag + '</p>'
                    + '      <div class="yt-plan-result-actions">'
                    + '        <a class="yt-btn yt-btn-primary yt-btn-block" href="<c:url value='/contact'/>">Enquire</a>'
                    + '      </div>'
                    + '    </div>'
                    + '  </article>'
                    + '</div>';
            }).join('');
        }

        async function fetchPlan() {
            const budget = Number(budgetEl.value || 0);
            const days = Number(daysEl.value || 0);
            const type = String(typeEl.value || "any");

            setStatus("Finding trips for your budget...");

            const res = await fetch("/api/plan-trip", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ budget, days, type })
            });

            if (!res.ok) throw new Error("HTTP " + res.status);
            const data = await res.json();

            setStatus(data.count ? ("Showing " + data.count + " trip ideas") : "No trips found");
            renderResults(data.results || []);
        }

        form.addEventListener("submit", async (e) => {
            e.preventDefault();
            resultsEl.innerHTML = "";
            try {
                await fetchPlan();
            } catch (err) {
                setStatus("Network issue. Please try again.");
            }
        });

        // default results for quick wow effect
        budgetEl.value = 3000;
        window.setTimeout(() => {
            form.dispatchEvent(new Event("submit"));
        }, 150);
    })();
</script>
</body>
</html>


