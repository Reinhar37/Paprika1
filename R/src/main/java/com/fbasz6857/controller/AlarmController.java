package com.fbasz6857.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
@RequestMapping("/alarm/*")
@AllArgsConstructor
@Log4j
public class AlarmController {
	
	private AlarmService service;
	
	@GetMapping(value = "/list")
	@ResponseBody
	public ResponseEntity<AlarmDTO> list(@RequestParam("userId") String userId){
		
		return new ResponseEntity<AlarmDTO>(service.getList(userId), HttpStatus.OK);
	}
	
	@GetMapping(value = "/chkmodify")
	@ResponseBody
	public void chkmodify(@RequestParam("userId") String userId){
		
		service.updateChk(userId);
		
	}
	
	@GetMapping(value = "/remove")
	@ResponseBody
	public ResponseEntity<Integer> remove(@RequestParam("ano") Long ano){
		
		int result = 0;
		
		if(service.delete(ano) + "" == "true") {
			result = 1;
		}
		
		
		log.info("BBBBBBBBBBBBBBBBBBBBBBBBBBB" + ano);
		
		log.info("CCCCCCCCCCCCCCCCCCCCCCCCCCC" + result);
		
		
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
		
	}
	
}
