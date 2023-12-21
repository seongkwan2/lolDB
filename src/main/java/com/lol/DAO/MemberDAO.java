package com.lol.DAO;

import com.lol.vo.MemberVO;

public interface MemberDAO {

	MemberVO findMemberId(String m_id);

	void insertMember(MemberVO memberInfo);

	void insertMemberRole(MemberVO memberInfo);

}
