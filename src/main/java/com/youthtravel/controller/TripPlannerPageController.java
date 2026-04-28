package com.youthtravel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TripPlannerPageController {

    @GetMapping("/plan-trip")
    public String planTripPage() {
        return "plan-trip";
    }
}

