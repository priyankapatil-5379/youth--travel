package com.youthtravel.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.youthtravel.entity.Vendor;
import com.youthtravel.service.VendorService;

@Controller
@RequestMapping("/vendor")
public class VendorController {

    @Autowired
    private VendorService vendorService;

    @GetMapping("/login")
    public String showVendorLoginForm() {
        // Auto-create a test account for verification if it doesn't exist
        if (vendorService.findByEmailId("admin@test.com").isEmpty()) {
            Vendor v = new Vendor();
            v.setBusinessName("Test Admin Business");
            v.setOwnerName("Admin");
            v.setEmailId("admin@test.com");
            v.setPhoneNumber("9876543210");
            v.setPassword("password123");
            v.setCompanyAddress("Adventure Street, Bengaluru");
            v.setAbout("Professional adventure travel provider since 2020.");
            v.setRegistrationId("REG-001");
            v.setTermsAccepted(true);
            v.setLogoPath("uploads/default_logo.png");
            v.setBannerPath("uploads/default_banner.png");
            v.setIdProofPath("uploads/default_id.png");
            v.setLicensePath("uploads/default_license.png");
            v.setInsurancePath("uploads/default_insurance.png");
            v.setStatus("APPROVED");
            vendorService.registerVendor(v);
        }
        return "vendor/login";
    }

    @PostMapping("/login")
    public String loginVendor(@RequestParam String emailId, @RequestParam String password,
            HttpSession session, RedirectAttributes redirectAttributes) {
        if (vendorService.loginVendor(emailId, password)) {
            Vendor vendor = vendorService.findByEmailId(emailId).orElse(null);
            if (vendor != null && vendor.getIsBlocked()) {
                redirectAttributes.addFlashAttribute("error", "Your account has been blocked by the administrator.");
                return "redirect:/vendor/login";
            }
            if (vendor != null && !"APPROVED".equals(vendor.getStatus())) {
                redirectAttributes.addFlashAttribute("error",
                        "Your account is " + vendor.getStatus() + ". You cannot login until approved by Admin.");
                return "redirect:/vendor/login";
            }
            session.setAttribute("loggedInVendor", vendor);
            return "redirect:/vendor/dashboard";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid credentials");
            return "redirect:/vendor/login";
        }
    }

    @GetMapping("/register")
    public String showVendorRegistrationForm() {
        return "vendor/register";
    }

