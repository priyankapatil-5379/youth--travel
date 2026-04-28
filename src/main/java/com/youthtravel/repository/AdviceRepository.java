package com.youthtravel.repository;

import com.youthtravel.entity.Advice;
import com.youthtravel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AdviceRepository extends JpaRepository<Advice, Long> {
    List<Advice> findByUserOrderByCreatedAtDesc(User user);
    long countByUser(User user);
}
