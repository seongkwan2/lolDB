package com.lol.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lol.Service.BoardService;
import com.lol.Service.MemberService;
import com.lol.Service.ReplyService;
import com.lol.vo.BoardVO;
import com.lol.vo.MemberVO;
import com.lol.vo.PageVO;
import com.lol.vo.ReplyVO;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReplyService replyService;


	//게시판 메인 페이지
	@GetMapping(value="/boardMain")
	public ModelAndView boardMain(HttpServletRequest request, PageVO p, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		//로그인 정보 가져오기
		MemberVO memberInfo =  (MemberVO) session.getAttribute("loginInfo");
		mv.addObject("memberInfo", memberInfo);

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

		//모든 게시글과, 해당게시글의 댓글수를 가져옴
		List<BoardVO> boardList = this.boardService.getBoardListWithReplyCount();

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
	public String boardWrite(HttpSession session, Model model, RedirectAttributes redirectAttributes) {

		//현재 로그인 정보를 세션을 통해서 가져옴
		MemberVO memberInfo =  (MemberVO) session.getAttribute("loginInfo");
		if(memberInfo == null) {
			redirectAttributes.addFlashAttribute("message", "로그인후 이용해주세요!");
			return "redirect:/member/login";
		}

		model.addAttribute("memberInfo", memberInfo);
		return "/board/boardWrite";
	}

	//글쓰기 액션
	@RequestMapping(value="/boardWrite", method=RequestMethod.POST)
	public String boardWrite(@ModelAttribute BoardVO boardInfo, RedirectAttributes redirectAttributes, HttpSession session) {
		//현재 로그인 정보를 세션을 통해서 가져옴
		MemberVO memberInfo =  (MemberVO) session.getAttribute("loginInfo");
		if(memberInfo == null) {
			redirectAttributes.addFlashAttribute("message", "로그인후 이용해주세요!");
			return "/member/login";
		}

		int result = this.boardService.writeBoard(boardInfo);
		if (result == 1) {
			redirectAttributes.addFlashAttribute("message", "글 쓰기 성공!");
			return "redirect:/board/boardMain";
		} else {
			redirectAttributes.addFlashAttribute("message", "글 쓰기 실패!");
			return "redirect:/board/boardWrite";
		}
	}

	//댓글 작성 액션
	@PostMapping(value="/writeReply")
	public String writeReply(@ModelAttribute ReplyVO replyInfo, 
			RedirectAttributes redirectAttributes, HttpSession session) {
		
		//현재 로그인 정보를 세션을 통해서 가져옴
		MemberVO memberInfo =  (MemberVO) session.getAttribute("loginInfo");
		if(memberInfo == null) {
			redirectAttributes.addFlashAttribute("message", "로그인후 이용해주세요!");
			return "redirect:/member/login";
		}
		int result = this.replyService.writeReply(replyInfo);
		if (result == 1) {
			redirectAttributes.addFlashAttribute("message", "댓글 쓰기 성공!");
			return "redirect:/board/boardCont?b_num=" + replyInfo.getR_board_num(); // 게시글 번호를 URL에 포함
		} else {
			redirectAttributes.addFlashAttribute("message", "댓글 쓰기 실패!");
			return "redirect:/board/boardWrite";
		}
	}

	//글확인
	@GetMapping(value="/boardCont")
	public ModelAndView boardCont(@RequestParam("b_num") long b_num, HttpSession session) {
	    ModelAndView mv = new ModelAndView();

	    // 현재 로그인 정보를 세션에서 가져옴
	    MemberVO memberInfo = (MemberVO) session.getAttribute("loginInfo");
	    mv.addObject("memberInfo", memberInfo);

	    // 조회수 증가
	    this.boardService.plusHits(b_num);

	    // 글번호를 기준으로 글의 정보를 가져오기  //StringEscapeUtils을 사용해서 HTML태그와 같은것들도 제대로 출력가능하게 만듬
	    BoardVO boardInfo = this.boardService.getCont(b_num);
	    String safeContent = StringEscapeUtils.escapeHtml4(boardInfo.getB_cont());
	    String formattedContent = safeContent.replace("\n", "<br>");
	    boardInfo.setB_cont(formattedContent);
	    mv.addObject("boardInfo", boardInfo);

	    // 댓글 리스트 가져오기
	    List<ReplyVO> replyList = this.replyService.getReplyList(b_num);
	    for (ReplyVO reply : replyList) {
	        String safeReplyContent = StringEscapeUtils.escapeHtml4(reply.getR_cont());
	        String formattedReplyContent = safeReplyContent.replace("\n", "<br>");
	        reply.setR_cont(formattedReplyContent);
	    }
	    mv.addObject("replyList", replyList);

	    mv.setViewName("/board/boardCont");
	    return mv;
	}


	//글삭제
	@PostMapping(value="/boardDel")
	public String boardDel(@RequestParam("b_num") long b_num, RedirectAttributes redirectAttributes) {
		int result = this.boardService.boardDel(b_num);
		if (result == 1) {
			redirectAttributes.addFlashAttribute("message", "글 삭제 성공!");
			return "redirect:/board/boardMain";
		} else {
			redirectAttributes.addFlashAttribute("message", "글 삭제 실패!");
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
