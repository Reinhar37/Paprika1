package com.fbasz6857.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fbasz6857.domain.BoardVO;
import com.fbasz6857.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public void insert(BoardVO board);

	public void insertSelectKey(BoardVO board);
	
	public void insertLastKey(BoardVO board); // 글 등록후 A.I 값 알아내기
	
	public BoardVO read(Long bno);
	
	public boolean delete(Long bno);
	
	public boolean update(BoardVO board);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	public void updateHit(@Param("bno") Long bno);
	
}
