package com.spring.study.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.study.domain.Criteria;
import com.spring.study.domain.ReplyDTO;
import com.spring.study.mapper.ReplyMapper;
import com.spring.study.service.IReplyService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements IReplyService {
	
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyDTO replyDto) {
		log.info("register........." + replyDto);
		return mapper.insert(replyDto);
	}

	@Override
	public ReplyDTO read(int rno) {
		log.info("read........." + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyDTO replyDto) {
		log.info("modify........." + replyDto );
		return mapper.update(replyDto);
	}

	@Override
	public int remove(int rno) {
		log.info("remove........." + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyDTO> getList(Criteria cri, int bno) {
		log.info("getList........." + bno);
		return mapper.getListWithPaging(cri, bno);
	}

}
