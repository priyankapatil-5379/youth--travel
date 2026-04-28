package com.youthtravel.repository;

import com.youthtravel.entity.Highlight;
import com.youthtravel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface HighlightRepository extends JpaRepository<Highlight, Long> {
    List<Highlight> findByUser(User user);
}
