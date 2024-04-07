package com.pet.domain;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class FreeBoardVO {
	
	private long f_no;	   	   //게시글 번호
	
	@NotEmpty(message = "제목을 입력하세요.")
	private String f_title;    //게시글 제목
	
	@Size(min = 5, max = 100, message = "내용은 5자 이상 100자 이하로 입력하세요")
	private String f_content;  //게시글 내용
	
	@NotEmpty(message = "작성자를 입력하세요.")
	private String f_writer;   //게시글 작성자
	
	private Date f_date;       //게시글 날짜
	private Date f_udate;      //게시글 수정날짜
	private int f_like;        //게시글 좋아요
	private int f_count;       //게시글 조회수 
	
}
