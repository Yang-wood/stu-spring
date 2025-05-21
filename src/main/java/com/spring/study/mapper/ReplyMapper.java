package com.spring.study.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.study.domain.Criteria;
import com.spring.study.domain.ReplyDTO;

public interface ReplyMapper {
	public int insert(ReplyDTO replyDto);
	public ReplyDTO read(int rno);
	public int delete(int rno);
	public int update(ReplyDTO reply);
	
	public List<ReplyDTO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") int bno);
}
