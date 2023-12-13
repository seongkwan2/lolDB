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
	public void writeBoard(BoardVO boardInfo) {
		this.boardDao.writeBoard(boardInfo);
	}
}
