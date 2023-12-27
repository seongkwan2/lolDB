package com.lol.Service;

import java.util.List;

import com.lol.vo.ReplyVO;

public interface ReplyService {

	List<ReplyVO> getReplyList(long b_num);

}
