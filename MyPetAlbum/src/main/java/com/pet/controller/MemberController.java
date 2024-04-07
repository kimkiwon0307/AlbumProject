package com.pet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pet.domain.Criteria;
import com.pet.domain.MemberVO;
import com.pet.service.MemberService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	private final MemberService service;
	
	public MemberController (MemberService service) {
		this.service = service;
	}

	@GetMapping("/list")
	public void list(Model modle) {
		modle.addAttribute("list", service.getList());
	}
	
	@GetMapping("/login")
	public void login(Model modle) {
	
	}
	
	@PostMapping("/login")
	public String login(HttpServletResponse response, HttpServletRequest request, MemberVO member) {
		
		HttpSession session = request.getSession();
		
		String m_id = member.getM_id();
		String m_pwd = member.getM_pwd();
		
		session.setAttribute("member",service.login(m_id, m_pwd));
		
		return "redirect:/album/list";
	}
	
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		System.out.println("hi");
		session.removeAttribute("member");
		
		return "/member/login";
	}
	

	
	@GetMapping("/register")
	public void register() {
	}
	
	
	@PostMapping("/register")
	public String register(@Validated MemberVO member, BindingResult bindingResult, RedirectAttributes rttr, Model model) {
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("errors", bindingResult.getAllErrors());
			return "/member/register";
		}
		
		rttr.addAttribute("m_pk", member.getM_pk());
		service.insert(member);
		
		return "redirect:/member/login";
	}
	
	// 내정보
	@GetMapping("/myinfo")
	public void myinfo() {
	}

	@PostMapping("/modify")
	public String modify(MemberVO member,RedirectAttributes rttr) {
		
		System.out.println(member.toString());
		
		
		  service.update(member);
		
		
		return "redirect:/album/list";
	}
	
	
	  @PostMapping("/remove") 
	  public String remove(@RequestParam("m_pk") Long m_pk,HttpSession session, RedirectAttributes rttr) {
	  
		session.removeAttribute("member");
		service.delete(m_pk);
		  
		  return "redirect:/album/list";
	  
	  }
	  
	  
	//닉네임 중복 체크
	@PostMapping("/m_nick_check")
	@ResponseBody
	public String m_nick_check(String m_nick) {
			
	  if(m_nick.equals("")) {
			return "fail";
	   }
			
	   int result = service.nickCheck(m_nick);
			
	  if(result !=0 ) {
			return "fail";
		}else {
			return "success";
		}
	 }
	  
	
}
