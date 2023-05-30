package com.fbasz6857.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userId;
	private String userPassword;
	private String userName;
	private Date regDate;
	private Date updateDate;
	private String postCode;
	private String address;
	private String detailAddress;
	private String extraAddress;
	
	private boolean enabled;
	

	private List<AuthVO> authList; //한명이 여러권한을 얻을 수 있다.
	
}
