package com.lol.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	//게시판 메인 페이지
	@GetMapping(value="/boardMain")
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
	
	//글쓰기 폼
	@RequestMapping(value="/boardWrite")
	public String boardWrite() {
	    // 현재 로그인 정보 가져오기 로직
	    // this.memberService.getMemberInfo(); // 로그인 완성 시 활성화

	    return "/board/boardWrite";
	}
	
	//글쓰기 액션
	@RequestMapping(value="/boardWrite", method=RequestMethod.POST)
	public String boardWrite(@ModelAttribute BoardVO boardInfo, RedirectAttributes redirectAttributes) {
	    int result = this.boardService.writeBoard(boardInfo);
	    if (result == 1) {
	        redirectAttributes.addFlashAttribute("alert_message", "글 쓰기 성공!");
	        return "redirect:/board/boardMain";
	    } else {
	        redirectAttributes.addFlashAttribute("alert_message", "글 쓰기 실패!");
	        return "redirect:/board/boardWrite";
	    }
	}


	
	//글확인
	@GetMapping(value="/boardCont")
	public ModelAndView boardCont(@RequestParam("b_num") long b_num) {
		ModelAndView mv = new ModelAndView();
		
		//글번호를 기준으로 글의 정보를 가져오기
		BoardVO boardInfo = this.boardService.getCont(b_num);
		this.boardService.plusHits(b_num);	//조회수 증가
		
		mv.addObject("boardInfo", boardInfo);
		mv.setViewName("/board/boardCont");
		return mv;
	}
	
	
	//글삭제
	@GetMapping(value="/boardDel")
	public String boardDel(@RequestParam("b_num") long b_num, RedirectAttributes redirectAttributes) {
	    int result = this.boardService.boardDel(b_num);
	    if (result == 1) {
	        redirectAttributes.addFlashAttribute("alert_message", "글 삭제 성공!");
	        return "redirect:/board/boardMain";
	    } else {
	        redirectAttributes.addFlashAttribute("alert_message", "글 삭제 실패!");
	        return "redirect:/board/boardWrite";
	    }
	}
	
	//글수정 폼
	@RequestMapping(value="/boardUpdate")
	public ModelAndView boardUpdate(@RequestParam("b_num") long b_num) {
		ModelAndView mv = new ModelAndView();
		
		BoardVO boardInfo = this.boardService.getCont(b_num);
		
		mv.addObject("boardInfo", boardInfo);
		mv.setViewName("/board/boardUpdate");
		return mv;
	}
	
	
	//글수정 액션
	@RequestMapping(value="/boardUpdate",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> boardUpdate(@RequestBody BoardVO boardInfo) {
	    Map<String, String> resultMap = new HashMap<>();
	    
	    int result = this.boardService.boardUpdate(boardInfo);
	    if (result == 1) {
	        resultMap.put("result", "success");
	    } else {
	        resultMap.put("result", "fail");
	    }
	    
	    return resultMap;
	}
	


}
















