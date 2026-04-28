package com.youthtravel.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.youthtravel.entity.Package;

@Repository
public interface PackageRepository extends JpaRepository<Package, Long> {
}
