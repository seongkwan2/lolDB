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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lol.Service.BoardService;
import com.lol.Service.MemberService;
import com.lol.Service.ReplyService;
import com.lol.vo.BoardDetailsVO;
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

	//게시판 메인화면
	@GetMapping("/boardMain")
	public ModelAndView boardMain(
	    @RequestParam(value = "b_title", required = false) String b_title,
	    @RequestParam(value = "b_category", required = false) String b_category,
	    @RequestParam(value = "page", defaultValue = "1") int page,
	    @RequestParam(value = "viewMode", defaultValue = "all") String viewMode,
	    HttpSession session, HttpServletRequest request) {
		
		// 세션을 통해 로그인 정보를 가져옴
		MemberVO loginInfo = (MemberVO) session.getAttribute("loginInfo");

	    ModelAndView mv = new ModelAndView();

	    // 세션에서 카테고리 확인, 없으면 기본값 설정 (게시판을 맨 처음 열었을땐 자유게시판 지정)
	    String selectedCategory = (String) session.getAttribute("selectedCategory");
	    if (selectedCategory == null) {
	        selectedCategory = "자유게시판";
	        session.setAttribute("selectedCategory", selectedCategory);
	    }

	    if (b_category != null && !b_category.isEmpty()) {
	        selectedCategory = b_category;
	        session.setAttribute("selectedCategory", selectedCategory);
	    }

	    // 페이지 처리
	    PageVO pageVO = new PageVO();
	    pageVO.setB_category(selectedCategory);
	    int limit = 10;
	    int offset = (page - 1) * limit;
	    pageVO.setOffset(offset);
	    pageVO.setLimit(limit);

	    int listCount;
	    List<BoardVO> boardList;

	   
	    //JSP에서 추천글과 전체글중 라디오버튼으로 선택된 게시글 가져오기
	     if ("popular".equals(viewMode)) {
	        // 추천글 처리
	        boardList = boardService.getPopularByCategory(pageVO);
	        listCount = this.boardService.getPopularCount(selectedCategory);
	    } else {
	        // 전체글 처리
	        boardList = boardService.getBoardListWithReplyCount(pageVO);
	        listCount = this.boardService.getCountByCategory(selectedCategory);
	    }

	    // 페이징 정보
	    int maxpage = (int) Math.ceil((double) listCount / limit);
	    int startpage = ((page - 1) / 10) * 10 + 1;
	    int endpage = Math.min(startpage + 9, maxpage);

	    mv.addObject("loginInfo", loginInfo);
	    mv.addObject("page", page);
	    mv.addObject("startpage", startpage);
	    mv.addObject("endpage", endpage);
	    mv.addObject("maxpage", maxpage);
	    mv.addObject("bCategory", selectedCategory);
	    mv.addObject("viewMode", viewMode);
	    mv.addObject("b_title", b_title);
	    mv.addObject("b_category", b_category);
	    mv.addObject("boardList", boardList);

	    // 뷰 결정
	    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
	        mv.setViewName("/board/boardList");
	    } else {
	        mv.setViewName("/board/boardMain");
	    }

	    return mv;
	}
	
	//검색 액션
	@GetMapping("/boardSearch")
	public ModelAndView boardSearch(
	    @RequestParam(value = "b_title", required = false) String b_title,
	    @RequestParam(value = "b_category", required = false) String b_category,
	    @RequestParam(value = "page", defaultValue = "1") int page,
	    HttpSession session) {

	    ModelAndView mv = new ModelAndView();

	    // 세션에서 카테고리 확인, 없으면 기본값 설정
	    String selectedCategory = (String) session.getAttribute("selectedCategory");
	    if (selectedCategory == null) {
	        selectedCategory = "자유게시판";
	        session.setAttribute("selectedCategory", selectedCategory);
	    }

	    if (b_category != null && !b_category.isEmpty()) {
	        selectedCategory = b_category;
	        session.setAttribute("selectedCategory", selectedCategory);
	    }

	    // 검색 조건을 세션에 저장
	    if (b_title != null && !b_title.isEmpty()) {
	        session.setAttribute("searchTitle", b_title);
	    } else {
	        session.removeAttribute("searchTitle");
	    }
	    if (b_category != null && !b_category.isEmpty()) {
	        session.setAttribute("searchCategory", b_category);
	    } else {
	        session.removeAttribute("searchCategory");
	    }

	    // 페이지 처리
	    PageVO pageVO = new PageVO();
	    pageVO.setB_category(selectedCategory);
	    int limit = 10;
	    int offset = (page - 1) * limit;
	    pageVO.setOffset(offset);
	    pageVO.setLimit(limit);

	    // 검색 결과 처리
	    List<BoardVO> boardList = boardService.searchByTitle(b_title, b_category, offset, limit);
	    int listCount = boardService.countSearchResults(b_title, b_category);

	    // 페이징 정보
	    int maxpage = (int) Math.ceil((double) listCount / limit);
	    int startpage = ((page - 1) / 10) * 10 + 1;
	    int endpage = Math.min(startpage + 9, maxpage);

	    mv.addObject("page", page);
	    mv.addObject("startpage", startpage);
	    mv.addObject("endpage", endpage);
	    mv.addObject("maxpage", maxpage);
	    mv.addObject("bCategory", selectedCategory);
	    mv.addObject("b_title", b_title);
	    mv.addObject("b_category", b_category);
	    mv.addObject("boardList", boardList);
	    mv.addObject("listCount", listCount);

	    mv.setViewName("/board/boardSearch");

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
	public String boardWrite(@ModelAttribute BoardVO boardInfo,
	                         RedirectAttributes redirectAttributes, 
	                         HttpSession session) throws Exception {
	    MemberVO memberInfo = (MemberVO) session.getAttribute("loginInfo");
	    if (memberInfo == null) {
	        redirectAttributes.addFlashAttribute("message", "로그인후 이용해주세요!");
	        return "redirect:/member/login";
	    }
	    
	    boardService.writeBoard(boardInfo, boardInfo.getB_file());
	    
	    return "redirect:/board/boardMain";
	}


	//글확인
	@GetMapping(value="/boardCont")
	public ModelAndView boardCont(@RequestParam("b_num") long b_num, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		BoardDetailsVO boardInfo = boardService.getCont(b_num);
		
		// 현재 로그인 정보를 세션에서 가져옴
		MemberVO memberInfo = (MemberVO) session.getAttribute("loginInfo");
		mv.addObject("memberInfo", memberInfo);

		// 조회수 증가
		this.boardService.plusHits(b_num);

		// 글번호를 기준으로 글의 정보를 가져오기  //StringEscapeUtils을 사용해서 HTML태그와 같은것들도 제대로 출력가능하게 만듬
		String safeContent = StringEscapeUtils.escapeHtml4(boardInfo.getBoardInfo().getB_cont());
		String formattedContent = safeContent.replace("\n", "<br>");	//글 줄바꿈처리 적용
		boardInfo.getBoardInfo().setB_cont(formattedContent);
		

		// 댓글 리스트 가져오기
		List<ReplyVO> replyList = this.replyService.getReplyList(b_num);
		for (ReplyVO reply : replyList) {
			String safeReplyContent = StringEscapeUtils.escapeHtml4(reply.getR_cont());
			String formattedReplyContent = safeReplyContent.replace("\n", "<br>");
			reply.setR_cont(formattedReplyContent);
		}
		
		mv.addObject("boardInfo", boardInfo);
		mv.addObject("replyList", replyList);

		mv.setViewName("/board/boardCont");
		return mv;
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

	//댓글 삭제 액션
	@PostMapping("/deleteReply")
	public String deleteReply(@RequestParam("r_num") long r_num,
			RedirectAttributes redirectAttributes, HttpSession session) {
		// 세션을 통해 로그인 정보를 가져옴
		MemberVO memberInfo = (MemberVO) session.getAttribute("loginInfo");

		// 댓글 번호(replyNum)를 사용하여 댓글 정보를 가져옴
		ReplyVO replyInfo = replyService.getReplyByNum(r_num);

		if (replyInfo != null) {
			// 댓글 작성자 아이디와 현재 로그인한 사용자 아이디를 비교하여 권한을 확인
			if (memberInfo != null && memberInfo.getM_id().equals(replyInfo.getR_id())) {
				// 아이디가 일치하면 댓글 삭제 작업 수행
				this.replyService.deleteReply(r_num);

				// 삭제 후, 리다이렉트할 URL을 설정하여 리다이렉트
				redirectAttributes.addFlashAttribute("message", "댓글이 삭제되었습니다.");
				return "redirect:/board/boardCont?b_num=" + replyInfo.getR_board_num();
			} else {
				// 아이디가 일치하지 않으면 오류 메시지를 전달하고 다시 게시글 상세 페이지로 리다이렉트
				redirectAttributes.addFlashAttribute("message", "댓글 삭제 권한이 없습니다.");
				return "redirect:/board/boardCont?b_num=" + replyInfo.getR_board_num();
			}
		} else {
			// 댓글이 존재하지 않으면 오류 메시지를 전달하고 다시 게시글 상세 페이지로 리다이렉트
			redirectAttributes.addFlashAttribute("message", "댓글이 존재하지 않습니다.");
			return "redirect:/board/boardCont?b_num=" + replyInfo.getR_board_num();
		}
	}

	//게시글 삭제
	@PostMapping("/boardDel")
	public String boardDel(@RequestParam("b_num") long b_num,
			RedirectAttributes redirectAttributes, HttpSession session) {
		// 세션을 통해 로그인 정보를 가져옴
		MemberVO memberInfo = (MemberVO) session.getAttribute("loginInfo");

		// 댓글 번호(replyNum)를 사용하여 댓글 정보를 가져옴
		BoardVO boardInfo = this.boardService.getBoardByNum(b_num);

		//게시글 삭제는 JSP에서 이미 보안설정을 했으나 이중 보안으로 하기로함
		if (boardInfo != null) {
			// 댓글 작성자 아이디와 현재 로그인한 사용자 아이디를 비교하여 권한을 확인
			if (memberInfo != null && memberInfo.getM_id().equals(boardInfo.getB_id())) {
				// 아이디가 일치하면 게시글 삭제 작업 수행
				this.boardService.boardDel(b_num);

				// 삭제 후, 리다이렉트할 URL을 설정하여 리다이렉트
				redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
				return "redirect:/board/boardMain"; // 게시글 목록 페이지로 리다이렉트
			} else {
				// 아이디가 일치하지 않으면 오류 메시지를 전달하고 다시 해당 게시글 페이지로 리다이렉트
				redirectAttributes.addFlashAttribute("message", "게시글 삭제 권한이 없습니다.");
				return "redirect:/board/boardCont?b_num=" + b_num;
			}
		} else {
			// 댓글이 존재하지 않으면 오류 메시지를 전달하고 다시 게시글 목록 페이지로 리다이렉트
			redirectAttributes.addFlashAttribute("message", "게시글이 존재하지 않습니다.");
			return "redirect:/board/boardMain"; // 게시글 목록 페이지로 리다이렉트
		}
	}

	//글수정 폼
	@RequestMapping(value="/boardUpdate")
	public ModelAndView boardUpdate(@RequestParam("b_num") long b_num) {
		ModelAndView mv = new ModelAndView();

		//BoardVO boardInfo = this.boardService.getCont(b_num);

		//mv.addObject("boardInfo", boardInfo);
		mv.setViewName("/board/boardUpdate");
		return mv;
	}

	//글수정 액션
	@RequestMapping(value="/boardUpdate",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> boardUpdate(@RequestBody BoardVO boardInfo, MultipartFile file)throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		/*int result = this.boardService.boardUpdate(boardInfo);
		if (result == 1) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}*/

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
			resultMap.put("message", "추천은 로그인 이후에 가능합니다!");
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
