package com.fbasz6857.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fbasz6857.domain.AuthVO;
import com.fbasz6857.domain.MemberVO;
import com.fbasz6857.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Override
	public MemberVO read(String userid) {
		
		return mapper.read(userid);
	}
	
	@Transactional
	@Override
	public void register(MemberVO vo) {
		mapper.insertMember(vo);
		
		mapper.insertAuth(vo.getUserId());
	}

	@Override
	public int idChk(String userId) {
		
		return mapper.idChk(userId);
	}

	@Transactional
	@Override
	public boolean remove(String userId) {
		
		mapper.deleteAuth(userId);
		
		return mapper.deleteMember(userId);
	}
	
	@Transactional
	@Override
	public boolean modify(MemberVO member) {
		
		return mapper.updateMember(member);
	}

	@Override
	public boolean modifyAuth(AuthVO auth) {
		
		int bCnt = mapper.updateAuthChkBoard(auth.getUserId());
		int rCnt = mapper.updateAuthChkReply(auth.getUserId());
		
		if(bCnt >= 10 && rCnt >= 30) {
			auth.setAuth("ROLE_MEMBER");
		}
		if(bCnt >= 30 && rCnt >= 90) {
			auth.setAuth("ROLE_ADMIN");
		}
		
		return mapper.updateAuth(auth);
	}
	
	
	
}
