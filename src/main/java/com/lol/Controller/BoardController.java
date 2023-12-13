package com.lol.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.lol.Service.BoardService;
import com.lol.Service.MemberService;
import com.lol.vo.BoardVO;
import com.lol.vo.PageVO;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {

	//해야할것, 의존성 추가 게시판제작, 페이징, 조회수, 좋아요 처리
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;

	//보드 메인 화면
	@RequestMapping(value="/boardMain")
	public ModelAndView boardMain(HttpServletRequest request, PageVO p) {
		int page=1;
		int limit=10;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
			//페이지 번호를 정수 숫자로 변경해서 저장
		}

		/* 검색 관련 부분 */
		String find_name=request.getParameter("find_name");//검색어
		String find_field=request.getParameter("find_field");//검색 필드
		p.setFind_name("%"+find_name+"%");
		p.setFind_field(find_field);

		int listcount = this.boardService.getListCount(p); //글의 개수를 파악

		p.setStartrow((page-1)*10+1); //시작행 번호
		p.setEndrow(p.getStartrow()+limit-1); //끝행 번호

		//총 페이지수
		int maxpage=(int)((double)listcount/limit+0.95);
		//시작페이지(1,11,21 ..)
		int startpage=(((int)((double)page/10+0.9))-1)*10+1;
		//현재 페이지에 보여질 마지막 페이지(10,20 ..)
		int endpage=maxpage;
		if(endpage>startpage+10-1) endpage=startpage+10-1;

		ModelAndView mv = new ModelAndView();
		List<BoardVO> boardList = this.boardService.getBoardList();
      
		mv.addObject("boardList", boardList);
		mv.addObject("page",page);// 쪽번호
		mv.addObject("startpage",startpage);// 시작페이지
		mv.addObject("endpage",endpage);// 마지막 페이지
		mv.addObject("maxpage",maxpage);// 최대 페이지
		mv.addObject("listcount",listcount);// 검색전후 레코드 개수
		mv.addObject("find_field", find_field);// 검색 필드
		mv.addObject("find_name", find_name);// 검색어
		
		mv.setViewName("/board/boardMain");

		return mv;
	}
	
	@RequestMapping(value="/boardWrite")
	public ModelAndView boardWrite() {
		ModelAndView mv = new ModelAndView();
		
		//세션을 이용하거나 어쨌거나 , 현재 로그인 정보를 가져옴 (글쓴이를 등록하기 위함)
		//this.memberService.getMemberInfo(); 로그인 완성시 활성화 시키도록 함
		
		mv.setViewName("/board/boardWrite");
		
		return mv;
	}
	
	@RequestMapping(value="/boardWrite", method=RequestMethod.POST)
	public ModelAndView boardWrite(BoardVO boardInfo) {
		ModelAndView mv = new ModelAndView();
		
		//세션을 이용하거나 어쨌거나 , 현재 로그인 정보를 가져옴 (글쓴이를 등록하기 위함)
		//this.memberService.getMemberInfo(); 로그인 완성시 활성화 시키도록 함
		
		//글쓴것을 DB에 저장
		this.boardService.writeBoard(boardInfo);
		
		
		mv.setViewName("/board/boardWrite");
		
		return mv;
	}
}
