package com.youthtravel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

	@Autowired
	private com.youthtravel.repository.HomeImageRepository homeImageRepository;

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

	@RequestMapping("/gallery")
	public String gallery() {
		return "gallery";
	}

	@RequestMapping("/plan-trip")
	public String planTrip() {
		return "plan-trip";
	}
}

