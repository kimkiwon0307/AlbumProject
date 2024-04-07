package com.pet.service;

import java.util.List;

import com.pet.domain.Criteria;
import com.pet.domain.ReplyVO;


public interface ReplyService {
	
	public int register(ReplyVO reply);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO reply);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long f_no);
	
}
