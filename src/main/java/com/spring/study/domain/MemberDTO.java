package com.spring.study.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
	private String userid;     
	private String userpw;     
	private String username;   
	private String email;       
	private Timestamp regdate;
	private Timestamp updatedate;
}
