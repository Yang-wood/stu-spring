package com.spring.study;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.study.domain.MemberDTO;
import com.spring.study.persistence.IMemberDAO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class IMemberDAOTest {
	@Autowired
	private IMemberDAO mDao;
	
//	@Test
//	public void testTime() {
//		log.info("mDao.getTime() ===> " + mDao.getTime());
//	}
//	
//	@Test
//	public void testInsertMember() throws Exception {
//		MemberDTO mDto = new MemberDTO();
//		mDto.setUserid("user01");
//		mDto.setUserpw("user01");
//		mDto.setUsername("USER01");
//		mDto.setEmail("user01@naver.com");
//		
//		mDao.insertMember(mDto);
//	}
	
//	@Test
//	public void selMember() throws Exception {
//		MemberDTO mDto = mDao.selMember("user02");
//		
//		log.info(mDto.toString());
//	}
//	
//	@Test
//	public void selLoginInfo() throws Exception {
//		MemberDTO mDto = mDao.selLoginInfo("user03", "user03");
//		
//		log.info(mDto.toString());
//	}
	
//	@Test
//	public void updateMember() throws Exception {
//		MemberDTO mDto = new MemberDTO();
//		mDto.setUserid("user01");
//		mDto.setUsername("user01");
//		mDao.updateMember(mDto);
//		
//		log.info(mDto.toString());
//	}
	
	@Test
	public void delMember() throws Exception {
		MemberDTO mDto = new MemberDTO();
		mDto.setUserid("user01");
		mDao.delMember(mDto);
		
		log.info(mDto.toString());
	}
	
	
	
}





