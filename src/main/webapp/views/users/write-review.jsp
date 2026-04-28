<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Write Review | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        
        .review-card {
            background: #161c28;
            border: 1px solid rgba(255,255,255,0.05);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.5);
        }

        .rating-stars {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }

        .rating-stars input { display: none; }

        .rating-stars label {
            font-size: 40px;
            color: rgba(255,255,255,0.1);
            cursor: pointer;
            transition: var(--transition);
        }

        .rating-stars label:hover,
        .rating-stars label:hover ~ label,
        .rating-stars input:checked ~ label {
            color: #f59e0b;
        }

        .form-control-dark {
            background: rgba(255,255,255,0.03);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            border-radius: 12px;
            padding: 15px;
            transition: var(--transition);
            resize: none;
        }

        .form-control-dark:focus {
            background: rgba(255,255,255,0.05);
            border-color: #f59e0b;
            color: #fff;
            box-shadow: none;
        }

        .btn-submit {
            background: #f59e0b;
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 15px 30px;
            font-weight: 700;
            width: 100%;
            margin-top: 20px;
            transition: var(--transition);
        }

        .btn-submit:hover {
            background: #d97706;
            transform: translateY(-2px);
        }

        .btn-back {
            color: var(--text-muted);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
            transition: var(--transition);
        }

        .btn-back:hover {
            color: #fff;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                
                <a href="<c:url value='/user/my-bookings'/>" class="btn-back">
                    <i class="fa fa-arrow-left"></i> Back to My Bookings
                </a>

                <div class="review-card">
                    <div class="text-center mb-4">
                        <div style="width: 60px; height: 60px; background: rgba(245, 158, 11, 0.1); color: #f59e0b; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; margin: 0 auto 20px;">
                            <i class="fa fa-star"></i>
                        </div>
                        <h2 style="font-weight: 800; margin: 0;">Rate Your Experience</h2>
                        <p style="color: var(--text-muted); margin-top: 10px;">How was your trip to <strong>${booking.trip.title}</strong> with <strong>${booking.vendor.businessName}</strong>?</p>
                    </div>

                    <form action="<c:url value='/user/booking/${booking.id}/review'/>" method="post">
                        
                        <!-- Star Rating -->
                        <div class="rating-stars">
                            <input type="radio" id="star5" name="rating" value="5" required />
                            <label for="star5" title="5 stars"><i class="fa fa-star"></i></label>
                            
                            <input type="radio" id="star4" name="rating" value="4" />
                            <label for="star4" title="4 stars"><i class="fa fa-star"></i></label>
                            
                            <input type="radio" id="star3" name="rating" value="3" />
                            <label for="star3" title="3 stars"><i class="fa fa-star"></i></label>
                            
                            <input type="radio" id="star2" name="rating" value="2" />
                            <label for="star2" title="2 stars"><i class="fa fa-star"></i></label>
                            
                            <input type="radio" id="star1" name="rating" value="1" />
                            <label for="star1" title="1 star"><i class="fa fa-star"></i></label>
                        </div>

                        <!-- Written Review -->
                        <div class="form-group mt-4">
                            <label style="font-weight: 600; margin-bottom: 10px; color: rgba(255,255,255,0.8);">Tell us more about your trip</label>
                            <textarea name="reviewText" class="form-control form-control-dark" rows="5" placeholder="What did you love? What could be improved? Share your thoughts to help other travelers!" required></textarea>
                        </div>

                        <button type="submit" class="btn-submit">Submit Review</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
