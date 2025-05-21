package com.spring.study.service;

import java.util.List;

import com.spring.study.domain.Criteria;
import com.spring.study.domain.ReplyDTO;

public interface IReplyService {
	
	public int register(ReplyDTO replyDto);
	public ReplyDTO read(int rno);
	public int modify(ReplyDTO replyDtt);
	public int remove(int rno);
	public List<ReplyDTO> getList(Criteria cri, int bno);
}
