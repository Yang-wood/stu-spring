package com.spring.study.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.study.domain.BoardAttachDTO;
import com.spring.study.domain.BoardDTO;
import com.spring.study.domain.Criteria;
import com.spring.study.mapper.BoardAttachMapper;
import com.spring.study.persistence.IBoardDAO;
import com.spring.study.service.IBoardService;

@Service
public class BoaedServiceImpl implements IBoardService {
	@Autowired
	private BoardAttachMapper attachmapper;
	
	@Autowired
	private IBoardDAO bDao;
	
	@Override
	public void register(BoardDTO bDto) throws Exception {
		bDao.create(bDto);
		
		if (bDto.getAttachList() == null || bDto.getAttachList().size() <= 0) {
			return;
		}
		
		bDto.getAttachList().forEach(attach -> {
			attach.setBno(bDto.getBno());
			attachmapper.insert(attach);
		});
	}

	@Override
	public BoardDTO read(Integer bno) throws Exception {
		return bDao.read(bno);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardDTO bDto) throws Exception {
		attachmapper.deleteAll(bDto.getBno());
		
		boolean modifyResult = bDao.update(bDto) == 1;
		
		if (modifyResult && bDto.getAttachList().size() > 0) {
			bDto.getAttachList().forEach(attach -> {
				attach.setBno(bDto.getBno());
				attachmapper.insert(attach);
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Integer bno) throws Exception {
		attachmapper.deleteAll(bno);
		return bDao.delete(bno) == 1;
	}

	@Override
	public List<BoardDTO> listAll(Criteria cri) throws Exception {
		return bDao.listAll(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return bDao.getTotalCnt(cri);
	}

	@Override
	public List<BoardAttachDTO> getAttachList(int bno) {
		return attachmapper.findByBno(bno);
	}
	
}
