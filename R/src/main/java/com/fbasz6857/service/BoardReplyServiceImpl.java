package com.fbasz6857.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fbasz6857.domain.AlarmVO;
import com.fbasz6857.domain.BoardReplyPageDTO;
import com.fbasz6857.domain.BoardReplyVO;
import com.fbasz6857.domain.BoardVO;
import com.fbasz6857.mapper.AlarmMapper;
import com.fbasz6857.mapper.BoardMapper;
import com.fbasz6857.mapper.BoardReplyMapper;

import lombok.Setter;

@Service
public class BoardReplyServiceImpl implements BoardReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Setter(onMethod_ = @Autowired)
	private AlarmMapper alarmMapper;
	
	@Transactional
	@Override
	public int register(BoardReplyVO vo) {
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		BoardVO board = boardMapper.read(vo.getBno());
		
		AlarmVO alarm = new AlarmVO();
		
		alarm.setBno(vo.getBno());
		alarm.setUserId(board.getWriter());
		alarm.setType("reply");
		alarm.setSourceTitle(board.getTitle());
		
		alarmMapper.insert(alarm);
		
		return mapper.insert(vo);
	}

	@Override
	public BoardReplyVO get(Long rno) {
		
		return mapper.read(rno);
	}

	@Override
	public int modify(BoardReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		
		BoardReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public BoardReplyPageDTO getList(int start, int amount, Long bno) {
		BoardReplyPageDTO dto = new BoardReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(start, amount, bno));
		return dto;
	}
	
	
	
}
