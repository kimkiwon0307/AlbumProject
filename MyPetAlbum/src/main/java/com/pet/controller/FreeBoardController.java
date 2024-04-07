package com.pet.controller;

import org.springframework.http.ResponseEntity;
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
import com.pet.domain.FreeBoardVO;
import com.pet.domain.PageDTO;
import com.pet.service.FreeBoardService;
import com.pet.service.ReplyService;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/free/*")
@Log4j
public class FreeBoardController {

	private final FreeBoardService service;
	
	
	public FreeBoardController (FreeBoardService service) {
		this.service = service;
	
	}
/**
	@GetMapping("/list")
	public void list(Model modle) {
		modle.addAttribute("list", service.getList());
	}
*/
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	@GetMapping("/register")
	public void register() {
	}
	
	
	@PostMapping("/register")
	public String register(@Validated FreeBoardVO free, BindingResult bindingResult, RedirectAttributes rttr, Model model) {
		
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("errors", bindingResult.getAllErrors());
			return "/free/register";
		}
		
		
		rttr.addAttribute("f_no", free.getF_no());
		service.insert(free);
		
		return "redirect:/free/list";
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("f_no")Long f_no, @ModelAttribute("cri") Criteria cri,  Model model) {
		model.addAttribute("free", service.read(f_no));
	}
	
	@PostMapping("/modify")
	public String modify(FreeBoardVO free, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		
		if(service.update(free)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		
		return "redirect:/free/list";
	}
	
	
	  @PostMapping("/remove") 
	  public String remove(@RequestParam("f_no") Long f_no, RedirectAttributes rttr) {
		  
		  
		  if (service.delete(f_no)) { 
			  
			  rttr.addFlashAttribute("result", "success"); 
			 }
		  
		  return "redirect:/free/list";
	  
	  }
	  
	  @PostMapping("/count")
	  @ResponseBody
	  public void count(@RequestParam Long f_no){
		  
		  service.count(f_no);
		  
	  }
	  
	  @PostMapping("/like")
	  @ResponseBody
	  public void like(@RequestParam Long f_no){
		  
		  service.like(f_no);
		  
	  }
	 
	
	
}
