package com.spring.study;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.study.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;
import oracle.net.aso.l;

@Controller
@Log4j
public class UploadController {
	private String uploadPath 
	= "D:\\workspaces\\sts_reg_workspace\\stu-spring\\src\\main\\webapp\\resources\\fileUpload";
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.GET)
	public void uploadForm() {
		log.info("upload form");
	}
//	@GetMapping("/uploadForm")
//	public void uploadForm() {
//		log.info("upload form");
//	}
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
	public void uploadFormPost(MultipartFile[] files, Model model) throws Exception {
		log.info("/uploadForm post.....................");
		
		for (MultipartFile multipartFile : files) {
			log.info("----------------------------");
			log.info("filename : " + multipartFile.getOriginalFilename());
			log.info("filesize : " + multipartFile.getSize());
			log.info("ContentType : " + multipartFile.getContentType());
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax...............");
	}
	
	// 년/월/일 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//오늘 날짜의 경로를 문자열로 생성
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@PostMapping(value = "/uploadAjaxAction",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("update ajax post................");
		
		List<AttachFileDTO> attachList = new ArrayList<>();
		String uploadFolderPath = getFolder();
		
		// 첨부파일이 저장될 폴더 생성
		File uploadFolder = new File(uploadPath, uploadFolderPath);
		log.info("uploadFolder : " + uploadFolder);
		
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			log.info("-----------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			log.info("Upload File ContentType : " + multipartFile.getContentType());
			
			AttachFileDTO attachFileDto = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			attachFileDto.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				// 지정된 폴더에 파일 저장
				File saveFile = new File(uploadFolder, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachFileDto.setUuid(uuid.toString());
				attachFileDto.setUploadPath(uploadFolderPath);
				
				if (checkImageType(saveFile)) {
					attachFileDto.setImage(true);
					
					File thumbnail = new File(uploadFolder, "s_" + uploadFileName);
					Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);
				}
				
				attachList.add(attachFileDto);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		} // end for
		return new ResponseEntity<>(attachList, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFiles(String fileName) {
		log.info("filename : " + fileName);
		
		File file = new File(uploadPath + "\\" + fileName);
		
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@GetMapping(value = "/download", 
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(
			@RequestHeader("User-Agent") String userAgent,
			String fileName) {
		Resource resource = new FileSystemResource(uploadPath + "\\" + fileName);
		
		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
			
			String downloadName = null;
			
			
			if (checkIE) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF8").replace("\\+", "");
			} else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename = " + downloadName);
			
			log.info(headers);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}

	// 첨부 파일 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String filename, String type) {
		log.info("deleteFile : " + filename);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "text/html; charset=UTF-8");
		
		if (filename == null || filename.trim().isEmpty()) {
			return new ResponseEntity<>("filename is null", headers, HttpStatus.BAD_REQUEST);
		}
		
		try {
			String decodeName = URLDecoder.decode(filename, "UTF-8");
			String originName = decodeName.replace("s_", "");
			File file = new File(uploadPath + "\\" + originName);
			
			boolean originDelResult = file.delete();
			log.info("오리진 파일 삭제 여부 : " + originDelResult);
			if (type.equals("image")) {
				File parentDir = file.getParentFile();
				String originFileName = file.getName();
				String thumbFileName = "s_" + originFileName;
				log.info("thumbFileName : " + thumbFileName);
				File thumbFile = new File(parentDir, thumbFileName);
				
				boolean thumbDelResult = thumbFile.delete();
				log.info("썸네일 파일 삭제 여부 : " + thumbDelResult);
			}
		}  catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<>("deleted", headers, HttpStatus.OK);
	}
}










