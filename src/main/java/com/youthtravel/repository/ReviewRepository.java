package com.youthtravel.repository;

import com.youthtravel.entity.Review;
import com.youthtravel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByUser(User user);
    List<Review> findByUserEmail(String email);
    List<Review> findByTrip(com.youthtravel.entity.Trip trip);
    List<Review> findByTrip_Vendor(com.youthtravel.entity.Vendor vendor);
}
