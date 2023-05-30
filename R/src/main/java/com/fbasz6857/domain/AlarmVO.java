package com.fbasz6857.domain;


import lombok.Data;

@Data
public class AlarmVO {
	
	private Long ano;
	private Long bno;
	private String userId;
	private String type;
	private String regDate;
	private String sourceTitle;
	private String checked;
	
}
