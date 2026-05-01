package com.youthtravel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.youthtravel.repository.AdminRepository;
import com.youthtravel.repository.PackageRepository;
import com.youthtravel.repository.TripBookingRepository;
import com.youthtravel.repository.UserRepository;
import com.youthtravel.repository.VendorRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private com.youthtravel.repository.TripRepository tripRepository;

    @Autowired
    private TripBookingRepository tripBookingRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private com.youthtravel.repository.HomeImageRepository homeImageRepository;

    @GetMapping("/login")
    public String showLoginForm(jakarta.servlet.http.HttpSession session) {
        if (session.getAttribute("adminLoggedIn") != null) {
            return "redirect:/admin/dashboard";
        }
        return "Admin/login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               jakarta.servlet.http.HttpSession session,
                               Model model) {
        if ("admin".equals(username) && "admin123".equals(password)) {
            session.setAttribute("adminLoggedIn", true);
            return "redirect:/admin/dashboard";
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "Admin/login";
        }
    }

    @GetMapping("/logout")
    public String logout(jakarta.servlet.http.HttpSession session) {
        session.removeAttribute("adminLoggedIn");
        return "redirect:/admin/login";
    }


    @RequestMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("vendorCount", vendorRepository.count());
        model.addAttribute("userCount", userRepository.count());
        model.addAttribute("tripCount", tripRepository.count());
        model.addAttribute("revenue", 0);
        return "Admin/dashboard";
    }

    @RequestMapping("/trips")
    public String trips(Model model) {
        model.addAttribute("packages", tripRepository.findAll());
        return "Admin/trips";
    }

    @RequestMapping("/trips/{id}")
    public String tripDetail(@PathVariable Long id, Model model) {
        tripRepository.findById(id).ifPresent(pkg -> {
            model.addAttribute("pkg", pkg);
            model.addAttribute("bookings", tripBookingRepository.findByTripPackageId(id));
        });
        return "Admin/trip-detail";
    }

    @RequestMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "Admin/users";
    }

    @RequestMapping("/users/{id}")
    public String userDetail(@PathVariable Long id, Model model) {
        userRepository.findById(id).ifPresent(user -> {
            model.addAttribute("user", user);
            model.addAttribute("bookings", tripBookingRepository.findByUserId(id));
        });
        return "Admin/user-detail";
    }

    @Autowired
    private org.springframework.mail.javamail.JavaMailSender mailSender;

    @RequestMapping("/vendors")
    public String vendors(@RequestParam(required = false) String status, Model model) {
        if (status != null && !status.isEmpty()) {
            model.addAttribute("vendors", vendorRepository.findByStatus(status));
            model.addAttribute("currentStatus", status);
        } else {
            model.addAttribute("vendors", vendorRepository.findAll());
            model.addAttribute("currentStatus", "ALL");
        }
        return "Admin/vendors";
    }

    @RequestMapping("/vendors/{id}")
    public String vendorDetail(@PathVariable Long id, Model model) {
        vendorRepository.findById(id).ifPresent(vendor -> {
            model.addAttribute("vendor", vendor);
        });
        return "Admin/vendor-detail";
    }

    @PostMapping("/vendors/{id}/approve")
    public String approveVendor(@PathVariable Long id, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        vendorRepository.findById(id).ifPresent(vendor -> {
            vendor.setStatus("APPROVED");
            vendorRepository.save(vendor);
            sendEmail(vendor.getEmailId(), "Account Approved", "Your account has been approved. You can now log in.");
            redirectAttributes.addFlashAttribute("message", "Vendor approved successfully.");
        });
        return "redirect:/admin/vendors";
    }

    @PostMapping("/vendors/{id}/reject")
    public String rejectVendor(@PathVariable Long id, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        vendorRepository.findById(id).ifPresent(vendor -> {
            vendor.setStatus("REJECTED");
            vendorRepository.save(vendor);
            sendEmail(vendor.getEmailId(), "Account Rejected", "Your registration has been rejected.");
            redirectAttributes.addFlashAttribute("message", "Vendor rejected successfully.");
        });
        return "redirect:/admin/vendors";
    }

    private void sendEmail(String to, String subject, String text) {
        try {
            org.springframework.mail.SimpleMailMessage message = new org.springframework.mail.SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(text);
            message.setFrom("nehakore2121@gmail.com");
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            // log error
        }
    }

    @RequestMapping("/inquiries")
    public String inquiries(Model model) {
        model.addAttribute("userInquiries", new java.util.ArrayList<>());
        model.addAttribute("vendorInquiries", new java.util.ArrayList<>());
        return "Admin/inquiries";
    }

    @GetMapping("/home-images")
    public String homeImages(Model model, jakarta.servlet.http.HttpSession session) {
        if (session.getAttribute("adminLoggedIn") == null) return "redirect:/admin/login";
        model.addAttribute("galleryImages", homeImageRepository.findBySection("GALLERY"));
        model.addAttribute("momentImages", homeImageRepository.findBySection("MOMENTS"));
        return "Admin/home-images";
    }

    @PostMapping("/home-images/upload")
    public String uploadHomeImage(@RequestParam("file") org.springframework.web.multipart.MultipartFile file,
                                  @RequestParam("section") String section,
                                  @RequestParam(value = "caption", required = false) String caption,
                                  jakarta.servlet.http.HttpSession session,
                                  org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        if (session.getAttribute("adminLoggedIn") == null) return "redirect:/admin/login";
        
        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please select a file to upload.");
            return "redirect:/admin/home-images";
        }

        try {
            String uploadDir = "uploads/home/";
            java.nio.file.Path uploadPath = java.nio.file.Paths.get(uploadDir);
            if (!java.nio.file.Files.exists(uploadPath)) {
                java.nio.file.Files.createDirectories(uploadPath);
            }

            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            java.nio.file.Path filePath = uploadPath.resolve(fileName);
            java.nio.file.Files.copy(file.getInputStream(), filePath, java.nio.file.StandardCopyOption.REPLACE_EXISTING);

            com.youthtravel.entity.HomeImage img = new com.youthtravel.entity.HomeImage();
            img.setImageUrl("/" + uploadDir + fileName);
            img.setSection(section);
            img.setCaption(caption);
            homeImageRepository.save(img);

            redirectAttributes.addFlashAttribute("message", "Image uploaded successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Upload failed: " + e.getMessage());
        }

        return "redirect:/admin/home-images";
    }

    @PostMapping("/home-images/{id}/delete")
    public String deleteHomeImage(@PathVariable Long id, jakarta.servlet.http.HttpSession session, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        if (session.getAttribute("adminLoggedIn") == null) return "redirect:/admin/login";
        homeImageRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Image deleted successfully.");
        return "redirect:/admin/home-images";
    }

}