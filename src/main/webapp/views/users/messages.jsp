<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>My Messages | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800" rel="stylesheet">
    <style>
        :root { --primary-blue: #e63946; --text-muted: #7e8c9a; --transition: all 0.3s ease; }
        body.yt-dark { background: #0b0f18; color: #fff; font-family: 'Dosis', sans-serif; margin: 0; padding: 0; overflow: hidden; height: 100vh; }

        .header { 
            position: fixed; top: 0; left: 0; right: 0; height: 75px; 
            background: rgba(0, 0, 0, 0.4); 
            backdrop-filter: blur(15px); 
            -webkit-backdrop-filter: blur(15px);
            display: flex; align-items: center; justify-content: space-between; 
            padding: 0 40px; z-index: 1000; 
            border-bottom: 1px solid rgba(255, 255, 255, 0.08); 
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
        }

        .main-content { margin-left: 240px; height: 100vh; display: flex; flex-direction: column; padding: 0; background: transparent; margin-top: 0; }

        /* Top Header */
        .page-header { padding: 25px 40px; border-bottom: 1px solid rgba(255,255,255,0.1); background: rgba(0,0,0,0.3); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: space-between; box-shadow: 0 4px 20px rgba(0,0,0,0.2); }
        .page-header h2 { margin: 0; font-weight: 800; font-size: 24px; color: #fff; text-shadow: 0 2px 10px rgba(0,0,0,0.8); }

        /* Chat UI Container */
        .chat-container { display: flex; flex-grow: 1; overflow: hidden; }

        /* Left Inbox List */
        .inbox-list { width: 350px; background: rgba(0,0,0,0.1); backdrop-filter: blur(15px); border-right: 1px solid rgba(255,255,255,0.1); overflow-y: auto; display: flex; flex-direction: column; }
        .inbox-search { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .inbox-search input { width: 100%; background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.2); border-radius: 30px; padding: 12px 20px; color: #fff; outline: none; transition: var(--transition); backdrop-filter: blur(5px); }
        .inbox-search input:focus { border-color: var(--primary-blue); background: rgba(0,0,0,0.6); box-shadow: 0 0 15px rgba(230, 57, 70, 0.2); }
        
        .inbox-item { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.03); cursor: pointer; transition: 0.2s; display: flex; align-items: center; gap: 15px; }
        .inbox-item:hover { background: rgba(255,255,255,0.05); }
        .inbox-item.active { background: rgba(240, 76, 38, 0.1); border-left: 4px solid var(--primary-blue); }
        
        .avatar { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; }
        .inbox-details { flex: 1; overflow: hidden; }
        .inbox-name { font-weight: 800; font-size: 16px; margin-bottom: 3px; display: flex; justify-content: space-between; align-items: center; color: #fff; text-shadow: 0 1px 3px rgba(0,0,0,0.5); }
        .inbox-preview { font-size: 13px; color: rgba(255,255,255,0.7); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-weight: 500; }
        
        /* Right Chat Area */
        .chat-view { flex-grow: 1; display: flex; flex-direction: column; background: rgba(0,0,0,0.05); backdrop-filter: blur(5px); }
        
        .chat-header { padding: 20px 30px; border-bottom: 1px solid rgba(255,255,255,0.1); background: rgba(0,0,0,0.2); backdrop-filter: blur(10px); display: flex; align-items: center; justify-content: space-between; }
        
        .chat-messages { flex-grow: 1; padding: 30px; overflow-y: auto; display: flex; flex-direction: column; gap: 20px; }
        
        .msg-bubble { max-width: 70%; padding: 15px 22px; border-radius: 20px; font-size: 16px; line-height: 1.5; position: relative; font-weight: 600; text-shadow: 0 1px 3px rgba(0,0,0,0.3); }
        .msg-time { font-size: 11px; color: rgba(255,255,255,0.8); margin-top: 6px; display: block; font-weight: 700; text-shadow: 0 1px 2px rgba(0,0,0,0.5); }
        
        /* Bubble from Customer (Me) */
        .msg-sent { align-self: flex-end; background: #ff4d4d; color: #fff; border-bottom-right-radius: 4px; box-shadow: 0 8px 25px rgba(255, 77, 77, 0.3); }
        .msg-sent .msg-time { text-align: right; color: rgba(255,255,255,0.9); }
        
        /* Bubble from Vendor (Them) */
        .msg-received { align-self: flex-start; background: rgba(0,0,0,0.5); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.1); border-bottom-left-radius: 4px; color: #fff; }
        
        /* Input Area */
        .chat-input-area { padding: 20px 30px; border-top: 1px solid rgba(255,255,255,0.1); background: rgba(0,0,0,0.3); backdrop-filter: blur(10px); }
        .chat-form { display: flex; gap: 15px; align-items: center; }
        .chat-input { flex: 1; background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.2); border-radius: 30px; padding: 15px 25px; color: #fff; outline: none; transition: var(--transition); backdrop-filter: blur(5px); }
        .chat-input:focus { border-color: var(--primary-blue); background: rgba(0,0,0,0.6); box-shadow: 0 0 15px rgba(230, 57, 70, 0.2); }
        .btn-send { background: var(--primary-blue); color: #fff; border: none; width: 50px; height: 50px; border-radius: 50%; display: flex; justify-content: center; align-items: center; cursor: pointer; transition: var(--transition); box-shadow: 0 5px 15px rgba(240, 76, 38, 0.3); flex-shrink: 0; }
        .btn-send:hover { transform: scale(1.05); }
    </style>
</head>

<body class="yt-dark premium-theme">

    <!-- Sunlight Rays -->
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
    </div>
    
    <jsp:include page="user-sidebar.jsp">
        <jsp:param name="activePage" value="messages" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-header">
            <h2>Messaging Center</h2>
            <span class="badge" style="background: rgba(34, 197, 94, 0.1); color: #22c55e; padding: 8px 15px; border-radius: 20px; font-weight: 700;">Global Inbox</span>
        </div>

        <div class="chat-container">
            <!-- Inbox List -->
            <div class="inbox-list">
                <div class="inbox-search">
                    <input type="text" placeholder="Search conversations...">
                </div>
                
                <c:forEach var="entry" items="${conversations}">
                    <c:set var="lastMsg" value="${entry.value[entry.value.size() - 1]}" />
                    <c:set var="vendor" value="${entry.key}" />
                    <a href="<c:url value='/user/messages?chatWith=${vendor.id}'/>" style="text-decoration: none; color: inherit; display: block;">
                        <div class="inbox-item ${chatWithVendor != null && chatWithVendor.id == vendor.id ? 'active' : ''}">
                            <div style="width: 48px; height: 48px; border-radius: 50%; background: rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--primary-blue); flex-shrink: 0;">
                                <i class="fa fa-building"></i>
                            </div>
                            <div class="inbox-details">
                                <div class="inbox-name">
                                    ${vendor.businessName}
                                    <span style="font-size: 11px; color: var(--text-muted); font-weight: 500;">
                                        ${lastMsg.formattedTime}
                                    </span>
                                </div>
                                <div class="inbox-preview">
                                    <c:if test="${not lastMsg.isFromVendor()}">You: </c:if>${lastMsg.content}
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
                
                <c:if test="${empty conversations}">
                    <div style="padding: 40px 20px; text-align: center; color: var(--text-muted);">
                        <i class="fa fa-inbox mb-3" style="font-size: 40px; opacity: 0.3;"></i>
                        <p>No messages yet.</p>
                    </div>
                </c:if>
            </div>

            <!-- Chat Area -->
            <div class="chat-view">
                <c:choose>
                    <c:when test="${not empty chatWithVendor}">
                        <!-- Active Chat Header -->
                        <div class="chat-header">
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <div style="width: 45px; height: 45px; border-radius: 50%; background: rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--primary-blue);">
                                    <i class="fa fa-building"></i>
                                </div>
                                <div>
                                    <h4 style="margin: 0; font-size: 18px; font-weight: 800; color: #fff;">${chatWithVendor.businessName}</h4>
                                    <div style="font-size: 13px; color: #22c55e;"><i class="fa fa-circle"></i> Online</div>
                                </div>
                            </div>
                        </div>

                        <!-- Messages -->
                        <div class="chat-messages" id="chatBox">
                            <div style="text-align: center; margin-bottom: 20px;">
                                <span style="background: rgba(255,255,255,0.05); padding: 5px 15px; border-radius: 20px; font-size: 12px; color: var(--text-muted);">Conversation started</span>
                            </div>

                            <c:forEach var="msg" items="${activeChat}">
                                <c:choose>
                                    <c:when test="${not msg.isFromVendor()}">
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
                            <form class="chat-form" action="<c:url value='/user/send-reply'/>" method="post">
                                <input type="hidden" name="vendorId" value="${chatWithVendor.id}">
                                <input type="text" name="content" class="chat-input" placeholder="Type your message to ${chatWithVendor.businessName}..." required autocomplete="off">
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
