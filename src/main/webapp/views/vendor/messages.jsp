<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vendor Messages | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
            --sidebar-width: 260px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            height: 100vh;
            display: flex;
            flex-direction: column;
            transition: 0.3s;
        }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; }
        }

        .page-header {
            padding: 20px 32px;
            background: var(--bg-card);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-shrink: 0;
        }

        .page-header h2 {
            margin: 0;
            font-weight: 800;
            font-size: 24px;
            letter-spacing: -0.5px;
        }

        /* Chat UI Container */
        .chat-container {
            display: flex;
            flex-grow: 1;
            overflow: hidden;
            background: var(--bg-card);
        }

        /* Left Inbox List */
        .inbox-list {
            width: 380px;
            background: #ffffff;
            border-right: 1px solid var(--border-color);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }

        .inbox-search {
            padding: 24px;
            border-bottom: 1px solid var(--border-color);
        }

        .inbox-search input {
            width: 100%;
            background: #f1f5f9;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 12px 20px;
            color: var(--text-main);
            font-size: 14px;
            outline: none;
            transition: 0.2s;
        }

        .inbox-search input:focus {
            border-color: var(--primary);
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1);
        }
        
        .inbox-item {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            cursor: pointer;
            transition: 0.2s;
            display: flex;
            align-items: center;
            gap: 16px;
            text-decoration: none;
            color: inherit;
        }

        .inbox-item:hover {
            background: #f8fafc;
        }

        .inbox-item.active {
            background: #f0f9f9;
            border-left: 4px solid var(--primary);
        }
        
        .avatar {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            object-fit: cover;
        }

        .inbox-details {
            flex: 1;
            overflow: hidden;
        }

        .inbox-name {
            font-weight: 700;
            font-size: 15px;
            margin-bottom: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .inbox-preview {
            font-size: 13px;
            color: var(--text-muted);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .inbox-time {
            font-size: 11px;
            color: var(--text-muted);
            font-weight: 500;
        }
        
        /* Right Chat Area */
        .chat-view {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            background: #f8fafc;
        }
        
        .chat-header {
            padding: 20px 32px;
            border-bottom: 1px solid var(--border-color);
            background: #ffffff;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .user-status {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-status h4 {
            margin: 0;
            font-size: 16px;
            font-weight: 700;
        }

        .status-indicator {
            font-size: 12px;
            color: #10b981;
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: 600;
        }
        
        .chat-messages {
            flex-grow: 1;
            padding: 32px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 24px;
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
        
        /* Bubble from Vendor (Me) */
        .msg-sent {
            align-self: flex-end;
            background: linear-gradient(135deg, var(--primary), #077378);
            color: #ffffff;
            border-bottom-right-radius: 4px;
            box-shadow: 0 4px 12px rgba(0, 128, 128, 0.2);
        }
        
        /* Bubble from Customer (Them) */
        .msg-received {
            align-self: flex-start;
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-bottom-left-radius: 4px;
            color: var(--text-main);
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        
        /* Input Area */
        .chat-input-area {
            padding: 24px 32px;
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

        .empty-chat {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            text-align: center;
            padding: 40px;
        }

        .empty-chat i {
            font-size: 64px;
            color: var(--border-color);
            margin-bottom: 24px;
        }

        .empty-chat h3 {
            color: var(--text-main);
            font-weight: 700;
            margin-bottom: 8px;
        }
    </style>
</head>

<body>
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="messages" />
    </jsp:include>

    <div class="main-content">
        <div class="page-header">
            <h2>Direct Inquiries</h2>
            <div style="background: #e0f2f2; color: var(--primary); padding: 8px 16px; border-radius: 30px; font-weight: 700; font-size: 12px;">Global Inbox</div>
        </div>

        <div class="chat-container">
            <!-- Inbox List -->
            <div class="inbox-list">
                <div class="inbox-search">
                    <input type="text" placeholder="Search conversations...">
                </div>
                
                <c:forEach var="entry" items="${conversations}">
                    <c:set var="lastMsg" value="${entry.value[entry.value.size() - 1]}" />
                    <a href="<c:url value='/vendor/messages?chatWith=${entry.key}'/>" class="inbox-item ${chatWithEmail == entry.key ? 'active' : ''}">
                        <img src="https://ui-avatars.com/api/?name=${lastMsg.senderName}&background=random&rounded=true&size=128" class="avatar">
                        <div class="inbox-details">
                            <div class="inbox-name">
                                ${lastMsg.senderName}
                                <span class="inbox-time">${lastMsg.formattedTime}</span>
                            </div>
                            <div class="inbox-preview">${lastMsg.content}</div>
                        </div>
                    </a>
                </c:forEach>
                
                <c:if test="${empty conversations}">
                    <div style="padding: 60px 24px; text-align: center; color: var(--text-muted);">
                        <i class="fa fa-inbox mb-3" style="font-size: 48px; color: var(--border-color);"></i>
                        <p style="font-weight: 500;">No inquiries received yet.</p>
                    </div>
                </c:if>
            </div>

            <!-- Chat Area -->
            <div class="chat-view">
                <c:choose>
                    <c:when test="${not empty chatWithEmail}">
                        <div class="chat-header">
                            <div class="user-status">
                                <img src="https://ui-avatars.com/api/?name=${chatWithEmail}&background=random&rounded=true&size=128" style="width: 44px; height: 44px;">
                                <div>
                                    <h4>${chatWithEmail}</h4>
                                    <div class="status-indicator"><i class="fa fa-circle"></i> Online</div>
                                </div>
                            </div>
                            <button class="btn btn-link text-muted"><i class="fa fa-ellipsis-v"></i></button>
                        </div>

                        <div class="chat-messages" id="chatBox">
                            <c:forEach var="msg" items="${activeChat}">
                                <c:choose>
                                    <c:when test="${msg.isFromVendor()}">
                                        <div class="msg-bubble msg-sent">
                                            ${msg.content}
                                            <span class="msg-time">${msg.formattedTime}</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="msg-bubble msg-received">
                                            ${msg.content}
                                            <span class="msg-time">${msg.formattedTime}</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>

                        <div class="chat-input-area">
                            <form class="chat-form" action="<c:url value='/vendor/send-reply'/>" method="post">
                                <input type="hidden" name="recipientEmail" value="${chatWithEmail}">
                                <input type="text" name="content" class="chat-input" placeholder="Type your reply to ${chatWithEmail}..." required autocomplete="off">
                                <button type="submit" class="btn-send"><i class="fa fa-paper-plane"></i></button>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-chat">
                            <i class="fa fa-comments-o"></i>
                            <h3>Your Messages</h3>
                            <p>Select a conversation from the left to start chatting with your customers.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script>
        const chatBox = document.getElementById('chatBox');
        if (chatBox) chatBox.scrollTop = chatBox.scrollHeight;

        let stompClient = null;
        const vendorId = "${loggedInVendor.id}";
        const vendorName = "${loggedInVendor.businessName}";
        const activeChatEmail = "${chatWithEmail}";

        function connect() {
            const socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                stompClient.subscribe('/topic/vendor/' + vendorId, function (msg) {
                    const message = JSON.parse(msg.body);
                    onMessageReceived(message);
                });
            });
        }

        function onMessageReceived(message) {
            // Append to chat if it's from the active user OR it's an echo of my own message to this user
            const isFromActiveUser = !message.fromVendor && message.senderEmail === activeChatEmail;
            const isMyEchoToActiveUser = message.fromVendor && message.userEmail === activeChatEmail;
            
            if (activeChatEmail && (isFromActiveUser || isMyEchoToActiveUser)) {
                appendMessage(message);
            }
            // Update preview in list
            const previews = document.querySelectorAll('.inbox-preview');
            previews.forEach(p => {
                if (p.closest('.inbox-item').href.includes(message.senderEmail)) {
                    p.innerText = message.content;
                }
            });
        }

        function appendMessage(msg) {
            if (!chatBox) return;
            const isMe = msg.fromVendor;
            const time = new Date(msg.sentAt).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
            
            const div = document.createElement('div');
            div.className = 'msg-bubble ' + (isMe ? 'msg-sent' : 'msg-received');
            div.innerHTML = `
                \${msg.content}
                <span class="msg-time">\${time}</span>
            `;
            chatBox.appendChild(div);
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        // Intercept form submission to send via WebSocket
        const chatForm = document.querySelector('.chat-form');
        if (chatForm) {
            chatForm.onsubmit = function(e) {
                e.preventDefault();
                const input = chatForm.querySelector('input[name="content"]');
                const content = input.value.trim();
                if (content && stompClient) {
                    const msgPayload = {
                        content: content,
                        vendorId: vendorId,
                        senderEmail: activeChatEmail, // Conversation key (user email)
                        senderName: vendorName,
                        userEmail: activeChatEmail, // Recipient identification
                        isFromVendor: true
                    };
                    stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(msgPayload));
                    input.value = '';
                }
            };
        }

        connect();
    </script>
</body>
</html>