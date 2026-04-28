package com.youthtravel.repository;

import com.youthtravel.entity.Post;
import com.youthtravel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long> {
    List<Post> findByUserOrderByCreatedAtDesc(User user);
    long countByUser(User user);
}
