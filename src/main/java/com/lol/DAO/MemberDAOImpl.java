package com.lol.DAO;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lol.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);

	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberVO findMemberId(String m_id) {
		return this.sqlSession.selectOne("findMemberId",m_id);
	}

    @Override
    public void insertMember(MemberVO memberInfo) {
        logger.info("회원 정보 삽입 전 m_num: {}", memberInfo.getM_num());
        this.sqlSession.insert("insertMember", memberInfo);
        logger.info("회원 정보 삽입 후 m_num: {}", memberInfo.getM_num());
    }

	@Override
	public void insertMemberRole(MemberVO memberInfo) {
		logger.info("권한 부여 전 m_num: {}", memberInfo.getM_num());
		this.sqlSession.insert("insertMemberRole",memberInfo);
	}
	
}
