package com.pet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pet.domain.AlbumBoardVO;
import com.pet.domain.MemberVO;


public interface MemberMapper {
		
	public List<MemberVO> getList(); 			// 회원 목록
	
	public void insert(MemberVO member); 		// 회원 등록
	
	public MemberVO read(long m_no);            // 회원 조회
	
	public int update(MemberVO mebmer); 		// 회원 수정 
	
	public int delete(long m_no); 				// 회원 삭제
	
	// 닉네임 중복검사
	public int nickCheck(String m_nick);
	
	// 로그인
	public MemberVO Login(@Param("m_id")String m_id, @Param("m_pwd")String m_pwd);

	
}
