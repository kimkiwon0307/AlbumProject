package com.pet.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pet.domain.FreeBoardVO;

import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FreeMapperTests {

	@Autowired
	private FreeBoardMapper FreeBoardFpper;
	
	
	@Test
	public void ListTests() {
		FreeBoardFpper.getList().forEach(free -> log.info(free));
	}

	@Test
	public void insertTests() {
		
		FreeBoardVO free = new FreeBoardVO();
		
		free.setF_title("새로운 제목");
		free.setF_content("새로운 내용");
		free.setF_writer("새로운 작성자");
		
		FreeBoardFpper.insert(free);
		
		log.info(free);
	}

	@Test
	public void reFdTests() {
		log.info("조회 테스트 : " + FreeBoardFpper.read(1L));
	}

	@Test
	public void updFteTest() {
		
		FreeBoardVO free = FreeBoardFpper.read(1L);
		
		free.setF_title("수정 제목");
		free.setF_content("수정 내용");
		free.setF_writer("수정 작성자");
		
		FreeBoardFpper.update(free);
		
		log.info("수정 테스트 : " + FreeBoardFpper.read(1L));
	}
	
	@Test
	public void deleteTest() {
		log.info(FreeBoardFpper.delete(2L));
	}

}
