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
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body { font-family: 'Dosis', sans-serif; background-color: #0b0f18; color: rgba(255, 255, 255, 0.92); margin: 0; padding: 0; height: 100vh; overflow: hidden; }
        
        .header { position: fixed; top: 0; left: 0; right: 0; height: 70px; background: #161c28; display: flex; align-items: center; justify-content: space-between; padding: 0 30px; z-index: 1000; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .chat-container { display: flex; flex-direction: column; height: calc(100vh - 70px); margin-top: 70px; max-width: 900px; margin-left: auto; margin-right: auto; background: #161c28; border-left: 1px solid rgba(255,255,255,0.05); border-right: 1px solid rgba(255,255,255,0.05); }
        
        .chat-header { padding: 20px 30px; border-bottom: 1px solid rgba(255,255,255,0.05); display: flex; justify-content: space-between; align-items: center; background: rgba(255,255,255,0.02); }
        .chat-header-info { display: flex; align-items: center; gap: 15px; }
        
        .messages-area { flex: 1; padding: 30px; overflow-y: auto; display: flex; flex-direction: column; gap: 20px; }
        
        .msg-bubble { max-width: 70%; padding: 15px 20px; border-radius: 20px; font-size: 15px; line-height: 1.5; position: relative; }
        .msg-time { font-size: 11px; color: rgba(255,255,255,0.4); margin-top: 5px; display: block; }
        
        /* Message from Vendor (Sent by me) */
        .msg-sent { align-self: flex-end; background: var(--primary-blue); color: #fff; border-bottom-right-radius: 4px; box-shadow: 0 5px 15px rgba(240, 76, 38, 0.2); }
        .msg-sent .msg-time { text-align: right; color: rgba(255,255,255,0.8); }
        
        /* Message from User (Received) */
        .msg-received { align-self: flex-start; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-bottom-left-radius: 4px; }
        .msg-received .sender-label { font-size: 12px; font-weight: 700; color: #3b82f6; margin-bottom: 5px; display: block; }
        
        .chat-input-area { padding: 20px 30px; border-top: 1px solid rgba(255,255,255,0.05); background: rgba(0,0,0,0.2); }
        .chat-form { display: flex; gap: 15px; }
        .chat-input { flex: 1; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 30px; padding: 15px 25px; color: #fff; outline: none; transition: var(--transition); }
        .chat-input:focus { border-color: var(--primary-blue); background: rgba(255,255,255,0.08); }
        .btn-send { background: var(--primary-blue); color: #fff; border: none; width: 50px; height: 50px; border-radius: 50%; display: flex; justify-content: center; align-items: center; cursor: pointer; transition: var(--transition); box-shadow: 0 5px 15px rgba(240, 76, 38, 0.3); }
        .btn-send:hover { transform: scale(1.05); }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-logo"><a href="<c:url value='/vendor/dashboard'/>"><img src="<c:url value='/views/assets/images/logo.png'/>" style="height: 35px;"></a></div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <a href="<c:url value='/vendor/guest-list'/>" style="color: #fff; text-decoration: none; font-weight: 700; font-size: 14px;"><i class="fa fa-arrow-left"></i> Back to Guest List</a>
        </div>
    </header>

    <div class="chat-container">
        <div class="chat-header">
            <div class="chat-header-info">
                <img src="https://ui-avatars.com/api/?name=${booking.customerName}&background=random" style="width: 45px; height: 45px; border-radius: 50%;">
                <div>
                    <h3 style="margin: 0; font-size: 18px; font-weight: 800;">${booking.customerName}</h3>
                    <div style="font-size: 13px; color: var(--text-muted);">Trip: <span style="color: #fff;">${booking.trip.title}</span></div>
                </div>
            </div>
            <div>
                <span class="status-badge" style="background: rgba(34, 197, 94, 0.1); color: #22c55e; padding: 5px 12px; border-radius: 20px; font-weight: 700; font-size: 12px;">Booking ID: #${booking.id}</span>
                <div style="font-size: 11px; color: var(--text-muted); text-align: right; margin-top: 5px;">Travelers: ${booking.numberOfTravelers}</div>
            </div>
        </div>

        <div class="messages-area" id="messagesArea">
            <div style="text-align: center; margin-bottom: 20px;">
                <span style="background: rgba(255,255,255,0.05); padding: 5px 15px; border-radius: 20px; font-size: 12px; color: var(--text-muted);">This is the start of your conversation</span>
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
            <form class="chat-form" action="<c:url value='/vendor/booking/${booking.id}/chat'/>" method="post">
                <input type="text" name="content" class="chat-input" placeholder="Type your reply to the customer..." required autocomplete="off">
                <button type="submit" class="btn-send"><i class="fa fa-paper-plane"></i></button>
            </form>
        </div>
    </div>

    <script>
        // Auto-scroll to bottom of messages
        const messagesArea = document.getElementById('messagesArea');
        messagesArea.scrollTop = messagesArea.scrollHeight;
    </script>
</body>
</html>
