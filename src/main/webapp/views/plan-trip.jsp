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
<section class="header" id="header">
    <div class="navbar-option">
        <div class="container">
            <nav class="navbar navbar-default">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" alt="" /></a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-left">
                        <li><a href="<c:url value='/'/>">Home</a></li>
                        <li><a href="<c:url value='/about'/>">About</a></li>
                        <li><a href="<c:url value='/gallery'/>">Gallery</a></li>
                        <li><a href="<c:url value='/contact'/>">Contact</a></li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
</section>

<main class="yt-plan-page" aria-label="Trip budget planner">
    <section class="yt-plan-hero">
        <div class="container">
            <div class="yt-plan-hero-inner">
                <h1>Plan My Trip</h1>
                <p>Tell your budget and vibe. We’ll suggest youth-friendly places that fit your pocket.</p>
            </div>

            <div class="yt-plan-card">
                <form id="ytPlanForm" class="yt-plan-form" autocomplete="off">
                    <div class="yt-plan-grid">
                        <label class="yt-plan-field">
                            <span>Budget (₹) per person</span>
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
                    + '        <span class="yt-plan-pill">₹' + minBudget + '–₹' + maxBudget + '</span>'
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

