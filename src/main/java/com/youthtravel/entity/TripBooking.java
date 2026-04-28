package com.youthtravel.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "trip_bookings")
public class TripBooking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "package_id", nullable = false)
    private Package tripPackage;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private com.youthtravel.entity.User user;

    @Column(nullable = false)
    private LocalDateTime bookingDate = LocalDateTime.now();

    @Column(nullable = false)
    private String status = "COMPLETED";

    public TripBooking() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Package getTripPackage() { return tripPackage; }
    public void setTripPackage(Package tripPackage) { this.tripPackage = tripPackage; }

    public com.youthtravel.entity.User getUser() { return user; }
    public void setUser(com.youthtravel.entity.User user) { this.user = user; }

    public LocalDateTime getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDateTime bookingDate) { this.bookingDate = bookingDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
