package com.youthtravel.repository;

import com.youthtravel.entity.Trip;
import com.youthtravel.entity.TripSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TripScheduleRepository extends JpaRepository<TripSchedule, Long> {
    List<TripSchedule> findByTrip(Trip trip);

    void deleteByTrip(Trip trip);
}
