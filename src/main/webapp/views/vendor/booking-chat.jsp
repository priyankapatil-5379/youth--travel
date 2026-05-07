<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat with ${booking.customerName} | Youth Travel Vendor</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
            -webkit-font-smoothing: antialiased;
        }
        
        .chat-container {
            display: flex;
            flex-direction: column;
            height: 100vh;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
            background: var(--bg-card);
            border-left: 1px solid var(--border-color);
            border-right: 1px solid var(--border-color);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }
        
        .chat-header {
            padding: 20px 30px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
        }

        .chat-header-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .messages-area {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 24px;
            background: #f8fafc;
        }
        
        .msg-bubble {
            max-width: 65%;
            padding: 14px 20px;
            border-radius: 16px;
            font-size: 14px;
            line-height: 1.6;
            position: relative;
        }

        .msg-time {
            font-size: 11px;
            margin-top: 6px;
            display: block;
            opacity: 0.7;
            font-weight: 500;
        }
        
        /* Message from Vendor (Sent by me) */
        .msg-sent {
            align-self: flex-end;
            background: linear-gradient(135deg, var(--primary), #077378);
            color: #ffffff;
            border-bottom-right-radius: 4px;
            box-shadow: 0 4px 12px rgba(0, 128, 128, 0.2);
        }
        .msg-sent .msg-time {
            text-align: right;
            color: rgba(255,255,255,0.8);
        }
        
        /* Message from User (Received) */
        .msg-received {
            align-self: flex-start;
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-bottom-left-radius: 4px;
            color: var(--text-main);
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        .msg-received .sender-label {
            font-size: 12px;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 6px;
            display: block;
        }
        .msg-received .msg-time {
            color: var(--text-muted);
        }
        
        .chat-input-area {
            padding: 24px 30px;
            border-top: 1px solid var(--border-color);
            background: #ffffff;
        }

        .chat-form {
            display: flex;
            gap: 16px;
            align-items: center;
        }

        .chat-input {
            flex: 1;
            background: #f1f5f9;
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 14px 24px;
            color: var(--text-main);
            font-size: 14px;
            outline: none;
            transition: 0.2s;
        }

        .chat-input:focus {
            border-color: var(--primary);
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1);
        }

        .btn-send {
            background: var(--primary);
            color: #ffffff;
            border: none;
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: 0.2s;
            box-shadow: 0 4px 12px rgba(0, 128, 128, 0.2);
        }

        .btn-send:hover {
            transform: translateY(-2px);
            background: var(--primary-hover);
        }

        .live-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }

        .live-dot {
            width: 6px;
            height: 6px;
            background: #10b981;
            border-radius: 50%;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse { 0%,100%{opacity:1;} 50%{opacity:0.4;} }
    </style>
</head>
<body>

    <div class="chat-container">
        <div class="chat-header">
            <div class="chat-header-info">
                <img src="https://ui-avatars.com/api/?name=${booking.customerName}&background=random" style="width: 45px; height: 45px; border-radius: 50%;">
                <div>
                    <h3 style="margin: 0; font-size: 18px; font-weight: 800; color: var(--text-main);">${booking.customerName}</h3>
                    <div style="font-size: 13px; color: var(--text-muted); margin-top: 2px;">Trip: <span style="color: var(--text-main); font-weight: 600;">${booking.trip.title}</span></div>
                </div>
            </div>
            <div style="display:flex; align-items:center; gap:15px;">
                <div class="live-badge"><div class="live-dot"></div> LIVE</div>
                <div>
                    <span class="status-badge" style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 5px 12px; border-radius: 20px; font-weight: 700; font-size: 12px;">Booking ID: #${booking.id}</span>
                    <div style="font-size: 11px; color: var(--text-muted); text-align: right; margin-top: 5px;">Travelers: ${booking.numberOfTravelers}</div>
                </div>
            </div>
        </div>

        <div class="messages-area" id="messagesArea">
            <div style="text-align: center; margin-bottom: 20px;">
                <span style="background: #ffffff; border: 1px solid var(--border-color); padding: 5px 15px; border-radius: 20px; font-size: 12px; color: var(--text-muted);">This is the start of your conversation</span>
            </div>

            <c:forEach var="msg" items="${messages}">
                <c:choose>
                    <c:when test="${msg.isFromVendor()}">
                        <div class="msg-bubble msg-sent">
                            ${msg.content}
                            <span class="msg-time">${msg.formattedTime}</span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="msg-bubble msg-received">
                            <span class="sender-label">${booking.customerName} (Customer)</span>
                            ${msg.content}
                            <span class="msg-time">${msg.formattedTime}</span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

        <div class="chat-input-area">
            <form class="chat-form" id="chatForm" action="<c:url value='/vendor/booking/${booking.id}/chat'/>" method="post">
                <input type="text" name="content" id="msgInput" class="chat-input" placeholder="Type your reply to the customer..." required autocomplete="off">
                <button type="submit" class="btn-send"><i class="fa fa-paper-plane"></i></button>
            </form>
        </div>
    </div>

    <script>
        const bookingId = ${booking.id};
        const messagesArea = document.getElementById('messagesArea');

        // Auto-scroll to bottom
        messagesArea.scrollTop = messagesArea.scrollHeight;

        // WebSocket connection — listen for incoming user replies
        let stompClient = null;

        function connect() {
            const socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);
            stompClient.debug = null; // suppress console noise
            stompClient.connect({}, function(frame) {
                // Subscribe to the booking-specific topic
                stompClient.subscribe('/topic/booking/' + bookingId, function(msg) {
                    const data = JSON.parse(msg.body);
                    // Only append messages FROM USER (not from vendor — those are added by form submit)
                    if (!data.fromVendor) {
                        appendMessage(data);
                    }
                });
            });
        }

        function appendMessage(msg) {
            const isVendor = msg.fromVendor;
            const div = document.createElement('div');
            div.className = 'msg-bubble ' + (isVendor ? 'msg-sent' : 'msg-received');
            if (!isVendor) {
                div.innerHTML = '<span class="sender-label">' + (msg.senderName || 'Customer') + ' (Customer)</span>' +
                    msg.content + '<span class="msg-time">' + (msg.formattedTime || '') + '</span>';
            } else {
                div.innerHTML = msg.content + '<span class="msg-time">' + (msg.formattedTime || '') + '</span>';
            }
            messagesArea.appendChild(div);
            messagesArea.scrollTop = messagesArea.scrollHeight;
        }

        connect();
    </script>
</body>
</html>
