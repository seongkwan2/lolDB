package com.lol.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lol.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReplyVO> getReplyList(long b_num) {
		return this.sqlSession.selectList("getReplyList",b_num);
	}

	@Override
	public int writeReply(ReplyVO replyInfo) {
		return this.sqlSession.insert("writeReply",replyInfo);
	}

	@Override
	public int deleteReply(long r_num) {
		return this.sqlSession.delete("deleteReply",r_num);
	}

	@Override
	public ReplyVO getReplyByNum(long r_num) {
		return this.sqlSession.selectOne("getReplyByNum",r_num);
	}
	
}
