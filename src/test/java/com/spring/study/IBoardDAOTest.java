package com.spring.study;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.study.domain.BoardDTO;
import com.spring.study.domain.Criteria;
import com.spring.study.persistence.IBoardDAO;

import lombok.extern.log4j.Log4j;
import oracle.net.aso.b;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@Log4j
public class IBoardDAOTest {
	@Autowired
	private IBoardDAO bDao;
	
//	@Test 
//	public void createtest() throws Exception { 
//	BoardDTO bDto = new BoardDTO();
//	bDto.setTitle("새로운 글을 작성해주세요5"); bDto.setContent("새로운 상담 내용을 작성해주세요6");
//	bDto.setWriter("임꺽정"); bDao.create(bDto);
//
//	log.info(bDto.toString()); 
//	}
//
//
//	@Test
//	public void readTest() throws Exception {
//		log.info(bDao.read(1).toString());
//	}
//	
//	@Test
//	public void updateTest() throws Exception {
//		BoardDTO bDto = new BoardDTO();
//		bDto.setBno(1);
//		bDto.setTitle("코딩은 즐거워");
//		bDto.setContent("코딩은 정말 즐거운거 같아요.");
//		
//		bDao.update(bDto);
//	}
//	
//	@Test
//	public void deleteTest() throws Exception {
//		
//		bDao.delete(1);
//	}
//	
//	@Test
//	public void listTest() throws Exception {
//		Criteria cri = new Criteria();
//		
//		cri.setPageNum(2);
//		cri.setAmount(10);
//		
//		List<BoardDTO> listAll = bDao.listAll(cri);
//		
//		listAll.forEach(bDto -> {
//			log.info(bDto);
//		});
//		
//		listAll.forEach(bDto -> {
//			log.info(bDto.getBno() + " : " + bDto.getContent());
//		});
//	}
	
	@Test
	public void testSerach() throws Exception {
		Criteria cri = new Criteria();
		cri.setKeyword("수정");
		cri.setType("TC");
		
		List<BoardDTO> list = bDao.listAll(cri);
		list.forEach(BoardDTO -> log.info(list));
	}
}












