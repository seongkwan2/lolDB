package com.lol.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lol.DAO.ReplyDAO;
import com.lol.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDAO replyDAO;

	@Override
	public List<ReplyVO> getReplyList(long b_num) {
		return this.replyDAO.getReplyList(b_num);
	}

	@Override
	public int writeReply(ReplyVO replyInfo) {
		return this.replyDAO.writeReply(replyInfo);
	}

	@Override
	public int deleteReply(long r_num) {
		return this.replyDAO.deleteReply(r_num);
	}

	@Override
	public ReplyVO getReplyByNum(long r_num) {
		return this.replyDAO.getReplyByNum(r_num);
	}

}
