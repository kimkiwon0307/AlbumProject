package com.pet.service;

import java.util.List;

import com.pet.domain.MemberVO;


public interface MemberService {
	
	public List<MemberVO> getList(); 			// 회원 목록
	
	public void insert(MemberVO member); 	    // 회원 등록
	
	public MemberVO read(long m_pk); 		     // 회원 조회
	
	public boolean update(MemberVO member); 	// 회원 수정 
	
	public boolean delete(long m_pk); 			// 회원 삭제
	
	public int nickCheck(String m_nick);
	
	public MemberVO login(String m_id, String m_pwd);
	
}
