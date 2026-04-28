package com.youthtravel.controller;

import com.youthtravel.entity.Trip;
import com.youthtravel.entity.Vendor;
import com.youthtravel.service.TripService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.youthtravel.entity.TripSchedule;
import com.youthtravel.repository.TripScheduleRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import java.time.LocalDate;
import java.time.LocalTime;
import org.springframework.transaction.annotation.Transactional;

@Controller
@RequestMapping("/vendor")
public class TripController {

    @Autowired
    private TripService tripService;

    @Autowired
    private TripScheduleRepository tripScheduleRepository;

    @GetMapping("/tours")
    public String showVendorTours(HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }
        List<Trip> trips = tripService.getTripsByVendor(vendor);
        model.addAttribute("trips", trips);
        model.addAttribute("vendor", vendor);
        return "/vendor/tours";
    }

    @GetMapping("/add-trip")
    public String showAddTripForm(HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }
        model.addAttribute("vendor", vendor);
        return "/vendor/add-trip";
    }

    @PostMapping("/add-trip")
    @Transactional
    public String addTrip(@ModelAttribute Trip trip,
            @RequestParam(value = "travelerCategories", required = false) List<String> categories,
            @RequestParam(value = "travelerSubCategories", required = false) List<String> subCategories,
            @RequestParam(value = "travelerCategoryOther", required = false) String categoryOther,
            @RequestParam(value = "travelerSubCategoryOther", required = false) String subCategoryOther,
            @RequestParam(value = "photoFiles", required = false) MultipartFile[] photoFiles,
            @RequestParam(value = "videoFiles", required = false) MultipartFile[] videoFiles,
            @RequestParam(value = "scheduleMode", required = false) String scheduleMode,
            @RequestParam(value = "schedulesJson", required = false) String schedulesJson,
            @RequestParam(value = "recurringDays", required = false) java.util.List<String> recurringDays,
            @RequestParam(value = "recStartTime", required = false) String recStartTime,
            @RequestParam(value = "recTotalSeats", required = false) Integer recTotalSeats,
            @RequestParam(value = "recEndDate", required = false) String recEndDate,
            @RequestParam(required = false) String bookingType,
            @RequestParam(required = false) String cancellationPolicy,
            @RequestParam(required = false) String customCancellation,
            @RequestParam(required = false) String mandatoryDocuments,
            @RequestParam(required = false) String pickupPoints,
            @RequestParam(required = false) String transportType,
            @RequestParam(required = false) String stayType,
            @RequestParam(required = false) String roomSharing,
            @RequestParam(required = false) String stayAmenities,
            @RequestParam(required = false) String mealsConfig,
            @RequestParam(required = false) String difficulty,
            @RequestParam(required = false) String safetyRequirements,
            @RequestParam(required = false) String safetyGuidelines,
            @RequestParam(required = false) String whatToCarry,
            @RequestParam(required = false) String refundPolicy,
            @RequestParam(required = false) String reschedulePolicy,
            @RequestParam(required = false) String tripRules,
            @RequestParam(required = false) Integer bookingCutoffHours,
            @RequestParam(required = false) Integer minTravelers,
            @RequestParam(required = false) Boolean customizable,
            @RequestParam(required = false) String ageGroup,
            @RequestParam(required = false) Boolean studentDiscountAvailable,
            HttpSession session, RedirectAttributes redirectAttributes) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }

        // Handle Split Media Upload
        List<String> filePaths = new ArrayList<>();
        String uploadDir = "uploads/trips/";
        java.io.File directory = new java.io.File(uploadDir);
        if (!directory.exists())
            directory.mkdirs();

        try {
            // Process Photos
            if (photoFiles != null) {
                for (MultipartFile file : photoFiles) {
                    if (!file.isEmpty()) {
                        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                        java.nio.file.Path path = java.nio.file.Paths.get(uploadDir + fileName);
                        java.nio.file.Files.copy(file.getInputStream(), path,
                                java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                        filePaths.add("/uploads/trips/" + fileName);
                    }
                }
            }
            // Process Videos
            if (videoFiles != null) {
                for (MultipartFile file : videoFiles) {
                    if (!file.isEmpty()) {
                        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                        java.nio.file.Path path = java.nio.file.Paths.get(uploadDir + fileName);
                        java.nio.file.Files.copy(file.getInputStream(), path,
                                java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                        filePaths.add("/uploads/trips/" + fileName);
                    }
                }
            }

            if (!filePaths.isEmpty()) {
                // Smart thumbnail: Prioritize image over video
                String thumbnail = filePaths.get(0);
                for (String p : filePaths) {
                    String lower = p.toLowerCase();
                    if (lower.endsWith(".jpg") || lower.endsWith(".jpeg") || lower.endsWith(".png")
                            || lower.endsWith(".webp") || lower.endsWith(".gif")) {
                        thumbnail = p;
                        break;
                    }
                }
                trip.setImageUrl(thumbnail);
                trip.setMediaUrls(String.join(",", filePaths));
            }
        } catch (java.io.IOException e) {
            e.printStackTrace();
        }

        List<String> finalCategories = categories != null ? new ArrayList<>(categories) : new ArrayList<>();
        if (categoryOther != null && !categoryOther.trim().isEmpty()) {
            finalCategories.remove("Others");
            finalCategories.add(categoryOther.trim());
        }

        List<String> finalSubCategories = subCategories != null ? new ArrayList<>(subCategories) : new ArrayList<>();
        if (subCategoryOther != null && !subCategoryOther.trim().isEmpty()) {
            finalSubCategories.remove("Other");
            finalSubCategories.remove("Others");
            finalSubCategories.add(subCategoryOther.trim());
        }

        if (!finalCategories.isEmpty()) {
            trip.setTravelerCategory(String.join(", ", finalCategories));
        }
        if (!finalSubCategories.isEmpty()) {
            trip.setTravelerSubCategory(String.join(", ", finalSubCategories));
        }

        trip.setVendor(vendor);
        trip.setBookingType(bookingType);
        trip.setCancellationPolicy(cancellationPolicy);
        trip.setCustomCancellation(customCancellation);
        trip.setMandatoryDocuments(mandatoryDocuments);
        trip.setPickupPoints(pickupPoints);
        trip.setTransportType(transportType);
        trip.setStayType(stayType);
        trip.setRoomSharing(roomSharing);
        trip.setStayAmenities(stayAmenities);
        trip.setMealsConfig(mealsConfig);
        trip.setDifficulty(difficulty);
        trip.setSafetyRequirements(safetyRequirements);
        trip.setSafetyGuidelines(safetyGuidelines);
        trip.setWhatToCarry(whatToCarry);
        trip.setRefundPolicy(refundPolicy);
        trip.setReschedulePolicy(reschedulePolicy);
        trip.setTripRules(tripRules);
        trip.setBookingCutoffHours(bookingCutoffHours != null ? bookingCutoffHours : 24);
        trip.setMinTravelers(minTravelers != null ? minTravelers : 1);
        if (trip.getMaxTravelers() == null)
            trip.setMaxTravelers(20);
        trip.setCustomizable(customizable != null ? customizable : false);
        trip.setAgeGroup(ageGroup);
        trip.setStudentDiscountAvailable(studentDiscountAvailable != null ? studentDiscountAvailable : false);

        Trip savedTrip = tripService.saveTrip(trip);

        // Handle Scheduling
        handleScheduling(savedTrip, scheduleMode, schedulesJson, recurringDays, recStartTime, recTotalSeats,
                recEndDate);

        redirectAttributes.addFlashAttribute("message", "Trip added successfully!");
        return "redirect:/vendor/tours";
    }

    @GetMapping("/edit-trip/{id}")
    public String showEditTripForm(@PathVariable Long id, HttpSession session, Model model) {
        try {
            Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
            if (vendor == null) {
                return "redirect:/vendor/login";
            }
            Trip trip = tripService.getTripById(id).orElse(null);
            if (trip == null || !trip.getVendor().getId().equals(vendor.getId())) {
                return "redirect:/vendor/tours";
            }
            // Populate transient fields for form re-hydration
            List<TripSchedule> schedules = tripScheduleRepository.findByTrip(trip);
            model.addAttribute("schedules", schedules);

            if (!schedules.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                try {
                    TripSchedule first = schedules.get(0);
                    if (Boolean.TRUE.equals(first.isRecurring())) {
                        trip.setScheduleMode("recurring");
                        trip.setRecStartTime(first.getStartTime() != null ? first.getStartTime().toString() : "");
                        trip.setRecTotalSeats(first.getTotalSeats());
                        LocalDate maxDate = schedules.stream().map(TripSchedule::getStartDate).max(LocalDate::compareTo)
                                .orElse(null);
                        if (maxDate != null)
                            trip.setRecEndDate(maxDate.toString());
                    } else {
                        trip.setScheduleMode("specific");
                        List<Map<String, Object>> slots = new ArrayList<>();
                        for (TripSchedule ts : schedules) {
                            Map<String, Object> slot = new java.util.HashMap<>();
                            slot.put("date", ts.getStartDate() != null ? ts.getStartDate().toString() : "");
                            slot.put("time", ts.getStartTime() != null ? ts.getStartTime().toString() : "");
                            slot.put("seats", ts.getTotalSeats());
                            slots.add(slot);
                        }
                        trip.setSchedulesJson(mapper.writeValueAsString(slots));
                    }
                } catch (Exception e) {
                    System.err.println("Scheduling re-hydration error: " + e.getMessage());
                }
            } else {
                trip.setScheduleMode("specific");
            }

            model.addAttribute("trip", trip);
            model.addAttribute("vendor", vendor);
            return "/vendor/edit-trip";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/vendor/tours?error=system";
        }
    }

    @PostMapping("/edit-trip")
    @Transactional
    public String editTrip(@ModelAttribute Trip trip,
            @RequestParam(value = "travelerCategories", required = false) List<String> categories,
            @RequestParam(value = "travelerSubCategories", required = false) List<String> subCategories,
            @RequestParam(value = "travelerCategoryOther", required = false) String categoryOther,
            @RequestParam(value = "travelerSubCategoryOther", required = false) String subCategoryOther,
            @RequestParam(value = "photoFiles", required = false) MultipartFile[] photoFiles,
            @RequestParam(value = "videoFiles", required = false) MultipartFile[] videoFiles,
            @RequestParam(value = "scheduleMode", required = false) String scheduleMode,
            @RequestParam(value = "schedulesJson", required = false) String schedulesJson,
            @RequestParam(value = "recurringDays", required = false) java.util.List<String> recurringDays,
            @RequestParam(value = "recStartTime", required = false) String recStartTime,
            @RequestParam(value = "recTotalSeats", required = false) Integer recTotalSeats,
            @RequestParam(value = "recEndDate", required = false) String recEndDate,
            @RequestParam(required = false) String bookingType,
            @RequestParam(required = false) String cancellationPolicy,
            @RequestParam(required = false) String customCancellation,
            @RequestParam(required = false) String mandatoryDocuments,
            @RequestParam(required = false) String pickupPoints,
            @RequestParam(required = false) String transportType,
            @RequestParam(required = false) String stayType,
            @RequestParam(required = false) String roomSharing,
            @RequestParam(required = false) String stayAmenities,
            @RequestParam(required = false) String mealsConfig,
            @RequestParam(required = false) String difficulty,
            @RequestParam(required = false) String safetyRequirements,
            @RequestParam(required = false) String safetyGuidelines,
            @RequestParam(required = false) String whatToCarry,
            @RequestParam(required = false) String refundPolicy,
            @RequestParam(required = false) String reschedulePolicy,
            @RequestParam(required = false) String tripRules,
            @RequestParam(required = false) Integer bookingCutoffHours,
            @RequestParam(required = false) Integer minTravelers,
            @RequestParam(required = false) Boolean customizable,
            @RequestParam(required = false) String ageGroup,
            @RequestParam(required = false) Boolean studentDiscountAvailable,
            HttpSession session, RedirectAttributes redirectAttributes) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }

        Trip existingTrip = tripService.getTripById(trip.getId()).orElse(null);
        if (existingTrip == null || !existingTrip.getVendor().getId().equals(vendor.getId())) {
            return "redirect:/vendor/tours";
        }

        // Handle Split Media Upload
        List<String> filePaths = new ArrayList<>();
        if (existingTrip.getMediaUrls() != null && !existingTrip.getMediaUrls().isEmpty()) {
            filePaths.addAll(java.util.Arrays.asList(existingTrip.getMediaUrls().split(",")));
        }

        String uploadDir = "uploads/trips/";
        java.io.File directory = new java.io.File(uploadDir);
        if (!directory.exists())
            directory.mkdirs();

        boolean hasNewPhotos = photoFiles != null && photoFiles.length > 0 && !photoFiles[0].isEmpty();
        boolean hasNewVideos = videoFiles != null && videoFiles.length > 0 && !videoFiles[0].isEmpty();

        if (hasNewPhotos || hasNewVideos) {
            try {
                if (hasNewPhotos) {
                    for (MultipartFile file : photoFiles) {
                        if (!file.isEmpty()) {
                            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                            java.nio.file.Path path = java.nio.file.Paths.get(uploadDir + fileName);
                            java.nio.file.Files.copy(file.getInputStream(), path,
                                    java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                            filePaths.add("/uploads/trips/" + fileName);
                        }
                    }
                }
                if (hasNewVideos) {
                    for (MultipartFile file : videoFiles) {
                        if (!file.isEmpty()) {
                            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                            java.nio.file.Path path = java.nio.file.Paths.get(uploadDir + fileName);
                            java.nio.file.Files.copy(file.getInputStream(), path,
                                    java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                            filePaths.add("/uploads/trips/" + fileName);
                        }
                    }
                }

                if (!filePaths.isEmpty()) {
                    // Smart thumbnail
                    String thumbnail = filePaths.get(0);
                    for (String p : filePaths) {
                        String lower = p.toLowerCase();
                        if (lower.endsWith(".jpg") || lower.endsWith(".jpeg") || lower.endsWith(".png")
                                || lower.endsWith(".webp") || lower.endsWith(".gif")) {
                            thumbnail = p;
                            break;
                        }
                    }
                    trip.setImageUrl(thumbnail);
                    trip.setMediaUrls(String.join(",", filePaths));
                }
            } catch (java.io.IOException e) {
                e.printStackTrace();
            }
        } else {
            // Keep old media if no new files uploaded
            trip.setImageUrl(existingTrip.getImageUrl());
            trip.setMediaUrls(existingTrip.getMediaUrls());
        }

        List<String> finalCategories = categories != null ? new ArrayList<>(categories) : new ArrayList<>();
        if (categoryOther != null && !categoryOther.trim().isEmpty()) {
            if (finalCategories.contains("Others"))
                finalCategories.remove("Others");
            finalCategories.add(categoryOther.trim());
        }

        List<String> finalSubCategories = subCategories != null ? new ArrayList<>(subCategories) : new ArrayList<>();
        if (subCategoryOther != null && !subCategoryOther.trim().isEmpty()) {
            finalSubCategories.remove("Other");
            finalSubCategories.remove("Others");
            finalSubCategories.add(subCategoryOther.trim());
        }

        if (!finalCategories.isEmpty()) {
            trip.setTravelerCategory(String.join(", ", finalCategories));
        }
        if (!finalSubCategories.isEmpty()) {
            trip.setTravelerSubCategory(String.join(", ", finalSubCategories));
        }

        // Preserve metadata
        trip.setVendor(vendor);
        trip.setCreatedAt(existingTrip.getCreatedAt());
        trip.setStatus(existingTrip.getStatus());

        trip.setBookingType(bookingType);
        trip.setCancellationPolicy(cancellationPolicy);
        trip.setCustomCancellation(customCancellation);
        trip.setMandatoryDocuments(mandatoryDocuments);
        trip.setPickupPoints(pickupPoints);
        trip.setTransportType(transportType);
        trip.setStayType(stayType);
        trip.setRoomSharing(roomSharing);
        trip.setStayAmenities(stayAmenities);
        trip.setMealsConfig(mealsConfig);
        trip.setDifficulty(difficulty);
        trip.setSafetyRequirements(safetyRequirements);
        trip.setSafetyGuidelines(safetyGuidelines);
        trip.setWhatToCarry(whatToCarry);
        trip.setRefundPolicy(refundPolicy);
        trip.setReschedulePolicy(reschedulePolicy);
        trip.setTripRules(tripRules);
        trip.setBookingCutoffHours(bookingCutoffHours != null ? bookingCutoffHours : 24);
        trip.setMinTravelers(minTravelers != null ? minTravelers : 1);
        if (trip.getMaxTravelers() == null)
            trip.setMaxTravelers(20);
        trip.setCustomizable(customizable != null ? customizable : false);
        trip.setAgeGroup(ageGroup);
        trip.setStudentDiscountAvailable(studentDiscountAvailable != null ? studentDiscountAvailable : false);

        Trip savedTrip = tripService.saveTrip(trip);

        // Update Scheduling (Clear old first)
        tripScheduleRepository.deleteByTrip(savedTrip);
        handleScheduling(savedTrip, scheduleMode, schedulesJson, recurringDays, recStartTime, recTotalSeats,
                recEndDate);

        redirectAttributes.addFlashAttribute("message", "Trip updated successfully!");
        return "redirect:/vendor/tours";
    }

    @GetMapping("/delete-trip/{id}")
    public String deleteTrip(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }
        Trip trip = tripService.getTripById(id).orElse(null);
        if (trip != null && trip.getVendor().getId().equals(vendor.getId())) {
            tripService.deleteTrip(id);
            redirectAttributes.addFlashAttribute("message", "Trip deleted successfully!");
        }
        return "redirect:/vendor/tours";
    }

    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }
        Trip trip = tripService.getTripById(id).orElse(null);
        if (trip != null && trip.getVendor().getId().equals(vendor.getId())) {
            String newStatus = trip.getStatus().equals("Active") ? "Inactive" : "Active";
            trip.setStatus(newStatus);
            tripService.saveTrip(trip);
            redirectAttributes.addFlashAttribute("message", "Trip status updated to " + newStatus);
        }
        return "redirect:/vendor/tours";
    }

    private void handleScheduling(Trip trip, String mode, String json, List<String> recurringDays,
            String recStartTime, Integer recTotalSeats, String recEndDate) {
        if ("specific".equals(mode) && json != null && !json.isEmpty()) {
            try {
                ObjectMapper mapper = new ObjectMapper();
                List<Map<String, String>> slots = mapper.readValue(json, new TypeReference<>() {
                });
                for (Map<String, String> slot : slots) {
                    TripSchedule ts = new TripSchedule();
                    ts.setTrip(trip);
                    ts.setStartDate(LocalDate.parse(slot.get("date")));
                    if (slot.get("time") != null && !slot.get("time").isEmpty()) {
                        ts.setStartTime(LocalTime.parse(slot.get("time")));
                    }
                    ts.setTotalSeats(Integer.parseInt(slot.get("seats")));
                    ts.setAvailableSeats(ts.getTotalSeats());
                    tripScheduleRepository.save(ts);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("recurring".equals(mode) && recurringDays != null && recEndDate != null) {
            LocalDate start = LocalDate.now();
            LocalDate end = LocalDate.parse(recEndDate);
            LocalTime time = (recStartTime != null && !recStartTime.isEmpty())
                    ? LocalTime.parse(recStartTime)
                    : null;

            while (!start.isAfter(end)) {
                if (recurringDays.contains(start.getDayOfWeek().name())) {
                    TripSchedule ts = new TripSchedule();
                    ts.setTrip(trip);
                    ts.setStartDate(start);
                    ts.setStartTime(time);
                    ts.setTotalSeats(recTotalSeats);
                    ts.setAvailableSeats(recTotalSeats);
                    ts.setRecurring(true);
                    ts.setRecurringPattern("WEEKLY");
                    tripScheduleRepository.save(ts);
                }
                start = start.plusDays(1);
            }
        }
    }
}
