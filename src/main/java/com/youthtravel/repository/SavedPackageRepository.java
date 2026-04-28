package com.youthtravel.repository;

import com.youthtravel.entity.SavedPackage;
import com.youthtravel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SavedPackageRepository extends JpaRepository<SavedPackage, Long> {
    List<SavedPackage> findByUser(User user);
    List<SavedPackage> findByUserEmail(String email);
}
