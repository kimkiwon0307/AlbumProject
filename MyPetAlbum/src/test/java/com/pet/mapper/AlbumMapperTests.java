package com.pet.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pet.domain.AlbumBoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AlbumMapperTests {

	@Autowired
	private AlbumBoardMapper albumBoardMapper;
	
	
	@Test
	public void ListTests() {
		
		albumBoardMapper.getList().forEach(album -> log.info(album));
	
	}
	
	@Test
	public void insertTests() {
		
		AlbumBoardVO album = new AlbumBoardVO();
		
		album.setA_title("새로운 제목");
		album.setA_content("새로운 내용");
		album.setA_writer("새로운 작성자");
		
		albumBoardMapper.insert(album);
		
		log.info(album);
	}
	
	@Test
	public void readTests() {
		log.info("조회 테스트 : " + albumBoardMapper.read(3L));
	}

	/*
	 * @Test public void updateTest() {
	 * 
	 * AlbumBoardVO album = albumBoardMapper.read(3L);
	 * 
	 * album.setA_title("수정 제목"); album.setA_content("수정 내용");
	 * album.setA_writer("수정 작성자");
	 * 
	 * albumBoardMapper.update(album);
	 * 
	 * log.info("수정 테스트 : " + albumBoardMapper.read(3L)); }
	 */
	@Test
	public void deleteTest() {
		log.info(albumBoardMapper.delete(2L));
	}
}
