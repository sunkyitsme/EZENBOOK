package com.ezbook.member.mapper;

import com.ezbook.member.vo.MemberVO;
import com.ezbook.member.vo.LoginVO;

public interface MemberMapper {

	// 1. 로그인처리
	public LoginVO login(LoginVO inVO) throws Exception;
	
	// 2. 회원가입
	public int write(MemberVO vo) throws Exception;
	
	// 2-1. ID 중복체크
	public String idCheck(String id) throws Exception;
	
	// 3. ID 찾기
	public String find_id(String email) throws Exception;

	// 4. 마이 페이지
	public MemberVO view(String id) throws Exception;

	// 4-1. 회원 정보 수정
	public int update(MemberVO vo) throws Exception;

	// 4-2. 회원 탈퇴
	public int delete(MemberVO vo) throws Exception;
}