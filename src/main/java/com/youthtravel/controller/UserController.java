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

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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
    private com.youthtravel.repository.MessageRepository messageRepository;

    @Autowired
    private com.youthtravel.repository.VendorRepository vendorRepository;

    @Autowired
    private com.youthtravel.repository.ReviewRepository reviewRepository;

    @Autowired
    private com.youthtravel.service.MessageService messageService;

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
    public String exploreUsers(@RequestParam(value = "search", required = false) String search, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        List<User> users;
        List<Post> posts;
        List<Advice> advices;

        if (search != null && !search.trim().isEmpty()) {
            String s = search.toLowerCase();
            users = userRepository.findAll().stream()
                .filter(u -> u.getFullName().toLowerCase().contains(s) || 
                            (u.getUsername() != null && u.getUsername().toLowerCase().contains(s)))
                .collect(java.util.stream.Collectors.toList());
            
            posts = postRepository.findAll().stream()
                .filter(p -> p.getCaption() != null && p.getCaption().toLowerCase().contains(s))
                .collect(java.util.stream.Collectors.toList());
                
            advices = adviceRepository.findAll().stream()
                .filter(a -> (a.getTitle() != null && a.getTitle().toLowerCase().contains(s)) ||
                             (a.getContent() != null && a.getContent().toLowerCase().contains(s)) ||
                             (a.getCategories() != null && a.getCategories().toLowerCase().contains(s)))
                .collect(java.util.stream.Collectors.toList());
        } else {
            users = userRepository.findAll();
            posts = postRepository.findAll();
            advices = adviceRepository.findAll();
        }
        
        // Remove current user from list
        users.removeIf(u -> u.getId().equals(user.getId()));

        model.addAttribute("user", user);
        model.addAttribute("users", users);
        model.addAttribute("posts", posts);
        model.addAttribute("advices", advices);
        model.addAttribute("searchQuery", search);
        return "users/explore";
    }

    @GetMapping("/dashboard")
    public String showDashboard(
            @RequestParam(required = false) String destination,
            @RequestParam(required = false) String tripType,
            @RequestParam(required = false) String departureCity,
            @RequestParam(required = false) String travelMonth,
            @RequestParam(required = false) String budget,
            @RequestParam(required = false) String duration,
            @RequestParam(required = false, defaultValue = "0") Double minPrice,
            @RequestParam(required = false, defaultValue = "100000") Double maxPrice,
            @RequestParam(required = false) String search,
            @RequestParam(required = false, defaultValue = "latest") String sortBy,
            @RequestParam(required = false, defaultValue = "travelerType") String groupBy,
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

        // Fetch all trips
        List<Trip> allTrips = tripService.getAllTrips();

        // Calculate soldOut status for each trip
        for (Trip trip : allTrips) {
            calculateTripAvailability(trip);
        }

        // Apply Filters
        List<Trip> filteredTrips = allTrips.stream()
                .filter(t -> t != null && "Active".equalsIgnoreCase(t.getStatus()))
                .filter(t -> {
                    boolean match = true;
                    if (destination != null && !destination.isEmpty()
                            && !"All Destinations".equalsIgnoreCase(destination)) {
                        match = match && t.getDestination().toLowerCase().contains(destination.toLowerCase());
                    }
                    if (tripType != null && !tripType.isEmpty() && !"All Types".equalsIgnoreCase(tripType)) {
                        match = match && t.getTravelerCategory() != null
                                && t.getTravelerCategory().toLowerCase().contains(tripType.toLowerCase());
                    }
                    if (departureCity != null && !departureCity.isEmpty() && !"Any".equalsIgnoreCase(departureCity) && !"Any City".equalsIgnoreCase(departureCity)) {
                        match = match && t.getPickupPoints() != null && t.getPickupPoints().toLowerCase().contains(departureCity.toLowerCase());
                    }
                    if (travelMonth != null && !travelMonth.isEmpty() && !"Any".equalsIgnoreCase(travelMonth) && !"Any Month".equalsIgnoreCase(travelMonth)) {
                        // Backend logic for Travel Month filtering to be implemented via TripScheduleRepository
                        // match = match && ...
                    }
                    if (duration != null && !duration.isEmpty() && !"All Durations".equalsIgnoreCase(duration)) {
                        int days = t.getDays() != null ? t.getDays() : 0;
                        if (duration.contains("1-3"))
                            match = match && (days >= 1 && days <= 3);
                        else if (duration.contains("4-7"))
                            match = match && (days >= 4 && days <= 7);
                        else if (duration.contains("7+"))
                            match = match && (days > 7);
                    }
                    if (search != null && !search.isEmpty()) {
                        String s = search.toLowerCase();
                        match = match && (t.getTitle().toLowerCase().contains(s)
                                || t.getDestination().toLowerCase().contains(s));
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

        // Grouping logic
        Map<String, List<Trip>> groupedPackages = new HashMap<>();
        for (Trip trip : filteredTrips) {
            if ("transport".equals(groupBy)) {
                String cat = trip.getTransportCategory() != null && !trip.getTransportCategory().trim().isEmpty() ? trip.getTransportCategory().trim() : "Other Transport";
                groupedPackages.computeIfAbsent(cat, k -> new ArrayList<>()).add(trip);
            } else if ("stay".equals(groupBy)) {
                String cat = trip.getStayCategory() != null && !trip.getStayCategory().trim().isEmpty() ? trip.getStayCategory().trim() : "Other Stay";
                groupedPackages.computeIfAbsent(cat, k -> new ArrayList<>()).add(trip);
            } else if ("activity".equals(groupBy)) {
                String cat = trip.getCategory() != null && !trip.getCategory().trim().isEmpty() ? trip.getCategory().trim() : "Other Activities";
                groupedPackages.computeIfAbsent(cat, k -> new ArrayList<>()).add(trip);
            } else if ("adventure".equals(groupBy)) {
                String cat = trip.getSubCategory() != null && !trip.getSubCategory().trim().isEmpty() ? trip.getSubCategory().trim() : "Other Adventures";
                groupedPackages.computeIfAbsent(cat, k -> new ArrayList<>()).add(trip);
            } else {
                // Default: travelerType
                if (trip.getTravelerCategory() != null && !trip.getTravelerCategory().trim().isEmpty()) {
                    String[] cats = trip.getTravelerCategory().split(",");
                    for (String cat : cats) {
                        String trimmedCat = cat.trim();
                        if (!trimmedCat.isEmpty()) {
                            groupedPackages.computeIfAbsent(trimmedCat, k -> new ArrayList<>()).add(trip);
                        }
                    }
                } else {
                    groupedPackages.computeIfAbsent("General Category", k -> new ArrayList<>()).add(trip);
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
        currentParams.put("tripType", tripType != null ? tripType : "");
        currentParams.put("departureCity", departureCity != null ? departureCity : "");
        currentParams.put("travelMonth", travelMonth != null ? travelMonth : "");
        currentParams.put("budget", budget != null ? budget : "");
        currentParams.put("duration", duration != null ? duration : "");
        currentParams.put("minPrice", minPrice);
        currentParams.put("maxPrice", maxPrice);
        currentParams.put("search", search != null ? search : "");
        currentParams.put("sortBy", sortBy != null ? sortBy : "latest");
        currentParams.put("groupBy", groupBy != null ? groupBy : "travelerType");
        
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

    @GetMapping("/package/{id}")
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
        msg.setSenderName(user.getName());
        msg.setContent(content);
        msg.setFromVendor(false);
        msg.setRead(false);
        
        // Attach to latest booking if exists
        java.util.List<com.youthtravel.entity.Message> activeChat = messageService.getChat(vendor, user.getEmail());
        if (activeChat != null && !activeChat.isEmpty()) {
            com.youthtravel.entity.Message lastMsg = activeChat.get(activeChat.size() - 1);
            if (lastMsg.getBooking() != null) {
                msg.setBooking(lastMsg.getBooking());
            }
        }
        
        messageRepository.save(msg);

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
    public String submitReview(@PathVariable Long id, @RequestParam("rating") Integer rating, 
            @RequestParam("reviewText") String reviewText, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        java.util.Optional<com.youthtravel.entity.Booking> bookingOpt = bookingService.getBookingById(id);
        if (bookingOpt.isPresent()) {
            com.youthtravel.entity.Booking booking = bookingOpt.get();
            if (booking.getCustomerEmail().equals(user.getEmail()) && "Completed".equals(booking.getStatus()) && !booking.isReviewed()) {
                com.youthtravel.entity.Review review = new com.youthtravel.entity.Review();
                review.setUser(user);
                review.setTrip(booking.getTrip());
                review.setRating(rating);
                review.setReviewText(reviewText);
                
                reviewRepository.save(review);
                
                booking.setReviewed(true);
                bookingService.saveBooking(booking);
                
                return "redirect:/user/my-bookings";
            }
        }
        return "redirect:/user/my-bookings";
    }
}
