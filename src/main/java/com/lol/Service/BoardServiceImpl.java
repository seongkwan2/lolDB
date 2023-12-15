package com.lol.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public int getListCount(PageVO p) {
		return this.boardDao.getListCount(p);
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
}
