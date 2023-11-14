package com.lol.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lol.Service.MemberService;


@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;

	//회원가입 폼
	@RequestMapping(value="/sign", method=RequestMethod.GET)
	public void sign() {
	}
}
