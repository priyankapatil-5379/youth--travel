package com.youthtravel.repository;

import com.youthtravel.entity.HomeImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface HomeImageRepository extends JpaRepository<HomeImage, Long> {
    List<HomeImage> findBySection(String section);
}
