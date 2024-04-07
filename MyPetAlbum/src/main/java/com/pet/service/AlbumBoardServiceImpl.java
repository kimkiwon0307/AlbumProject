package com.pet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pet.domain.AlbumAttachVO;
import com.pet.domain.AlbumBoardVO;
import com.pet.mapper.AlbumBoardAttachMapper;
import com.pet.mapper.AlbumBoardMapper;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;


@Service
@Log4j
public class AlbumBoardServiceImpl implements AlbumBoardService{
	

	private final AlbumBoardMapper mapper;
	private final AlbumBoardAttachMapper attachmapper;
	
	@Autowired
	public AlbumBoardServiceImpl(AlbumBoardMapper mapper, AlbumBoardAttachMapper attachmapper) {
		this.mapper = mapper;
		this.attachmapper = attachmapper;
	}
	
	@Override
	public List<AlbumBoardVO> getList() {
		return mapper.getList();
	}
	
	@Transactional
	@Override
	public void insert(AlbumBoardVO album) {
		log.info("앨범추가");
		mapper.insert(album);
		
		album.getAttachList().forEach(attach -> {
			attach.setA_no(album.getA_no());
			attachmapper.insert(attach);
		});
	}

	/*
	 * @Override public AlbumBoardVO read(long a_no) { log.info("앨범 조회"); return
	 * mapper.read(a_no); }
	 */
	
	@Override
	public List<AlbumBoardVO> read(long a_no) {
		return mapper.read(a_no);
	}
	
	

	@Override
	public boolean update(AlbumBoardVO album) {
		log.info("앨범 수정");
		
		return mapper.update(album)==1;
	}

	@Transactional
	@Override
	public boolean delete(long a_no) {
		
		attachmapper.attacheDelete(a_no);
		
		return mapper.delete(a_no)==1;
	}

	@Override
	public List<AlbumAttachVO> getAttachList(long a_no) {
		return attachmapper.findByAno(a_no);
	}



}
