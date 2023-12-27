package com.lol.DAO;

import java.util.List;

import com.lol.vo.ReplyVO;

public interface ReplyDAO {

	List<ReplyVO> getReplyList(long b_num);

}
