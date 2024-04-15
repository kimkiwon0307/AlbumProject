package com.pet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pet.domain.Criteria;
import com.pet.domain.FreeBoardVO;
import com.pet.domain.MemberVO;
import com.pet.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper;
	
	@Autowired
	public MemberServiceImpl(MemberMapper mapper) {
		this.mapper = mapper;
	}

	@Override
	public List<MemberVO> getList() {
		return mapper.getList();
	}

	@Override
	public void insert(MemberVO member) {
		mapper.insert(member);
	}

	@Override
	public MemberVO read(long m_pk) {
		return mapper.read(m_pk);
	}

	@Override
	public boolean update(MemberVO member) {
		return mapper.update(member)==1;
	}

	@Override
	public boolean delete(long m_pk) {
		return mapper.delete(m_pk)==1;
	}

	@Override
	public int nickCheck(String m_nick) {
		return mapper.nickCheck(m_nick);
	}

	@Override
	public MemberVO login(String m_id, String m_pwd) {
		return mapper.Login(m_id, m_pwd);
	}

	@Override
	public MemberVO idCheck(String m_id) {
		return mapper.idCheck(m_id);
	}



}
