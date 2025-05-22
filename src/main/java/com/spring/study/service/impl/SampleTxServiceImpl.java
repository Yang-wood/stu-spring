package com.spring.study.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.study.mapper.Sample1Mapper;
import com.spring.study.service.ISampleTxService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleTxServiceImpl implements ISampleTxService {
	@Autowired
	private Sample1Mapper mapper;
	
	@Transactional
	@Override
	public void addData(String value) {
		log.info("insertCol1.............");
		mapper.insertCol1(value);
		log.info("insertCol2.............");
		mapper.insertCol2(value);
		log.info("end");
	}
	
}
