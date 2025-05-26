package com.spring.study;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.study.domain.MemberDTO;
import com.spring.study.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private IMemberService service;
	
	@GetMapping("/login")
	public void loginGet(@ModelAttribute("mDto") MemberDTO mDto) {
		
	}
	
	@PostMapping("/loginPost")
	public String loginPost(MemberDTO mDto, HttpSession session, Model model) throws Exception {
		String returnURL = "";
		
		MemberDTO memInfo = service.login(mDto);
		log.info("memInfo ====> " + memInfo);
		
		if (memInfo == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("memInfo", memInfo);
		//사용자가 쭉 타고온 경로를 그대로 돌려줌
		return returnURL;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.info("logout..............");
		
		//로그인 정보 삽입
		Object obj = session.getAttribute("login");
		
		if (obj != null) {
			//세션 정보 제거
			session.removeAttribute("login");
			//세션 객체 제거
			session.invalidate();
		}
		
		return "redirect:/board/list";
	}
	
}
