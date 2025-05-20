package com.spring.study;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.study.domain.SampleDTO;
import com.spring.study.domain.SampleDTOList;
import com.spring.study.domain.TodoDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	@RequestMapping("/basic")
	private void basic() {
		log.info("basic.............................");
		System.out.println("basic.........");
	}
	
	@RequestMapping(value = "/basic1", method = {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		log.info("basic1.......................");
	}
	
	@RequestMapping(value = "/basic2", method = RequestMethod.GET)
	
	@GetMapping("/basicOnlyGet")
	public void basicGet1() {
		log.info("basic only get.................");
	}
	
	@PostMapping("/basicOnlyPost")
	public void basicPost() {
		log.info("basic only post.................");
	}
	
	@GetMapping("/ex01")
	public String ex01(SampleDTO sDto) {
		log.info("이름 : " + sDto.getName() + ", 나이 : " + sDto.getAge());
		
		return "ex01";  //jsp 파일이름
	}
	
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String userName,
						@RequestParam("age") int userAge) {
		log.info(userName);
		log.info(userAge);
		return "ex02";
	}
	
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids") ArrayList<String> ids) {
		log.info("ids ===> " + ids);
		return "ex02List";
	}

	@GetMapping("/ex02Array")
	public String ex02Array(@RequestParam("ids") String[] ids) {
		log.info("Array ids ===> " + Arrays.toString(ids));
		return "ex02Array";
	}
	
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		log.info("list dtos : " + list);
		return "ex02Bean";
	}
	
	/*
	 * @InitBinder public void initBinder(WebDataBinder binder) { SimpleDateFormat
	 * dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	 * binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,
	 * false)); }
	 */
	
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		log.info("todo : " + todo);
		return "ex03";
	}
	
	@RequestMapping("/sampleModel")
	public String sampleModel(Model model) {
		SampleDTO sampleDTO = new SampleDTO("이순신", 20);
		model.addAttribute("sDto", sampleDTO);
		
		log.info(model);
		return "/sample/sample";
	}
	
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {
		log.info("dto : " + dto);
		log.info("page : " + page);
		
		return "/sample/ex04";
	}
	
	@RequestMapping(value = "/doE")
	public String doE(RedirectAttributes rttr) {
		log.info("doE 호출되지만 /doF로 리다이렉트 .......");
		
		rttr.addFlashAttribute("msg", "리다이렉트된 메세지입니다.");
		
		return "redirect:/sample/doF";
	}
	
	@RequestMapping("/doF")
	public String doF(String msg) {
		log.info("doF 호출됨.............");
		return "/sample/redirectAttributeResult";
	}
	
	@RequestMapping("/ex05")
	public void ex05() {
		log.info("/ex05.................");
	}
	
	@RequestMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("/ex06...................");
		
		SampleDTO dto = new SampleDTO();
		dto.setAge(18);
		dto.setName("홍길동");
		
		return dto;
	}
	
	@RequestMapping("/ex6_1")
	public @ResponseBody Map<String, SampleDTO> ex06_1() {
		log.info("/ex07...................");
		SampleDTO dto = new SampleDTO();
		dto.setAge(18);
		dto.setName("홍길동");
		Map<String, SampleDTO> map = new HashMap<>();
		map.put("info", dto);
		
		return map;
	}
	
	@RequestMapping("/ex6_2")
	public @ResponseBody Map<String, List<SampleDTO>> ex06_2() {
		log.info("/ex08.....................");
		SampleDTO dto = new SampleDTO();
		dto.setAge(18);
		dto.setName("홍길동");
		SampleDTO dto2 = new SampleDTO();
		dto2.setAge(48);
		dto2.setName("강감찬");
		List<SampleDTO> list = new ArrayList<>();
		list.add(dto);
		list.add(dto2);
		Map<String, List<SampleDTO>> map = new HashMap<>();
		map.put("info", list);
		
		return map;
	}
	
	@RequestMapping("/ex07")
	public ResponseEntity<String> ex07() {
		log.info("/ex07......................");
		
		String msg = "{\"name\":\"홍길동\"}";
		
		HttpHeaders header = new HttpHeaders(); // {"name":"홍길동"}
		
		header.add("Content-type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg, header, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/exFileUpload", method = RequestMethod.GET)
	public void exFileUpload() {
		log.info("/exFileupload.......................");
	}
	
	@RequestMapping(value = "/exUploadPost", method = RequestMethod.POST)
	public void exUploadPost(ArrayList<MultipartFile> files) throws Exception {
		log.info("/exUploadPost.....................");
	
		files.forEach(file -> {
			log.info("----------------------------");
			log.info("filename : " + file.getOriginalFilename());
			log.info("filesize : " + file.getSize());
		});
	}
}














