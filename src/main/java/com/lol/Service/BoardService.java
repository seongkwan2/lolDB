package com.lol.Service;

import java.util.List;

import com.lol.vo.BoardVO;
import com.lol.vo.PageVO;

public interface BoardService {

	List<BoardVO> getBoardList();
	
	int getListCount();

	int writeBoard(BoardVO boardInfo);

	BoardVO getCont(long b_num);

	int boardDel(long b_num);

	int boardUpdate(BoardVO boardInfo);

	void plusHits(long b_num);

	List<BoardVO> getBoardListWithReplyCount(PageVO pageInfo);
	
	String toggleLike(long b_num, String m_id);

	int getLikesCount(long b_num);

	int getCountByCategory(String bCategory);

	BoardVO getBoardByNum(long b_num);

	List<BoardVO> getPopularByCategory(PageVO pageVO);
	
	List<BoardVO> getPopularByCategory(String b_title, String b_category, int offset, int limit);

	int getPopularCount(String selectedCategory);

	List<BoardVO> searchByTitle(String b_title, String b_category, int offset, int limit);

	int countSearchResults(String b_title, String b_category);

	

}
