package com.fbasz6857.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardReplyVO {
	
	private long rno;
	private long bno;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	
}
