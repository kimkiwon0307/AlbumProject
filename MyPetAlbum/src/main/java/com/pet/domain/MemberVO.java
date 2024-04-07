package com.pet.domain;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class MemberVO {
	
	private Long m_pk;       // 멤버 고유번호
 	
	@NotBlank(message ="아이디를 입력하세요.")
	private String m_id;     // 멤버 아이디
	
	@NotEmpty(message = "비밀번호를 입력하세요.")
	private String m_pwd;    // 멤버 패스워드
	
	@NotEmpty(message = "이메일을 입력하세요.")
	private String m_email;  // 멤버 이메일
	private Date m_date;     // 멤버 가입날짜
	private Date m_udate;    // 멤버 수정날짜
	private int m_admin;    // 멤버 관리자 여부 0:일반회원 / 1:관리자
}
