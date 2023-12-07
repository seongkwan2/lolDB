package com.lol.Service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lol.DAO.MemberDAO;
import com.lol.vo.MemberVO;
import com.lol.Service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDao;

	@Override
	public void signTest(MemberVO memberInfo) {
		this.memberDao.signTest(memberInfo);
	}

}
