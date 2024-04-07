package com.pet.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pet.domain.Criteria;
import com.pet.domain.FreeBoardVO;


public interface FreeBoardService {
	
	//public List<FreeBoardVO> getList(); 				// 자유게시판 목록
	
	public List<FreeBoardVO> getList(Criteria cri);  // 자유게시판 페이징
	
	public void insert(FreeBoardVO free); 			// 자유게시판 등록
	
	public FreeBoardVO read(long f_no); 				// 자유게시판 조회
	
	public boolean update(FreeBoardVO free); 			// 자유게시판 수정 
	
	public boolean delete(long f_no); 					// 자유게시판 삭제
	
	public int getTotal(Criteria cri);
	
	public void count(long f_no);
	
	public void like(long f_no);
}
