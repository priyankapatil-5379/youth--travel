<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>My Messages | Youth Travel</title>
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #008080;
            --primary-hover: #077378;
            --accent-red: #e63946;
            --bg-body: #f1f5f9;
            --bg-card: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --sidebar-width: 260px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body.light-theme { 
            background: var(--bg-body); 
            color: var(--text-main); 
            font-family: 'Inter', sans-serif; 
            margin: 0; padding: 0; 
            overflow: hidden; 
            height: 100vh; 
            -webkit-font-smoothing: antialiased;
        }

        .wrapper { display: flex; height: 100vh; }

        .main-content { 
            flex: 1; 
            margin-left: var(--sidebar-width); 
            height: 100vh; 
            display: flex; 
            flex-direction: column; 
            background: var(--bg-body);
        }

        /* Top Header */
        .page-header { 
            padding: 24px 40px; 
            background: var(--bg-card); 
            border-bottom: 1px solid var(--border-color); 
            display: flex; 
            align-items: center; 
            justify-content: space-between; 
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            z-index: 10;
        }
        .page-header h2 { margin: 0; font-weight: 800; font-size: 24px; color: var(--text-main); letter-spacing: -0.5px; }

        /* Chat UI Container */
        .chat-container { display: flex; flex: 1; overflow: hidden; background: var(--bg-card); margin: 24px; border-radius: 16px; border: 1px solid var(--border-color); box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }

        /* Left Inbox List */
        .inbox-list { width: 350px; background: #f8fafc; border-right: 1px solid var(--border-color); overflow-y: auto; display: flex; flex-direction: column; }
        .inbox-search { padding: 20px; border-bottom: 1px solid var(--border-color); background: #ffffff; }
        .inbox-search input { 
            width: 100%; 
            background: #f1f5f9; 
            border: 1px solid var(--border-color); 
            border-radius: 12px; 
            padding: 12px 16px; 
            color: var(--text-main); 
            outline: none; 
            transition: var(--transition); 
            font-size: 14px;
            font-weight: 500;
        }
        .inbox-search input:focus { border-color: var(--primary); background: #ffffff; box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1); }
        
        .inbox-item { padding: 20px; border-bottom: 1px solid var(--border-color); cursor: pointer; transition: var(--transition); display: flex; align-items: center; gap: 16px; background: #ffffff; }
        .inbox-item:hover { background: #f8fafc; }
        .inbox-item.active { background: #f0fdfa; border-left: 4px solid var(--primary); }
        
        .inbox-details { flex: 1; overflow: hidden; }
        .inbox-name { font-weight: 700; font-size: 15px; margin-bottom: 4px; display: flex; justify-content: space-between; align-items: center; color: var(--text-main); }
        .inbox-preview { font-size: 13px; color: var(--text-muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-weight: 500; }
        
        /* Right Chat Area */
        .chat-view { flex: 1; display: flex; flex-direction: column; background: #ffffff; }
        
        .chat-header { padding: 20px 32px; border-bottom: 1px solid var(--border-color); background: #ffffff; display: flex; align-items: center; justify-content: space-between; }
        
        .chat-messages { flex: 1; padding: 32px; overflow-y: auto; display: flex; flex-direction: column; gap: 24px; background: #f8fafc; }
        
        .msg-bubble { max-width: 70%; padding: 14px 20px; border-radius: 16px; font-size: 15px; line-height: 1.5; position: relative; font-weight: 500; }
        .msg-time { font-size: 11px; margin-top: 6px; display: block; font-weight: 600; }
        
        /* Bubble from Me */
        .msg-sent { align-self: flex-end; background: var(--primary); color: #ffffff; border-bottom-right-radius: 4px; box-shadow: 0 4px 6px -1px rgba(0, 128, 128, 0.2); }
        .msg-sent .msg-time { text-align: right; color: rgba(255,255,255,0.8); }
        
        /* Bubble from Them */
        .msg-received { align-self: flex-start; background: #ffffff; border: 1px solid var(--border-color); border-bottom-left-radius: 4px; color: var(--text-main); box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); }
        .msg-received .msg-time { color: var(--text-muted); }
        
        /* Input Area */
        .chat-input-area { padding: 24px 32px; border-top: 1px solid var(--border-color); background: #ffffff; }
        .chat-form { display: flex; gap: 16px; align-items: center; }
        .chat-input { 
            flex: 1; 
            background: #f1f5f9; 
            border: 1px solid var(--border-color); 
            border-radius: 12px; 
            padding: 14px 20px; 
            color: var(--text-main); 
            outline: none; 
            transition: var(--transition); 
            font-weight: 500;
        }
        .chat-input:focus { border-color: var(--primary); background: #ffffff; box-shadow: 0 0 0 4px rgba(0, 128, 128, 0.1); }
        
        .btn-send { 
            background: var(--primary); 
            color: #ffffff; 
            border: none; 
            width: 48px; 
            height: 48px; 
            border-radius: 12px; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            cursor: pointer; 
            transition: var(--transition); 
            box-shadow: 0 4px 6px -1px rgba(0, 128, 128, 0.2); 
            flex-shrink: 0; 
        }
        .btn-send:hover { background: var(--primary-hover); transform: translateY(-1px); }

        @media (max-width: 991px) {
            .main-content { margin-left: 0; }
            .inbox-list { width: 100%; }
            .chat-view { display: none; }
            .chat-view.active { display: flex; position: fixed; inset: 0; z-index: 2000; }
        }
    </style>
</head>

    
<body class="light-theme">
    <div class="wrapper">
        <jsp:include page="user-sidebar.jsp">
            <jsp:param name="activePage" value="messages" />
        </jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-header">
            <h2>Messaging Center</h2>
            <span style="background: #f0fdf4; color: #166534; padding: 6px 12px; border-radius: 100px; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Support Active</span>
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
                            <div style="width: 48px; height: 48px; border-radius: 12px; background: #f0fdfa; display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--primary); flex-shrink: 0; border: 1px solid #ccfbf1;">
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
                                <div style="width: 45px; height: 45px; border-radius: 12px; background: #f0fdfa; display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--primary); border: 1px solid #ccfbf1;">
                                    <i class="fa fa-building"></i>
                                </div>
                                <div>
                                    <h4 style="margin: 0; font-size: 18px; font-weight: 800; color: var(--text-main); letter-spacing: -0.3px;">${chatWithVendor.businessName}</h4>
                                    <div style="font-size: 13px; color: #166534; font-weight: 600;"><i class="fa fa-circle" style="font-size: 8px; margin-right: 4px;"></i> Online</div>
                                </div>
                            </div>
                        </div>

                        <!-- Messages -->
                        <div class="chat-messages" id="chatBox">
                            <div style="text-align: center; margin-bottom: 8px;">
                                <span style="background: #ffffff; padding: 6px 16px; border-radius: 100px; font-size: 12px; color: var(--text-muted); font-weight: 600; border: 1px solid var(--border-color); box-shadow: 0 1px 2px 0 rgba(0,0,0,0.05);">Secure encrypted conversation started</span>
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
                        <div style="flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; color: var(--text-muted); background: #f8fafc;">
                            <div style="width: 80px; height: 80px; border-radius: 20px; background: #ffffff; display: flex; align-items: center; justify-content: center; margin-bottom: 24px; border: 1px solid var(--border-color); box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);">
                                <i class="fa fa-comments-o" style="font-size: 40px; color: #e2e8f0;"></i>
                            </div>
                            <h3 style="color: var(--text-main); font-weight: 800; margin-bottom: 8px;">Your Messages</h3>
                            <p style="font-weight: 500;">Select a conversation to start chatting.</p>
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