    @PostMapping("/register")
    public String registerVendor(
            @ModelAttribute Vendor vendor,
            @RequestParam(value = "logoFile", required = false) org.springframework.web.multipart.MultipartFile logoFile,
            @RequestParam(value = "bannerFile", required = false) org.springframework.web.multipart.MultipartFile bannerFile,
            @RequestParam(value = "licenseFile", required = false) org.springframework.web.multipart.MultipartFile licenseFile,
            @RequestParam(value = "insuranceFile", required = false) org.springframework.web.multipart.MultipartFile insuranceFile,
            @RequestParam(value = "idProofFile", required = false) org.springframework.web.multipart.MultipartFile idProofFile,
            RedirectAttributes redirectAttributes) {

        try {
            // Check if email already exists
            if (vendorService.findByEmailId(vendor.getEmailId()).isPresent()) {
                redirectAttributes.addFlashAttribute("error",
                        "Email address is already registered. Please login or use a different email.");
                return "redirect:/vendor/register";
            }

            // Super Permissive Backend Defaults
            if (vendor.getBusinessName() == null || vendor.getBusinessName().trim().isEmpty()) {
                vendor.setBusinessName("New Adventure Vendor " + System.currentTimeMillis());
            }
            if (vendor.getEmailId() == null || vendor.getEmailId().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Email is required for account creation.");
                return "redirect:/vendor/register";
            }
            if (vendor.getPhoneNumber() == null || vendor.getPhoneNumber().trim().isEmpty()) {
                vendor.setPhoneNumber("0000000000");
            }
            if (vendor.getPassword() == null || vendor.getPassword().trim().isEmpty()) {
                vendor.setPassword("password123");
            }
            if (vendor.getCompanyAddress() == null || vendor.getCompanyAddress().trim().isEmpty()) {
                vendor.setCompanyAddress("Not Specified");
            }
            if (vendor.getAbout() == null || vendor.getAbout().length() < 1) {
                vendor.setAbout("Professional adventure travel provider.");
            }
            vendor.setTermsAccepted(true);
            vendor.setStatus("PENDING"); // Reverted to PENDING so Admin must approve as requested

            // Save initial vendor to get ID for file naming
            Vendor savedVendor = vendorService.registerVendor(vendor);

            // Handle file uploads
            String uploadDir = "uploads/vendor_docs/" + savedVendor.getId() + "/";
            java.nio.file.Path uploadPath = java.nio.file.Paths.get(uploadDir);
            if (!java.nio.file.Files.exists(uploadPath)) {
                java.nio.file.Files.createDirectories(uploadPath);
            }

            if (logoFile != null && !logoFile.isEmpty()) {
                String fileName = "logo_" + logoFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(logoFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                savedVendor.setLogoPath(filePath.toString().replace("\\", "/"));
            }

            if (bannerFile != null && !bannerFile.isEmpty()) {
                String fileName = "banner_" + bannerFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(bannerFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                savedVendor.setBannerPath(filePath.toString().replace("\\", "/"));
            }

            if (idProofFile != null && !idProofFile.isEmpty()) {
                String fileName = "idproof_" + idProofFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(idProofFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                savedVendor.setIdProofPath(filePath.toString().replace("\\", "/"));
            }

            if (licenseFile != null && !licenseFile.isEmpty()) {
                String fileName = "license_" + licenseFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(licenseFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                savedVendor.setLicensePath(filePath.toString().replace("\\", "/"));
            }

            if (insuranceFile != null && !insuranceFile.isEmpty()) {
                String fileName = "insurance_" + insuranceFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(insuranceFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                savedVendor.setInsurancePath(filePath.toString().replace("\\", "/"));
            }

            // Save again with file paths
            vendorService.saveVendor(savedVendor);

            redirectAttributes.addFlashAttribute("message", "Registration successful! Please login below.");
            return "redirect:/vendor/login";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "An error occurred during registration: " + e.getMessage());
            return "redirect:/vendor/register";
        }
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "/vendor/forgot-password";
    }

    @Autowired
    private com.youthtravel.service.TripService tripService;

    @Autowired
    private com.youthtravel.service.BookingService bookingService;

    @Autowired
    private com.youthtravel.service.MessageService messageService;

    @Autowired
    private com.youthtravel.repository.MessageRepository messageRepository;

    @Autowired
    private com.youthtravel.repository.ReviewRepository reviewRepository;

    @Autowired
    private com.youthtravel.repository.TripScheduleRepository tripScheduleRepository;
    @Autowired
    private org.springframework.messaging.simp.SimpMessagingTemplate messagingTemplate;

    @GetMapping("/dashboard")
    public String showVendorDashboard(HttpSession session, org.springframework.ui.Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }
        model.addAttribute("tourCount", tripService.getTourCountByVendor(vendor));
        model.addAttribute("activeTourCount", tripService.getActiveTourCountByVendor(vendor));
        model.addAttribute("inactiveTourCount", tripService.getInactiveTourCountByVendor(vendor));
        model.addAttribute("bookingCount", bookingService.getBookingCountByVendor(vendor));

        double estRevenue = bookingService.getTotalEarnings(vendor);
        
        String formattedRevenue;
        if (estRevenue >= 10000000) {
            formattedRevenue = String.format("%.1fCr", estRevenue / 10000000.0);
        } else if (estRevenue >= 100000) {
            formattedRevenue = String.format("%.2fL", estRevenue / 100000.0);
        } else if (estRevenue >= 1000) {
            formattedRevenue = String.format("%.1fK", estRevenue / 1000.0);
        } else {
            formattedRevenue = String.format("%.0f", estRevenue);
        }
        model.addAttribute("estRevenue", formattedRevenue);

        // Dynamic Revenue Analytics for last 6 months
        java.util.List<com.youthtravel.entity.Booking> vendorBookingsForAnalytics = bookingService.getBookingsByVendor(vendor);
        java.time.YearMonth currentMonth = java.time.YearMonth.now();
        java.util.List<String> labels = new java.util.ArrayList<>();
        java.util.List<Double> data = new java.util.ArrayList<>();
        
        for (int i = 5; i >= 0; i--) {
            java.time.YearMonth ym = currentMonth.minusMonths(i);
            String monthName = ym.getMonth().getDisplayName(java.time.format.TextStyle.SHORT, java.util.Locale.ENGLISH);
            labels.add("'" + monthName + "'");
            
            double sum = vendorBookingsForAnalytics.stream()
                .filter(b -> ("Confirmed".equalsIgnoreCase(b.getStatus()) || "Completed".equalsIgnoreCase(b.getStatus())) && 
                             b.getBookingDate() != null && 
                             java.time.YearMonth.from(b.getBookingDate()).equals(ym))
                .mapToDouble(b -> b.getTotalPrice() != null ? b.getTotalPrice() : 0.0)
                .sum();
            data.add(sum);
        }
        
        model.addAttribute("revenueLabels", String.join(",", labels));
        model.addAttribute("revenueData", data.stream().map(String::valueOf).collect(java.util.stream.Collectors.joining(",")));

        java.util.List<com.youthtravel.entity.Trip> allTrips = tripService.getTripsByVendor(vendor);
        java.util.List<com.youthtravel.entity.Trip> recentTrips = allTrips.stream()
                .sorted((t1, t2) -> t2.getId().compareTo(t1.getId()))
                .limit(4)
                .collect(java.util.stream.Collectors.toList());
        model.addAttribute("recentTrips", recentTrips);

        return "vendor/dashboard";
    }

    @GetMapping("/inventory")
    public String showInventory(HttpSession session, org.springframework.ui.Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";

        java.util.List<com.youthtravel.entity.Trip> trips = tripService.getTripsByVendor(vendor);
        java.util.Map<Long, Integer> occupiedMap = new java.util.HashMap<>();
        java.util.Map<Long, java.util.List<com.youthtravel.entity.TripSchedule>> schedulesMap = new java.util.HashMap<>();
        java.util.Map<Long, Integer> scheduleOccupiedMap = new java.util.HashMap<>();
        
        for (com.youthtravel.entity.Trip trip : trips) {
            occupiedMap.put(trip.getId(), bookingService.getOccupiedSlotsByTrip(trip));
            java.util.List<com.youthtravel.entity.TripSchedule> schedules = tripScheduleRepository.findByTrip(trip);
            schedulesMap.put(trip.getId(), schedules);
            
            java.util.List<com.youthtravel.entity.Booking> bookings = bookingService.getBookingsByTrip(trip);
            for (com.youthtravel.entity.TripSchedule sched : schedules) {
                int schedOccupied = bookings.stream()
                        .filter(b -> "Confirmed".equalsIgnoreCase(b.getStatus()) || "Pending".equalsIgnoreCase(b.getStatus()))
                        .filter(b -> b.getSelectedDate() != null && b.getSelectedDate().equals(sched.getStartDate().toString()))
                        .mapToInt(b -> b.getNumberOfTravelers() != null ? b.getNumberOfTravelers() : 1)
                        .sum();
                scheduleOccupiedMap.put(sched.getId(), schedOccupied);
            }
        }

        model.addAttribute("trips", trips);
        model.addAttribute("occupiedMap", occupiedMap);
        model.addAttribute("schedulesMap", schedulesMap);
        model.addAttribute("scheduleOccupiedMap", scheduleOccupiedMap);
        return "vendor/inventory";
    }

    @PostMapping("/inventory/adjust-slots")
    @ResponseBody
    public java.util.Map<String, Object> adjustSlots(
            @RequestParam("tripId") Long tripId,
            @RequestParam(value = "scheduleId", required = false) Long scheduleId,
            @RequestParam("newCapacity") Integer newCapacity) {
        
        java.util.Map<String, Object> response = new java.util.HashMap<>();
        try {
            if (scheduleId != null) {
                java.util.Optional<com.youthtravel.entity.TripSchedule> schedOpt = tripScheduleRepository.findById(scheduleId);
                if (schedOpt.isPresent()) {
                    com.youthtravel.entity.TripSchedule schedule = schedOpt.get();
                    int diff = newCapacity - schedule.getTotalSeats();
                    schedule.setTotalSeats(newCapacity);
                    schedule.setAvailableSeats(Math.max(0, schedule.getAvailableSeats() + diff));
                    tripScheduleRepository.save(schedule);
                    response.put("success", true);
                    response.put("message", "Schedule capacity updated successfully!");
                    return response;
                }
            } else {
                java.util.Optional<com.youthtravel.entity.Trip> tripOpt = tripService.getTripById(tripId);
                if (tripOpt.isPresent()) {
                    com.youthtravel.entity.Trip trip = tripOpt.get();
                    trip.setMaxTravelers(newCapacity);
                    tripService.saveTrip(trip);
                    response.put("success", true);
                    response.put("message", "Trip capacity updated successfully!");
                    return response;
                }
            }
            response.put("success", false);
            response.put("message", "Trip or Schedule not found.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }
        return response;
    }

    @GetMapping("/guest-list")
    public String showGuestList(HttpSession session, org.springframework.ui.Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";
        model.addAttribute("bookings", bookingService.getBookingsByVendor(vendor));
        return "vendor/guest-list";
    }

    @GetMapping("/booking/{id}/chat")
    public String showBookingChat(@PathVariable Long id, HttpSession session, org.springframework.ui.Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) return "redirect:/vendor/login";

        java.util.Optional<com.youthtravel.entity.Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            com.youthtravel.entity.Booking booking = bookingOpt.get();
            if (!booking.getVendor().getId().equals(vendor.getId())) {
                return "redirect:/vendor/guest-list";
            }
            model.addAttribute("booking", booking);
            model.addAttribute("messages", messageRepository.findByBookingOrderBySentAtAsc(booking));
            return "vendor/booking-chat";
        }
        return "redirect:/vendor/guest-list";
    }

    @PostMapping("/booking/{id}/chat")
    public String sendBookingMessage(@PathVariable Long id, @RequestParam String content, HttpSession session) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) return "redirect:/vendor/login";

        java.util.Optional<com.youthtravel.entity.Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            com.youthtravel.entity.Booking booking = bookingOpt.get();
            if (!booking.getVendor().getId().equals(vendor.getId())) {
                return "redirect:/vendor/guest-list";
            }
            
            com.youthtravel.entity.Message msg = new com.youthtravel.entity.Message();
            msg.setBooking(booking);
            msg.setVendor(vendor);
            msg.setSenderName(vendor.getBusinessName());
            msg.setSenderEmail(vendor.getEmailId());
            msg.setContent(content);
            msg.setFromVendor(true);
            msg.setRead(false);
            com.youthtravel.entity.Message savedMsg = messageRepository.save(msg);

            // Broadcast via WebSocket so user sees it instantly
            String time = savedMsg.getSentAt() != null
                ? savedMsg.getSentAt().format(java.time.format.DateTimeFormatter.ofPattern("hh:mm a, MMM dd")) : "";
            java.util.Map<String, Object> dto = new java.util.LinkedHashMap<>();
            dto.put("id", savedMsg.getId());
            dto.put("content", savedMsg.getContent());
            dto.put("senderName", savedMsg.getSenderName());
            dto.put("senderEmail", savedMsg.getSenderEmail());
            dto.put("fromVendor", true);
            dto.put("formattedTime", time);
            dto.put("sentAt", savedMsg.getSentAt() != null ? savedMsg.getSentAt().toString() : "");
            dto.put("bookingId", booking.getId());
            dto.put("vendorId", vendor.getId());
            dto.put("userEmail", booking.getCustomerEmail());

            // Notify booking-specific room
            messagingTemplate.convertAndSend("/topic/booking/" + booking.getId(), dto);
            // Notify user's personal inbox
            String safeEmail = booking.getCustomerEmail().replace("@", "_at_").replace(".", "_dot_");
            messagingTemplate.convertAndSend("/topic/user/" + safeEmail, dto);
            // Notify vendor topic as well
            messagingTemplate.convertAndSend("/topic/vendor/" + vendor.getId(), dto);

            return "redirect:/vendor/booking/" + id + "/chat";
        }
        return "redirect:/vendor/guest-list";
    }

