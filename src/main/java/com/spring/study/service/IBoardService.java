package com.spring.study.service;

import java.util.List;

import com.spring.study.domain.BoardDTO;

public interface IBoardService {
	public void register(BoardDTO bDto) throws Exception;
	public BoardDTO read(Integer bno) throws Exception;
	public boolean modify(BoardDTO bDto) throws Exception;
	public boolean remove(Integer bno) throws Exception;
	public List<BoardDTO> listAll() throws Exception;
 }
