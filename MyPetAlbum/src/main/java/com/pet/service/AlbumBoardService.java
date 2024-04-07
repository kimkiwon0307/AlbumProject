package com.pet.service;

import java.util.List;

import com.pet.domain.AlbumAttachVO;
import com.pet.domain.AlbumBoardVO;


public interface AlbumBoardService {
	
	public List<AlbumBoardVO> getList(); 			// 앨범 목록
	
	public void insert(AlbumBoardVO album); 		// 앨범 등록
	
	//public AlbumBoardVO read(long a_no); 			// 앨범 조회
	
	public List<AlbumBoardVO> read(long a_no);
	
	public boolean update(AlbumBoardVO album); 			// 앨범 수정 
	
	public boolean delete(long a_no); 					// 앨범 삭제
	
	public List<AlbumAttachVO> getAttachList(long a_no); 
}
