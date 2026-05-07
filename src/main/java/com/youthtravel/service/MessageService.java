package com.youthtravel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.youthtravel.entity.Message;
import com.youthtravel.entity.Vendor;
import com.youthtravel.entity.Booking;
import com.youthtravel.repository.MessageRepository;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;

@Service
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;

    public List<Message> getMessagesByVendor(Vendor vendor) {
        return messageRepository.findByVendorOrderBySentAtAsc(vendor);
    }

    // Used by vendor messages page — group by senderEmail
    public List<Message> getChat(Vendor vendor, String senderEmail) {
        return messageRepository.findByVendorAndSenderEmailOrderBySentAtAsc(vendor, senderEmail);
    }

    // Used by vendor messages page — returns conversations grouped by user email
    public Map<String, List<Message>> getConversations(Vendor vendor) {
        return getMessagesByVendor(vendor).stream()
                .collect(Collectors.groupingBy(Message::getSenderEmail));
    }

    // Used by user messages page — returns all booking conversations grouped by Vendor
    public Map<Vendor, List<Message>> getUserConversations(String customerEmail) {
        List<Message> allMessages = messageRepository.findByBookingCustomerEmail(customerEmail);

        // Also include messages sent by this user (senderEmail = userEmail, isFromVendor = false)
        List<Message> sentByUser = messageRepository.findBySenderEmailOrderBySentAtAsc(customerEmail);

        // Merge both lists, de-duplicate by ID
        Map<Long, Message> merged = new LinkedHashMap<>();
        for (Message m : allMessages) {
            merged.put(m.getId(), m);
        }
        for (Message m : sentByUser) {
            merged.put(m.getId(), m);
        }

        // Group by vendor, only messages that have a vendor set
        return merged.values().stream()
                .filter(m -> m.getVendor() != null)
                .sorted((a, b) -> a.getSentAt().compareTo(b.getSentAt()))
                .collect(Collectors.groupingBy(Message::getVendor, LinkedHashMap::new, Collectors.toList()));
    }

    // Get full chat for a specific booking
    public List<Message> getChatByBooking(Booking booking) {
        return messageRepository.findByBookingOrderBySentAtAsc(booking);
    }

    public Message sendMessage(Message message) {
        return messageRepository.save(message);
    }
}
