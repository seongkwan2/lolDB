package com.lol.Controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lol.Service.MemberService;
import com.lol.vo.MemberVO;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;

	//추후 비밀번호 암호화 코드할것

	//회원가입 폼
	@RequestMapping(value="/sign", method=RequestMethod.GET)
	public ModelAndView sign() {
		System.out.println("sign() GET 동작");
		ModelAndView mv =new ModelAndView();

		mv.setViewName("member/sign");
		return mv;
	}//sign()


	// 중복 아이디 확인 컨트롤러
	@PostMapping("/member_idcheck")
	@ResponseBody
	public String member_idcheck(@RequestParam String m_id) {
		// DB에서 클라이언트가 입력한 ID가 존재하는지 검색
		MemberVO memberInfo = this.memberService.findMemberId(m_id);
		System.out.println("아이디검색결과: "+memberInfo);

		if (memberInfo != null) {
			// 중복된 아이디인 경우 "1"을 반환
			return "1";
		} else {
			// 중복되지 않은 아이디인 경우 "0"을 반환
			return "0";
		}
	}

	//회원저장(회원가입 완료)
	@RequestMapping(value="/sign", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sign(@RequestBody MemberVO memberInfo) {
		Map<String, Object> map = new HashMap<>();

		try {
			//m.setM_pwd(passwordEncoder.encode(m.getM_pwd())); //비번 암호화

			memberService.registerMember(memberInfo); // 트랜잭션 적용 메서드 호출

			map.put("status", "success");
			map.put("message", "가입 성공");

		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "error");
			map.put("message", "가입 실패: " + e.getMessage());
		}
		System.out.println("map의값 : " + map);
		return map;
	}

	// 로그인 폼
	@RequestMapping(value="/login")
	public void login() {
	}

	// 로그인 액션
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam String m_id,
	        @RequestParam String m_pwd,
	        HttpServletResponse response,
	        HttpServletRequest request,
	        HttpSession session, Model model) throws Exception {

	    response.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    // 사용자 정보를 데이터베이스에서 가져오는 서비스 메서드 호출 (아래는 예시)
	    MemberVO memberInfo = memberService.findMemberId(m_id);

	    if (memberInfo != null && memberInfo.getM_pwd().equals(m_pwd)) {//로그인이 되었을 때
	        session = request.getSession();
	        session.setAttribute("loginInfo", memberInfo); // 사용자 정보를 세션에 저장

	        boolean isAdmin = isAdminUser(memberInfo); // 사용자가 관리자인지 확인
	        System.out.println("로그인정보: "+memberInfo);

	        if (isAdmin) {
	            // 권한이 있을 경우 실행할 코드
	            return "/admin/adminMain";
	        } else {
	            // 권한이 없을 경우 실행할 코드
	            model.addAttribute("message", "로그인 되었습니다!\n"+memberInfo.getM_name()+"님 안녕하세요!");
	            return "redirect:/board/boardMain";
	        }
	    } else {
	        // 인증 실패 처리
	        model.addAttribute("message", "아이디와 비밀번호를 다시 확인해주세요!");
	        return "/member/login";
	    }
	}


	private boolean isAdminUser(MemberVO memberInfo) {
		// 사용자 정보가 null이면 관리자 권한이 없다고 간주
		if (memberInfo == null) {
			return false;
		}

		// 사용자의 권한을 확인하고, 관리자 권한이 있다면 true를 반환
		// 여기에서는 단순 예시이며, 실제로는 데이터베이스에서 사용자의 권한 정보를 확인
		return memberInfo.getRoles() != null && memberInfo.getRoles().contains("ADMIN");
	}


	@RequestMapping("/admin/add-admin-role/{userId}")
	public String addAdminRole(@PathVariable("userId") Long userId) {
		// 특정 사용자에게 ADMIN 권한을 부여
		//memberService.addAdminRole(userId);
		return "redirect:/admin/user-list";
	}


	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes redirectAttributes) throws Exception{
	    session.invalidate(); // 세션 만료 => 로그아웃
	    redirectAttributes.addFlashAttribute("message", "로그아웃 되었습니다!");
	    return "redirect:/member/login";
	}




}
