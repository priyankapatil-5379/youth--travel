<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Share Your Journey | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-teal: #008080;
            --secondary-teal: #077378;
            --primary-light: rgba(0, 128, 128, 0.1);
            --accent-red: #e63946;
            --accent-gold: #fbbf24;
            --bg-body: #f1f5f9;
            --bg-card: rgba(255, 255, 255, 0.9);
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --glass-bg: rgba(255, 255, 255, 0.8);
            --glass-border: rgba(255, 255, 255, 0.5);
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-body); 
            color: var(--text-main); 
            margin: 0; padding: 0; 
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 40px !important; }

        .page-header { margin-bottom: 32px; }
        .page-header h1 { font-size: 32px; font-weight: 800; color: var(--text-main); margin: 0; letter-spacing: -1px; }
        .page-header p { color: var(--text-muted); margin: 4px 0 0; font-size: 16px; font-weight: 500; }

        .layout-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 32px; align-items: start; }

        /* Card Styles */
        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05), 0 10px 15px -3px rgba(0,0,0,0.05);
            transition: var(--transition);
        }
        .glass-card:hover { transform: translateY(-2px); box-shadow: 0 20px 25px -5px rgba(0,0,0,0.08); }

        /* Trip Summary Card */
        .trip-summary { display: flex; gap: 24px; align-items: center; }
        .trip-image { width: 140px; height: 100px; border-radius: 16px; object-fit: cover; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .trip-info h3 { font-size: 20px; font-weight: 800; margin: 0; color: var(--text-main); }
        .trip-loc { font-size: 14px; color: var(--text-muted); font-weight: 500; margin: 4px 0 8px; }
        .status-badge { background: #f0fdf4; color: #166534; padding: 4px 12px; border-radius: 100px; font-size: 11px; font-weight: 700; text-transform: uppercase; }

        /* Rating Section */
        .rating-box { text-align: center; padding: 20px 0; }
        .stars-container { display: flex; justify-content: center; gap: 12px; font-size: 42px; margin-bottom: 12px; }
        .star-input { cursor: pointer; color: #e2e8f0; transition: var(--transition); }
        .star-input:hover, .star-input.active { color: var(--accent-gold); transform: scale(1.1); }
        .rating-label { font-size: 14px; font-weight: 700; color: var(--primary-teal); text-transform: uppercase; letter-spacing: 1px; min-height: 20px; }

        /* Form Controls */
        .form-label { font-size: 13px; font-weight: 700; color: var(--text-main); margin-bottom: 10px; display: block; }
        .form-control {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 14px 18px;
            font-size: 14px;
            color: var(--text-main);
            transition: var(--transition);
        }
        .form-control:focus {
            border-color: var(--primary-teal);
            box-shadow: 0 0 0 4px var(--primary-light);
            outline: none;
        }

        /* Tag Chips */
        .tags-container { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 8px; }
        .tag-chip {
            padding: 8px 18px; border-radius: 100px; border: 1px solid var(--border-color);
            font-size: 13px; font-weight: 600; color: var(--text-muted); cursor: pointer;
            transition: var(--transition); background: white;
        }
        .tag-chip:hover { border-color: var(--primary-teal); color: var(--primary-teal); background: #f0fdfa; }
        .tag-chip.active { background: var(--primary-teal); color: white; border-color: var(--primary-teal); box-shadow: 0 4px 12px rgba(0, 128, 128, 0.2); }

        /* Recommendation Toggle */
        .toggle-group { display: flex; gap: 12px; margin-top: 10px; }
        .toggle-btn {
            flex: 1; padding: 12px; border-radius: 12px; border: 1px solid var(--border-color);
            background: white; color: var(--text-muted); font-weight: 700; font-size: 14px;
            cursor: pointer; transition: var(--transition); display: flex; align-items: center; justify-content: center; gap: 8px;
        }
        .toggle-btn.yes.active { background: #f0fdf4; border-color: #22c55e; color: #166534; }
        .toggle-btn.no.active { background: #fef2f2; border-color: #ef4444; color: #991b1b; }

        /* Image Upload Area */
        .upload-area {
            border: 2px dashed var(--border-color);
            border-radius: 16px;
            padding: 30px;
            text-align: center;
            background: #f8fafc;
            cursor: pointer;
            transition: var(--transition);
        }
        .upload-area:hover { border-color: var(--primary-teal); background: #f0fdfa; }
        .upload-area i { font-size: 32px; color: #94a3b8; margin-bottom: 12px; }
        .upload-area p { font-size: 13px; color: var(--text-muted); margin: 0; }

        /* Action Buttons */
        .actions { display: flex; gap: 16px; margin-top: 40px; }
        .btn-submit {
            flex: 2; padding: 16px; border-radius: 14px; border: none;
            background: linear-gradient(135deg, var(--primary-teal), var(--secondary-teal));
            color: white; font-weight: 800; text-transform: uppercase; letter-spacing: 1px;
            box-shadow: 0 10px 20px -5px rgba(0, 128, 128, 0.3); transition: var(--transition);
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 15px 30px -5px rgba(0, 128, 128, 0.4); opacity: 0.95; }
        .btn-cancel {
            flex: 1; padding: 16px; border-radius: 14px; border: 1px solid var(--border-color);
            background: white; color: var(--text-muted); font-weight: 700; transition: var(--transition);
        }
        .btn-cancel:hover { background: #f1f5f9; color: var(--text-main); }

        /* Right Sidebar Widgets */
        .widget { background: white; border-radius: 24px; border: 1px solid var(--border-color); padding: 28px; margin-bottom: 24px; }
        .widget h4 { font-size: 16px; font-weight: 800; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .widget-item { display: flex; gap: 14px; margin-bottom: 16px; }
        .widget-item i { font-size: 14px; color: var(--primary-teal); margin-top: 3px; }
        .widget-item p { font-size: 13px; color: var(--text-muted); line-height: 1.5; margin: 0; }

        .progress-box { background: #f8fafc; border-radius: 16px; padding: 20px; margin-top: 20px; }
        .progress-label { font-size: 11px; font-weight: 800; text-transform: uppercase; color: var(--text-muted); display: block; margin-bottom: 8px; }
        .progress-bar-bg { height: 6px; background: #e2e8f0; border-radius: 100px; }
        .progress-bar-fill { height: 100%; background: var(--primary-teal); width: 0%; border-radius: 100px; transition: 0.5s; }

        .trust-badge {
            background: linear-gradient(135deg, #fffbeb, #fef3c7);
            border: 1px solid #fde68a; border-radius: 16px; padding: 16px; display: flex; align-items: center; gap: 12px;
        }
        .trust-badge i { font-size: 24px; color: #d97706; }
        .trust-badge span { font-size: 12px; font-weight: 700; color: #92400e; }

        @media (max-width: 1200px) { .layout-grid { grid-template-columns: 1fr; } .main-content { margin-left: 0; } }
    </style>
</head>
<body>
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="bookings" />
        </jsp:include>
        
        <main class="main-content">
            <div class="page-header">
                <h1>Share Your Journey</h1>
                <p>Help other explorers by sharing your experience</p>
            </div>

            <form id="fullReviewForm" action="<c:url value='/user/booking/${booking.id}/review/submit'/>" method="post" enctype="multipart/form-data">
                <div class="layout-grid">
                    <div class="form-container">
                        <!-- Trip Summary -->
                        <div class="glass-card">
                            <div class="trip-summary">
                                <c:set var="tripImg" value="${not empty booking.trip.imageUrl ? booking.trip.imageUrl : 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600'}" />
                                <img src="${tripImg}" class="trip-image" alt="Trip">
                                <div class="trip-info">
                                    <span class="status-badge">Completed</span>
                                    <h3>${booking.trip.title}</h3>
                                    <p class="trip-loc"><i class="fa fa-map-marker"></i> ${booking.trip.destination}, India</p>
                                    <p class="trip-loc" style="font-size: 12px;"><i class="fa fa-calendar"></i> Traveled on: 
                                        <fmt:parseDate value="${booking.selectedDate}" pattern="yyyy-MM-dd" var="parsedDate" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy" />
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Rating Section -->
                        <div class="glass-card">
                            <div class="rating-box">
                                <label class="form-label">Overall Rating</label>
                                <div class="stars-container">
                                    <i class="fa fa-star star-input" data-value="1"></i>
                                    <i class="fa fa-star star-input" data-value="2"></i>
                                    <i class="fa fa-star star-input" data-value="3"></i>
                                    <i class="fa fa-star star-input" data-value="4"></i>
                                    <i class="fa fa-star star-input" data-value="5"></i>
                                </div>
                                <input type="hidden" name="rating" id="ratingValue" required>
                                <div id="ratingText" class="rating-label">Select a Rating</div>
                            </div>
                        </div>

                        <!-- Review Content -->
                        <div class="glass-card">
                            <div class="mb-4">
                                <label class="form-label">Review Title</label>
                                <input type="text" name="title" class="form-control" placeholder="Summarize your experience in a short sentence" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Experience Description</label>
                                <textarea name="reviewText" class="form-control" rows="6" placeholder="What did you love? How was the guide? Any tips for other youths?" required></textarea>
                                <div style="text-align: right; font-size: 11px; color: var(--text-muted); margin-top: 5px;">
                                    <span id="charCount">0</span>/1000 characters
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label class="form-label">Key Highlights</label>
                                    <input type="text" name="highlights" class="form-control" placeholder="e.g. Scenic views, Great food">
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label class="form-label">Suggestions for Improvement</label>
                                    <input type="text" name="suggestions" class="form-control" placeholder="e.g. Faster check-in">
                                </div>
                            </div>
                        </div>

                        <!-- Experience Tags -->
                        <div class="glass-card">
                            <label class="form-label">Experience Tags (Select all that apply)</label>
                            <div class="tags-container">
                                <span class="tag-chip" data-tag="Adventure">Adventure</span>
                                <span class="tag-chip" data-tag="Budget Friendly">Budget Friendly</span>
                                <span class="tag-chip" data-tag="Scenic">Scenic</span>
                                <span class="tag-chip" data-tag="Family Friendly">Family Friendly</span>
                                <span class="tag-chip" data-tag="Solo Travel">Solo Travel</span>
                                <span class="tag-chip" data-tag="Luxury">Luxury</span>
                                <span class="tag-chip" data-tag="Trekking">Trekking</span>
                                <span class="tag-chip" data-tag="Beach">Beach</span>
                                <span class="tag-chip" data-tag="Food">Food</span>
                                <span class="tag-chip" data-tag="Culture">Culture</span>
                            </div>
                            <input type="hidden" name="tags" id="tagsValue">
                        </div>

                        <!-- Recommendation Section -->
                        <div class="glass-card">
                            <label class="form-label">Would you recommend this trip to other explorers?</label>
                            <div class="toggle-group">
                                <button type="button" class="toggle-btn yes" onclick="setRecommend(true)">
                                    <i class="fa fa-thumbs-up"></i> YES
                                </button>
                                <button type="button" class="toggle-btn no" onclick="setRecommend(false)">
                                    <i class="fa fa-thumbs-down"></i> NO
                                </button>
                            </div>
                            <input type="hidden" name="recommend" id="recommendValue">
                        </div>

                        <!-- Optional Image Upload -->
                        <div class="glass-card">
                            <label class="form-label">Upload Your Memories (Optional)</label>
                            <div class="upload-area" onclick="document.getElementById('photoInput').click()">
                                <i class="fa fa-cloud-upload"></i>
                                <p>Drag and drop or <strong>click to browse</strong></p>
                                <span style="font-size: 11px; color: var(--text-muted);">Max 5 photos, JPG/PNG only</span>
                                <input type="file" id="photoInput" name="photos" multiple style="display: none;" onchange="updateUploadText()">
                                <div id="uploadFeedback" style="margin-top: 10px; font-weight: 700; color: var(--primary-teal); font-size: 12px; display: none;"></div>
                            </div>
                        </div>

                        <div class="actions">
                            <button type="button" class="btn-cancel" onclick="history.back()">Cancel</button>
                            <button type="submit" class="btn-submit">Submit Review</button>
                        </div>
                    </div>

                    <div class="sidebar-container">
                        <div class="widget">
                            <h4><i class="fa fa-lightbulb-o"></i> Review Tips</h4>
                            <div class="widget-item">
                                <i class="fa fa-check"></i>
                                <p>Be specific about what you enjoyed most.</p>
                            </div>
                            <div class="widget-item">
                                <i class="fa fa-check"></i>
                                <p>Mention the guide or hospitality if applicable.</p>
                            </div>
                            <div class="widget-item">
                                <i class="fa fa-check"></i>
                                <p>Upload high-quality photos to help others.</p>
                            </div>
                        </div>

                        <div class="widget">
                            <h4><i class="fa fa-shield"></i> Community Guidelines</h4>
                            <p style="font-size: 13px; color: var(--text-muted); margin-bottom: 15px;">Your review helps maintain the quality of our community. Please ensure it is:</p>
                            <ul style="padding-left: 18px; margin: 0; font-size: 12px; color: var(--text-muted);">
                                <li style="margin-bottom: 8px;">Honest and factual</li>
                                <li style="margin-bottom: 8px;">Respectful to all vendors</li>
                                <li>No offensive language</li>
                            </ul>
                        </div>

                        <div class="widget">
                            <h4><i class="fa fa-tasks"></i> Review Progress</h4>
                            <div class="progress-box">
                                <span class="progress-label">Completion Status</span>
                                <div class="progress-bar-bg">
                                    <div id="progressBar" class="progress-bar-fill"></div>
                                </div>
                                <span id="progressText" style="font-size: 11px; font-weight: 700; color: var(--primary-teal); margin-top: 8px; display: block;">0% Complete</span>
                            </div>
                        </div>

                        <div class="trust-badge">
                            <i class="fa fa-certificate"></i>
                            <span>Trusted Explorer Review Badge</span>
                        </div>
                    </div>
                </div>
            </form>
        </main>
    </div>

    <!-- Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="border-radius: 24px; border: none; overflow: hidden;">
                <div style="background: var(--primary-teal); padding: 40px; text-align: center; color: white;">
                    <i class="fa fa-check-circle" style="font-size: 64px; margin-bottom: 20px;"></i>
                    <h3 style="font-weight: 800; margin: 0;">Review Submitted!</h3>
                </div>
                <div style="padding: 30px; text-align: center;">
                    <p style="color: var(--text-muted); font-size: 15px; margin-bottom: 25px;">Thank you for sharing your reflection. Your story will help other explorers choose their next adventure!</p>
                    <button class="btn-submit" style="width: auto; padding: 12px 40px;" onclick="window.location.href='/user/my-reviews'">Great!</button>
                </div>
            </div>
        </div>
    </div>

    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/views/assets/js/bootstrap.min.js'/>"></script>
    <script>
        // Rating System
        const stars = document.querySelectorAll('.star-input');
        const ratingText = document.getElementById('ratingText');
        const labels = {
            1: 'Poor',
            2: 'Fair',
            3: 'Good',
            4: 'Very Good',
            5: 'Excellent'
        };

        stars.forEach(star => {
            star.addEventListener('mouseover', function() {
                const val = this.dataset.value;
                highlightStars(val);
                ratingText.innerText = labels[val];
            });

            star.addEventListener('mouseout', function() {
                const val = document.getElementById('ratingValue').value;
                highlightStars(val || 0);
                ratingText.innerText = val ? labels[val] : 'Select a Rating';
            });

            star.addEventListener('click', function() {
                const val = this.dataset.value;
                document.getElementById('ratingValue').value = val;
                highlightStars(val);
                updateProgress();
            });
        });

        function highlightStars(val) {
            stars.forEach(s => {
                s.classList.toggle('active', s.dataset.value <= val);
            });
        }

        // Tags Logic
        const tags = document.querySelectorAll('.tag-chip');
        const selectedTags = new Set();
        tags.forEach(tag => {
            tag.addEventListener('click', function() {
                const val = this.dataset.tag;
                if (selectedTags.has(val)) {
                    selectedTags.delete(val);
                    this.classList.remove('active');
                } else {
                    selectedTags.add(val);
                    this.classList.add('active');
                }
                document.getElementById('tagsValue').value = Array.from(selectedTags).join(',');
                updateProgress();
            });
        });

        // Recommend Toggle
        function setRecommend(val) {
            document.querySelectorAll('.toggle-btn').forEach(b => b.classList.remove('active'));
            if (val) document.querySelector('.toggle-btn.yes').classList.add('active');
            else document.querySelector('.toggle-btn.no').classList.add('active');
            document.getElementById('recommendValue').value = val;
            updateProgress();
        }

        // Progress Tracking
        function updateProgress() {
            const form = document.getElementById('fullReviewForm');
            let filled = 0;
            let total = 6; // Rating, Title, Text, Tags, Recommend, Highlights

            if (document.getElementById('ratingValue').value) filled++;
            if (form.title.value.length > 5) filled++;
            if (form.reviewText.value.length > 10) filled++;
            if (selectedTags.size > 0) filled++;
            if (document.getElementById('recommendValue').value !== "") filled++;
            if (form.highlights.value.length > 3) filled++;

            const percent = Math.round((filled / total) * 100);
            document.getElementById('progressBar').style.width = percent + '%';
            document.getElementById('progressText').innerText = percent + '% Complete';
        }

        document.querySelectorAll('.form-control').forEach(el => {
            el.addEventListener('input', updateProgress);
        });

        // Char Count
        const textarea = document.querySelector('textarea[name="reviewText"]');
        textarea.addEventListener('input', function() {
            document.getElementById('charCount').innerText = this.value.length;
        });

        // Photo Upload Feedback
        function updateUploadText() {
            const input = document.getElementById('photoInput');
            const feedback = document.getElementById('uploadFeedback');
            if (input.files.length > 0) {
                feedback.innerText = input.files.length + ' Photo(s) selected';
                feedback.style.display = 'block';
            }
        }

        // Success Handling
        document.getElementById('fullReviewForm').onsubmit = function(e) {
            e.preventDefault();
            const btn = document.querySelector('.btn-submit');
            btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Submitting...';
            btn.disabled = true;

            const formData = new FormData(this);
            fetch("<c:url value='/user/api/reviews/create/${booking.id}'/>", {
                method: 'POST',
                body: formData
            })
            .then(async res => {
                if (res.ok) {
                    $('#successModal').modal({
                        backdrop: 'static',
                        keyboard: false
                    }).modal('show');
                } else {
                    const errorText = await res.text();
                    console.error('Submission failed:', res.status, errorText);
                    alert('Something went wrong (Status: ' + res.status + '). Please try again.');
                    btn.innerHTML = 'Submit Review';
                    btn.disabled = false;
                }
            })
            .catch(err => {
                console.error(err);
                alert('Submission failed.');
                btn.innerHTML = 'Submit Review';
                btn.disabled = false;
            });
        };
    </script>
</body>
</html>
