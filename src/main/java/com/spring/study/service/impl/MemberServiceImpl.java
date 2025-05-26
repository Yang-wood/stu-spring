package com.spring.study.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.study.domain.MemberDTO;
import com.spring.study.mapper.MemberMapper;
import com.spring.study.service.IMemberService;

@Service
public class MemberServiceImpl implements IMemberService{

	@Autowired
	private MemberMapper mapper;

	@Override
	public MemberDTO login(MemberDTO mDto) {
		return mapper.login(mDto);
	}
	
	
}
