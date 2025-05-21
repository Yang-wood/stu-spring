package com.spring.study;

import static org.junit.Assert.*;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.study.domain.Criteria;
import com.spring.study.domain.ReplyDTO;
import com.spring.study.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReplyMapperTests {
	private int[] bnoArr = {353, 354, 355, 356, 359};
	
	@Autowired
	private ReplyMapper mapper;
	
//	@Test
//	public void testCreate() {
//		IntStream.rangeClosed(1, 10).forEach(i -> {
//			ReplyDTO replyDto = new ReplyDTO();
//			
//			replyDto.setBno(bnoArr[i % 5]);
//			replyDto.setReplytext("댓글 테스트 " + i);
//			replyDto.setReplyer("replyer " + i);
//			
//			mapper.insert(replyDto);
//		});
//	}
	
//	@Test
//	public void testRead() {
//		int targetRno = 4;
//		
//		ReplyDTO replyDto = mapper.read(targetRno);
//		
//		log.info(replyDto);
//	}
	
//	@Test
//	public void testDelete() {
//		int targetRno = 11;
//		
//		int rs =  mapper.delete(targetRno);
//		
//		log.info(rs);
//	}
	
//	@Test
//	public void testUpdate() {
//		int targetRno = 2;
//		
//		ReplyDTO replyDto = mapper.read(targetRno);
//		replyDto.setReplytext("댓글 수정");
//		int count = mapper.update(replyDto);
//		
//		log.info("UPDATE COUNT : " + count);
//	}
	
//	@Test
//	public void testList() {
//		Criteria cri = new Criteria();
//		
//		List<ReplyDTO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
//		
//		replies.forEach(reply -> log.info(reply));
//	}

}
