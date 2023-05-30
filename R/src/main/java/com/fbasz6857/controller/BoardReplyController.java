package com.fbasz6857.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fbasz6857.domain.BoardReplyPageDTO;
import com.fbasz6857.domain.BoardReplyVO;
import com.fbasz6857.domain.Criteria;
import com.fbasz6857.service.BoardReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/board/replies/*")
@Log4j
@AllArgsConstructor
public class BoardReplyController {
	
	private BoardReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody BoardReplyVO vo){
		log.info("BoardReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply insert count : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<BoardReplyPageDTO> getList(@PathVariable("page") int page,
														@PathVariable( "bno") Long bno){
		log.info("getList......");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		
		return new ResponseEntity<BoardReplyPageDTO>(service.getList(cri.getStart(), cri.getAmount(), bno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}")
	public ResponseEntity<BoardReplyVO> get(@PathVariable("rno") Long rno){
		return new ResponseEntity<BoardReplyVO>(service.get(rno), HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value = "/{rno}")
	public ResponseEntity<String> remove(@RequestBody BoardReplyVO vo, @PathVariable("rno") Long rno){
		return service.remove(rno) == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(value = "/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH}, consumes = "application/json")
	public ResponseEntity<String> modify(@RequestBody BoardReplyVO vo, @PathVariable("rno") Long rno){
		vo.setRno(rno);

		return service.modify(vo) == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
}
