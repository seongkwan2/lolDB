package com.lol.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lol.vo.BoardVO;
import com.lol.vo.PageVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<BoardVO> getBoardList() {
		return this.sqlSession.selectList("getBoardList");
	}

	@Override
	public int getListCount(PageVO p) {
		return this.sqlSession.selectOne("getListCount",p);
	}

	@Override
	public int writeBoard(BoardVO boardInfo) {
		return this.sqlSession.insert("writeBoard",boardInfo);
	}

	@Override
	public BoardVO getCont(long b_num) {
		return this.sqlSession.selectOne("getCont",b_num);
	}

	@Override
	public int boardDel(long b_num) {
		return this.sqlSession.delete("boardDel",b_num);
	}

	@Override
	public int boardUpdate(BoardVO boardInfo) {
		return this.sqlSession.update("boardUpdate",boardInfo);
	}

	@Override
	public void plusHits(long b_num) {
		this.sqlSession.update("plusHits",b_num);
	}
	
	
}
