package com.lol.Service;

import com.lol.vo.MemberVO;

public interface MemberService {

	MemberVO findMemberId(String m_id);

	//회원가입
	void registerMember(MemberVO memberInfo);

}
