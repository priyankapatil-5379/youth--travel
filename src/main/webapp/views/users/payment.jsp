<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Payment | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --text-muted: #7e8c9a; }
        body { font-family: 'Dosis', sans-serif; background: #0b0f18; color: #fff; }
        .payment-container { max-width: 600px; margin: 100px auto; background: #161c28; border-radius: 20px; padding: 40px; border: 1px solid rgba(255,255,255,0.05); text-align: center; }
        .booking-details { background: rgba(255,255,255,0.03); border-radius: 15px; padding: 25px; margin-bottom: 30px; text-align: left; }
        .detail-row { display: flex; justify-content: space-between; margin-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 10px; }
        .total-amount { font-size: 28px; font-weight: 800; color: var(--primary-blue); margin-top: 20px; }
        .btn-pay { background: var(--primary-blue); color: #fff; width: 100%; padding: 18px; border-radius: 12px; font-weight: 700; font-size: 18px; border: none; margin-top: 20px; transition: 0.3s; }
        .btn-pay:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(240, 76, 38, 0.2); }
    </style>
</head>
<body>
    <div class="payment-container">
        <img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 40px; margin-bottom: 30px;">
        <h2 style="font-weight: 800;">Secure Checkout</h2>
        <p style="color: var(--text-muted);">Completing your adventure booking</p>

        <div class="booking-details">
            <h5 style="font-weight: 700; margin-bottom: 20px; color: var(--primary-blue); text-transform: uppercase; letter-spacing: 1px;">Booking Summary</h5>
            
            <div class="detail-row">
                <span style="color: var(--text-muted);">Trip Adventure</span>
                <span style="font-weight: 700; color: #fff;">${booking.trip.title}</span>
            </div>
            
            <div class="detail-row">
                <span style="color: var(--text-muted);">Travel Date</span>
                <span style="font-weight: 700; color: var(--primary-blue);"><i class="fa fa-calendar"></i> ${booking.selectedDate}</span>
            </div>
            
            <div class="detail-row">
                <span style="color: var(--text-muted);">Travelers</span>
                <span style="font-weight: 700;">${booking.numberOfTravelers} Person(s)</span>
            </div>

            <div style="margin-top: 25px; padding-top: 20px; border-top: 1px dashed rgba(255,255,255,0.1);">
                <div class="detail-row" style="border: none; margin-bottom: 5px;">
                    <span style="color: var(--text-muted);">Base Price (₹${booking.trip.price} × ${booking.numberOfTravelers})</span>
                    <span>₹${booking.trip.price * booking.numberOfTravelers}</span>
                </div>
                <div class="detail-row" style="border: none; margin-bottom: 5px;">
                    <span style="color: var(--text-muted);">Service Fee / GST (5%)</span>
                    <span>₹${(booking.trip.price * booking.numberOfTravelers) * 0.05}</span>
                </div>
                <div class="total-amount" style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px; background: rgba(240, 76, 38, 0.1); padding: 15px; border-radius: 10px;">
                    <span style="font-size: 18px; color: #fff; font-weight: 700;">Total Amount</span>
                    <span style="color: var(--primary-blue);">₹${booking.totalPrice}</span>
                </div>
            </div>
        </div>

        <button id="rzp-button1" class="btn-pay">Pay with Razorpay</button>
        
        <div style="margin-top: 30px; color: var(--text-muted); font-size: 13px;">
            <i class="fa fa-lock"></i> SSL Secured • Encrypted Payment Process
        </div>
    </div>

    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
        var options = {
            "key": "rzp_test_RIlD5bEKRjyn3h", // Hardcoded test key found in properties
            "amount": "${booking.totalPrice * 100}", // Amount in paise
            "currency": "INR",
            "name": "Youth Travel",
            "description": "Booking for ${booking.trip.title}",
            "image": "https://ui-avatars.com/api/?name=YT&background=f04c26&color=fff",
            "handler": function (response){
                fetch('<c:url value="/user/payment/success"/>', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        bookingId: '${booking.id}',
                        paymentId: response.razorpay_payment_id
                    })
                }).then(res => {
                    if (res.ok) {
                        alert("Payment Successful! Payment ID: " + response.razorpay_payment_id);
                        window.location.href = "<c:url value='/user/my-bookings'/>";
                    } else {
                        alert("Payment recorded by Razorpay, but local sync failed. Please contact support.");
                    }
                });
            },
            "prefill": {
                "name": "${user.name}",
                "email": "${user.email}"
            },
            "theme": {
                "color": "#f04c26"
            }
        };
        var rzp1 = new Razorpay(options);
        document.getElementById('rzp-button1').onclick = function(e){
            rzp1.open();
            e.preventDefault();
        }
    </script>
</body>
</html>