    @GetMapping("/messages")
    public String showMessages(@RequestParam(value = "chatWith", required = false) String chatWith,
            HttpSession session, org.springframework.ui.Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";

        model.addAttribute("conversations", messageService.getConversations(vendor));
        if (chatWith != null) {
            model.addAttribute("activeChat", messageService.getChat(vendor, chatWith));
            model.addAttribute("chatWithEmail", chatWith);
        }
        return "vendor/messages";
    }

    @PostMapping("/send-reply")
    public String sendReply(@RequestParam("recipientEmail") String recipientEmail,
            @RequestParam("content") String content,
            HttpSession session) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";

        com.youthtravel.entity.Message msg = new com.youthtravel.entity.Message();
        msg.setVendor(vendor);
        msg.setSenderEmail(recipientEmail); // grouping key — user email
        msg.setSenderName(vendor.getBusinessName());
        msg.setContent(content);
        msg.setFromVendor(true);
        msg.setRead(false);
        
        java.util.List<com.youthtravel.entity.Message> activeChat = messageService.getChat(vendor, recipientEmail);
        if (activeChat != null && !activeChat.isEmpty()) {
            com.youthtravel.entity.Message lastMsg = activeChat.get(activeChat.size() - 1);
            if (lastMsg.getBooking() != null) {
                msg.setBooking(lastMsg.getBooking());
            }
        }
        
