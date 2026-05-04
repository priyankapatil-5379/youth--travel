<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-dark: #020617;
            --card-bg: #0f172a;
            --accent-red: #e11d48;
            --text-light: #f8fafc;
            --text-muted: #94a3b8;
            --border: rgba(255, 255, 255, 0.1);
        }

        body { font-family: 'Outfit', sans-serif; background-color: var(--bg-dark); color: var(--text-light); margin: 0; padding: 0; }
        .payment-container { max-width: 500px; margin: 60px auto; padding: 20px; }

        .card { background: var(--card-bg); border-radius: 24px; padding: 30px; border: 1px solid var(--border); }
        .back-btn { color: var(--text-muted); text-decoration: none; font-size: 14px; font-weight: 600; display: flex; align-items: center; gap: 8px; margin-bottom: 25px; }

        .section-title { font-size: 18px; font-weight: 800; margin-bottom: 25px; }

        .payment-option { display: flex; align-items: center; gap: 15px; background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 16px; padding: 15px 20px; margin-bottom: 15px; cursor: pointer; transition: 0.3s; position: relative; }
        .payment-option.active { border-color: var(--accent-red); background: rgba(225, 29, 72, 0.05); }
        .radio-circle { width: 20px; height: 20px; border: 2px solid var(--text-muted); border-radius: 50%; position: relative; }
        .payment-option.active .radio-circle { border-color: var(--accent-red); }
        .payment-option.active .radio-circle::after { content: ''; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 10px; height: 10px; background: var(--accent-red); border-radius: 50%; }

        .option-info { flex-grow: 1; }
        .option-name { font-size: 15px; font-weight: 700; display: block; }
        .option-desc { font-size: 12px; color: var(--text-muted); }

        .upi-input-box { margin-top: 20px; display: none; }
        .upi-input-box.active { display: block; }
        .input-dark { background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 12px; color: #fff; padding: 12px 15px; width: 100%; font-weight: 600; outline: none; }

        .footer-summary { margin-top: 40px; display: flex; justify-content: space-between; align-items: center; }
        .total-label { font-size: 14px; font-weight: 600; color: var(--text-muted); }
        .total-amount { font-size: 24px; font-weight: 800; color: #fff; }

        .btn-pay { width: 100%; background: var(--accent-red); color: #fff; border: none; padding: 18px; border-radius: 16px; font-weight: 800; font-size: 16px; margin-top: 25px; cursor: pointer; transition: 0.3s; text-transform: uppercase; }
        .btn-pay:hover { transform: translateY(-3px); box-shadow: 0 10px 25px rgba(225, 29, 72, 0.4); }
    </style>
</head>
<body>

    <div class="payment-container">
        <a href="javascript:history.back()" class="back-btn"><i class="fa fa-arrow-left"></i> Back</a>

        <div class="card">
            <h2 class="section-title">Payment Method</h2>

            <div class="payment-option active" onclick="selectOption(this, 'upi')">
                <div class="radio-circle"></div>
                <div class="option-info">
                    <span class="option-name">UPI</span>
                    <span class="option-desc">Pay using any UPI app</span>
                </div>
                <i class="fa fa-chevron-right text-muted"></i>
            </div>

            <div id="upiBox" class="upi-input-box active">
                <label style="font-size: 12px; font-weight: 800; color: var(--text-muted); margin-bottom: 8px; display: block;">UPI ID</label>
                <input type="text" class="input-dark" placeholder="name@upi" id="upiId">
            </div>

            <div class="payment-option" onclick="selectOption(this, 'card')">
                <div class="radio-circle"></div>
                <div class="option-info">
                    <span class="option-name">Credit / Debit Card <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Visa_Inc._logo.svg" height="15" style="margin-left: 5px;"></span>
                    <span class="option-desc">Mastercard, Visa, RuPay</span>
                </div>
            </div>

            <div class="payment-option" onclick="selectOption(this, 'nb')">
                <div class="radio-circle"></div>
                <div class="option-info">
                    <span class="option-name">Net Banking</span>
                    <span class="option-desc">All major banks available</span>
                </div>
            </div>

            <div class="payment-option" onclick="selectOption(this, 'wallet')">
                <div class="radio-circle"></div>
                <div class="option-info">
                    <span class="option-name">Wallets</span>
                    <span class="option-desc">Paytm, PhonePe, Amazon Pay & more</span>
                </div>
            </div>

            <div class="footer-summary">
                <span class="total-label">Total Amount</span>
                <span class="total-amount">₹${amount}</span>
            </div>

            <button class="btn-pay" onclick="processPayment()">PAY ₹${amount}</button>
        </div>
    </div>

    <script>
        function selectOption(el, type) {
            document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('active'));
            el.classList.add('active');
            
            const upiBox = document.getElementById('upiBox');
            if (type === 'upi') {
                upiBox.classList.add('active');
            } else {
                upiBox.classList.remove('active');
            }
        }

        function processPayment() {
            const upiId = document.getElementById('upiId').value;
            if (document.getElementById('upiBox').classList.contains('active') && !upiId) {
                alert("Please enter a valid UPI ID");
                return;
            }
            const bookingId = "TRIP-2026-" + Math.random().toString(36).substr(2, 6).toUpperCase();
            window.location.href = `/user/booking/success?bookingId=` + bookingId + `&amount=${amount}`;
        }
    </script>
</body>
</html>
