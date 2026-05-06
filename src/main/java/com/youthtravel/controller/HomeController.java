package com.youthtravel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.youthtravel.entity.Trip;
import java.util.*;
import java.util.stream.Collectors;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

	@Autowired
	private com.youthtravel.repository.HomeImageRepository homeImageRepository;

	@Autowired
	private com.youthtravel.repository.EnquiryRepository enquiryRepository;

	@Autowired
	private com.youthtravel.repository.TripRepository tripRepository;

	@Autowired
	private com.youthtravel.service.SavedPackageService savedPackageService;

	@RequestMapping("/")
	public String Home(org.springframework.ui.Model model) {
		model.addAttribute("galleryImages", homeImageRepository.findBySection("GALLERY"));
		model.addAttribute("momentImages", homeImageRepository.findBySection("MOMENTS"));
		model.addAttribute("featuredTrips", tripRepository.findTop5ByStatusOrderByCreatedAtDesc("Active"));
		return "index";
	}

	@RequestMapping("/about")
	public String about() {
		return "about";
	}

	@RequestMapping("/contact")
	public String contact() {
		return "contact";
	}

	@org.springframework.web.bind.annotation.PostMapping("/enquiry/submit")
	@ResponseBody
	public String submitEnquiry(@org.springframework.web.bind.annotation.RequestParam String name, 
								@org.springframework.web.bind.annotation.RequestParam String email,
								@org.springframework.web.bind.annotation.RequestParam(required = false) String phone,
								@org.springframework.web.bind.annotation.RequestParam String message) {
		com.youthtravel.entity.Enquiry enquiry = new com.youthtravel.entity.Enquiry(name, email, phone, message);
		enquiryRepository.save(enquiry);
		return "success";
	}

	@RequestMapping("/gallery")
	public String gallery() {
		return "gallery";
	}

	@RequestMapping("/plan-trip")
	public String planTrip() {
		return "plan-trip";
	}

	@RequestMapping("/explore-packages")
	public String explorePackages(
			@RequestParam(required = false) String destination,
			@RequestParam(required = false) String tripType,
			@RequestParam(required = false) String search,
			@RequestParam(required = false, defaultValue = "latest") String sortBy,
			Model model, HttpSession session) {
		
		List<Trip> allTrips = tripRepository.findAll();
		
		// Apply Filters
		List<Trip> filteredTrips = allTrips.stream()
				.filter(t -> t != null && "Active".equalsIgnoreCase(t.getStatus()))
				.filter(t -> {
					boolean match = true;
					if (destination != null && !destination.isEmpty() && !"All".equalsIgnoreCase(destination)) {
						match = match && t.getDestination().toLowerCase().contains(destination.toLowerCase());
					}
					if (tripType != null && !tripType.isEmpty() && !"All".equalsIgnoreCase(tripType)) {
						String tt = tripType.toLowerCase();
						match = match && (
							(t.getTravelerCategory() != null && t.getTravelerCategory().toLowerCase().contains(tt)) ||
							(t.getCategory() != null && t.getCategory().toLowerCase().contains(tt))
						);
					}
					if (search != null && !search.isEmpty()) {
						String s = search.toLowerCase();
						match = match && (t.getTitle().toLowerCase().contains(s) || t.getDestination().toLowerCase().contains(s));
					}
					return match;
				}).collect(Collectors.toList());

		// Sorting
		if ("priceLow".equals(sortBy)) {
			filteredTrips.sort(Comparator.comparing(Trip::getPrice, Comparator.nullsLast(Comparator.naturalOrder())));
		} else if ("priceHigh".equals(sortBy)) {
			filteredTrips.sort(Comparator.comparing(Trip::getPrice, Comparator.nullsLast(Comparator.reverseOrder())));
		} else {
			filteredTrips.sort((a, b) -> {
				if (a.getCreatedAt() == null) return 1;
				if (b.getCreatedAt() == null) return -1;
				return b.getCreatedAt().compareTo(a.getCreatedAt());
			});
		}

		// Grouping by traveler category
		Map<String, List<Trip>> groupedPackages = new LinkedHashMap<>();
		for (Trip trip : filteredTrips) {
			String category = "Featured Adventures";
			if (trip.getTravelerCategory() != null && !trip.getTravelerCategory().trim().isEmpty()) {
				category = trip.getTravelerCategory().split(",")[0].trim();
			} else if (trip.getCategory() != null && !trip.getCategory().trim().isEmpty()) {
				category = trip.getCategory();
			}
			groupedPackages.computeIfAbsent(category, k -> new ArrayList<>()).add(trip);
		}

		model.addAttribute("groupedPackages", groupedPackages);
		model.addAttribute("totalCount", filteredTrips.size());
		
		// Unique destinations for filter
		List<String> destinations = allTrips.stream()
				.map(Trip::getDestination)
				.filter(Objects::nonNull)
				.distinct()
				.sorted()
				.collect(Collectors.toList());
		model.addAttribute("destinations", destinations);

		com.youthtravel.entity.User user = (com.youthtravel.entity.User) session.getAttribute("user");
		if (user != null) {
			List<Long> savedTripIds = savedPackageService.getSavedPackagesByEmail(user.getEmail())
				.stream().map(sp -> sp.getTrip().getId()).collect(Collectors.toList());
			model.addAttribute("savedTripIds", savedTripIds);
		} else {
			model.addAttribute("savedTripIds", Collections.emptyList());
		}

		model.addAttribute("user", user);
		model.addAttribute("destination", destination);
		model.addAttribute("tripType", tripType);
		model.addAttribute("search", search);
		model.addAttribute("sortBy", sortBy);

		return "explore-packages";
	}
}

