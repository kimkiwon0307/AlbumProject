package com.pet.mapper;

import java.util.List;

import com.pet.domain.AlbumBoardVO;


public interface AlbumBoardMapper {
		
	public List<AlbumBoardVO> getList(); 			// 앨범 목록
	
	public void insert(AlbumBoardVO album); 		// 앨범 등록
	
	//public AlbumBoardVO read(long a_no);          // 앨범 조회
	
	public List<AlbumBoardVO> read(long a_no);
	
	public int update(AlbumBoardVO album); 			// 앨범 수정 
	
	public int delete(long a_no); 					// 앨범 삭제
	
	
}
