package com.lol.Service;

import java.util.List;

import com.lol.vo.BoardVO;
import com.lol.vo.PageVO;

public interface BoardService {

	List<BoardVO> getBoardList();
	
	int getListCount(PageVO pageInfo);

	int writeBoard(BoardVO boardInfo);

	BoardVO getCont(long b_num);

	int boardDel(long b_num);

	int boardUpdate(BoardVO boardInfo);

	void plusHits(long b_num);

	List<BoardVO> getBoardListWithReplyCount(PageVO pageInfo);
	
	String toggleLike(long b_num, String m_id);

	int getLikesCount(long b_num);
}
