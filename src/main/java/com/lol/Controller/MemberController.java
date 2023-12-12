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

  //회원가입 폼
  @RequestMapping(value="/sign", method=RequestMethod.GET) 
  public void sign() {
    System.out.println("sign get 받음");
  }

  @RequestMapping(value="/sign", method=RequestMethod.POST) 
  public ModelAndView sign(MemberVO m) {
    ModelAndView mv = new ModelAndView();

    this.memberService.signTest(m);
    System.out.println("sign post 받음");
    return mv;
  }
}
