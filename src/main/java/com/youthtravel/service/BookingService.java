package com.youthtravel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.youthtravel.entity.Booking;
import com.youthtravel.entity.Vendor;
import com.youthtravel.repository.BookingRepository;
import java.util.List;
import java.util.Optional;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    public List<Booking> getBookingsByVendor(Vendor vendor) {
        return bookingRepository.findByVendor(vendor);
    }

    public long getBookingCountByVendor(Vendor vendor) {
        return bookingRepository.countByVendor(vendor);
    }

    public Optional<Booking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    public Booking saveBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    public List<Booking> getBookingsByUserEmail(String email) {
        return bookingRepository.findByCustomerEmail(email);
    }

    public double getTotalEarnings(Vendor vendor) {
        return bookingRepository.findByVendor(vendor).stream()
                .filter(b -> "Confirmed".equalsIgnoreCase(b.getStatus()) || "Completed".equalsIgnoreCase(b.getStatus()))
                .mapToDouble(b -> b.getTotalPrice() != null ? b.getTotalPrice() : 0.0)
                .sum();
    }

    public int getOccupiedSlotsByTrip(com.youthtravel.entity.Trip trip) {
        return bookingRepository.findByTrip(trip).stream()
                .filter(b -> "Confirmed".equalsIgnoreCase(b.getStatus()) || "Pending".equalsIgnoreCase(b.getStatus()))
                .mapToInt(b -> b.getNumberOfTravelers() != null ? b.getNumberOfTravelers() : 1)
                .sum();
    }
}
