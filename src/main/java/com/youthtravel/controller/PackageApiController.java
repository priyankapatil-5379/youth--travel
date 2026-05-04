package com.youthtravel.controller;

import com.youthtravel.entity.Trip;
import com.youthtravel.entity.TripSchedule;
import com.youthtravel.repository.TripScheduleRepository;
import com.youthtravel.service.TripService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/packages")
public class PackageApiController {

    @Autowired
    private TripService tripService;

    @Autowired
    private TripScheduleRepository tripScheduleRepository;

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getPackageDetails(@PathVariable Long id) {
        Optional<Trip> tripOpt = tripService.getTripById(id);
        if (tripOpt.isPresent()) {
            Trip trip = tripOpt.get();
            List<TripSchedule> schedules = tripScheduleRepository.findByTrip(trip);
            
            Map<String, Object> response = new HashMap<>();
            response.put("trip", trip);
            response.put("schedules", schedules);
            
            // Add custom data if needed (itinerary parsing, etc.)
            // Assuming itinerary might be a JSON or newline separated string in description or a separate field
            // For now, we'll send the trip object as is.
            
            return ResponseEntity.ok(response);
        }
        return ResponseEntity.notFound().build();
    }
}
