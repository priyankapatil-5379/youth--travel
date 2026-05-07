<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Messaging Center | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --bg-body: #f1f5f9;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            --sidebar-width: 260px;
        }
        body { font-family: 'Inter', sans-serif; background: var(--bg-body); color: var(--text-main); margin: 0; height: 100vh; overflow: hidden; }
        .main-content { margin-left: var(--sidebar-width); display: flex; flex-direction: column; height: 100vh; }

        .page-header { padding: 20px 32px; background: white; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; flex-shrink: 0; }
        .page-header h1 { font-size: 22px; font-weight: 800; margin: 0; }

        .chat-container { display: flex; flex: 1; overflow: hidden; background: white; margin: 20px; border-radius: 20px; border: 1px solid var(--border-color); box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04); }

        /* Left panel */
        .conv-panel { width: 340px; border-right: 1px solid var(--border-color); display: flex; flex-direction: column; flex-shrink: 0; }
        .conv-panel-header { padding: 20px; border-bottom: 1px solid var(--border-color); }
        .conv-panel-header h5 { margin: 0; font-weight: 700; font-size: 15px; }
        .search-box input { width: 100%; padding: 10px 14px; border-radius: 10px; border: 1px solid var(--border-color); background: #f8fafc; font-size: 13px; outline: none; margin-top: 10px; }
        .conv-list { flex: 1; overflow-y: auto; }
        .conv-item { padding: 15px 20px; display: flex; gap: 14px; cursor: pointer; border-bottom: 1px solid #f8fafc; transition: 0.2s; text-decoration: none; color: inherit; }
        .conv-item:hover { background: #f8fafc; }
        .conv-item.active { background: #f0f9f9; border-left: 4px solid var(--primary); }
        .vendor-avatar { width: 46px; height: 46px; border-radius: 12px; object-fit: cover; }
        .conv-info { flex: 1; overflow: hidden; }
        .conv-header-row { display: flex; justify-content: space-between; align-items: baseline; margin-bottom: 3px; }
        .vendor-name { font-weight: 700; font-size: 14px; }
        .last-time { font-size: 11px; color: var(--text-muted); }
        .last-msg { font-size: 12px; color: var(--text-muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .unread-badge { background: var(--primary); color: white; border-radius: 50%; width: 18px; height: 18px; font-size: 10px; display: flex; align-items: center; justify-content: center; font-weight: 700; margin-left: auto; flex-shrink: 0; }

        /* Right panel */
        .chat-panel { flex: 1; display: flex; flex-direction: column; background: #fafafa; overflow: hidden; }
        .chat-header { padding: 15px 28px; background: white; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; flex-shrink: 0; }
        .header-user { display: flex; align-items: center; gap: 12px; }
        .online-dot { width: 8px; height: 8px; border-radius: 50%; background: #10b981; animation: pulse 1.5s infinite; }
        @keyframes pulse { 0%,100%{opacity:1;} 50%{opacity:0.4;} }

        .messages-area { flex: 1; padding: 24px; overflow-y: auto; display: flex; flex-direction: column; gap: 16px; }
        .msg-bubble { max-width: 68%; padding: 12px 16px; border-radius: 16px; font-size: 14px; line-height: 1.5; }
        .msg-user { align-self: flex-end; background: var(--primary); color: white; border-bottom-right-radius: 4px; }
        .msg-vendor { align-self: flex-start; background: white; border: 1px solid var(--border-color); border-bottom-left-radius: 4px; }
        .msg-vendor .sender-label { font-size: 11px; font-weight: 700; color: var(--primary); margin-bottom: 4px; display: block; }
        .msg-time { font-size: 10px; margin-top: 5px; opacity: 0.65; display: block; }

        .input-area { padding: 18px 28px; background: white; border-top: 1px solid var(--border-color); flex-shrink: 0; }
        .input-wrapper { display: flex; gap: 12px; align-items: center; background: #f8fafc; border: 1px solid var(--border-color); border-radius: 14px; padding: 4px 12px; }
        .input-wrapper input { flex: 1; border: none; background: transparent; padding: 10px; outline: none; font-size: 14px; }
        .btn-send { background: var(--primary); color: white; width: 38px; height: 38px; border-radius: 10px; display: flex; align-items: center; justify-content: center; border: none; cursor: pointer; transition: 0.2s; flex-shrink: 0; }
        .btn-send:hover { background: var(--primary-hover); transform: scale(1.05); }

        .empty-state { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; color: var(--text-muted); padding: 40px; }
        .empty-state i { font-size: 56px; margin-bottom: 16px; opacity: 0.2; }
        .no-convs { padding: 40px 20px; text-align: center; color: var(--text-muted); font-size: 13px; }
    </style>
</head>
<body>
    <jsp:include page="user-sidebar.jsp">
        <jsp:param name="activePage" value="messages" />
    </jsp:include>

    <main class="main-content">
        <div class="page-header">
            <div>
                <h1>Messaging Center</h1>
                <p style="margin:0; color:var(--text-muted); font-size:13px;">Real-time chat with your trip vendors</p>
            </div>
            <div id="connStatus" style="background:#f0fdf4;color:#166534;padding:5px 14px;border-radius:100px;font-weight:700;font-size:11px;">
                <i class="fa fa-circle" style="font-size:8px;"></i> CONNECTING...
            </div>
        </div>

        <div class="chat-container">
            <!-- Left conversation list -->
            <div class="conv-panel">
                <div class="conv-panel-header">
                    <h5>Conversations</h5>
                    <div class="search-box">
                        <input type="text" id="searchInput" placeholder="Search vendors..." oninput="filterConversations(this.value)">
                    </div>
                </div>
                <div class="conv-list" id="convList">
                    <c:forEach var="entry" items="${conversations}">
                        <c:set var="msgs" value="${entry.value}" />
                        <c:set var="lastMsg" value="${msgs[msgs.size()-1]}" />
                        <div class="conv-item" id="conv-vendor-${entry.key.id}"
                             onclick="loadConversation(${entry.key.id}, '${entry.key.businessName}', ${lastMsg.booking != null ? lastMsg.booking.id : 0})"
                             data-vendor-name="${entry.key.businessName}">
                            <img src="https://ui-avatars.com/api/?name=${entry.key.businessName}&background=random&rounded=true" class="vendor-avatar" alt="${entry.key.businessName}">
                            <div class="conv-info">
                                <div class="conv-header-row">
                                    <span class="vendor-name">${entry.key.businessName}</span>
                                    <span class="last-time" id="last-time-${entry.key.id}">${lastMsg.formattedTime}</span>
                                </div>
                                <div class="last-msg" id="last-msg-${entry.key.id}">${lastMsg.content}</div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty conversations}">
                        <div class="no-convs">
                            <i class="fa fa-comments-o" style="font-size:36px;opacity:0.2;display:block;margin-bottom:10px;"></i>
                            No conversations yet.<br>Book a trip to start chatting with vendors.
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Right chat area -->
            <div class="chat-panel">
                <div id="chatEmpty" class="empty-state">
                    <i class="fa fa-comments-o"></i>
                    <h4 style="font-weight:700;margin-bottom:8px;">Your Messages</h4>
                    <p style="margin:0;font-size:14px;">Select a conversation to start chatting</p>
                </div>

                <div id="chatActive" style="display:none; flex-direction:column; height:100%; overflow:hidden;">
                    <div class="chat-header">
                        <div class="header-user">
                            <img id="activeVendorAvatar" src="" class="vendor-avatar" style="width:40px;height:40px;">
                            <div>
                                <div id="activeVendorName" style="font-weight:800;font-size:15px;"></div>
                                <div style="font-size:11px;color:#10b981;font-weight:700;display:flex;align-items:center;gap:5px;">
                                    <div class="online-dot"></div> Live Connected
                                </div>
                            </div>
                        </div>
                        <div style="color:var(--text-muted);font-size:12px;" id="activeBookingInfo"></div>
                    </div>

                    <div class="messages-area" id="msgArea"></div>

                    <div class="input-area">
                        <div class="input-wrapper">
                            <i class="fa fa-smile-o" style="color:var(--text-muted);"></i>
                            <input type="text" id="msgInput" placeholder="Type your message..."
                                   onkeypress="if(event.key==='Enter'&&!event.shiftKey){event.preventDefault();sendMsg();}">
                            <button class="btn-send" onclick="sendMsg()">
                                <i class="fa fa-paper-plane"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        // ── State ────────────────────────────────────────────
        const userEmail    = '${user.email}';
        const userName     = '${user.fullName}';
        const safeEmail    = userEmail.replace(/@/g, '_at_').replace(/\./g, '_dot_');

        let stompClient    = null;
        let activeVendorId = null;
        let activeBookingId= null;

        // ── WebSocket connection ─────────────────────────────
        function connect() {
            const socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);
            stompClient.debug = null;
            stompClient.connect({}, function(frame) {
                document.getElementById('connStatus').innerHTML =
                    '<i class="fa fa-circle" style="font-size:8px;"></i> LIVE';
                document.getElementById('connStatus').style.color = '#166534';

                // Subscribe to user's personal topic — receives vendor messages
                stompClient.subscribe('/topic/user/' + safeEmail, function(msg) {
                    const data = JSON.parse(msg.body);
                    handleIncoming(data);
                });
            }, function() {
                document.getElementById('connStatus').innerHTML =
                    '<i class="fa fa-circle" style="font-size:8px;color:#ef4444;"></i> OFFLINE';
                // Retry after 3s
                setTimeout(connect, 3000);
            });
        }

        function handleIncoming(msg) {
            const vendorIdStr = String(msg.vendorId);

            // Update sidebar preview for this vendor conversation
            const lastMsgEl  = document.getElementById('last-msg-' + msg.vendorId);
            const lastTimeEl = document.getElementById('last-time-' + msg.vendorId);
            if (lastMsgEl)  lastMsgEl.innerText  = msg.content;
            if (lastTimeEl) lastTimeEl.innerText = msg.formattedTime || '';

            // If the chat area for this vendor is currently open
            if (activeVendorId && vendorIdStr === String(activeVendorId)) {
                // Only append vendor messages — user messages are added optimistically
                if (msg.fromVendor) {
                    appendMessage(msg.content, false, msg.formattedTime || '', msg.senderName || 'Vendor');
                }
            } else if (msg.fromVendor) {
                // Conversation not open — add unread badge
                const convEl = document.getElementById('conv-vendor-' + msg.vendorId);
                if (convEl) {
                    let badge = convEl.querySelector('.unread-badge');
                    if (!badge) {
                        badge = document.createElement('div');
                        badge.className = 'unread-badge';
                        badge.innerText = '1';
                        convEl.querySelector('.conv-info').appendChild(badge);
                    } else {
                        badge.innerText = (parseInt(badge.innerText) || 0) + 1;
                    }
                }
            }
        }

        // ── Load conversation ────────────────────────────────
        async function loadConversation(vendorId, vendorName, bookingId) {
            activeVendorId  = vendorId;
            activeBookingId = bookingId;

            // UI switch
            document.getElementById('chatEmpty').style.display  = 'none';
            const chatActive = document.getElementById('chatActive');
            chatActive.style.display = 'flex';

            // Mark active in list and clear unread badge
            document.querySelectorAll('.conv-item').forEach(el => el.classList.remove('active'));
            const convEl = document.getElementById('conv-vendor-' + vendorId);
            if (convEl) {
                convEl.classList.add('active');
                const badge = convEl.querySelector('.unread-badge');
                if (badge) badge.remove();
            }

            // Set header
            document.getElementById('activeVendorName').innerText = vendorName;
            document.getElementById('activeVendorAvatar').src =
                'https://ui-avatars.com/api/?name=' + encodeURIComponent(vendorName) + '&background=random&rounded=true';
            document.getElementById('activeBookingInfo').innerText =
                bookingId && bookingId > 0 ? 'Booking #' + bookingId : '';

            // Always use the merged chat API (includes booking + non-booking messages)
            try {
                const resp = await fetch('/user/api/chat/' + vendorId);
                if (!resp.ok) throw new Error('HTTP ' + resp.status);
                const messages = await resp.json();

                const area = document.getElementById('msgArea');
                area.innerHTML = '';
                if (!Array.isArray(messages) || messages.length === 0) {
                    area.innerHTML = '<div style="text-align:center;color:var(--text-muted);font-size:13px;padding:20px;">No messages yet. Say hello!</div>';
                } else {
                    messages.forEach(m => {
                        const isUser = !m.fromVendor;
                        appendMessage(m.content, isUser, m.formattedTime, isUser ? userName : (m.senderName || vendorName));
                    });
                }
            } catch(err) {
                console.error('Error loading chat:', err);
            }
        }

        // ── Append message bubble ────────────────────────────
        function appendMessage(content, isUser, time, senderName) {
            const area = document.getElementById('msgArea');
            const div = document.createElement('div');
            div.className = 'msg-bubble ' + (isUser ? 'msg-user' : 'msg-vendor');
            if (!isUser && senderName) {
                div.innerHTML = '<span class="sender-label">' + senderName + '</span>' +
                    escapeHtml(content) + '<span class="msg-time">' + (time || '') + '</span>';
            } else {
                div.innerHTML = escapeHtml(content) + '<span class="msg-time">' + (time || '') + '</span>';
            }
            area.appendChild(div);
            area.scrollTop = area.scrollHeight;
        }

        // ── Send message ─────────────────────────────────────
        function sendMsg() {
            const input = document.getElementById('msgInput');
            const content = input.value.trim();
            if (!content || !stompClient || !activeVendorId) return;

            const now = new Date();
            const timeStr = now.toLocaleTimeString([], {hour:'2-digit',minute:'2-digit'}) +
                            ', ' + now.toLocaleDateString('en-US',{month:'short',day:'2-digit'});

            // Optimistic UI update
            appendMessage(content, true, timeStr, userName);
            input.value = '';

            // Send via WebSocket
            const payload = {
                content:     content,
                vendorId:    activeVendorId,
                senderEmail: userEmail,
                senderName:  userName,
                isFromVendor:false,
                bookingId:   activeBookingId || null,
                userEmail:   userEmail
            };
            stompClient.send('/app/chat.sendMessage', {}, JSON.stringify(payload));

            // Update preview
            const lastMsgEl = document.getElementById('last-msg-' + activeVendorId);
            if (lastMsgEl) lastMsgEl.innerText = content;
        }

        // ── Search/filter conversations ───────────────────────
        function filterConversations(query) {
            document.querySelectorAll('.conv-item').forEach(el => {
                const name = (el.dataset.vendorName || '').toLowerCase();
                el.style.display = name.includes(query.toLowerCase()) ? '' : 'none';
            });
        }

        function escapeHtml(text) {
            const div = document.createElement('div');
            div.appendChild(document.createTextNode(text));
            return div.innerHTML;
        }

        // ── Init ─────────────────────────────────────────────
        connect();
    </script>
</body>
</html>
