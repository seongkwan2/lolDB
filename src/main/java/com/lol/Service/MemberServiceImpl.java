package com.lol.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lol.DAO.MemberDAO;
import com.lol.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDao;

	@Override
	public MemberVO findMemberId(String m_id) {
		return this.memberDao.findMemberId(m_id);
	}

    @Transactional
    @Override
    public void registerMember(MemberVO memberInfo) {
        memberDao.insertMember(memberInfo); // 회원 정보 저장
        memberDao.insertMemberRole(memberInfo); // 회원 권한 지정
    }



}
