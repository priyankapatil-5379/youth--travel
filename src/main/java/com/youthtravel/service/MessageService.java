package com.youthtravel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.youthtravel.entity.Message;
import com.youthtravel.entity.Vendor;
import com.youthtravel.repository.MessageRepository;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Map;

@Service
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;

    public List<Message> getMessagesByVendor(Vendor vendor) {
        return messageRepository.findByVendorOrderBySentAtAsc(vendor);
    }

    public List<Message> getChat(Vendor vendor, String senderEmail) {
        return messageRepository.findByVendorAndSenderEmailOrderBySentAtAsc(vendor, senderEmail);
    }

    public Message sendMessage(Message message) {
        return messageRepository.save(message);
    }

    public Map<String, List<Message>> getConversations(Vendor vendor) {
        return getMessagesByVendor(vendor).stream()
                .collect(Collectors.groupingBy(Message::getSenderEmail));
    }

    public Map<Vendor, List<Message>> getUserConversations(String userEmail) {
        return messageRepository.findBySenderEmailOrderBySentAtAsc(userEmail).stream()
                .filter(m -> m.getVendor() != null)
                .collect(Collectors.groupingBy(Message::getVendor));
    }
}