        com.youthtravel.entity.Message savedMsg = messageRepository.save(msg);

        // ── WebSocket broadcast so user sees message instantly ──────────────
        String time = savedMsg.getSentAt() != null
            ? savedMsg.getSentAt().format(java.time.format.DateTimeFormatter.ofPattern("hh:mm a, MMM dd")) : "";

        java.util.Map<String, Object> dto = new java.util.LinkedHashMap<>();
        dto.put("id", savedMsg.getId());
        dto.put("content", savedMsg.getContent());
        dto.put("senderName", vendor.getBusinessName());
        dto.put("senderEmail", vendor.getEmailId());
        dto.put("fromVendor", true);
        dto.put("formattedTime", time);
        dto.put("sentAt", savedMsg.getSentAt() != null ? savedMsg.getSentAt().toString() : "");
        dto.put("bookingId", savedMsg.getBooking() != null ? savedMsg.getBooking().getId() : null);
        dto.put("vendorId", vendor.getId());
        dto.put("userEmail", recipientEmail);

        // user personal topic — must match what user/messages.jsp subscribes to
        String safeEmail = recipientEmail.replace("@", "_at_").replace(".", "_dot_");
        messagingTemplate.convertAndSend("/topic/user/" + safeEmail, dto);

        // also broadcast on booking topic if there's a booking
        if (savedMsg.getBooking() != null) {
            messagingTemplate.convertAndSend("/topic/booking/" + savedMsg.getBooking().getId(), dto);
        }

