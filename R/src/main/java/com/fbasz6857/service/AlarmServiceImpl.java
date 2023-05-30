package com.fbasz6857.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fbasz6857.domain.AlarmDTO;
import com.fbasz6857.mapper.AlarmMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AlarmServiceImpl implements AlarmService {
	
	@Setter(onMethod_ = @Autowired)
	private AlarmMapper mapper;
	
	@Override
	public AlarmDTO getList(String userId) {
		
		AlarmDTO dto = new AlarmDTO(mapper.getList(userId));
		
		return dto;
	}

	@Override
	public boolean updateChk(String userId) {
		
		return mapper.updateChk(userId);
		
	}

	@Override
	public boolean delete(Long ano) {
		
		return mapper.delete(ano);
		
	}
	
}
