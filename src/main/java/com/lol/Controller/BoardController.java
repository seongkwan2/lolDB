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
	@GetMapping("/boardMain")
	public ModelAndView boardMain(@RequestParam(value = "page", defaultValue = "1") int page,
	                              @RequestParam(value = "b_category", required = false) String bCategory, // 카테고리 파라미터 추가
	                              PageVO pageVO, HttpSession session, HttpServletRequest request) {
	    ModelAndView mv = new ModelAndView();

	    // 로그인 정보 가져오기
	    MemberVO memberInfo = (MemberVO) session.getAttribute("loginInfo");
	    mv.addObject("memberInfo", memberInfo);

	 // 세션에서 선택한 카테고리 읽어오기
	    String selectedCategory = (String) session.getAttribute("selectedCategory");
	    if (selectedCategory == null) {
	        selectedCategory = "자유게시판"; // 기본값으로 자유게시판 설정
	    }

	    // 카테고리 파라미터가 제공되면 선택한 카테고리를 사용하고, 그렇지 않으면 세션에서 읽어온 카테고리를 사용합니다.
	    if (bCategory != null) {
	        // 카테고리 파라미터가 제공되면 해당 카테고리로 변경
	        selectedCategory = bCategory;
	        // 선택한 카테고리를 세션에 다시 저장 (다른 페이지에서도 사용하기 위함)
	        session.setAttribute("selectedCategory", selectedCategory);
	    }

	    pageVO.setB_category(selectedCategory);
	    int listCount = this.boardService.getCountByCategory(selectedCategory);

	    // 페이징 처리
	    int limit = 10;
	    int offset = (page - 1) * limit;
	    pageVO.setOffset(offset);
	    pageVO.setLimit(limit);

	    // 총 페이지 수 계산
	    int maxpage = (int) Math.ceil((double) listCount / limit);
	    int startpage = ((page - 1) / 10) * 10 + 1;
	    int endpage = Math.min(startpage + 9, maxpage);

	    // 해당 카테고리의 게시판 목록 가져오기
	    List<BoardVO> boardList = this.boardService.getBoardListWithReplyCount(pageVO);

	    // 뷰 설정
	    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
	        mv.setViewName("/board/boardList"); // AJAX 요청인 경우 boardList.jsp만 반환 (카테고리 선택시)
	    } else {
	        mv.setViewName("/board/boardMain"); // 전체 페이지 반환
	    }

	    // 모델에 데이터 추가
	    mv.addObject("boardList", boardList);
	    mv.addObject("page", page);
	    mv.addObject("startpage", startpage);
	    mv.addObject("endpage", endpage);
	    mv.addObject("maxpage", maxpage);
	    mv.addObject("bCategory", selectedCategory); // 현재 선택된 카테고리

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
			return "redirect:/member/login";
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
			//redirectAttributes.addFlashAttribute("message", "댓글 쓰기 성공!");
			return "redirect:/board/boardCont?b_num=" + replyInfo.getR_board_num(); // 게시글 번호를 URL에 포함
		} else {
			//redirectAttributes.addFlashAttribute("message", "댓글 쓰기 실패!");
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
		String formattedContent = safeContent.replace("\n", "<br>");	//글 줄바꿈처리 적용
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
			redirectAttributes.addFlashAttribute("message", "해당 글이 삭제되었습니다!");
			return "redirect:/board/boardMain";
		} else {
			redirectAttributes.addFlashAttribute("message", "해당 글을 삭제에 실패했습니다.");
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

	//추천액션
	@PostMapping("/likesUp")
	@ResponseBody
	public Map<String, Object> likesUp(@RequestParam("b_num") long b_num, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
		MemberVO memberInfo = (MemberVO) session.getAttribute("loginInfo");

		if (memberInfo == null) {
			resultMap.put("status", "fail");
			resultMap.put("message", "로그인 후 이용해주세요!");
			return resultMap;
		}
		//추천 검증(추천을 했는지 안했는지 확인하고 여부에따라 추천,취소하는 메서드)
		String result = this.boardService.toggleLike(b_num, memberInfo.getM_id());

		//비동기식 ajax를 적용하기위해 추천수를 가져와서 resultMap에 추가
		int LikesCount = boardService.getLikesCount(b_num);
		resultMap.put("LikesCount", LikesCount);

		resultMap.put("status", "success");
		resultMap.put("message", result);
		return resultMap;
	}


}
