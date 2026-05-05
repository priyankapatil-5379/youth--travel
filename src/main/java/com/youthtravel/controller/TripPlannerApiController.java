package com.youthtravel.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@RestController
public class TripPlannerApiController {

    private static final List<Map<String, Object>> SUGGESTIONS = List.of(
            Map.of(
                    "name", "Coorg Weekend (Stay + Sightseeing)",
                    "type", "dayouts",
                    "minBudget", 999,
                    "maxBudget", 2499,
                    "days", 2,
                    "place", "Coorg, Karnataka",
                    "tag", "Coffee estates + waterfalls",
                    "image", "/views/assets/images/gallery-van-camp.png"
            ),
            Map.of(
                    "name", "Nandi Hills Bike Ride",
                    "type", "rides",
                    "minBudget", 999,
                    "maxBudget", 2999,
                    "days", 2,
                    "place", "Bengaluru → Nandi Hills",
                    "tag", "Sunrise ride + breakfast stop",
                    "image", "/views/assets/images/gallery-bike.png"
            ),
            Map.of(
                    "name", "Saklespur Camping (Bonfire Night)",
                    "type", "camping",
                    "minBudget", 1499,
                    "maxBudget", 2999,
                    "days", 2,
                    "place", "Saklespur, Karnataka",
                    "tag", "Tent stay + campfire",
                    "image", "/views/assets/images/gallery-camp-sunset.png"
            ),
            Map.of(
                    "name", "Kudremukh Trek (Guided)",
                    "type", "trekking",
                    "minBudget", 2499,
                    "maxBudget", 4999,
                    "days", 3,
                    "place", "Kudremukh, Karnataka",
                    "tag", "Green peaks + group trek",
                    "image", "/views/assets/images/gallery-trek.png"
            ),
            Map.of(
                    "name", "Wayanad Budget Trek + Stay",
                    "type", "trekking",
                    "minBudget", 1999,
                    "maxBudget", 4499,
                    "days", 2,
                    "place", "Wayanad, Kerala",
                    "tag", "Viewpoints + forest trails",
                    "image", "/views/assets/images/gallery-tent-view.png"
            ),
            Map.of(
                    "name", "Beach Camping (Gokarna)",
                    "type", "camping",
                    "minBudget", 1999,
                    "maxBudget", 4999,
                    "days", 2,
                    "place", "Gokarna, Karnataka",
                    "tag", "Beach night + bonfire",
                    "image", "/views/assets/images/gallery-couple-tent.png"
            ),
            Map.of(
                    "name", "Off-road Dirt Ride Day",
                    "type", "rides",
                    "minBudget", 1999,
                    "maxBudget", 5999,
                    "days", 1,
                    "place", "Bengaluru (Off-road track)",
                    "tag", "Dirt track practice + guidance",
                    "image", "/views/assets/images/gallery-dirt-bike.png"
            ),
            Map.of(
                    "name", "Sunset Lake-side Day Out",
                    "type", "dayouts",
                    "minBudget", 799,
                    "maxBudget", 1999,
                    "days", 1,
                    "place", "Near your city",
                    "tag", "Picnic + sunset spot",
                    "image", "/views/assets/images/more-waterpark.png"
            )
    );

    @org.springframework.beans.factory.annotation.Autowired
    private com.youthtravel.repository.TripRepository tripRepository;

    @PostMapping(value = "/api/plan-trip", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> plan(@RequestBody Map<String, Object> payload) {
        int budget = intVal(payload, "budget", 0);
        int days = intVal(payload, "days", 0);
        String type = strVal(payload, "type", "any").toLowerCase(Locale.ROOT);

        // Fetch from DB
        List<com.youthtravel.entity.Trip> trips;
        double maxPrice = budget > 0 ? (double) budget : 999999.0;
        
        // If type is "any", we pass empty string to match all categories
        String categoryFilter = "any".equalsIgnoreCase(type) ? "" : type;
        
        trips = tripRepository.findByStatusAndPriceBetweenAndTravelerCategoryContainingIgnoreCase("Active", 0.0, maxPrice, categoryFilter);

        // If no results for specific category, try finding ANY trip within budget to not show empty page
        if (trips.isEmpty() && !categoryFilter.isEmpty()) {
            trips = tripRepository.findByStatusAndPriceBetweenAndTravelerCategoryContainingIgnoreCase("Active", 0.0, maxPrice, "");
        }

        List<Map<String, Object>> results = new ArrayList<>();
        for (com.youthtravel.entity.Trip t : trips) {
            // Basic matching for days if days is provided
            if (days > 0 && t.getDays() != null) {
                if (Math.abs(t.getDays() - days) > 1) continue;
            }

            results.add(Map.of(
                "id", t.getId(),
                "name", t.getTitle(),
                "price", t.getPrice(),
                "place", t.getDestination() != null ? t.getDestination() : "Various",
                "days", t.getDays() != null ? t.getDays() : 1,
                "image", (t.getImageUrl() != null && !t.getImageUrl().isEmpty()) ? t.getImageUrl() : "/views/assets/images/gallery-van-camp.png",
                "tag", t.getTravelerCategory() != null ? t.getTravelerCategory() : "Adventure"
            ));
        }

        // Limit results
        if (results.size() > 6) {
            results = results.subList(0, 6);
        }

        return Map.of(
                "count", results.size(),
                "results", results
        );
    }

    private int score(Map<String, Object> s, int budget, int days) {
        int score = 0;
        if (budget > 0) {
            int min = (int) s.get("minBudget");
            int max = (int) s.get("maxBudget");
            int mid = (min + max) / 2;
            score += Math.abs(budget - mid);
        }
        if (days > 0) {
            int sDays = (int) s.get("days");
            score += Math.abs(days - sDays) * 300;
        }
        return score;
    }

    private int intVal(Map<String, Object> payload, String key, int fallback) {
        if (payload == null) return fallback;
        Object v = payload.get(key);
        if (v == null) return fallback;
        try {
            return Integer.parseInt(String.valueOf(v));
        } catch (Exception ignored) {
            return fallback;
        }
    }

    private String strVal(Map<String, Object> payload, String key, String fallback) {
        if (payload == null) return fallback;
        Object v = payload.get(key);
        if (v == null) return fallback;
        String s = String.valueOf(v).trim();
        return s.isEmpty() ? fallback : s;
    }
}

