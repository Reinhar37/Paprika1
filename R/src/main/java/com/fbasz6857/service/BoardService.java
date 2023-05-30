package com.fbasz6857.service;

import java.util.List;

import com.fbasz6857.domain.BoardAttachVO;
import com.fbasz6857.domain.BoardVO;
import com.fbasz6857.domain.Criteria;

public interface BoardService {
	
	//글 등록
	public void register(BoardVO board);
	
	//글 상세내용
	public BoardVO get(Long bno);
	
	//글 수정
	public boolean modify(BoardVO board);
	
	//글 삭제
	public boolean remove(BoardVO board);
	
	//글 목록
	public List<BoardVO> getList();
	
	//글 목록 페이징
	public List<BoardVO> getList(Criteria cri);
	
	//글 전체 수
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(BoardVO vo);	
	
}