        // vendor's own topic so other vendor tabs update too
        messagingTemplate.convertAndSend("/topic/vendor/" + vendor.getId(), dto);

        return "redirect:/vendor/messages?chatWith=" + recipientEmail;
    }

    @GetMapping("/reviews")
    public String showReviews(HttpSession session, org.springframework.ui.Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";
        
        java.util.List<com.youthtravel.entity.Review> reviews = reviewRepository.findByTrip_Vendor(vendor);
        model.addAttribute("reviews", reviews);
        
        return "vendor/reviews";
    }


    @GetMapping("/profile")
    public String showVendorProfile(HttpSession session, org.springframework.ui.Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null) {
            return "redirect:/vendor/login";
        }
        model.addAttribute("loggedInVendor", vendor);
        return "vendor/profile";
    }

    @PostMapping("/update-profile")
    public String updateVendorProfile(@ModelAttribute Vendor updatedVendor,
            @RequestParam(value = "idProof", required = false) org.springframework.web.multipart.MultipartFile idProof,
            @RequestParam(value = "addrProof", required = false) org.springframework.web.multipart.MultipartFile addrProof,
            @RequestParam(value = "logoFile", required = false) org.springframework.web.multipart.MultipartFile logoFile,
            @RequestParam(value = "bannerFile", required = false) org.springframework.web.multipart.MultipartFile bannerFile,
            @RequestParam(value = "licenseFile", required = false) org.springframework.web.multipart.MultipartFile licenseFile,
            @RequestParam(value = "insuranceFile", required = false) org.springframework.web.multipart.MultipartFile insuranceFile,
            HttpSession session, RedirectAttributes redirectAttributes) {

        Vendor existingVendor = (Vendor) session.getAttribute("loggedInVendor");
        if (existingVendor == null) {
            return "redirect:/vendor/login";
        }

        // Handle file uploads
        String uploadDir = "uploads/vendor_docs/" + existingVendor.getId() + "/";
        try {
            java.nio.file.Path uploadPath = java.nio.file.Paths.get(uploadDir);
            if (!java.nio.file.Files.exists(uploadPath)) {
                java.nio.file.Files.createDirectories(uploadPath);
            }

            // Sync paths from existing vendor first
            updatedVendor.setIdProofPath(existingVendor.getIdProofPath());
            updatedVendor.setAddressProofPath(existingVendor.getAddressProofPath());
            updatedVendor.setLogoPath(existingVendor.getLogoPath());
            updatedVendor.setBannerPath(existingVendor.getBannerPath());
            updatedVendor.setLicensePath(existingVendor.getLicensePath());
            updatedVendor.setInsurancePath(existingVendor.getInsurancePath());

            if (idProof != null && !idProof.isEmpty()) {
                String fileName = "idproof_" + idProof.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(idProof.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                updatedVendor.setIdProofPath(filePath.toString());
            }

            if (addrProof != null && !addrProof.isEmpty()) {
                String fileName = "addrproof_" + addrProof.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(addrProof.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                updatedVendor.setAddressProofPath(filePath.toString());
            }

            if (logoFile != null && !logoFile.isEmpty()) {
                String fileName = "logo_" + logoFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(logoFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                updatedVendor.setLogoPath(filePath.toString());
            }

            if (bannerFile != null && !bannerFile.isEmpty()) {
                String fileName = "banner_" + bannerFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(bannerFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                updatedVendor.setBannerPath(filePath.toString());
            }

            if (licenseFile != null && !licenseFile.isEmpty()) {
                String fileName = "license_" + licenseFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(licenseFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                updatedVendor.setLicensePath(filePath.toString());
            }

            if (insuranceFile != null && !insuranceFile.isEmpty()) {
                String fileName = "insurance_" + insuranceFile.getOriginalFilename();
                java.nio.file.Path filePath = uploadPath.resolve(fileName);
                java.nio.file.Files.copy(insuranceFile.getInputStream(), filePath,
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                updatedVendor.setInsurancePath(filePath.toString());
            }

        } catch (java.io.IOException e) {
            e.printStackTrace();
        }

        // Maintain core identity
        updatedVendor.setId(existingVendor.getId());
        updatedVendor.setEmailId(existingVendor.getEmailId());
        updatedVendor.setPassword(existingVendor.getPassword());

        Vendor savedVendor = vendorService.saveVendor(updatedVendor);
        session.setAttribute("loggedInVendor", savedVendor);

        redirectAttributes.addFlashAttribute("message", "Profile updated successfully!");
        return "redirect:/vendor/profile";
    }

    @GetMapping("/logout")
    public String logoutVendor(HttpSession session) {
        session.invalidate();
        return "redirect:/vendor/login";
    }
}
