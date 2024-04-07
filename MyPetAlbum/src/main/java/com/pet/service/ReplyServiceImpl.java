package com.pet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.domain.Criteria;
import com.pet.domain.FreeBoardVO;
import com.pet.domain.ReplyVO;
import com.pet.mapper.AlbumBoardMapper;
import com.pet.mapper.FreeBoardMapper;
import com.pet.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	private final ReplyMapper mapper;
	
	@Autowired
	public ReplyServiceImpl(ReplyMapper mapper) {
		this.mapper = mapper;
	}

	@Override
	public int register(ReplyVO reply) {
		return mapper.insert(reply);
	}

	@Override
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO reply) {
		return mapper.update(reply);
	}

	@Override
	public int remove(Long rno) {
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long f_no) {
		return mapper.getListWithPaging(cri, f_no);
	}
	

}
