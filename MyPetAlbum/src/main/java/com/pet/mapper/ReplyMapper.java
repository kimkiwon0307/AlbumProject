package com.pet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pet.domain.Criteria;
import com.pet.domain.ReplyVO;


public interface ReplyMapper {
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long f_no);
	
	public int delete(Long rno);
	
	public int Adelete(Long f_no);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("f_no") Long f_no);
	
}
