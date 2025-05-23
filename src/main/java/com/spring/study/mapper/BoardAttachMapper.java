package com.spring.study.mapper;

import java.util.List;

import com.spring.study.domain.BoardAttachDTO;

public interface BoardAttachMapper {
	public void insert(BoardAttachDTO attachDto);
	public void delete(String uuid);
	public List<BoardAttachDTO> findByBno(int bno);
	
	public void deleteAll(int bno);
}
