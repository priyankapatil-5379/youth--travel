package com.youthtravel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

	@Autowired
	private com.youthtravel.repository.HomeImageRepository homeImageRepository;

	@Autowired
	private com.youthtravel.repository.EnquiryRepository enquiryRepository;

	@RequestMapping("/")
	public String Home(org.springframework.ui.Model model) {
		model.addAttribute("galleryImages", homeImageRepository.findBySection("GALLERY"));
		model.addAttribute("momentImages", homeImageRepository.findBySection("MOMENTS"));
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
}

