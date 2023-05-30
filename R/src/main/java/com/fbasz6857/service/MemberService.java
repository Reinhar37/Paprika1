package com.fbasz6857.service;


import com.fbasz6857.domain.AuthVO;
import com.fbasz6857.domain.MemberVO;


public interface MemberService {
	
	//회원조회
	public MemberVO read(String userId);
	
	//회원가입
	public void register(MemberVO vo);
	
	//중복확인
	public int idChk(String userId);
	
	//회원수정
	public boolean modify(MemberVO member);
	
	//회원삭제
	public boolean remove(String userId);
	
	//등급갱신
	public boolean modifyAuth(AuthVO auth);
	
}
