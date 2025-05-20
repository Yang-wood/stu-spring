package com.spring.study;

import static org.junit.Assert.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MyBatisTest {
	
	@Autowired
	private SqlSessionFactory sqlFactory;  //필드 주입 방식
	
	@Test
	public void testFactory() {
		log.info("sqlFactory ==> " + sqlFactory);
	}
	
	@Test
	public void testSession() {
		try (SqlSession session = sqlFactory.openSession()) {
			log.info("session ==> " + session);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
