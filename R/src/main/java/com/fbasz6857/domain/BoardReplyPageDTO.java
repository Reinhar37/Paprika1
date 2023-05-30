package com.fbasz6857.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BoardReplyPageDTO {
	
	private int replyCnt; //해당 글의 댓글 수
	private List<BoardReplyVO> list; //해당 글의 댓글 목록
	
}
