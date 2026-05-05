package com.youthtravel.repository;


import com.youthtravel.entity.Trip;
import com.youthtravel.entity.Vendor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {
    List<Trip> findByVendor_Id(Long vendorId);

    long countByVendor_Id(Long vendorId);

    long countByVendor_IdAndStatus(Long vendorId, String status);
    
    List<Trip> findTop5ByStatusOrderByCreatedAtDesc(String status);
}
