package com.spring.study.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardDTO {
	private Integer bno;         
    private String title;   
    private String content;    
    private String writer;      
    private Date regdate;     
    private int viewcnt;    
    
    private List<BoardAttachDTO> attachList;
}
