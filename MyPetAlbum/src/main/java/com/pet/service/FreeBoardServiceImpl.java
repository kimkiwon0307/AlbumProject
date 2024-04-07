package com.pet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pet.domain.Criteria;
import com.pet.domain.FreeBoardVO;
import com.pet.mapper.AlbumBoardMapper;
import com.pet.mapper.FreeBoardMapper;
import com.pet.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	private final FreeBoardMapper mapper;
	private final ReplyMapper  rMapper;
	
	@Autowired
	public FreeBoardServiceImpl(FreeBoardMapper mapper, ReplyMapper rMapper) {
		this.mapper = mapper;
		this.rMapper = rMapper;
	}
	
/**
	@Override
	public List<FreeBoardVO> getList() {
		return mapper.getList();
	}
*/	

	@Override
	public List<FreeBoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	

	@Override
	public void insert(FreeBoardVO free) {
		mapper.insert(free);
	}

	@Override
	public FreeBoardVO read(long f_no) {
		return mapper.read(f_no);
	}

	@Override
	public boolean update(FreeBoardVO free) {
		return mapper.update(free) == 1;
	}
	
	@Transactional
	@Override
	public boolean delete(long f_no) {
		
		rMapper.Adelete(f_no);
		
		return mapper.delete(f_no) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}


	// 조회수
	@Override
	public void count(long f_no) {
		mapper.count(f_no);
	}
	
	// 좋아요
	@Override
	public void like(long f_no) {
		mapper.like(f_no);
	}

}
