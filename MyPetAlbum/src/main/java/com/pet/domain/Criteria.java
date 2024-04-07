package com.pet.domain;

import lombok.Data;

@Data
public class Criteria {

	private int pageNum; // 현재페이지
	private int amount;  // 페이지당 게시글 갯수
	
	public Criteria() {
		this(1,15);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
