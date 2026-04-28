package com.youthtravel.repository;


import com.youthtravel.entity.Trip;
import com.youthtravel.entity.Vendor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {
    List<Trip> findByVendor(Vendor vendor);

    long countByVendor(Vendor vendor);

    long countByVendorAndStatus(Vendor vendor, String status);
}
