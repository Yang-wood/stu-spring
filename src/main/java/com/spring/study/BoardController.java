package com.spring.study;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.study.domain.BoardDTO;
import com.spring.study.domain.Criteria;
import com.spring.study.domain.PageDTO;
import com.spring.study.service.IBoardService;

import lombok.extern.log4j.Log4j;
import oracle.net.aso.c;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Autowired
	private IBoardService service;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listAll(Criteria cri, Model model) throws Exception {
		log.info("Show All list :: " + cri);
		
		model.addAttribute("list", service.listAll(cri));
		
		int total = service.getTotalCnt(cri);
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 게시물 등록
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void resgisterGET(BoardDTO bDto, Model model) throws Exception {
		log.info("register get :: ");
	}
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(BoardDTO bDto, RedirectAttributes rttr) throws Exception {
		log.info("register post :: ");
		log.info(bDto.toString());
		
		service.register(bDto);
		
		rttr.addFlashAttribute("result", bDto.getBno());
		
		return "redirect:/board/list";
	}
	
//	// 게시물 조회
//	@RequestMapping(value = "/read", method = RequestMethod.GET)
//	public void read(@RequestParam("bno") int bno, Model model) throws Exception {
//		log.info("read.................");
//		model.addAttribute("board", service.read(bno));
//		
//	}
// 	
//	// 게시물 수정
//	@RequestMapping(value = "/modify", method = RequestMethod.GET)
//	public void modifyGET(@RequestParam("bno") int bno, Model model) throws Exception {
//		log.info("modifyGet.................");
//		model.addAttribute("board", service.read(bno));
//	}
	
	// 다중 매핑 적용(상세, 수정)
//	@RequestMapping(value = {"/read", "/modify"}, method = RequestMethod.GET)
	@GetMapping(value = {"/read", "/modify"})
	public void modifyGET(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri ,Model model) throws Exception {
		log.info("/read or /modify :: ");
		model.addAttribute("board", service.read(bno));
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BoardDTO bDto, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("modify Post :: " + service.modify(bDto));
		
		if (service.modify(bDto)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	// 게시물 삭제
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String modifyPOST(@RequestParam("bno") int bno, Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("remove Post :: ");
		
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
}
