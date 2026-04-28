package com.youthtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.youthtravel.entity.TripBooking;
import java.util.List;

@Repository
public interface TripBookingRepository extends JpaRepository<TripBooking, Long> {
    List<TripBooking> findByTripPackageId(Long packageId);
    List<TripBooking> findByUserId(Long userId);
}
