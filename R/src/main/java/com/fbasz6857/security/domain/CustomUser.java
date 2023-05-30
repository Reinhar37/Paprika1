package com.fbasz6857.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.fbasz6857.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	
	private MemberVO member;
	
	public CustomUser(String userName, String password, Collection<? extends GrantedAuthority> authorities) {
		super(userName, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		this(vo.getUserId(), vo.getUserPassword(), vo.getAuthList().stream().map(auth ->
			new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.member = vo;
	}
	
	
}
 