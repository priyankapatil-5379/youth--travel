package com.youthtravel.controller;

import com.youthtravel.entity.Trip;
import com.youthtravel.service.TripService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/user/booking")
public class BookingFlowController {

    @Autowired
    private TripService tripService;

    @GetMapping("/review")
    public String showBookingReview(@RequestParam Long tripId,
                                    @RequestParam String selectedDate,
                                    @RequestParam Integer travelers,
                                    HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/user/login";
        }

        Optional<Trip> tripOpt = tripService.getTripById(tripId);
        if (tripOpt.isPresent()) {
            model.addAttribute("trip", tripOpt.get());
            model.addAttribute("selectedDate", selectedDate);
            model.addAttribute("travelers", travelers);
            return "users/booking-review";
        }
        return "redirect:/user/dashboard";
    }

    @GetMapping("/payment")
    public String showPayment(@RequestParam Long tripId,
                              @RequestParam String selectedDate,
                              @RequestParam Integer travelers,
                              @RequestParam Double amount,
                              Model model) {
        model.addAttribute("tripId", tripId);
        model.addAttribute("selectedDate", selectedDate);
        model.addAttribute("travelers", travelers);
        model.addAttribute("amount", amount);
        return "users/payment-page";
    }

    @GetMapping("/success")
    public String showSuccess(@RequestParam String bookingId,
                              @RequestParam Double amount,
                              Model model) {
        model.addAttribute("bookingId", bookingId);
        model.addAttribute("amount", amount);
        return "users/payment-success";
    }
}

