package com.youthtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.youthtravel.entity.Vendor;

import java.util.Optional;

@Repository
public interface VendorRepository extends JpaRepository<Vendor, Long> {
    Optional<Vendor> findByEmailId(String emailId);

    Optional<Vendor> findByBusinessName(String businessName);

    java.util.List<Vendor> findByStatus(String status);
}
