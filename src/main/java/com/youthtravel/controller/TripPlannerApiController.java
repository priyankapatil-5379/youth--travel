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

    @PostMapping(value = "/api/plan-trip", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> plan(@RequestBody Map<String, Object> payload) {
        int budget = intVal(payload, "budget", 0);
        int days = intVal(payload, "days", 0);
        String type = strVal(payload, "type", "any").toLowerCase(Locale.ROOT);

        List<Map<String, Object>> matches = new ArrayList<>();
        for (Map<String, Object> s : SUGGESTIONS) {
            int min = (int) s.get("minBudget");
            int max = (int) s.get("maxBudget");
            int sDays = (int) s.get("days");
            String sType = String.valueOf(s.get("type"));

            boolean budgetOk = budget <= 0 || (budget >= min && budget <= max);
            boolean typeOk = "any".equals(type) || type.equals(sType);
            boolean daysOk = days <= 0 || Math.abs(days - sDays) <= 1;

            if (budgetOk && typeOk && daysOk) {
                matches.add(s);
            }
        }

        matches.sort(Comparator.comparingInt(s -> score(s, budget, days)));
        if (matches.size() > 6) {
            matches = matches.subList(0, 6);
        }

        return Map.of(
                "count", matches.size(),
                "results", matches
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

