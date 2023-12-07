package com.lol.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.lol.Service.MemberService;
import com.lol.vo.MemberVO;


@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;

	//회원가입 폼 작성
	@RequestMapping(value="/sign")
	public void sign() {}
	
	//
	@RequestMapping(value="/sign",method=RequestMethod.POST)
	public ModelAndView sign(MemberVO memberInfo) {
		ModelAndView mv = new ModelAndView();
		
		this.memberService.signTest(memberInfo);
		
		return mv;
	}
}
