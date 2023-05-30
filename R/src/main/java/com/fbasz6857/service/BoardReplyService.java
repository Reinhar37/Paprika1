package com.fbasz6857.service;


import com.fbasz6857.domain.BoardReplyPageDTO;
import com.fbasz6857.domain.BoardReplyVO;

public interface BoardReplyService {
	
	public int register(BoardReplyVO vo);
	
	public BoardReplyVO get(Long rno);
	
	public int modify(BoardReplyVO vo);
	
	public int remove(Long rno);
	
	public BoardReplyPageDTO getList(int start, int amount, Long bno);
}