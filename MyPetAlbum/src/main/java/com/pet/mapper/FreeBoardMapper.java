package com.pet.mapper;

import java.util.List;

import com.pet.domain.Criteria;
import com.pet.domain.FreeBoardVO;


public interface FreeBoardMapper {
		
	public List<FreeBoardVO> getList(); 			// 자유게시판 목록
	
	public List<FreeBoardVO> getListWithPaging(Criteria cri); // 자유게시판 목록(페이징포함)
	
	public void insert(FreeBoardVO free); 			// 게시글 등록
	
	public FreeBoardVO read(long f_no); 			// 게시글 조회
	
	public int update(FreeBoardVO free); 			// 게시글 수정 
	
	public int delete(long f_no); 					// 게시글 삭제
	
	public int getTotalCount(Criteria cri); 
	
	public void count(long f_no);

	public void like(long f_no);
}
