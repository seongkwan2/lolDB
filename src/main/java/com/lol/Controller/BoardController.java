package com.lol.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {

	//해야할것, 의존성 추가 게시판제작, 페이징, 조회수, 좋아요 처리
	
	//보드 메인 화면
		@RequestMapping(value="/boardMain")
		public void boardMain() {}
}
