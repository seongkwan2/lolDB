package com.lol.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public int getListCount() {
		return this.sqlSession.selectOne("getListCount");
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

	@Override
	public List<BoardVO> getBoardListWithReplyCount(PageVO pageInfo) {
		return this.sqlSession.selectList("getBoardListWithReplyCount",pageInfo);
	}

	@Override	//파라미터가 두개이상이면 Map형태로 만들어서 put으로 변수에 집어넣고 mybatis에 전달해야함
	public int checkLikeStatus(long b_num, String m_id) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("b_num", b_num);
	    paramMap.put("m_id", m_id);
	    return this.sqlSession.selectOne("checkLikeStatus", paramMap);
	}

	@Override
	public void addLike(long b_num, String m_id) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("b_num", b_num);
	    paramMap.put("m_id", m_id);
	    this.sqlSession.insert("addLike", paramMap);
	}

	@Override
	public void removeLike(long b_num, String m_id) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("b_num", b_num);
	    paramMap.put("m_id", m_id);
	    this.sqlSession.delete("removeLike", paramMap);
	}

	@Override
	public void upLike(long b_num) {
	    this.sqlSession.update("upLike", b_num);
	}

	@Override
	public void downLike(long b_num) {
	    this.sqlSession.update("downLike", b_num);
	}

	@Override
	public int getLikesCount(long b_num) {
		return this.sqlSession.selectOne("getLikesCount",b_num);
	}

	@Override
	public int getCountByCategory(String bCategory) {
	    return this.sqlSession.selectOne("getCountByCategory", bCategory);
	}

	@Override
	public BoardVO getBoardByNum(long b_num) {
		return this.sqlSession.selectOne("getBoardByNum",b_num);
	}

	@Override
	public List<BoardVO> getPopularByCategory(PageVO pageVO) {
		return this.sqlSession.selectList("getPopularByCategory",pageVO);
	}

	@Override
	public int getPopularCount(String selectedCategory) {
		return this.sqlSession.selectOne("getPopularCount",selectedCategory);
	}

	@Override
	public List<BoardVO> searchByTitle(String b_title, String b_category, int offset, int limit) {
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("b_title", b_title);
	    paramMap.put("b_category", b_category);
	    paramMap.put("offset", offset);
	    paramMap.put("limit", limit);
	    return this.sqlSession.selectList("searchByTitle", paramMap);
	}

	@Override
	public int countSearchResults(String b_title, String b_category) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("b_title", b_title);
	    paramMap.put("b_category", b_category);
	    return this.sqlSession.selectOne("countSearchResults", paramMap);
	}


}
