package com.youthtravel.controller;

import java.time.Instant;
import java.util.Locale;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ChatApiController {

    @PostMapping(value = "/api/chat", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> chat(@RequestBody Map<String, Object> payload) {
        String message = payload == null ? "" : String.valueOf(payload.getOrDefault("message", ""));
        String reply = replyFor(message);

        return Map.of(
                "reply", reply,
                "ts", Instant.now().toString()
        );
    }

    private String replyFor(String message) {
        String m = (message == null ? "" : message).trim();
        if (m.isEmpty()) {
            return "Hi! Tell me what you want to plan — bike ride, trekking, camping, or a weekend trip. I’ll guide you.";
        }

        String s = m.toLowerCase(Locale.ROOT);

        if (containsAny(s, "hi", "hello", "hey", "hii", "namaste")) {
            return "Hello! I’m Youth Travel assistant. What are you planning — ride, trek, camping, or day out?";
        }
        if (containsAny(s, "price", "cost", "budget", "fees", "rate")) {
            return "Budget depends on the location and duration. Share your city + dates + group size, I’ll suggest a good option under your budget.";
        }
        if (containsAny(s, "trek", "trekking", "hike")) {
            return "Nice! For trekking, tell me your fitness level (easy/medium/hard) and preferred state. I can suggest a weekend trek with inclusions and packing tips.";
        }
        if (containsAny(s, "bike", "ride", "riding", "ktm", "bullet", "royal enfield")) {
            return "For bike rides, share starting city + your bike type + weekend dates. I’ll suggest a route, approximate timing, and what to carry.";
        }
        if (containsAny(s, "camp", "camping", "bonfire")) {
            return "Camping sounds great. Tell me your group size and whether you want lake-side, hill-side, or forest stay. I’ll suggest a safe plan.";
        }
        if (containsAny(s, "safety", "safe", "secure")) {
            return "Safety is priority. We recommend verified partners, clear inclusions, and proper coordination. Share your plan and I’ll guide you with do’s and don’ts.";
        }
        if (containsAny(s, "contact", "whatsapp", "call", "phone")) {
            return "You can message us on WhatsApp using the button on this page, or go to Contact page and send your requirement. We usually reply quickly.";
        }

        return "Got it. Share your city, dates, group size, and what experience you want — I’ll suggest the best plan for you.";
    }

    private boolean containsAny(String s, String... needles) {
        for (String n : needles) {
            if (s.contains(n)) {
                return true;
            }
        }
        return false;
    }
}

