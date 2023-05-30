package com.fbasz6857.mapper;

import java.util.List;

import com.fbasz6857.domain.AlarmVO;

public interface AlarmMapper {
	
	public List<AlarmVO> getList(String userId);
	
	public boolean insert(AlarmVO Alarm);
	
	public boolean updateChk(String userId);
	
	public boolean delete(Long ano);
	
}
