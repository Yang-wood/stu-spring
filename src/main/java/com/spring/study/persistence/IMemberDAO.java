package com.spring.study.persistence;

import com.spring.study.domain.MemberDTO;

public interface IMemberDAO {
	public String getTime();
	public void insertMember(MemberDTO mDto);
	public MemberDTO selMember(String userid) throws Exception;
	public MemberDTO selLoginInfo(String userid, String userpw) throws Exception;
	public void updateMember(MemberDTO mDto);
	public void delMember(MemberDTO mDto);
	
}
