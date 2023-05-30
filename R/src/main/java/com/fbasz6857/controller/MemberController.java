package com.fbasz6857.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fbasz6857.domain.AuthVO;
import com.fbasz6857.domain.MemberVO;
import com.fbasz6857.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j
public class MemberController {
	
	private MemberService service;
	
	private BCryptPasswordEncoder pwencoder;
	
	@PreAuthorize("isAnonymous()")
	@GetMapping("/signup")
	public void signup() {
	}
	
	@PreAuthorize("isAnonymous()")
	@PostMapping("/signup")
	public String register(MemberVO vo) {
		
		vo.setUserPassword(pwencoder.encode(vo.getUserPassword()));
		
		log.info(pwencoder.encode(vo.getUserPassword()));
		
		service.register(vo);
		
		
		return "redirect:/customLogin";
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/profile")
	public void profile(String userId, Model model) {
		model.addAttribute("member", service.read(userId));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/modify")
	public String modify(MemberVO member) {
		
		service.modify(member);
		
		return "redirect:/";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/remove")
	public String remove(String userId) {
		
		service.remove(userId);
		
		return "redirect:/customLogout";
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/authup")
	public String authUp(AuthVO auth) {
		
		service.modifyAuth(auth);
		
		return "redirect:/member/profile?userId=" + auth.getUserId();
		
	}
}
