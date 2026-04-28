package com.youthtravel.controller;

import com.youthtravel.entity.Booking;
import com.youthtravel.entity.Vendor;
import com.youthtravel.service.BookingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/vendor")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @GetMapping("/bookings")
    public String showBookings(HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";

        List<Booking> bookings = bookingService.getBookingsByVendor(vendor);
        model.addAttribute("bookings", bookings);
        model.addAttribute("vendor", vendor);
        return "/vendor/bookings";
    }

    @GetMapping("/update-booking/{id}/{status}")
    public String updateBookingStatus(@PathVariable Long id, @PathVariable String status, HttpSession session,
            RedirectAttributes redirectAttributes) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";

        Booking booking = bookingService.getBookingById(id).orElse(null);
        if (booking != null && booking.getVendor().getId().equals(vendor.getId())) {
            booking.setStatus(status);
            bookingService.saveBooking(booking);
            redirectAttributes.addFlashAttribute("message", "Booking status updated to " + status);
        }
        return "redirect:/vendor/bookings";
    }

    @GetMapping("/earnings")
    public String showEarnings(HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("loggedInVendor");
        if (vendor == null)
            return "redirect:/vendor/login";

        double totalEarnings = bookingService.getTotalEarnings(vendor);
        List<Booking> bookings = bookingService.getBookingsByVendor(vendor);

        model.addAttribute("totalEarnings", totalEarnings);
        model.addAttribute("bookings", bookings);
        model.addAttribute("vendor", vendor);
        return "/vendor/earnings";
    }
}
