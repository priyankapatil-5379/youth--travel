package com.youthtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.youthtravel.entity.Message;
import com.youthtravel.entity.Vendor;
import com.youthtravel.entity.Booking;
import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Long> {

    List<Message> findByVendorOrderBySentAtAsc(Vendor vendor);

    List<Message> findByVendorAndSenderEmailOrderBySentAtAsc(Vendor vendor, String senderEmail);

    List<Message> findBySenderEmailOrderBySentAtAsc(String senderEmail);

    List<Message> findByBookingOrderBySentAtAsc(Booking booking);

    List<Message> findByBookingAndVendorOrderBySentAtAsc(Booking booking, Vendor vendor);

    // All messages where the booking's customer email matches — for user-side inbox
    @Query("SELECT m FROM Message m WHERE m.booking.customerEmail = :customerEmail ORDER BY m.sentAt ASC")
    List<Message> findByBookingCustomerEmail(@Param("customerEmail") String customerEmail);
}
