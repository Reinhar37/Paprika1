package com.fbasz6857.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fbasz6857.domain.BoardReplyVO;

public interface BoardReplyMapper {
	
	public int insert(BoardReplyVO vo);
	
	public BoardReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(BoardReplyVO vo);
	
	public List<BoardReplyVO> getListWithPaging(@Param("start") int start, @Param("amount") int amount, @Param("bno") Long bno);
	
	public int getCountByBno(Long bno);

	public void deleteAll(Long bno);
}
