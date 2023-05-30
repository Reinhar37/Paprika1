package com.fbasz6857.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fbasz6857.domain.AlarmDTO;
import com.fbasz6857.domain.AlarmVO;
import com.fbasz6857.service.AlarmService;
import com.fbasz6857.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/ajax/*")
@AllArgsConstructor
@Log4j
public class AjaxController {
	
	private MemberService memberService;
	
	@GetMapping(value = "/idChk")
	@ResponseBody
	public ResponseEntity<String> idChk(@RequestParam("userId") String userId){
		
		String cnt = memberService.idChk(userId) + "";
		
		return new ResponseEntity<String>(cnt, HttpStatus.OK);
	}
	
}
