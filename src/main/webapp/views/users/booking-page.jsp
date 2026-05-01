<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Your Trip | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --dark-bg: #0b0f18; --dark-card: #161c28; --text-muted: #7e8c9a; --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        body { font-family: 'Dosis', sans-serif; background-color: var(--dark-bg); color: #fff; margin: 0; line-height: 1.6; }
        
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: var(--dark-card); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        
        .page-wrapper { max-width: 1200px; margin: 0 auto; padding: 100px 24px 60px; }
        
        .booking-grid { display: grid; grid-template-columns: 1fr 400px; gap: 40px; }
        
        .section-card { background: var(--dark-card); border-radius: 24px; padding: 35px; border: 1px solid rgba(255,255,255,0.05); margin-bottom: 30px; }
        .section-title { font-size: 20px; font-weight: 800; margin-bottom: 25px; display: flex; align-items: center; gap: 12px; border-left: 4px solid var(--primary-blue); padding-left: 15px; }

        .trip-summary-mini { display: flex; gap: 20px; align-items: center; margin-bottom: 30px; padding-bottom: 25px; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .trip-thumb { width: 120px; height: 80px; border-radius: 12px; object-fit: cover; }
        .trip-mini-title { font-size: 20px; font-weight: 800; margin: 0; }
        .trip-mini-meta { color: var(--text-muted); font-size: 14px; font-weight: 600; }

        .form-group { margin-bottom: 20px; }
        .form-label { display: block; font-size: 13px; font-weight: 700; color: var(--text-muted); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-control-custom { background: #1a2230 !important; border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; color: #fff !important; padding: 12px 18px; width: 100%; transition: var(--transition); font-size: 15px; }
        .form-control-custom:focus { outline: none; border-color: var(--primary-blue); background: #242d3c !important; box-shadow: 0 0 0 3px rgba(240, 76, 38, 0.1); }
        .form-control-custom::placeholder { color: rgba(255,255,255,0.3); }

        /* Permanent Dark Mode for Autofill & Filled States */
        input:-webkit-autofill,
        input:-webkit-autofill:hover, 
        input:-webkit-autofill:focus, 
        input:-webkit-autofill:active {
            -webkit-box-shadow: 0 0 0 1000px #1a2230 inset !important;
            -webkit-text-fill-color: #fff !important;
            transition: background-color 5000s ease-in-out 0s;
        }
        
        .guest-row { background: rgba(255,255,255,0.02); border-radius: 16px; padding: 20px; border: 1px solid rgba(255,255,255,0.05); margin-bottom: 15px; }
        .guest-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; font-weight: 800; color: var(--primary-blue); font-size: 14px; }

        .summary-sidebar { position: sticky; top: 100px; }
        .summary-card { background: var(--dark-card); border-radius: 28px; padding: 35px; border: 1px solid rgba(255,255,255,0.08); box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-weight: 600; }
        .summary-total { border-top: 1px solid rgba(255,255,255,0.1); margin-top: 20px; padding-top: 20px; font-size: 24px; font-weight: 800; color: #fff; }
        
        .btn-pay { width: 100%; background: var(--primary-blue); color: #fff; border: none; padding: 20px; border-radius: 16px; font-size: 18px; font-weight: 800; margin-top: 25px; transition: var(--transition); cursor: pointer; box-shadow: 0 10px 20px rgba(240, 76, 38, 0.2); }
        .btn-pay:hover { transform: translateY(-3px); box-shadow: 0 15px 30px rgba(240, 76, 38, 0.4); }

        .trust-badge { display: flex; align-items: center; gap: 10px; font-size: 13px; color: var(--text-muted); font-weight: 600; margin-top: 20px; }
        .trust-badge i { color: #22c55e; }

        @media (max-width: 992px) {
            .booking-grid { grid-template-columns: 1fr; }
            .summary-sidebar { position: static; }
            .page-wrapper { padding: 80px 15px 40px; }
            .section-card { padding: 25px; }
        }

        @media (max-width: 576px) {
            .trip-summary-mini { flex-direction: column; align-items: flex-start; gap: 15px; }
            .trip-thumb { width: 100%; height: 160px; }
            .summary-card { padding: 25px; }
            .summary-total { font-size: 20px; }
        }

        /* Prevent infinite horizontal stretch on ultra-wide screens */
        @media (min-width: 2000px) {
            .header, .page-wrapper {
                max-width: 1400px;
                margin-left: auto;
                margin-right: auto;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-logo"><a href="<c:url value='/'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
        <div style="display: flex; align-items: center; gap: 15px;">
            <span style="font-weight: 700;">Hi, ${user.name}</span>
            <c:set var="defaultAvatar" value="https://ui-avatars.com/api/?name=${user.name}&background=f04c26&color=fff" />
            <img src="${not empty user.profilePhoto ? user.profilePhoto : defaultAvatar}" 
                 style="width: 35px; height: 35px; border-radius: 50%; object-fit: cover;">
        </div>
    </header>

    <div class="page-wrapper">
        <form action="<c:url value='/user/booking/submit'/>" method="POST" id="bookingForm">
            <input type="hidden" name="tripId" value="${trip.id}">
            <input type="hidden" name="guestDetails" id="guestDetailsInput">
            
            <div class="booking-grid">
                <div class="booking-left">
                    <div class="section-card">
                        <div class="trip-summary-mini">
                            <img src="${trip.imageUrl}" class="trip-thumb">
                            <div>
                                <h2 class="trip-mini-title">${trip.title}</h2>
                                <div class="trip-mini-meta">
                                    <span><i class="fa fa-map-marker"></i> ${trip.destination}</span> &bull; 
                                    <span><i class="fa fa-clock-o"></i> ${trip.days} Days / ${trip.nights} Nights</span>
                                </div>
                            </div>
                        </div>

                        <h2 class="section-title">Booking Details</h2>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Trip Type</label>
                                    <select name="tripType" class="form-control-custom" onchange="calculateTotal()">
                                        <option value="Solo">Solo Traveler</option>
                                        <option value="Group">Group Trip</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Select Travel Date</label>
                                    <input type="date" name="selectedDate" class="form-control-custom" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Number of Travelers</label>
                                    <input type="number" name="travelers" id="travelerCount" class="form-control-custom" value="1" min="1" max="${trip.maxTravelers}" onchange="updateGuestForms(); calculateTotal();">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="section-card">
                        <h2 class="section-title">Traveler Information</h2>
                        <div id="guestFormsContainer">
                            <!-- Dynamically generated forms -->
                        </div>
                    </div>
                </div>

                <div class="booking-right">
                    <div class="summary-sidebar">
                        <div class="summary-card">
                            <h2 style="font-size: 20px; font-weight: 800; margin-bottom: 25px;">Price Summary</h2>
                            <div class="summary-row">
                                <span>Base Price (₹${trip.price} x <span id="summaryTravelers">1</span>)</span>
                                <span>₹<span id="subtotal">0</span></span>
                            </div>
                            <div class="summary-row" style="color: var(--text-muted); font-size: 14px;">
                                <span>Service Fee (5%)</span>
                                <span>₹<span id="tax">0</span></span>
                            </div>
                            <div class="summary-total">
                                <div class="summary-row">
                                    <span>Total Amount</span>
                                    <span style="color: var(--primary-blue);">₹<span id="totalAmount">0</span></span>
                                </div>
                            </div>

                            <button type="submit" class="btn-pay" onclick="prepareGuestDetails()">Proceed to Payment</button>

                            <div class="trust-badge"><i class="fa fa-shield"></i> Secure 256-bit SSL encrypted payment</div>
                            <div class="trust-badge"><i class="fa fa-check-circle"></i> Instant confirmation via email</div>
                            <div class="trust-badge"><i class="fa fa-calendar"></i> Free cancellation before 48 hours</div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script>
        const basePricePerPerson = ${trip.price};

        function updateGuestForms() {
            const count = document.getElementById('travelerCount').value;
            const container = document.getElementById('guestFormsContainer');
            container.innerHTML = '';
            
            for(let i = 1; i <= count; i++) {
                const guestHtml = `
                    <div class="guest-row" data-guest="\${i}">
                        <div class="guest-header">Traveler \${i} \${i === 1 ? '(Primary)' : ''}</div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control-custom guest-name" placeholder="John Doe" required>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">Age</label>
                                    <input type="number" class="form-control-custom guest-age" placeholder="24" min="5" required>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">Gender</label>
                                    <select class="form-control-custom guest-gender">
                                        <option>Male</option>
                                        <option>Female</option>
                                        <option>Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" class="form-control-custom guest-email" placeholder="john@example.com" required>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                container.insertAdjacentHTML('beforeend', guestHtml);
            }
        }

        function calculateTotal() {
            const travelers = document.getElementById('travelerCount').value;
            const subtotal = basePricePerPerson * travelers;
            const tax = subtotal * 0.05;
            const total = subtotal + tax;

            document.getElementById('summaryTravelers').innerText = travelers;
            document.getElementById('subtotal').innerText = subtotal.toLocaleString();
            document.getElementById('tax').innerText = tax.toLocaleString();
            document.getElementById('totalAmount').innerText = total.toLocaleString();
        }

        function prepareGuestDetails() {
            const guestRows = document.querySelectorAll('.guest-row');
            const guests = [];
            guestRows.forEach(row => {
                guests.push({
                    name: row.querySelector('.guest-name').value,
                    age: row.querySelector('.guest-age').value,
                    gender: row.querySelector('.guest-gender').value,
                    email: row.querySelector('.guest-email').value
                });
            });
            document.getElementById('guestDetailsInput').value = JSON.stringify(guests);
        }

        // Initialize
        updateGuestForms();
        calculateTotal();
    </script>
</body>
</html>
