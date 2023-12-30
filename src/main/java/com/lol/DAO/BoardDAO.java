package com.lol.DAO;

import java.util.List;

import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.data.domain.Page;

import com.lol.vo.BoardVO;
import com.lol.vo.PageVO;

public interface BoardDAO {

	List<BoardVO> getBoardList();

	int getListCount(PageVO pageInfo);

	int writeBoard(BoardVO boardInfo);

	BoardVO getCont(long b_num);

	int boardDel(long b_num);

	int boardUpdate(BoardVO boardInfo);

	void plusHits(long b_num);

	List<BoardVO> getBoardListWithReplyCount();
	
	List<BoardVO> getBoardListPaging(PageVO page);

	int checkLikeStatus(long b_num, String m_id);

	void removeLike(long b_num, String m_id);

	void addLike(long b_num, String m_id);

	void upLike(long b_num);

	void downLike(long b_num);

	int getLikesCount(long b_num);

}
