package com.youthtravel.controller;

import com.youthtravel.entity.Message;
import com.youthtravel.entity.Vendor;
import com.youthtravel.entity.Booking;
import com.youthtravel.service.VendorService;
import com.youthtravel.service.BookingService;
import com.youthtravel.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class MessagingController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private VendorService vendorService;

    @Autowired
    private BookingService bookingService;

    /**
     * Handles real-time messages sent via WebSocket from either side.
     * Topic routing:
     *   - Vendor booking chat: /topic/booking/{bookingId}
     *   - User messages page: /topic/user/{userEmail}
     *   - Vendor messages page: /topic/vendor/{vendorId}
     */
    @MessageMapping("/chat.sendMessage")
    public void sendMessage(@Payload Map<String, Object> payload) {
        String content = (String) payload.get("content");
        Long vendorId = Long.valueOf(payload.get("vendorId").toString());
        String senderEmail = (String) payload.get("senderEmail");
        String senderName = (String) payload.get("senderName");
        Boolean isFromVendor = (Boolean) payload.get("isFromVendor");
        Long bookingId = payload.get("bookingId") != null
                ? Long.valueOf(payload.get("bookingId").toString()) : null;
        String userEmail = (String) payload.get("userEmail"); // Customer's email

        Vendor vendor = vendorService.findById(vendorId).orElse(null);
        Booking booking = bookingId != null ? bookingService.getBookingById(bookingId).orElse(null) : null;

        // Derive user email from booking if not provided
        if (userEmail == null && booking != null) {
            userEmail = booking.getCustomerEmail();
        }

        Message message = new Message();
        message.setVendor(vendor);
        message.setBooking(booking);
        message.setContent(content);
        message.setSenderEmail(senderEmail);
        message.setSenderName(senderName);
        message.setFromVendor(isFromVendor != null && isFromVendor);
        message.setRead(false);

        Message savedMsg = messageRepository.save(message);

        // Build a simple DTO map to avoid Jackson serialization of JPA proxies
        Map<String, Object> msgDto = buildMessageDto(savedMsg, userEmail, vendorId);

        // Broadcast to booking-specific topic (vendor booking chat listens here)
        if (bookingId != null) {
            messagingTemplate.convertAndSend("/topic/booking/" + bookingId, msgDto);
        }

        // Broadcast to user topic (user messages page listens here)
        if (userEmail != null) {
            messagingTemplate.convertAndSend("/topic/user/" + encodeEmail(userEmail), msgDto);
        }

        // Broadcast to vendor topic (vendor messages page listens here)
        messagingTemplate.convertAndSend("/topic/vendor/" + vendorId, msgDto);
    }

    private Map<String, Object> buildMessageDto(Message msg, String userEmail, Long vendorId) {
        String time = msg.getSentAt() != null
                ? msg.getSentAt().format(java.time.format.DateTimeFormatter.ofPattern("hh:mm a, MMM dd"))
                : "";

        java.util.LinkedHashMap<String, Object> dto = new java.util.LinkedHashMap<>();
        dto.put("id", msg.getId());
        dto.put("content", msg.getContent());
        dto.put("senderName", msg.getSenderName());
        dto.put("senderEmail", msg.getSenderEmail());
        dto.put("fromVendor", msg.isFromVendor());
        dto.put("formattedTime", time);
        dto.put("sentAt", msg.getSentAt() != null ? msg.getSentAt().toString() : "");
        dto.put("bookingId", msg.getBooking() != null ? msg.getBooking().getId() : null);
        dto.put("vendorId", vendorId);
        dto.put("userEmail", userEmail);
        return dto;
    }

    private String encodeEmail(String email) {
        return email.replace("@", "_at_").replace(".", "_dot_");
    }
}
