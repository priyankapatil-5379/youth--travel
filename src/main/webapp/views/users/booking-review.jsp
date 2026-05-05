<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Booking | Youth Travel</title>
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
        .review-container { max-width: 500px; margin: 60px auto; padding: 20px; }

        .card { background: var(--card-bg); border-radius: 24px; padding: 30px; border: 1px solid var(--border); box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
        .back-btn { color: var(--text-muted); text-decoration: none; font-size: 14px; font-weight: 600; display: flex; align-items: center; gap: 8px; margin-bottom: 25px; }

        .price-header { display: flex; align-items: baseline; gap: 8px; margin-bottom: 30px; }
        .price-val { font-size: 32px; font-weight: 800; color: #fff; }
        .price-label { color: var(--text-muted); font-size: 14px; font-weight: 600; }

        .field-label { display: block; font-size: 13px; font-weight: 700; color: var(--text-muted); margin-bottom: 10px; text-transform: uppercase; }
        .input-dark { background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 12px; color: #fff; padding: 12px 15px; width: 100%; margin-bottom: 25px; font-weight: 600; }

        .counter-box { display: flex; align-items: center; justify-content: space-between; background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 12px; padding: 10px 20px; margin-bottom: 30px; }
        .counter-btn { width: 30px; height: 30px; background: rgba(255,255,255,0.1); border: none; border-radius: 8px; color: #fff; font-size: 18px; font-weight: 800; cursor: pointer; }

        .price-details { margin-top: 30px; padding-top: 25px; border-top: 1px dashed var(--border); }
        .price-row { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 14px; font-weight: 600; color: var(--text-muted); }
        .total-row { border-top: 1px solid var(--border); margin-top: 15px; padding-top: 15px; font-size: 18px; font-weight: 800; color: #fff; }

        .btn-book { width: 100%; background: var(--accent-red); color: #fff; border: none; padding: 18px; border-radius: 16px; font-weight: 800; font-size: 16px; margin-top: 30px; cursor: pointer; transition: 0.3s; text-transform: uppercase; }
        .btn-book:hover { transform: translateY(-3px); box-shadow: 0 10px 25px rgba(225, 29, 72, 0.4); }
    </style>
</head>
<body>

    <div class="review-container">
        <a href="javascript:history.back()" class="back-btn"><i class="fa fa-arrow-left"></i> Back</a>

        <div class="card">
            <div class="price-header">
                <span class="price-val">₹${trip.price}</span>
                <span class="price-label">/ person</span>
            </div>

            <label class="field-label">Select Date</label>
            <input type="text" class="input-dark" value="${selectedDate}" readonly>

            <label class="field-label">Travelers</label>
            <div class="counter-box">
                <button class="counter-btn" onclick="update(-1)">-</button>
                <span id="count" style="font-weight: 800; font-size: 18px;">${travelers}</span>
                <button class="counter-btn" onclick="update(1)">+</button>
            </div>

            <div class="price-details">
                <div style="font-size: 15px; font-weight: 800; margin-bottom: 15px;">Price Details</div>
                <div class="price-row">
                    <span id="breakupLabel">₹${trip.price} x ${travelers} Adults</span>
                    <span id="basicCost">₹${trip.price * travelers}</span>
                </div>
                <div class="price-row">
                    <span>Discount (0%)</span>
                    <span style="color: #22c55e;">- ₹0</span>
                </div>
                <div class="total-row">
                    <span>Total Amount</span>
                    <span id="finalTotal">₹${trip.price * travelers}</span>
                </div>
            </div>

            <button class="btn-book" onclick="pay()">BOOK NOW</button>
        </div>
    </div>

    <script>
        let travelers = ${travelers};
        const price = ${trip.price};

        function update(delta) {
            travelers = Math.max(1, travelers + delta);
            document.getElementById('count').innerText = travelers;
            const total = price * travelers;
            document.getElementById('breakupLabel').innerText = "₹" + price.toLocaleString('en-IN') + " x " + travelers + " Adults";
            document.getElementById('basicCost').innerText = "₹" + total.toLocaleString('en-IN');
            document.getElementById('finalTotal').innerText = "₹" + total.toLocaleString('en-IN');
        }

        function pay() {
            const total = price * travelers;
            window.location.href = `/user/booking/payment?tripId=${trip.id}&selectedDate=${selectedDate}&travelers=` + travelers + `&amount=` + total;
        }
    </script>
</body>
</html>
