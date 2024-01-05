package com.lol.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lol.DAO.BoardDAO;
import com.lol.vo.BoardVO;
import com.lol.vo.PageVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardDao;

	@Override
	public List<BoardVO> getBoardList() {
		return this.boardDao.getBoardList();
	}

	@Override
	public int getListCount() {
		return this.boardDao.getListCount();
	}

	@Override
	public int writeBoard(BoardVO boardInfo) {
		return this.boardDao.writeBoard(boardInfo);
	}

	@Override
	public BoardVO getCont(long b_num) {
		return this.boardDao.getCont(b_num);
	}

	@Override
	public int boardDel(long b_num) {
		return this.boardDao.boardDel(b_num);
	}

	@Override
	public int boardUpdate(BoardVO boardInfo) {
		return this.boardDao.boardUpdate(boardInfo);
	}

	@Override
	public void plusHits(long b_num) {
		this.boardDao.plusHits(b_num);
	}

	@Override
	public List<BoardVO> getBoardListWithReplyCount(PageVO pageInfo) {
		return this.boardDao.getBoardListWithReplyCount(pageInfo);
	}

	@Transactional
	@Override
	public String toggleLike(long b_num, String m_id) {
		int likeStatus = this.boardDao.checkLikeStatus(b_num, m_id);
		if (likeStatus > 0) {
			this.boardDao.removeLike(b_num, m_id);
			this. boardDao.downLike(b_num);
			return "추천을 취소했습니다.";
		} else {
			this.boardDao.addLike(b_num, m_id);
			this.boardDao.upLike(b_num);
			return "해당 게시글을 추천합니다.";
		}
	}

	@Override
	public int getLikesCount(long b_num) {
		return this.boardDao.getLikesCount(b_num);
	}

	@Override
	public int getCountByCategory(String bCategory) {
		return this.boardDao.getCountByCategory(bCategory);
	}

	@Override
	public BoardVO getBoardByNum(long b_num) {
		return this.boardDao.getBoardByNum(b_num);
	}

	@Override
	public List<BoardVO> getPopularByCategory(PageVO pageVO) {
		return this.boardDao.getPopularByCategory(pageVO);
	}

	@Override
	public int getPopularCount(String selectedCategory) {
		return this.boardDao.getPopularCount(selectedCategory);
	}

	@Override
	public List<BoardVO> searchByTitle(String b_title, String b_category, int offset, int limit) {
		return this.boardDao.searchByTitle(b_title, b_category, offset, limit);
	}

	@Override
	public int countSearchResults(String b_title, String b_category) {
		return this.boardDao.countSearchResults(b_title, b_category);
	}

	@Override
	public List<BoardVO> getPopularByCategory(String b_title, String b_category, int offset, int limit) {
		return this.boardDao.getPopularByCategory(b_title,b_category, offset, limit);
	}


}
