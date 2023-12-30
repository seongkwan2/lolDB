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
	public int getListCount(PageVO pageInfo) {
		return this.boardDao.getListCount(pageInfo);
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
			return "추천을 했습니다.";
		}
	}

	@Override
	public int getLikesCount(long b_num) {
		return this.boardDao.getLikesCount(b_num);
	}


}
