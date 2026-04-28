package com.youthtravel.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "trips")
public class Trip {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private String destination;

    private String duration;
    private Integer days;
    private Integer nights;

    @Column(nullable = false)
    private Double price;

    private String category;
    private String subCategory;

    @Column(columnDefinition = "LONGTEXT")
    private String imageUrl;

    private String status = "Active"; // Active, Inactive

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "trip", fetch = FetchType.LAZY)
    private java.util.List<Review> reviews;

    @Column(name = "local_vendor", nullable = false)
    private boolean localVendor = false;

    // ... (skipping some lines for brevity in thought, but tool call will be
    // complete)

    private Integer maxTravelers;
    private String travelerTypes; // Keeps tags if needed
    @Column(columnDefinition = "TEXT")
    private String travelerCategory;

    @Column(columnDefinition = "TEXT")
    private String travelerSubCategory;

    @Column(name = "media_urls", columnDefinition = "LONGTEXT")
    private String mediaUrls;

    @Column(name = "itinerary", columnDefinition = "LONGTEXT")
    private String itinerary; // JSON format for day-wise plan

    @Column(name = "inclusions", columnDefinition = "TEXT")
    private String inclusions;

    @Column(name = "exclusions", columnDefinition = "TEXT")
    private String exclusions;

    // Advanced Pricing Fields
    @Column(name = "pricing_type")
    private String pricingType = "perPerson"; // perPerson, perGroup

    @Column(name = "adult_price")
    private Double adultPrice;

    @Column(name = "child_price")
    private Double childPrice;

    @Column(name = "group_discount")
    private Double groupDiscount; // Percentage

    @Column(name = "weekend_price")
    private Double weekendPrice; // Price for weekend slots

    @Column(name = "slot_pricing", columnDefinition = "LONGTEXT")
    private String slotPricing; // JSON format for date-range specific prices

    // Booking Policies
    @Column(name = "booking_type")
    private String bookingType = "Instant"; // Instant, Request

    @Column(name = "cancellation_policy")
    private String cancellationPolicy = "Flexible"; // Flexible, Moderate, Strict, Custom

    @Column(name = "custom_cancellation", columnDefinition = "TEXT")
    private String customCancellation;

    @Column(name = "mandatory_documents")
    private String mandatoryDocuments; // Comma separated list

    // Pickup & Transport
    @Column(name = "pickup_points", columnDefinition = "LONGTEXT")
    private String pickupPoints; // JSON: [{location: 'BTM', time: '10pm'}]

    @Column(name = "transport_category")
    private String transportCategory;

    @Column(name = "transport_type")
    private String transportType;

    @Column(name = "stay_category")
    private String stayCategory;

    @Column(name = "stay_type")
    private String stayType;

    @Column(name = "stay_variant")
    private String stayVariant;

    @Column(name = "room_sharing")
    private String roomSharing;

    @Column(name = "stay_amenities", columnDefinition = "LONGTEXT")
    private String stayAmenities;

    // Module B: Hospitality, Safety & Prep
    @Column(name = "meals_config", columnDefinition = "LONGTEXT")
    private String mealsConfig; // JSON: {B: true, L: true, D: true, VegOnly: true}

    @Column(name = "difficulty")
    private String difficulty; // Easy, Moderate, Hard

    @Column(name = "safety_requirements")
    private String safetyRequirements;

    @Column(name = "safety_guidelines", columnDefinition = "LONGTEXT")
    private String safetyGuidelines;

    @Column(name = "what_to_carry", columnDefinition = "LONGTEXT")
    private String whatToCarry;

    @Column(name = "refund_policy", columnDefinition = "LONGTEXT")
    private String refundPolicy;

    @Column(name = "reschedule_policy", columnDefinition = "LONGTEXT")
    private String reschedulePolicy;

    @Column(name = "trip_rules", columnDefinition = "LONGTEXT")
    private String tripRules;

    @Column(name = "booking_cutoff_hours")
    private Integer bookingCutoffHours;

    @Column(name = "min_travelers")
    private Integer minTravelers;

    @Column(name = "customizable")
    private Boolean customizable = false;

    @Column(name = "age_group")
    private String ageGroup; // 18-24, 25-30, All Youths

    @Column(name = "student_discount_available")
    private Boolean studentDiscountAvailable = false;

    // Transient fields for form re-hydration
    @Transient
    private String schedulesJson;

    @Transient
    private String scheduleMode;

    @Transient
    private String recEndDate;

    @Transient
    private String recStartTime;

    @Transient
    private Integer recTotalSeats;

    @Transient
    private String travelerCategoryOther;

    @Transient
    private String travelerSubCategoryOther;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public Trip() {
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public Integer getNights() {
        return nights;
    }

    public void setNights(Integer nights) {
        this.nights = nights;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isLocalVendor() {
        return localVendor;
    }

    public void setLocalVendor(boolean localVendor) {
        this.localVendor = localVendor;
    }

    public Integer getMaxTravelers() {
        return maxTravelers;
    }

    public void setMaxTravelers(Integer maxTravelers) {
        this.maxTravelers = maxTravelers;
    }

    public String getTravelerTypes() {
        return travelerTypes;
    }

    public void setTravelerTypes(String travelerTypes) {
        this.travelerTypes = travelerTypes;
    }

    public String getTravelerCategory() {
        return travelerCategory;
    }

    public void setTravelerCategory(String travelerCategory) {
        this.travelerCategory = travelerCategory;
    }

    public String getTravelerSubCategory() {
        return travelerSubCategory;
    }

    public void setTravelerSubCategory(String travelerSubCategory) {
        this.travelerSubCategory = travelerSubCategory;
    }

    public String getMediaUrls() {
        return mediaUrls;
    }

    public void setMediaUrls(String mediaUrls) {
        this.mediaUrls = mediaUrls;
    }

    public String getItinerary() {
        return itinerary;
    }

    public void setItinerary(String itinerary) {
        this.itinerary = itinerary;
    }

    public String getInclusions() {
        return inclusions;
    }

    public void setInclusions(String inclusions) {
        this.inclusions = inclusions;
    }

    public String getExclusions() {
        return exclusions;
    }

    public void setExclusions(String exclusions) {
        this.exclusions = exclusions;
    }

    public String getPricingType() {
        return pricingType;
    }

    public void setPricingType(String pricingType) {
        this.pricingType = pricingType;
    }

    public Double getAdultPrice() {
        return adultPrice;
    }

    public void setAdultPrice(Double adultPrice) {
        this.adultPrice = adultPrice;
    }

    public Double getChildPrice() {
        return childPrice;
    }

    public void setChildPrice(Double childPrice) {
        this.childPrice = childPrice;
    }

    public Double getGroupDiscount() {
        return groupDiscount;
    }

    public void setGroupDiscount(Double groupDiscount) {
        this.groupDiscount = groupDiscount;
    }

    public Double getWeekendPrice() {
        return weekendPrice;
    }

    public void setWeekendPrice(Double weekendPrice) {
        this.weekendPrice = weekendPrice;
    }

    public String getSlotPricing() {
        return slotPricing;
    }

    public void setSlotPricing(String slotPricing) {
        this.slotPricing = slotPricing;
    }

    public String getBookingType() {
        return bookingType;
    }

    public void setBookingType(String bookingType) {
        this.bookingType = bookingType;
    }

    public String getCancellationPolicy() {
        return cancellationPolicy;
    }

    public void setCancellationPolicy(String cancellationPolicy) {
        this.cancellationPolicy = cancellationPolicy;
    }

    public String getCustomCancellation() {
        return customCancellation;
    }

    public void setCustomCancellation(String customCancellation) {
        this.customCancellation = customCancellation;
    }

    public String getMandatoryDocuments() {
        return mandatoryDocuments;
    }

    public void setMandatoryDocuments(String mandatoryDocuments) {
        this.mandatoryDocuments = mandatoryDocuments;
    }

    public String getPickupPoints() {
        return pickupPoints;
    }

    public void setPickupPoints(String pickupPoints) {
        this.pickupPoints = pickupPoints;
    }

    public String getTransportCategory() {
        return transportCategory;
    }

    public void setTransportCategory(String transportCategory) {
        this.transportCategory = transportCategory;
    }

    public String getTransportType() {
        return transportType;
    }

    public void setTransportType(String transportType) {
        this.transportType = transportType;
    }

    public String getStayCategory() {
        return stayCategory;
    }

    public void setStayCategory(String stayCategory) {
        this.stayCategory = stayCategory;
    }

    public String getStayType() {
        return stayType;
    }

    public void setStayType(String stayType) {
        this.stayType = stayType;
    }

    public String getStayVariant() {
        return stayVariant;
    }

    public void setStayVariant(String stayVariant) {
        this.stayVariant = stayVariant;
    }

    public String getRoomSharing() {
        return roomSharing;
    }

    public void setRoomSharing(String roomSharing) {
        this.roomSharing = roomSharing;
    }

    public String getStayAmenities() {
        return stayAmenities;
    }

    public void setStayAmenities(String stayAmenities) {
        this.stayAmenities = stayAmenities;
    }

    public String getMealsConfig() {
        return mealsConfig;
    }

    public void setMealsConfig(String mealsConfig) {
        this.mealsConfig = mealsConfig;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public String getSafetyRequirements() {
        return safetyRequirements;
    }

    public void setSafetyRequirements(String safetyRequirements) {
        this.safetyRequirements = safetyRequirements;
    }

    public String getSafetyGuidelines() {
        return safetyGuidelines;
    }

    public void setSafetyGuidelines(String safetyGuidelines) {
        this.safetyGuidelines = safetyGuidelines;
    }

    public String getWhatToCarry() {
        return whatToCarry;
    }

    public void setWhatToCarry(String whatToCarry) {
        this.whatToCarry = whatToCarry;
    }

    public String getRefundPolicy() {
        return refundPolicy;
    }

    public void setRefundPolicy(String refundPolicy) {
        this.refundPolicy = refundPolicy;
    }

    public String getReschedulePolicy() {
        return reschedulePolicy;
    }

    public void setReschedulePolicy(String reschedulePolicy) {
        this.reschedulePolicy = reschedulePolicy;
    }

    public String getTripRules() {
        return tripRules;
    }

    public void setTripRules(String tripRules) {
        this.tripRules = tripRules;
    }

    public Integer getBookingCutoffHours() {
        return bookingCutoffHours;
    }

    public void setBookingCutoffHours(Integer bookingCutoffHours) {
        this.bookingCutoffHours = bookingCutoffHours;
    }

    public Integer getMinTravelers() {
        return minTravelers;
    }

    public void setMinTravelers(Integer minTravelers) {
        this.minTravelers = minTravelers;
    }

    public Boolean getCustomizable() {
        return customizable;
    }

    public void setCustomizable(Boolean customizable) {
        this.customizable = customizable;
    }

    public String getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(String ageGroup) {
        this.ageGroup = ageGroup;
    }

    public Boolean getStudentDiscountAvailable() {
        return studentDiscountAvailable;
    }

    public void setStudentDiscountAvailable(Boolean studentDiscountAvailable) {
        this.studentDiscountAvailable = studentDiscountAvailable;
    }

    public String getSchedulesJson() {
        return schedulesJson;
    }

    public void setSchedulesJson(String schedulesJson) {
        this.schedulesJson = schedulesJson;
    }

    public String getScheduleMode() {
        return scheduleMode;
    }

    public void setScheduleMode(String scheduleMode) {
        this.scheduleMode = scheduleMode;
    }

    public String getRecEndDate() {
        return recEndDate;
    }

    public void setRecEndDate(String recEndDate) {
        this.recEndDate = recEndDate;
    }

    public String getRecStartTime() {
        return recStartTime;
    }

    public void setRecStartTime(String recStartTime) {
        this.recStartTime = recStartTime;
    }

    public Integer getRecTotalSeats() {
        return recTotalSeats;
    }

    public void setRecTotalSeats(Integer recTotalSeats) {
        this.recTotalSeats = recTotalSeats;
    }

    public String getTravelerCategoryOther() {
        return travelerCategoryOther;
    }

    public void setTravelerCategoryOther(String travelerCategoryOther) {
        this.travelerCategoryOther = travelerCategoryOther;
    }

    public String getTravelerSubCategoryOther() {
        return travelerSubCategoryOther;
    }

    public void setTravelerSubCategoryOther(String travelerSubCategoryOther) {
        this.travelerSubCategoryOther = travelerSubCategoryOther;
    }

    public java.util.List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(java.util.List<Review> reviews) {
        this.reviews = reviews;
    }

    public double getAverageRating() {
        if (reviews == null || reviews.isEmpty()) return 0.0;
        double sum = 0;
        for (Review r : reviews) {
            sum += r.getRating() != null ? r.getRating() : 0;
        }
        return Math.round((sum / reviews.size()) * 10.0) / 10.0;
    }
}
