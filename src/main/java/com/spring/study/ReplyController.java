package com.spring.study;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.study.domain.Criteria;
import com.spring.study.domain.ReplyDTO;
import com.spring.study.domain.ReplyPageDTO;
import com.spring.study.service.IReplyService;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	/* 						url구조
	 * 작업			URL						HTTP 전송 방식
	 * 등록		/replies/new					POST
	 * 조회		/replies/:rno					GET
	 * 삭제		/replies/:rno					DELETE
	 * 수정		/replies/:rno					PUT or PATCH
	 * 목록		/replies/pages/:bno/:page		GET
	 * 
	 */
	
	@Autowired
	private IReplyService service;
	
	// 등록
	@PostMapping(value = "/new", consumes = "application/json", 
				produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyDTO replyDto) {
		
		log.info("ReplyDTO : " + replyDto);
		
		int insertCount = service.register(replyDto);
		
		log.info("insertCount : " + insertCount);
		
		return insertCount
		== 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
		     : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 목록
	@GetMapping(value = "/pages/{bno}/{page}",
				produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") int bno) {
		Criteria cri = new Criteria(page, 10);
		
		log.info("get Reply List bno : " + bno);
		log.info("cri : " + cri);
		
//		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	// 조회
	@GetMapping(value = "/{rno}", 
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyDTO> read(@PathVariable("rno") int rno) {
		log.info("get : " + rno);
		
		return new ResponseEntity<>(service.read(rno), HttpStatus.OK);
	}
	
	// 삭제
	@DeleteMapping(value = "/{rno}", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") int rno) {
		log.info("remove : " + rno);
		
		return service.remove(rno) == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{rno}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody ReplyDTO replyDto,
			@PathVariable("rno") int rno){
		replyDto.setRno(rno);
		
		log.info("rno : " + rno);
		log.info("modify : " + replyDto);
		
		return service.modify(replyDto) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}







