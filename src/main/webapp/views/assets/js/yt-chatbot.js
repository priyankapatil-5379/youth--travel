(() => {
  function qs(sel, root = document) {
    return root.querySelector(sel);
  }
 
  function escapeHtml(str) {
    return String(str)
      .replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&#039;");
  }
 
  function createEl(tag, className) {
    const el = document.createElement(tag);
    if (className) el.className = className;
    return el;
  }
 
  function init() {
    const widget = qs("#ytChatWidget");
    if (!widget) return;
 
    const openBtn = qs("#ytChatOpen");
    const closeBtn = qs("#ytChatClose", widget);
    const form = qs("#ytChatForm", widget);
    const input = qs("#ytChatInput", widget);
    const list = qs("#ytChatMessages", widget);
 
    let isOpen = false;
 
    function setOpen(next) {
      isOpen = next;
      widget.classList.toggle("yt-chat-open", isOpen);
      if (isOpen) {
        input.focus();
        scrollToBottom();
      }
    }
 
    function scrollToBottom() {
      list.scrollTop = list.scrollHeight;
    }
 
    function addMsg(role, text) {
      const item = createEl("div", `yt-chat-msg yt-chat-msg-${role}`);
      item.innerHTML = `<div class="yt-chat-bubble">${escapeHtml(text)}</div>`;
      list.appendChild(item);
      scrollToBottom();
    }
 
    function addTyping() {
      const item = createEl("div", "yt-chat-msg yt-chat-msg-bot");
      item.dataset.typing = "1";
      item.innerHTML = `
        <div class="yt-chat-bubble yt-chat-typing">
          <span></span><span></span><span></span>
        </div>`;
      list.appendChild(item);
      scrollToBottom();
      return item;
    }
 
    async function sendToApi(message) {
      const res = await fetch("/api/chat", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message }),
      });
      if (!res.ok) {
        throw new Error(`HTTP ${res.status}`);
      }
      const data = await res.json();
      return data.reply || "Sorry, I could not understand. Please try again.";
    }
 
    openBtn?.addEventListener("click", () => setOpen(true));
    closeBtn?.addEventListener("click", () => setOpen(false));
 
    // Close on Escape
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && isOpen) setOpen(false);
    });
 
    form?.addEventListener("submit", async (e) => {
      e.preventDefault();
      const text = (input.value || "").trim();
      if (!text) return;
 
      input.value = "";
      addMsg("user", text);
 
      const typingEl = addTyping();
      try {
        const reply = await sendToApi(text);
        typingEl.remove();
        addMsg("bot", reply);
      } catch (err) {
        typingEl.remove();
        addMsg("bot", "Network issue. Please try again, or message us on WhatsApp.");
      }
    });
 
    // Initial greeting (only once per page load)
    addMsg("bot", "Hi! I’m Youth Travel assistant. What are you planning today?");
  }
 
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();