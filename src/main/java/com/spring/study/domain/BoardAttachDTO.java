package com.spring.study.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardAttachDTO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private int bno;
}
