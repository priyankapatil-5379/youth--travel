package com.youthtravel.repository;

import com.youthtravel.entity.Follower;
import com.youthtravel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface FollowerRepository extends JpaRepository<Follower, Long> {
    long countByFollowing(User user);
    long countByFollower(User user);
    Optional<Follower> findByFollowerAndFollowing(User follower, User following);
    boolean existsByFollowerAndFollowing(User follower, User following);
}
