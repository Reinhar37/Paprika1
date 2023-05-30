package com.fbasz6857.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fbasz6857.domain.BoardAttachVO;
import com.fbasz6857.domain.BoardVO;
import com.fbasz6857.domain.Criteria;
import com.fbasz6857.mapper.BoardAttachMapper;
import com.fbasz6857.mapper.BoardMapper;
import com.fbasz6857.mapper.BoardReplyMapper;

import lombok.Setter;

@Service
//@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	//spring 4.3 이상에서 자동 처리
		@Setter(onMethod_ = @Autowired)
		private BoardMapper mapper;
		@Setter(onMethod_ = @Autowired)
		private BoardAttachMapper attachMapper;
		@Setter(onMethod_ = @Autowired)
		private BoardReplyMapper replyMapper;
		
		@Transactional
		@Override
		public void register(BoardVO board) {
			mapper.insertSelectKey(board);
			
			if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
				return;
			}
			
			board.getAttachList().forEach(attach ->{
				attach.setBno(board.getBno());
				attach.setTableId(board.getTABLE_ID());
				attachMapper.insert(attach);
			});
			
		}
		
		@Transactional
		@Override
		public BoardVO get(Long bno) {
			
			mapper.updateHit(bno);
			
			return mapper.read(bno);
		}
		
		@Transactional
		@Override
		public boolean modify(BoardVO board) {
			attachMapper.deleteAll(board);
			
			boolean modifyResult = mapper.update(board);
			
			if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
				
				board.getAttachList().forEach(attach ->{
					attach.setBno(board.getBno());
					attach.setTableId(board.getTABLE_ID());
					attachMapper.insert(attach);
				});
			}
			
			return modifyResult;
		}

		@Override
		public boolean remove(BoardVO board) {
			replyMapper.deleteAll(board.getBno()); //댓글 삭제
			attachMapper.deleteAll(board); // 첨부파일 리스트 삭제
			return mapper.delete(board.getBno()); // 해당 글 삭제
		}
		
		@Deprecated
		@Override
		public List<BoardVO> getList() {
			return mapper.getList();
		}

		@Override
		public List<BoardVO> getList(Criteria cri) {
			return mapper.getListWithPaging(cri);
		}

		@Override
		public int getTotal(Criteria cri) {
			return mapper.getTotalCount(cri);
		}

		@Override
		public List<BoardAttachVO> getAttachList(BoardVO vo) {
			
			return attachMapper.findByBno(vo);
		}
	
}
