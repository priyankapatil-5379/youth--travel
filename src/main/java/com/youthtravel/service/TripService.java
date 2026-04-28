package com.youthtravel.service;

import com.youthtravel.entity.Trip;
import com.youthtravel.entity.Vendor;
import com.youthtravel.repository.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TripService {

    @Autowired
    private TripRepository tripRepository;

    public Trip saveTrip(Trip trip) {
        return tripRepository.save(trip);
    }

    public List<Trip> getTripsByVendor(Vendor vendor) {
        return tripRepository.findByVendor(vendor);
    }

    public long getTourCountByVendor(Vendor vendor) {
        return tripRepository.countByVendor(vendor);
    }

    public long getActiveTourCountByVendor(Vendor vendor) {
        return tripRepository.countByVendorAndStatus(vendor, "Active");
    }

    public long getInactiveTourCountByVendor(Vendor vendor) {
        return tripRepository.countByVendorAndStatus(vendor, "Inactive");
    }

    public List<Trip> getAllTrips() {
        return tripRepository.findAll();
    }

    public Optional<Trip> getTripById(Long id) {
        return tripRepository.findById(id);
    }

    public void deleteTrip(Long id) {
        tripRepository.deleteById(id);
    }
}
