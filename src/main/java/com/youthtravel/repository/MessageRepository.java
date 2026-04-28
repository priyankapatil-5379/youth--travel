package com.youthtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.youthtravel.entity.Message;
import com.youthtravel.entity.Vendor;
import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findByVendorOrderBySentAtAsc(Vendor vendor);

    List<Message> findByVendorAndSenderEmailOrderBySentAtAsc(Vendor vendor, String senderEmail);
    List<Message> findBySenderEmailOrderBySentAtAsc(String senderEmail);

    List<Message> findByBookingOrderBySentAtAsc(com.youthtravel.entity.Booking booking);
}
