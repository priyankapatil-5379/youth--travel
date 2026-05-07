package com.youthtravel.controller;

import com.youthtravel.entity.Booking;
import com.youthtravel.entity.Trip;
import com.youthtravel.entity.User;
import com.youthtravel.entity.Post;
import com.youthtravel.entity.Advice;
import com.youthtravel.repository.PostRepository;
import com.youthtravel.repository.AdviceRepository;
import com.youthtravel.service.BookingService;
import com.youthtravel.service.DashboardService;
import com.youthtravel.service.SavedPackageService;
import com.youthtravel.service.TripService;
import com.youthtravel.service.UserService;
import com.youthtravel.repository.UserRepository;
import com.youthtravel.entity.Review;
import com.youthtravel.repository.ReviewRepository;
import com.youthtravel.repository.TripScheduleRepository;
import com.youthtravel.repository.FollowerRepository;
import org.springframework.http.ResponseEntity;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.Collections;
import com.youthtravel.entity.SavedPackage;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.UUID;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping({ "/user", "/users" })
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private SavedPackageService savedPackageService;

    @Autowired
    private DashboardService dashboardService;

    @Autowired
    private TripService tripService;

    @Autowired
    private FollowerRepository followerRepository;

    @Autowired
    private com.youthtravel.repository.MessageRepository messageRepository;

    @Autowired
    private com.youthtravel.repository.VendorRepository vendorRepository;

    @Autowired
    private com.youthtravel.repository.PaymentRepository paymentRepository;

    @Autowired
    private com.youthtravel.repository.ReviewRepository reviewRepository;

    @Autowired
    private com.youthtravel.service.MessageService messageService;

    @Autowired
    private com.youthtravel.service.VendorService vendorService;

    @Autowired
    private org.springframework.messaging.simp.SimpMessagingTemplate messagingTemplate;

    @Autowired
    private JavaMailSender mailSender;

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "users/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email, HttpSession session,
            RedirectAttributes redirectAttributes) {
        User user = userService.getUserByEmail(email);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Email address not found.");
            return "redirect:/user/forgot-password";
        }

        // Generate 6-digit OTP
        String otp = String.format("%06d", new Random().nextInt(999999));

        // Save in session
        session.setAttribute("resetEmail", email);
        session.setAttribute("resetOtp", otp);

        // Send email
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Youth Travel - Password Reset OTP");
            message.setText("Your OTP for password reset is: " + otp + "\n\nPlease do not share this OTP with anyone.");
            mailSender.send(message);
        } catch (Exception e) {
            System.out.println("Failed to send OTP email: " + e.getMessage());
            // For testing purposes locally without valid SMTP, we show it in console
            System.out.println("OTP for " + email + " is " + otp);
        }

        redirectAttributes.addFlashAttribute("message", "An OTP has been sent to your email address.");
        return "redirect:/user/verify-otp";
    }

    @GetMapping("/verify-otp")
    public String showVerifyOtpForm(HttpSession session) {
        if (session.getAttribute("resetEmail") == null) {
            return "redirect:/user/forgot-password";
        }
        return "users/verify-otp";
    }

    @PostMapping("/verify-otp")
    public String processVerifyOtp(@RequestParam("otp") String otp, HttpSession session,
            RedirectAttributes redirectAttributes) {
        String sessionOtp = (String) session.getAttribute("resetOtp");
        if (sessionOtp != null && sessionOtp.equals(otp)) {
            return "redirect:/user/reset-password";
        }
        redirectAttributes.addFlashAttribute("error", "Invalid OTP. Please try again.");
        return "redirect:/user/verify-otp";
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(HttpSession session) {
        if (session.getAttribute("resetEmail") == null || session.getAttribute("resetOtp") == null) {
            return "redirect:/user/forgot-password";
        }
        return "users/reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(@RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpSession session, RedirectAttributes redirectAttributes) {
        String email = (String) session.getAttribute("resetEmail");
        if (email == null) {
            return "redirect:/user/forgot-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match!");
            return "redirect:/user/reset-password";
        }

        User user = userService.getUserByEmail(email);
        if (user != null) {
            user.setPassword(newPassword); // In a real app, this should be encoded
            userService.updateUser(user);
        }

        session.removeAttribute("resetEmail");
        session.removeAttribute("resetOtp");

        redirectAttributes.addFlashAttribute("message", "Password has been reset successfully. You can now login.");
        return "redirect:/user/login";
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "users/login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email, @RequestParam String password,
            HttpSession session, RedirectAttributes redirectAttributes) {
        if (userService.loginUser(email, password)) {
            User user = userService.getUserByEmail(email);
            if (user.getIsBlocked()) {
                redirectAttributes.addFlashAttribute("error", "Your account has been blocked by the administrator.");
                return "redirect:/user/login";
            }
            session.setAttribute("user", user);
            redirectAttributes.addFlashAttribute("message", "Login successful! Welcome back.");
            return "redirect:/user/dashboard";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid Email or Password");
            return "redirect:/user/login";
        }
    }

    @GetMapping("/register")
    public String showRegisterForm() {
        return "users/register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        try {
            if (userService.getUserByEmail(user.getEmail()) != null) {
                redirectAttributes.addFlashAttribute("error", "Email is already registered!");
                return "redirect:/user/register";
            }
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("message", "Registration successful! Please login.");
            return "redirect:/user/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Registration failed: " + e.getMessage());
            return "redirect:/user/register";
        }
    }





    @Autowired
    private PostRepository postRepository;

    @Autowired
    private AdviceRepository adviceRepository;

    @Autowired
    private com.youthtravel.repository.TripScheduleRepository tripScheduleRepository;

    @GetMapping("/explore")
    public String exploreUsers(
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "country", required = false) String country,
            @RequestParam(value = "sortBy", required = false, defaultValue = "latest") String sortBy,
            HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        List<User> users = userRepository.findAll();
        List<Post> posts = postRepository.findAll();
        List<Advice> advices = adviceRepository.findAll();

        // 1. Exclude logged-in user
        users.removeIf(u -> u.getId().equals(user.getId()));

        // 2. Search & Filters
        if (search != null && !search.trim().isEmpty()) {
            String s = search.toLowerCase();
            users = users.stream()
                .filter(u -> u.getFullName().toLowerCase().contains(s) || 
                            (u.getUsername() != null && u.getUsername().toLowerCase().contains(s)))
                .collect(Collectors.toList());
            posts = posts.stream()
                .filter(p -> p.getCaption() != null && p.getCaption().toLowerCase().contains(s))
                .collect(Collectors.toList());
            advices = advices.stream()
                .filter(a -> (a.getTitle() != null && a.getTitle().toLowerCase().contains(s)) ||
                             (a.getContent() != null && a.getContent().toLowerCase().contains(s)))
                .collect(Collectors.toList());
        }

        if (country != null && !country.isEmpty() && !"All Countries".equals(country)) {
            users = users.stream()
                .filter(u -> u.getCity() != null && u.getCity().toLowerCase().contains(country.toLowerCase()))
                .collect(Collectors.toList());
        }

        // 3. Sorting
        if ("popular".equals(sortBy)) {
            users.sort((a, b) -> Long.compare(b.getTravelPoints(), a.getTravelPoints()));
            posts.sort((a, b) -> Integer.compare(b.getLikes(), a.getLikes()));
            advices.sort((a, b) -> Integer.compare(b.getLikes(), a.getLikes()));
        } else {
            // Default latest (if created_at is available)
            posts.sort((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));
            advices.sort((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));
        }

        // Fetch following IDs for the logged-in user
        List<Long> followingIds = followerRepository.findByFollower(user).stream()
            .map(f -> f.getFollowing().getId())
            .collect(Collectors.toList());

        model.addAttribute("user", user);
        model.addAttribute("users", users);
        model.addAttribute("posts", posts);
        model.addAttribute("advices", advices);
        model.addAttribute("searchQuery", search);
        model.addAttribute("selectedCountry", country);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("followingIds", followingIds);
        
        return "users/explore";
    }

    @GetMapping("/dashboard")
    public String showDashboard(
            @RequestParam(required = false) String destination,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String departureCity,
            @RequestParam(required = false) String month,
            @RequestParam(required = false) String budget,
            @RequestParam(required = false) String duration,
            @RequestParam(required = false, defaultValue = "0") Double minPrice,
            @RequestParam(required = false, defaultValue = "1000000") Double maxPrice,
            @RequestParam(required = false) String search,
            @RequestParam(required = false, defaultValue = "latest") String sortBy,
            @RequestParam(required = false, defaultValue = "none") String groupBy,
            HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        
        Map<String, Object> dashboardData = new HashMap<>();
        dashboardData.put("fullName", user.getFullName());
        dashboardData.put("profilePct", 85);
        dashboardData.put("tier", "Silver Explorer");
        dashboardData.put("bookingsCount", bookingService.getBookingsByUserEmail(user.getEmail()).size());
        dashboardData.put("reviewsCount", 0);
        dashboardData.put("savedCount", savedPackageService.getSavedPackagesByEmail(user.getEmail()).size());
        dashboardData.put("upcomingTrip", "Kudremukh Trek");
        dashboardData.put("upcomingDate", "May 12, 2024");
        dashboardData.put("balance", "₹1,200");
        dashboardData.put("notifications", 3);

        model.addAllAttributes(dashboardData);
        model.addAttribute("user", user);

        // Fetch saved trip IDs for highlighting heart icons
        List<Long> savedTripIds = savedPackageService.getSavedPackagesByEmail(user.getEmail())
            .stream().map(sp -> sp.getTrip().getId()).collect(Collectors.toList());
        model.addAttribute("savedTripIds", savedTripIds);

        // Fetch all trips
        List<Trip> allTrips = tripService.getAllTrips();

        // Calculate soldOut status for each trip
        for (Trip trip : allTrips) {
            calculateTripAvailability(trip);
        }

        // Apply Filters with Smart "All" detection
        List<Trip> filteredTrips = allTrips.stream()
                .filter(t -> t != null && "Active".equalsIgnoreCase(t.getStatus()))
                .filter(t -> {
                    boolean match = true;
                    
                    // Destination Filter
                    if (destination != null && !destination.isEmpty() && !"All".equalsIgnoreCase(destination) && !"All Destinations".equalsIgnoreCase(destination)) {
                        match = match && t.getDestination() != null && t.getDestination().toLowerCase().contains(destination.toLowerCase());
                    }
                    
                    // Category/Type Filter
                    if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category) && !"All Types".equalsIgnoreCase(category)) {
                        String cat = category.toLowerCase();
                        boolean mainCat = t.getCategory() != null && t.getCategory().toLowerCase().contains(cat);
                        boolean subCat = t.getSubCategory() != null && t.getSubCategory().toLowerCase().contains(cat);
                        boolean travelerCat = t.getTravelerCategory() != null && t.getTravelerCategory().toLowerCase().contains(cat);
                        match = match && (mainCat || subCat || travelerCat);
                    }
                    
                    // Departure City Filter
                    if (departureCity != null && !departureCity.isEmpty() && !"All".equalsIgnoreCase(departureCity) && !"Any".equalsIgnoreCase(departureCity)) {
                        match = match && t.getPickupPoints() != null && t.getPickupPoints().toLowerCase().contains(departureCity.toLowerCase());
                    }
                    
                    // Month Filter (Implementation check)
                    if (month != null && !month.isEmpty() && !"All".equalsIgnoreCase(month) && !"Any".equalsIgnoreCase(month)) {
                        // For now, matching against any specific month text in description or custom fields if exists
                        // match = match && ...
                    }
                    
                    // Duration Filter
                    if (duration != null && !duration.isEmpty() && !"All".equalsIgnoreCase(duration) && !"All Durations".equalsIgnoreCase(duration)) {
                        int days = t.getDays() != null ? t.getDays() : 0;
                        if (duration.contains("1-3")) match = match && (days >= 1 && days <= 3);
                        else if (duration.contains("4-7")) match = match && (days >= 4 && days <= 7);
                        else if (duration.contains("7+")) match = match && (days > 7);
                    }
                    
                    // Search Logic
                    if (search != null && !search.isEmpty()) {
                        String s = search.toLowerCase();
                        match = match && (t.getTitle().toLowerCase().contains(s) || t.getDestination().toLowerCase().contains(s));
                    }
                    
                    // Price Range
                    match = match && (t.getPrice() != null && t.getPrice() >= minPrice && t.getPrice() <= maxPrice);

                    return match;
                }).collect(Collectors.toList());

        // Apply Sorting
        if ("priceLow".equals(sortBy)) {
            filteredTrips.sort((a, b) -> a.getPrice().compareTo(b.getPrice()));
        } else if ("priceHigh".equals(sortBy)) {
            filteredTrips.sort((a, b) -> b.getPrice().compareTo(a.getPrice()));
        } else {
            // Default: Latest
            filteredTrips.sort((a, b) -> {
                if (a.getCreatedAt() == null)
                    return 1;
                if (b.getCreatedAt() == null)
                    return -1;
                return b.getCreatedAt().compareTo(a.getCreatedAt());
            });
        }

        // Grouping logic (Diamond Standard - Multi-Logistics)
        Map<String, List<Trip>> groupedPackages = new HashMap<>();
        
        if ("none".equals(groupBy) || groupBy == null || groupBy.isEmpty()) {
            groupedPackages.put("All Adventures", filteredTrips);
        } else {
            for (Trip trip : filteredTrips) {
                String groupKey = "Other Expeditions";
                
                if ("transport".equals(groupBy)) {
                    groupKey = trip.getTransportCategory() != null && !trip.getTransportCategory().isEmpty() ? trip.getTransportCategory() : "Local Transport";
                    groupedPackages.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(trip);
                } else if ("stay".equals(groupBy)) {
                    groupKey = trip.getStayCategory() != null && !trip.getStayCategory().isEmpty() ? trip.getStayCategory() : "Standard Stays";
                    groupedPackages.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(trip);
                } else if ("adventure".equals(groupBy)) {
                    groupKey = trip.getSubCategory() != null && !trip.getSubCategory().isEmpty() ? trip.getSubCategory() : "Wild Adventures";
                    groupedPackages.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(trip);
                } else if ("category".equals(groupBy) || "activity".equals(groupBy)) {
                    groupKey = trip.getCategory() != null && !trip.getCategory().isEmpty() ? trip.getCategory() : "General Activity";
                    groupedPackages.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(trip);
                } else if ("travelerType".equals(groupBy)) {
                    if (trip.getTravelerCategory() != null && !trip.getTravelerCategory().trim().isEmpty()) {
                        String[] cats = trip.getTravelerCategory().split(",");
                        for (String cat : cats) {
                            String trimmedCat = cat.trim();
                            if (!trimmedCat.isEmpty()) {
                                groupedPackages.computeIfAbsent(trimmedCat, k -> new ArrayList<>()).add(trip);
                            }
                        }
                    } else {
                        groupedPackages.computeIfAbsent("General Audience", k -> new ArrayList<>()).add(trip);
                    }
                } else {
                    groupedPackages.computeIfAbsent("All Journeys", k -> new ArrayList<>()).add(trip);
                }
            }
        }

        model.addAttribute("groupedPackages", groupedPackages);
        model.addAttribute("totalCount", filteredTrips.size());

        // Extract unique destinations for filter dropdown
        List<String> destinations = allTrips.stream()
                .map(Trip::getDestination)
                .filter(d -> d != null && !d.isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());
        model.addAttribute("destinations", destinations);

        // Pass back params for UI state
        Map<String, Object> currentParams = new HashMap<>();
        currentParams.put("destination", destination != null ? destination : "");
        currentParams.put("category", category != null ? category : "");
        currentParams.put("departureCity", departureCity != null ? departureCity : "");
        currentParams.put("month", month != null ? month : "");
        currentParams.put("budget", budget != null ? budget : "");
        currentParams.put("duration", duration != null ? duration : "");
        currentParams.put("minPrice", minPrice);
        currentParams.put("maxPrice", maxPrice);
        currentParams.put("search", search != null ? search : "");
        currentParams.put("sortBy", sortBy != null ? sortBy : "latest");
        currentParams.put("groupBy", groupBy != null ? groupBy : "none");
        
        model.addAttribute("currentParams", currentParams);

        return "users/user-dashboard";
    }

    private void calculateTripAvailability(Trip trip) {
        // Check schedules first
        List<com.youthtravel.entity.TripSchedule> schedules = tripScheduleRepository.findByTrip(trip);
        boolean hasAvailableSchedule = false;
        for (com.youthtravel.entity.TripSchedule s : schedules) {
            if (s.getAvailableSeats() != null && s.getAvailableSeats() > 0 && "Active".equals(s.getStatus())) {
                hasAvailableSchedule = true;
                break;
            }
        }
        
        // If it has schedules, sold out depends on those schedules
        if (!schedules.isEmpty()) {
            trip.setSoldOut(!hasAvailableSchedule);
        } else {
            // Fallback to maxTravelers logic if no schedules exist
            int occupied = bookingService.getOccupiedSlotsByTrip(trip);
            if (trip.getMaxTravelers() != null && trip.getMaxTravelers() > 0) {
                trip.setSoldOut(occupied >= trip.getMaxTravelers());
            } else {
                trip.setSoldOut(false); // Assume available if no limit and no schedules
            }
        }
    }

    @GetMapping({"/package/{id}", "/package-details/{id}"})
    public String showPackageDetails(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        Optional<Trip> tripOpt = tripService.getTripById(id);
        if (tripOpt.isPresent()) {
            Trip trip = tripOpt.get();
            calculateTripAvailability(trip);
            // Only show Active packages
            if (!"Active".equalsIgnoreCase(trip.getStatus())) {
                return "redirect:/user/dashboard";
            }
            model.addAttribute("trip", trip);
            model.addAttribute("user", user);
            model.addAttribute("isSaved", savedPackageService.isTripSaved(user, trip));

            java.util.List<com.youthtravel.entity.TripSchedule> schedules = tripScheduleRepository.findByTrip(trip);
            schedules.sort((a, b) -> a.getStartDate().compareTo(b.getStartDate()));
            model.addAttribute("schedules", schedules);

            // Handle media gallery (comma separated)
            if (trip.getMediaUrls() != null && !trip.getMediaUrls().isEmpty()) {
                model.addAttribute("gallery", trip.getMediaUrls().split(","));
            }

            // Fetch Related Trips
            List<Trip> allTrips = tripService.getAllTrips();
            List<Trip> related = allTrips.stream()
                .filter(t -> !"Inactive".equalsIgnoreCase(t.getStatus()))
                .filter(t -> !t.getId().equals(id))
                .filter(t -> t.getCategory() != null && t.getCategory().equals(trip.getCategory()))
                .limit(4)
                .collect(Collectors.toList());
            model.addAttribute("relatedTrips", related);

            return "users/package-details";
        }

        return "redirect:/user/dashboard";
    }

    @GetMapping("/package/{id}/wishlist")
    public String toggleWishlist(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        Optional<Trip> tripOpt = tripService.getTripById(id);
        if (tripOpt.isPresent()) {
            Trip trip = tripOpt.get();
            if (savedPackageService.isTripSaved(user, trip)) {
                savedPackageService.removeSavedTrip(user, trip);
            } else {
                savedPackageService.saveTrip(user, trip);
            }
            return "redirect:/user/package/" + id;
        }

        return "redirect:/user/dashboard";
    }

    @PostMapping("/api/toggle-wishlist/{id}")
    @ResponseBody
    public ResponseEntity<?> toggleWishlistAjax(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Trip> tripOpt = tripService.getTripById(id);
        if (tripOpt.isPresent()) {
            Trip trip = tripOpt.get();
            boolean isSaved;
            if (savedPackageService.isTripSaved(user, trip)) {
                savedPackageService.removeSavedTrip(user, trip);
                isSaved = false;
            } else {
                savedPackageService.saveTrip(user, trip);
                isSaved = true;
            }
            Map<String, Object> response = new HashMap<>();
            response.put("saved", isSaved);
            return ResponseEntity.ok(response);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/booking/{id}")
    public String showBookingPage(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:/user/login";

        Optional<Trip> tripOpt = tripService.getTripById(id);
        if (tripOpt.isPresent()) {
            model.addAttribute("trip", tripOpt.get());
            model.addAttribute("user", user);
            return "users/booking-page";
        }
        return "redirect:/user/dashboard";
    }

    @PostMapping("/booking/submit")
    public String submitBooking(@RequestParam Long tripId,
            @RequestParam String tripType,
            @RequestParam String selectedDate,
            @RequestParam Integer travelers,
            @RequestParam String guestDetails,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:/user/login";

        Optional<Trip> tripOpt = tripService.getTripById(tripId);
        if (tripOpt.isPresent()) {
            Trip trip = tripOpt.get();
            Booking booking = new Booking();
            booking.setTrip(trip);
            booking.setVendor(trip.getVendor());
            booking.setCustomerName(user.getFullName());
            booking.setCustomerEmail(user.getEmail());
            booking.setCustomerPhone(user.getPhoneNumber());
            booking.setTripType(tripType);
            booking.setSelectedDate(selectedDate);
            booking.setNumberOfTravelers(travelers);
            booking.setGuestDetails(guestDetails);

            double basePrice = trip.getPrice() * travelers;
            double serviceFee = basePrice * 0.05; // 5% fee
            booking.setTotalPrice(basePrice + serviceFee);
            booking.setStatus("Pending");

            bookingService.saveBooking(booking);
            return "redirect:/user/payment/" + booking.getId();
        }
        return "redirect:/user/dashboard";
    }

    @GetMapping("/payment/{id}")
    public String showPaymentPage(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        Optional<Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            if (!booking.getCustomerEmail().equals(user.getEmail())) {
                return "redirect:/user/dashboard";
            }
            model.addAttribute("booking", booking);
            model.addAttribute("user", user);
            return "users/payment";
        }
        return "redirect:/user/dashboard";
    }

    @PostMapping("/payment/success")
    @ResponseBody
    public ResponseEntity<?> paymentSuccess(@RequestBody Map<String, String> payload, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        String bookingIdStr = payload.get("bookingId");
        if (bookingIdStr != null) {
            try {
                Long bookingId = Long.parseLong(bookingIdStr);
                Optional<Booking> bookingOpt = bookingService.getBookingById(bookingId);
                if (bookingOpt.isPresent()) {
                    Booking booking = bookingOpt.get();
                    booking.setStatus("Confirmed");
                    bookingService.saveBooking(booking);

                    // Create Payment Record
                    com.youthtravel.entity.Payment payment = new com.youthtravel.entity.Payment();
                    payment.setUser(user);
                    payment.setBooking(booking);
                    payment.setAmount(booking.getTotalPrice());
                    payment.setStatus("Success");
                    payment.setPaymentMethod("Razorpay");
                    paymentRepository.save(payment);

                    return ResponseEntity.ok("Payment recorded");
                }
            } catch (Exception e) {
                return ResponseEntity.status(500).body(e.getMessage());
            }
        }
        return ResponseEntity.badRequest().build();
    }

    @GetMapping("/booking/{id}/chat")
    public String showBookingChat(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        Optional<Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            if (!booking.getCustomerEmail().equals(user.getEmail())) {
                return "redirect:/user/my-bookings";
            }
            model.addAttribute("booking", booking);
            model.addAttribute("user", user);
            model.addAttribute("messages", messageRepository.findByBookingOrderBySentAtAsc(booking));
            return "users/booking-chat";
        }
        return "redirect:/user/my-bookings";
    }

    @PostMapping("/booking/{id}/chat")
    public String sendBookingMessage(@PathVariable Long id, @RequestParam String content, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        Optional<Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            if (!booking.getCustomerEmail().equals(user.getEmail())) {
                return "redirect:/user/my-bookings";
            }
            
            com.youthtravel.entity.Message msg = new com.youthtravel.entity.Message();
            msg.setBooking(booking);
            msg.setVendor(booking.getVendor());
            msg.setSenderName(user.getName());
            msg.setSenderEmail(user.getEmail());
            msg.setContent(content);
            msg.setFromVendor(false);
            msg.setRead(false);
            messageRepository.save(msg);
            
            return "redirect:/user/booking/" + id + "/chat";
        }
        return "redirect:/user/my-bookings";
    }

    @GetMapping("/user-list")
    public String listUsers(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "users/user-list";
    }

    @GetMapping("/my-bookings")
    public String showMyBookings(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("bookings", bookingService.getBookingsByUserEmail(user.getEmail()));
        return "users/my-bookings";
    }

    @GetMapping("/save-trip/{id}")
    public String saveTrip(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        Optional<Trip> tripOpt = tripService.getTripById(id);
        if (tripOpt.isPresent()) {
            Trip trip = tripOpt.get();
            if (!savedPackageService.isTripSaved(user, trip)) {
                savedPackageService.saveTrip(user, trip);
                redirectAttributes.addFlashAttribute("message", "Trip successfully saved to your wishlist!");
            } else {
                redirectAttributes.addFlashAttribute("message", "This trip is already in your saved list.");
            }
        }
        return "redirect:/user/saved-trips";
    }

    @GetMapping("/saved-trips")
    public String showSavedTrips(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("savedPackages", savedPackageService.getSavedPackagesByEmail(user.getEmail()));
        return "users/saved-trips";
    }

    @GetMapping("/my-reviews")
    public String showMyReviews(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("reviews", dashboardService.getUserReviews(user.getEmail()));
        return "users/my-reviews";
    }

    @GetMapping("/payments")
    public String showPayments(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("payments", dashboardService.getUserPayments(user.getEmail()));
        return "users/payments";
    }

    @GetMapping("/messages")
    public String showMessages(@RequestParam(value = "chatWith", required = false) Long chatWithVendorId,
            HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("conversations", messageService.getUserConversations(user.getEmail()));
        
        if (chatWithVendorId != null) {
            com.youthtravel.entity.Vendor vendor = vendorRepository.findById(chatWithVendorId).orElse(null);
            if (vendor != null) {
                model.addAttribute("activeChat", messageService.getChat(vendor, user.getEmail()));
                model.addAttribute("chatWithVendor", vendor);
            }
        }
        return "users/messages";
    }

    @GetMapping("/api/chat/{vendorId}")
    @ResponseBody
    public java.util.List<java.util.Map<String, Object>> getChatApi(@PathVariable Long vendorId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return new java.util.ArrayList<>();

        com.youthtravel.entity.Vendor vendor = vendorRepository.findById(vendorId).orElse(null);
        if (vendor == null) return new java.util.ArrayList<>();

        // Source 1: messages from bookings where this user is the customer
        java.util.List<com.youthtravel.entity.Message> fromBookings =
            messageRepository.findByBookingCustomerEmail(user.getEmail())
                .stream()
                .filter(m -> m.getVendor() != null && m.getVendor().getId().equals(vendorId))
                .collect(java.util.stream.Collectors.toList());

        // Source 2: messages grouped by user email (vendor messages page convention)
        // These have senderEmail = user's email, isFromVendor = true, no booking
        java.util.List<com.youthtravel.entity.Message> fromSenderEmail =
            messageRepository.findBySenderEmailOrderBySentAtAsc(user.getEmail())
                .stream()
                .filter(m -> m.getVendor() != null && m.getVendor().getId().equals(vendorId))
                .collect(java.util.stream.Collectors.toList());

        // Merge and deduplicate by message ID, then sort by time
        java.util.Map<Long, com.youthtravel.entity.Message> merged = new java.util.LinkedHashMap<>();
        for (com.youthtravel.entity.Message m : fromBookings) merged.put(m.getId(), m);
        for (com.youthtravel.entity.Message m : fromSenderEmail) merged.put(m.getId(), m);

        java.util.List<com.youthtravel.entity.Message> messages = merged.values().stream()
            .sorted(java.util.Comparator.comparing(com.youthtravel.entity.Message::getSentAt))
            .collect(java.util.stream.Collectors.toList());

        return toDto(messages);
    }

    @GetMapping("/api/booking-chat/{bookingId}")
    @ResponseBody
    public java.util.List<java.util.Map<String, Object>> getBookingChatApi(@PathVariable Long bookingId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return new java.util.ArrayList<>();

        Optional<Booking> bookingOpt = bookingService.getBookingById(bookingId);
        if (bookingOpt.isEmpty()) return new java.util.ArrayList<>();

        Booking booking = bookingOpt.get();
        if (!booking.getCustomerEmail().equals(user.getEmail())) return new java.util.ArrayList<>();

        java.util.List<com.youthtravel.entity.Message> messages =
            messageRepository.findByBookingOrderBySentAtAsc(booking);
        return toDto(messages);
    }

    private java.util.List<java.util.Map<String, Object>> toDto(java.util.List<com.youthtravel.entity.Message> messages) {
        java.util.List<java.util.Map<String, Object>> result = new java.util.ArrayList<>();
        for (com.youthtravel.entity.Message m : messages) {
            java.util.LinkedHashMap<String, Object> dto = new java.util.LinkedHashMap<>();
            dto.put("id", m.getId());
            dto.put("content", m.getContent());
            dto.put("senderName", m.getSenderName());
            dto.put("senderEmail", m.getSenderEmail());
            dto.put("fromVendor", m.isFromVendor());
            dto.put("formattedTime", m.getFormattedTime());
            dto.put("sentAt", m.getSentAt() != null ? m.getSentAt().toString() : "");
            dto.put("bookingId", m.getBooking() != null ? m.getBooking().getId() : null);
            dto.put("vendorId", m.getVendor() != null ? m.getVendor().getId() : null);
            result.add(dto);
        }
        return result;
    }

    @PostMapping("/send-reply")
    public String sendReply(@RequestParam("vendorId") Long vendorId,
            @RequestParam("content") String content,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        com.youthtravel.entity.Vendor vendor = vendorRepository.findById(vendorId).orElse(null);
        if (vendor == null) return "redirect:/user/messages";

        com.youthtravel.entity.Message msg = new com.youthtravel.entity.Message();
        msg.setVendor(vendor);
        msg.setSenderEmail(user.getEmail());
        msg.setSenderName(user.getFullName());
        msg.setContent(content);
        msg.setFromVendor(false);
        msg.setRead(false);

        // Attach to latest booking with this vendor
        java.util.List<com.youthtravel.entity.Message> allBookingMsgs =
            messageRepository.findByBookingCustomerEmail(user.getEmail())
                .stream()
                .filter(m -> m.getVendor() != null && m.getVendor().getId().equals(vendorId))
                .sorted(java.util.Comparator.comparing(com.youthtravel.entity.Message::getSentAt).reversed())
                .collect(java.util.stream.Collectors.toList());
        if (!allBookingMsgs.isEmpty() && allBookingMsgs.get(0).getBooking() != null) {
            msg.setBooking(allBookingMsgs.get(0).getBooking());
        }

        com.youthtravel.entity.Message savedMsg = messageRepository.save(msg);

        // Broadcast via WebSocket so vendor sees it instantly
        String time = savedMsg.getSentAt() != null
            ? savedMsg.getSentAt().format(java.time.format.DateTimeFormatter.ofPattern("hh:mm a, MMM dd")) : "";
        java.util.Map<String, Object> dto = new java.util.LinkedHashMap<>();
        dto.put("id", savedMsg.getId());
        dto.put("content", savedMsg.getContent());
        dto.put("senderName", savedMsg.getSenderName());
        dto.put("senderEmail", savedMsg.getSenderEmail());
        dto.put("fromVendor", false);
        dto.put("formattedTime", time);
        dto.put("sentAt", savedMsg.getSentAt() != null ? savedMsg.getSentAt().toString() : "");
        dto.put("bookingId", savedMsg.getBooking() != null ? savedMsg.getBooking().getId() : null);
        dto.put("vendorId", vendorId);
        dto.put("userEmail", user.getEmail());

        // Notify vendor's booking topic (vendor booking-chat page)
        if (savedMsg.getBooking() != null) {
            messagingTemplate.convertAndSend("/topic/booking/" + savedMsg.getBooking().getId(), dto);
        }
        // Notify vendor general topic (vendor messages page)
        messagingTemplate.convertAndSend("/topic/vendor/" + vendorId, dto);
        // Notify user's own topic (user messages page echo confirmation)
        String safeEmail = user.getEmail().replace("@", "_at_").replace(".", "_dot_");
        messagingTemplate.convertAndSend("/topic/user/" + safeEmail, dto);

        return "redirect:/user/messages?chatWith=" + vendorId;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/user/login";
    }

    @GetMapping("/booking/{id}/review")
    public String showReviewPage(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        java.util.Optional<com.youthtravel.entity.Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            com.youthtravel.entity.Booking booking = bookingOpt.get();
            if (booking.getCustomerEmail().equals(user.getEmail()) && "Completed".equals(booking.getStatus()) && !booking.isReviewed()) {
                model.addAttribute("booking", booking);
                return "users/write-review";
            }
        }
        return "redirect:/user/my-bookings";
    }

    @PostMapping("/booking/{id}/review")
    @ResponseBody
    public ResponseEntity<String> submitReview(@PathVariable Long id, @RequestBody Map<String, Object> payload, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).body("Unauthorized");

        Optional<Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            
            Review review;
            List<Review> existingReviews = reviewRepository.findByUserAndTrip(user, booking.getTrip());
            if (!existingReviews.isEmpty()) {
                review = existingReviews.get(0);
            } else {
                review = new Review();
                review.setUser(user);
                review.setTrip(booking.getTrip());
            }

            review.setRating(Integer.parseInt(payload.get("rating").toString()));
            review.setReviewText(payload.get("reviewText").toString());
            
            reviewRepository.save(review);
            booking.setReviewed(true);
            bookingService.saveBooking(booking);
            
            return ResponseEntity.ok("Review saved");
        }
        return ResponseEntity.status(404).body("Booking not found");
    }

    @PostMapping("/booking/{id}/review/submit")
    @ResponseBody
    public ResponseEntity<String> submitFullReview(
            @PathVariable Long id,
            @RequestParam("rating") Integer rating,
            @RequestParam("title") String title,
            @RequestParam("reviewText") String reviewText,
            @RequestParam(value = "highlights", required = false) String highlights,
            @RequestParam(value = "suggestions", required = false) String suggestions,
            @RequestParam(value = "tags", required = false) String tags,
            @RequestParam(value = "recommend", required = false) Boolean recommend,
            @RequestParam(value = "photos", required = false) MultipartFile[] photos,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).body("Unauthorized");

        Optional<Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            
            Review review;
            List<Review> existingReviews = reviewRepository.findByUserAndTrip(user, booking.getTrip());
            if (!existingReviews.isEmpty()) {
                review = existingReviews.get(0);
            } else {
                review = new Review();
                review.setUser(user);
                review.setTrip(booking.getTrip());
            }

            review.setRating(rating);
            review.setTitle(title);
            review.setReviewText(reviewText);
            review.setHighlights(highlights);
            review.setSuggestions(suggestions);
            review.setTags(tags);
            review.setRecommended(recommend);
            review.setTravelDate(booking.getSelectedDate());

            // Handle Photo Uploads
            if (photos != null && photos.length > 0) {
                StringBuilder photoUrls = new StringBuilder();
                String uploadDir = "uploads/reviews/";
                java.io.File directory = new java.io.File(uploadDir);
                if (!directory.exists()) directory.mkdirs();
                
                try {
                    for (MultipartFile photo : photos) {
                        if (photo != null && !photo.isEmpty()) {
                            String fileName = UUID.randomUUID().toString() + "_" + photo.getOriginalFilename();
                            java.nio.file.Path path = java.nio.file.Paths.get(uploadDir + fileName);
                            java.nio.file.Files.copy(photo.getInputStream(), path, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                            if (photoUrls.length() > 0) photoUrls.append(",");
                            photoUrls.append("/uploads/reviews/").append(fileName);
                        }
                    }
                    review.setPhotos(photoUrls.toString());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            
            reviewRepository.save(review);
            booking.setReviewed(true);
            bookingService.saveBooking(booking);
            
            return ResponseEntity.ok("Review saved");
        }
        return ResponseEntity.status(404).body("Booking not found");
    }

    @GetMapping("/booking/{id}/review/data")
    @ResponseBody
    public ResponseEntity<Review> getReviewData(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            // Find review by user and trip
            List<Review> reviews = reviewRepository.findByUserAndTrip(user, booking.getTrip());
            if (!reviews.isEmpty()) {
                return ResponseEntity.ok(reviews.get(0));
            }
        }
        return ResponseEntity.notFound().build();
    }
    @GetMapping("/booking/{id}/advice")
    public String showAdvicePage(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        java.util.Optional<com.youthtravel.entity.Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            com.youthtravel.entity.Booking booking = bookingOpt.get();
            if (booking.getCustomerEmail().equals(user.getEmail())) {
                model.addAttribute("booking", booking);
                model.addAttribute("user", user);
                return "users/write-advice";
            }
        }
        return "redirect:/user/my-bookings";
    }

    @PostMapping("/booking/{id}/advice")
    @ResponseBody
    public ResponseEntity<String> submitAdvice(@PathVariable Long id, @RequestBody Map<String, Object> payload, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).body("Unauthorized");

        Optional<Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            
            Advice advice = new Advice();
            advice.setUser(user);
            advice.setTitle(payload.get("title") != null ? payload.get("title").toString() : "My Journey Advice");
            advice.setContent(payload.get("content") != null ? payload.get("content").toString() : "");
            advice.setCategories(payload.get("categories") != null ? payload.get("categories").toString() : (booking.getTrip() != null ? booking.getTrip().getCategory() : "General"));
            
            // Expert Fields
            advice.setBestTimeToVisit(payload.get("bestTimeToVisit") != null ? payload.get("bestTimeToVisit").toString() : "");
            advice.setWhatToPack(payload.get("whatToPack") != null ? payload.get("whatToPack").toString() : "");
            advice.setSafetyTips(payload.get("safetyTips") != null ? payload.get("safetyTips").toString() : "");
            advice.setBudgetTips(payload.get("budgetTips") != null ? payload.get("budgetTips").toString() : "");
            
            // Additional Expert Fields
            advice.setStayFoodAdvice(payload.get("stayFoodAdvice") != null ? payload.get("stayFoodAdvice").toString() : "");
            advice.setTransportTips(payload.get("transportTips") != null ? payload.get("transportTips").toString() : "");
            advice.setConnectivityTips(payload.get("connectivityTips") != null ? payload.get("connectivityTips").toString() : "");
            advice.setLocalRules(payload.get("localRules") != null ? payload.get("localRules").toString() : "");
            advice.setEnvironmentalTips(payload.get("environmentalTips") != null ? payload.get("environmentalTips").toString() : "");
            advice.setProTips(payload.get("proTips") != null ? payload.get("proTips").toString() : "");

            adviceRepository.save(advice);
            return ResponseEntity.ok("Advice saved");
        }
        return ResponseEntity.status(404).body("Booking not found");
    }

    // New API Endpoints for Reviews
    @GetMapping("/api/reviews/user")
    @ResponseBody
    public ResponseEntity<List<Review>> getUserReviews(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();
        return ResponseEntity.ok(reviewRepository.findByUser(user));
    }

    @PostMapping("/api/reviews/create/{bookingId}")
    @ResponseBody
    public ResponseEntity<String> createReviewApi(
            @PathVariable Long bookingId,
            @RequestParam("rating") Integer rating,
            @RequestParam("title") String title,
            @RequestParam("reviewText") String reviewText,
            @RequestParam(value = "highlights", required = false) String highlights,
            @RequestParam(value = "suggestions", required = false) String suggestions,
            @RequestParam(value = "tags", required = false) String tags,
            @RequestParam(value = "recommend", required = false) Boolean recommend,
            @RequestParam(value = "photos", required = false) MultipartFile[] photos,
            HttpSession session) {
        return submitFullReview(bookingId, rating, title, reviewText, highlights, suggestions, tags, recommend, photos, session);
    }
}
