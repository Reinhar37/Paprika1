package com.fbasz6857.domain;


import lombok.Data;

@Data
public class BoardAttachVO {
	
	//private final String TABLE_ID = "board";
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private String tableId;
	
	private Long bno;
	
}
