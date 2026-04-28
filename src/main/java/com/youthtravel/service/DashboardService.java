package com.youthtravel.service;

import com.youthtravel.entity.Review;
import com.youthtravel.entity.Payment;
import com.youthtravel.entity.Message;
import com.youthtravel.repository.ReviewRepository;
import com.youthtravel.repository.PaymentRepository;
import com.youthtravel.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DashboardService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private MessageRepository messageRepository;

    public List<Review> getUserReviews(String email) {
        return reviewRepository.findByUserEmail(email);
    }

    public List<Payment> getUserPayments(String email) {
        return paymentRepository.findByUserEmail(email);
    }

    public List<Message> getUserMessages(String email) {
        return messageRepository.findBySenderEmailOrderBySentAtAsc(email);
    }
}
