package com.youthtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.youthtravel.entity.Booking;
import com.youthtravel.entity.Vendor;
import java.util.List;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByVendor(Vendor vendor);

    long countByVendor(Vendor vendor);

    List<Booking> findByCustomerEmail(String email);

    List<Booking> findByTrip(com.youthtravel.entity.Trip trip);
}
