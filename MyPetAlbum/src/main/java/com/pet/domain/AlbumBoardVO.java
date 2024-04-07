package com.pet.domain;

import java.util.Date;
import java.util.List;

import javax.inject.Named;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;


@Data
public class AlbumBoardVO {
			
	private Long a_no;	    // 게시글 앨범 번호
	
	@NotEmpty(message="제목을 입력하세요")
	private String a_title; 	// 게시글 앨범 제목
	
    @Size(min = 5, max = 100, message = "내용은 5자 이상 100자 이하로 입력하세요")
	private String a_content;   // 게시글 앨범 내용
	
	@NotEmpty(message="작성자를 입력하세요")
    private String a_writer;    // 게시글 앨범 작성자
	private Date   a_date;      // 게시글 앨범 작성날짜
	private Date   a_udate;     // 게시글 앨범 작성수정날짜
	
	@NotEmpty(message="이미지를 입력하세요")
	private List<AlbumAttachVO> attachList; // 앨범 이미지 파일
	
}
