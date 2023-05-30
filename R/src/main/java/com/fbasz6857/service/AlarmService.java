package com.fbasz6857.service;


import com.fbasz6857.domain.AlarmDTO;

public interface AlarmService {
	
	//알람 목록
	public AlarmDTO getList(String userId);
	
	//체크
	public boolean updateChk(String userId);
	
	//알람 삭제
	public boolean delete(Long ano);
	
}
