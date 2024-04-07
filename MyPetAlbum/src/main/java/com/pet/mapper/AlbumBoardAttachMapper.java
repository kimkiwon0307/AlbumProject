package com.pet.mapper;

import java.util.List;

import com.pet.domain.AlbumAttachVO;



public interface AlbumBoardAttachMapper {
		
	public void insert(AlbumAttachVO vo);
	
	public void delete(String uuid);
	
	public List<AlbumAttachVO> findByAno(Long a_no);
	
	public void attacheDelete(Long a_no);
	
}
