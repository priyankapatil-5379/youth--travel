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

        // Mock data for Analytics
        model.addAttribute("monthlyRevenue", new double[] { 12000, 19000, 15000, 25000, 22000, 30000 });
        model.addAttribute("monthlyLabels", new String[] { "Jan", "Feb", "Mar", "Apr", "May", "Jun" });
        model.addAttribute("categoryStats", new int[] { 45, 25, 20, 10 });
        model.addAttribute("categoryLabels", new String[] { "Adventure", "Water Sports", "Workation", "Others" });

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
        for (com.youthtravel.entity.Trip trip : trips) {
            occupiedMap.put(trip.getId(), bookingService.getOccupiedSlotsByTrip(trip));
        }

        model.addAttribute("trips", trips);
        model.addAttribute("occupiedMap", occupiedMap);
        return "vendor/inventory";
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
            messageRepository.save(msg);
            
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
        msg.setSenderEmail(recipientEmail); // We use this to group conversations
        msg.setSenderName("Traveler"); // Ideally fetch from conversation
        msg.setContent(content);
        msg.setFromVendor(true);
        msg.setRead(false);
        
        java.util.List<com.youthtravel.entity.Message> activeChat = messageService.getChat(vendor, recipientEmail);
        if (activeChat != null && !activeChat.isEmpty()) {
            com.youthtravel.entity.Message lastMsg = activeChat.get(activeChat.size() - 1);
            msg.setSenderName(lastMsg.getSenderName() != null ? lastMsg.getSenderName() : "Traveler");
            if (lastMsg.getBooking() != null) {
                msg.setBooking(lastMsg.getBooking());
            }
        }
        
        messageRepository.save(msg);

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
