<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Vendor Messages | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #f04c26; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body.yt-dark { background: #0b0f18; color: #fff; font-family: 'Dosis', sans-serif; margin: 0; padding: 0; overflow: hidden; height: 100vh; }

        /* Top Header */
        .main-content { padding: 0 !important; display: flex; flex-direction: column; }
        .page-header { padding: 25px 40px; border-bottom: 1px solid rgba(255,255,255,0.05); background: #161c28; display: flex; align-items: center; justify-content: space-between; }
        .page-header h2 { margin: 0; font-weight: 800; font-size: 24px; }

        /* Chat UI Container */
        .chat-container { display: flex; flex-grow: 1; overflow: hidden; }

        /* Left Inbox List */
        .inbox-list { width: 350px; background: rgba(255,255,255,0.02); border-right: 1px solid rgba(255,255,255,0.05); overflow-y: auto; display: flex; flex-direction: column; }
        .inbox-search { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .inbox-search input { width: 100%; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 30px; padding: 12px 20px; color: #fff; outline: none; transition: var(--transition); }
        .inbox-search input:focus { border-color: var(--primary-blue); }
        
        .inbox-item { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.03); cursor: pointer; transition: 0.2s; display: flex; align-items: center; gap: 15px; }
        .inbox-item:hover { background: rgba(255,255,255,0.05); }
        .inbox-item.active { background: rgba(240, 76, 38, 0.1); border-left: 4px solid var(--primary-blue); }
        
        .avatar { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; }
        .inbox-details { flex: 1; overflow: hidden; }
        .inbox-name { font-weight: 700; font-size: 16px; margin-bottom: 3px; display: flex; justify-content: space-between; align-items: center; color: #fff; }
        .inbox-preview { font-size: 13px; color: var(--text-muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        
        /* Right Chat Area */
        .chat-view { flex-grow: 1; display: flex; flex-direction: column; background: #0b0f18; }
        
        .chat-header { padding: 20px 30px; border-bottom: 1px solid rgba(255,255,255,0.05); background: rgba(255,255,255,0.02); display: flex; align-items: center; justify-content: space-between; }
        
        .chat-messages { flex-grow: 1; padding: 30px; overflow-y: auto; display: flex; flex-direction: column; gap: 20px; }
        
        .msg-bubble { max-width: 70%; padding: 15px 20px; border-radius: 20px; font-size: 15px; line-height: 1.5; position: relative; }
        .msg-time { font-size: 11px; color: rgba(255,255,255,0.4); margin-top: 5px; display: block; }
        
        /* Bubble from Vendor (Me) */
        .msg-sent { align-self: flex-end; background: var(--primary-blue); color: #fff; border-bottom-right-radius: 4px; box-shadow: 0 5px 15px rgba(240, 76, 38, 0.2); }
        .msg-sent .msg-time { text-align: right; color: rgba(255,255,255,0.8); }
        
        /* Bubble from Customer (Them) */
        .msg-received { align-self: flex-start; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-bottom-left-radius: 4px; }
        
        /* Input Area */
        .chat-input-area { padding: 20px 30px; border-top: 1px solid rgba(255,255,255,0.05); background: #161c28; }
        .chat-form { display: flex; gap: 15px; align-items: center; }
        .chat-input { flex: 1; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 30px; padding: 15px 25px; color: #fff; outline: none; transition: var(--transition); }
        .chat-input:focus { border-color: var(--primary-blue); background: rgba(255,255,255,0.08); }
        .btn-send { background: var(--primary-blue); color: #fff; border: none; width: 50px; height: 50px; border-radius: 50%; display: flex; justify-content: center; align-items: center; cursor: pointer; transition: var(--transition); box-shadow: 0 5px 15px rgba(240, 76, 38, 0.3); flex-shrink: 0; }
        .btn-send:hover { transform: scale(1.05); }
    </style>
</head>

<body class="yt-dark">
    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="messages" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-header">
            <h2>Direct Inquiries</h2>
            <span class="badge" style="background: rgba(240, 76, 38, 0.1); color: var(--primary-blue); padding: 8px 15px; border-radius: 20px; font-weight: 700;">Global Inbox</span>
        </div>

        <div class="chat-container">
            <!-- Inbox List -->
            <div class="inbox-list">
                <div class="inbox-search">
                    <input type="text" placeholder="Search conversations...">
                </div>
                
                <c:forEach var="entry" items="${conversations}">
                    <c:set var="lastMsg" value="${entry.value[entry.value.size() - 1]}" />
                    <a href="<c:url value='/vendor/messages?chatWith=${entry.key}'/>" style="text-decoration: none; color: inherit; display: block;">
                        <div class="inbox-item ${chatWithEmail == entry.key ? 'active' : ''}">
                            <img src="https://ui-avatars.com/api/?name=${lastMsg.senderName}&background=random" class="avatar">
                            <div class="inbox-details">
                                <div class="inbox-name">
                                    ${lastMsg.senderName}
                                    <span style="font-size: 11px; color: var(--text-muted); font-weight: 500;">
                                        ${lastMsg.formattedTime}
                                    </span>
                                </div>
                                <div class="inbox-preview">${lastMsg.content}</div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
                
                <c:if test="${empty conversations}">
                    <div style="padding: 40px 20px; text-align: center; color: var(--text-muted);">
                        <i class="fa fa-inbox mb-3" style="font-size: 40px; opacity: 0.3;"></i>
                        <p>No inquiries received yet.</p>
                    </div>
                </c:if>
            </div>

            <!-- Chat Area -->
            <div class="chat-view">
                <c:choose>
                    <c:when test="${not empty chatWithEmail}">
                        <!-- Active Chat Header -->
                        <div class="chat-header">
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <img src="https://ui-avatars.com/api/?name=${chatWithEmail}&background=random" style="width: 45px; height: 45px; border-radius: 50%;">
                                <div>
                                    <h4 style="margin: 0; font-size: 18px; font-weight: 800; color: #fff;">${chatWithEmail}</h4>
                                    <div style="font-size: 13px; color: #22c55e;"><i class="fa fa-circle"></i> Online</div>
                                </div>
                            </div>
                            <button class="btn btn-sm btn-outline-light" style="border-radius: 20px; border-color: rgba(255,255,255,0.1);"><i class="fa fa-ellipsis-v"></i></button>
                        </div>

                        <!-- Messages -->
                        <div class="chat-messages" id="chatBox">
                            <div style="text-align: center; margin-bottom: 20px;">
                                <span style="background: rgba(255,255,255,0.05); padding: 5px 15px; border-radius: 20px; font-size: 12px; color: var(--text-muted);">Conversation started</span>
                            </div>

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

                        <!-- Input Box -->
                        <div class="chat-input-area">
                            <form class="chat-form" action="<c:url value='/vendor/send-reply'/>" method="post">
                                <input type="hidden" name="recipientEmail" value="${chatWithEmail}">
                                <input type="text" name="content" class="chat-input" placeholder="Type your reply to ${chatWithEmail}..." required autocomplete="off">
                                <button type="submit" class="btn-send"><i class="fa fa-paper-plane"></i></button>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Empty State -->
                        <div style="flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; color: var(--text-muted);">
                            <div style="width: 100px; height: 100px; border-radius: 50%; background: rgba(255,255,255,0.02); display: flex; align-items: center; justify-content: center; margin-bottom: 20px;">
                                <i class="fa fa-comments-o" style="font-size: 40px; color: rgba(255,255,255,0.1);"></i>
                            </div>
                            <h3 style="color: #fff; font-weight: 700;">Your Messages</h3>
                            <p>Select a conversation from the left to start chatting.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        // Auto-scroll to bottom
        const chatBox = document.getElementById('chatBox');
        if (chatBox) {
            chatBox.scrollTop = chatBox.scrollHeight;
        }
    </script>
</body>
</html>