package com.lol.Service;

import java.util.List;

import com.lol.vo.BoardVO;
import com.lol.vo.PageVO;

public interface BoardService {

	List<BoardVO> getBoardList();

	int getListCount(PageVO p);

	int writeBoard(BoardVO boardInfo);

	BoardVO getCont(long b_num);

	int boardDel(long b_num);

	int boardUpdate(BoardVO boardInfo);

}