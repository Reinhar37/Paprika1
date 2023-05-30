package com.fbasz6857.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@Controller
public class CommonController {
	
	//private static final Logger Logger = LoggerFactory.getLogger(CommonController.class);
	
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("error: " + error);
		log.info("logout: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logoooooooooouuuuuuuuuuuuuttttttttttttttt!!!!!!!!!!!!!");
		}
		
	}
	/*
	 * 로그아웃 get방식으로 처리
	 */
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}
	
	
	//403 에러 페이지
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
		
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*
	 * @RequestMapping(value = "/login", method = RequestMethod.GET) public void
	 * login(Locale locale, Model model) { }
	 */
}
