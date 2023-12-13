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
	public void writeBoard(BoardVO boardInfo) {
		this.sqlSession.insert("boardInfo",boardInfo);
	}
	
	
}
