package com.fbasz6857.mapper;

import com.fbasz6857.domain.AuthVO;
import com.fbasz6857.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userId); 
	
	public void insertMember(MemberVO vo);
	
	public void insertAuth(String userId);
	
	public int idChk(String userId);
	
	public boolean deleteMember(String userId);
	
	public boolean deleteAuth(String userId);
	
	public boolean updateMember(MemberVO vo);
	
	public boolean updateAuth(AuthVO auth);
	
	public int updateAuthChkBoard(String userId);
	
	public int updateAuthChkReply(String userId);
	
}
