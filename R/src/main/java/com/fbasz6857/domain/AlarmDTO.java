package com.fbasz6857.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AlarmDTO {
	
	private List<AlarmVO> list; //해당 글의 댓글 목록
	
}
