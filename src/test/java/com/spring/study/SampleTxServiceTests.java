package com.spring.study;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.study.service.ISampleTxService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class SampleTxServiceTests {
	
	@Autowired
	private ISampleTxService service;
	
	@Test
	public void testLong() {
		String str = "Starry\r\\n" + 
					 "Starry night\r\\n" +
					 "Paint your palette blue and prey\r\n" +
					 "Look out on a summer's day";
		
		log.info("=========>" + str.getBytes().length);
		
		service.addData(str);
	}

}
